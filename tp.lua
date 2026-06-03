-- [[ 3C SANKEN HUNT - ALL IN ONE PANEL (LOADSTRING FIX) ]] --

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local PlaceId = 121864768012064 -- ID Game Fish It
local ProxyUrl = "https://cengarcengir.devil15sep.workers.dev/" -- URL Cloudflare Worker Anda

-- [[ INTERFACE GUI ]] --
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Saga3CSankenHunt"
ScreenGui.Parent = game:GetService("CoreGui") 
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 450)
MainFrame.Position = UDim2.new(0.5, -130, 0.4, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 150)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame

-- Title Panel
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "3C SANKEN HUNT"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

-- Tombol Close (X)
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

----------------------------------------------------------------
-- KATEGORI 1: TREASURE TELEPORT & INFO
----------------------------------------------------------------
local ActionButton = Instance.new("TextButton")
ActionButton.Size = UDim2.new(0.9, 0, 0, 45)
ActionButton.Position = UDim2.new(0.05, 0, 0, 45)
ActionButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
ActionButton.Text = "TELEPORT KE TREASURE"
ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.Font = Enum.Font.GothamBold
ActionButton.TextSize = 13
ActionButton.Parent = MainFrame

local ActionCorner = Instance.new("UICorner")
ActionCorner.Parent = ActionButton

-- TEKS KETERANGAN
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(0.9, 0, 0, 35)
InfoLabel.Position = UDim2.new(0.05, 0, 0, 95)
InfoLabel.Text = "Gunakan Diving gear kemudian berenang manual kedasar laut"
InfoLabel.TextColor3 = Color3.fromRGB(255, 230, 100)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Font = Enum.Font.GothamMedium
InfoLabel.TextSize = 10
InfoLabel.TextWrapped = true
InfoLabel.Parent = MainFrame

-- Garis Pembatas
local Separator = Instance.new("Frame")
Separator.Size = UDim2.new(0.9, 0, 0, 2)
Separator.Position = UDim2.new(0.05, 0, 0, 135)
Separator.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
Separator.BackgroundTransparency = 0.5
Separator.BorderSizePixel = 0
Separator.Parent = MainFrame

----------------------------------------------------------------
-- KATEGORI 2: SERVER CRAWLER
----------------------------------------------------------------
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(0.9, 0, 0, 190)
ScrollFrame.Position = UDim2.new(0.05, 0, 0, 145)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 5)

-- Tombol Refresh Server
local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(0.9, 0, 0, 40)
RefreshBtn.Position = UDim2.new(0.05, 0, 0, 345)
RefreshBtn.Text = "CRAWL / REFRESH LIST"
RefreshBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.Parent = MainFrame

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.Parent = RefreshBtn

-- Label Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0, 395)
Status.Text = "Ready..."
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Gotham
Status.TextSize = 11
Status.Parent = MainFrame


----------------------------------------------------------------
-- LOGIKA TELEPORTASI
----------------------------------------------------------------
local function getClosestTreasure()
    local container = Workspace:FindFirstChild("Sunken Wreckage") or Workspace:FindFirstChild("PirateTreasureChests", true)
    if not container then return nil end

    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local closestObject = nil
    local shortestDistance = math.huge

    for _, child in pairs(container:GetChildren()) do
        if child:IsA("Model") or child:IsA("BasePart") then
            if child:GetAttribute("Opened") ~= true and child:GetAttribute("Open") ~= true then
                local targetPos = child:GetPivot().Position
                local distance = (hrp.Position - targetPos).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestObject = child
                end
            end
        end
    end
    return closestObject
end

local function executeSingleTeleport()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local target = getClosestTreasure()
    if target then
        local targetPosition = target:GetPivot().Position
        local safeTpPosition = Vector3.new(targetPosition.X, targetPosition.Y + 100, targetPosition.Z)
        
        Status.Text = "Teleported: " .. target.Name
        hrp.CFrame = CFrame.new(safeTpPosition)
    else
        Status.Text = "No active treasure found!"
    end
end


----------------------------------------------------------------
-- LOGIKA SERVER CRAWLER (LOADSTRING BYPASS PATCH)
----------------------------------------------------------------
local function createServerEntry(serverId, playerCount)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
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
    
    local JoinCorner = Instance.new("UICorner")
    JoinCorner.Parent = JoinBtn
    
    JoinBtn.MouseButton1Click:Connect(function()
        Status.Text = "Teleporting to server..."
        TeleportService:TeleportToPlaceInstance(PlaceId, serverId, player)
    end)
end

local function crawlServers()
    for _, child in pairs(ScrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    Status.Text = "Crawling servers..."
    
    local robloxApi = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local finalUrl = ProxyUrl .. "?url=" .. HttpService:UrlEncode(robloxApi)
    
    local success, result = pcall(function()
        -- UTAMAKAN MENGGUNAKAN REQUEST EXECUTOR (WAJIB UNTUK LOADSTRING)
        local httpRequest = request or (syn and syn.request) or (http and http.request)
        
        if httpRequest then
            local response = httpRequest({
                Url = finalUrl,
                Method = "GET",
                Headers = {
                    ["User-Agent"] = "Roblox/WinInet"
                }
            })
            return HttpService:JSONDecode(response.Body)
        else
            -- Cadangan darurat jika executor jadul
            local responseText = game:HttpGet(finalUrl)
            return HttpService:JSONDecode(responseText)
        end
    end)
    
    if success and result and result.data then
        local found = 0
        for _, server in ipairs(result.data) do
            if server.playing >= 1 and server.playing <= 2 and server.id ~= game.JobId then
                createServerEntry(server.id, server.playing)
                found = found + 1
            end
        end
        Status.Text = "Ditemukan " .. found .. " server sunyi."
        ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    else
        Status.Text = "Gagal mengambil data server!"
        warn("[3C LOADSTRING ERROR]: " .. tostring(result))
    end
end

----------------------------------------------------------------
-- EVENTS TRIGGER
----------------------------------------------------------------
ActionButton.MouseButton1Click:Connect(executeSingleTeleport)
RefreshBtn.MouseButton1Click:Connect(crawlServers)

CloseBtn.MouseButton1Click:Connect(function() 
    ScreenGui:Destroy() 
end)

-- Jalankan crawler secara asinkronus (menghindari block thread loadstring)
task.spawn(crawlServers)
print("[3C SANKEN HUNT] Loadstring Optimization Patch Active.")
