-- [[ SAGA SERVER CRAWLER V1 - STANDALONE ]] --

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local PlaceId = 121864768012064 -- ID Game Fish It

-- [[ INTERFACE GUI ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SagaServerCrawler"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 320)
MainFrame.Position = UDim2.new(0.5, -125, 0.4, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "[SAGA] - SERVER CRAWL"
Title.TextColor3 = Color3.fromRGB(0, 200, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- Scrolling Frame untuk List Server
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(0.9, 0, 0.6, 0)
ScrollFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 5)

local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(0.9, 0, 0, 40)
RefreshBtn.Position = UDim2.new(0.05, 0, 0.8, 0)
RefreshBtn.Text = "CRAWL / REFRESH LIST"
RefreshBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.Parent = MainFrame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.93, 0)
Status.Text = "Ready to crawl..."
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.BackgroundTransparency = 1
Status.TextSize = 10
Status.Parent = MainFrame

-- [[ LOGIC CRAWLER ]] --

local function createServerEntry(serverId, playerCount)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.Parent = ScrollFrame
    
    local Corner = Instance.new("UICorner")
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.Text = "Pemain: " .. playerCount .. " / 20"
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.Parent = Frame
    
    local JoinBtn = Instance.new("TextButton")
    JoinBtn.Size = UDim2.new(0.3, 0, 0.7, 0)
    JoinBtn.Position = UDim2.new(0.65, 0, 0.15, 0)
    JoinBtn.Text = "JOIN"
    JoinBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    JoinBtn.Font = Enum.Font.GothamBold
    JoinBtn.Parent = Frame
    
    JoinBtn.MouseButton1Click:Connect(function()
        Status.Text = "Teleporting..."
        TeleportService:TeleportToPlaceInstance(PlaceId, serverId, player)
    end)
end

local function crawlServers()

    for _, child in pairs(ScrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    Status.Text = "Crawling servers..."
    
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)
    
    if success and result and result.data then
        local found = 0
        for _, server in ipairs(result.data) do
            -- Menampilkan server yang isinya hanya 1-2 orang sesuai permintaan
            if server.playing >= 1 and server.playing <= 2 and server.id ~= game.JobId then
                createServerEntry(server.id, server.playing)
                found = found + 1
            end
        end
        Status.Text = "Ditemukan " .. found .. " server sunyi :v"
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    else
        Status.Text = "Gagal mengambil data server."
    end
end

-- Events
RefreshBtn.MouseButton1Click:Connect(crawlServers)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Initial Crawl
crawlServers()
