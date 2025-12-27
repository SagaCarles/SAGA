local UI = {}

function UI.Load(TeleportModule, EventModule)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    
    -- MAIN FRAME (Background Semi-Transparan)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 250, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -125, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    MainFrame.BackgroundTransparency = 0.3 -- Efek transparan agar modern
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
    
    -- Stroke (Garis Tepi Menyala)
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Color = Color3.fromRGB(0, 255, 200)
    Stroke.Thickness = 2

    -- TOMBOL MINIMIZE (S) LINGKARAN
    local MiniBtn = Instance.new("TextButton", MainFrame)
    MiniBtn.Size = UDim2.new(0, 32, 0, 32)
    MiniBtn.Position = UDim2.new(1, -75, 0, 10)
    MiniBtn.Text = "S"
    MiniBtn.Font = Enum.Font.GothamBold -- BOLD
    MiniBtn.TextSize = 18
    MiniBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    local c1 = Instance.new("UICorner", MiniBtn)
    c1.CornerRadius = UDim.new(1, 0)

    -- TOMBOL CLOSE (X)
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 32, 0, 32)
    CloseBtn.Position = UDim2.new(1, -38, 0, 10)
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold -- BOLD
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255) -- PUTIH
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

    -- TAB NAVIGATION (PUTIH & BOLD)
    local TabEv = Instance.new("TextButton", MainFrame)
    TabEv.Size = UDim2.new(0.5, -12, 0, 35); TabEv.Position = UDim2.new(0, 8, 0, 55)
    TabEv.Text = "AUTO EVENT"; TabEv.Font = Enum.Font.GothamBold
    TabEv.TextColor3 = Color3.fromRGB(255, 255, 255); TabEv.BackgroundColor3 = Color3.fromRGB(30, 110, 255)
    Instance.new("UICorner", TabEv)

    local TabTp = Instance.new("TextButton", MainFrame)
    TabTp.Size = UDim2.new(0.5, -12, 0, 35); TabTp.Position = UDim2.new(0.5, 4, 0, 55)
    TabTp.Text = "TELEPORT"; TabTp.Font = Enum.Font.GothamBold
    TabTp.TextColor3 = Color3.fromRGB(255, 255, 255); TabTp.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", TabTp)

    -- CONTAINER PAGES
    local PageEv = Instance.new("Frame", MainFrame)
    PageEv.Size = UDim2.new(1, -16, 1, -110); PageEv.Position = UDim2.new(0, 8, 0, 100)
    PageEv.BackgroundTransparency = 1

    local PageTp = Instance.new("ScrollingFrame", MainFrame)
    PageTp.Size = UDim2.new(1, -16, 1, -110); PageTp.Position = UDim2.new(0, 8, 0, 100)
    PageTp.BackgroundTransparency = 1; PageTp.Visible = false; PageTp.ScrollBarThickness = 2
    Instance.new("UIListLayout", PageTp).HorizontalAlignment = "Center"

    -- SMART AUTO CONTENT (PUTIH & BOLD)
    local StatusLabel = Instance.new("TextLabel", PageEv)
    StatusLabel.Size = UDim2.new(1, 0, 0, 40); StatusLabel.Text = "SYSTEM READY"
    StatusLabel.Font = Enum.Font.GothamBold; StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusLabel.BackgroundTransparency = 1; StatusLabel.TextSize = 18

    local TimeLabel = Instance.new("TextLabel", PageEv)
    TimeLabel.Size = UDim2.new(1, 0, 0, 30); TimeLabel.Position = UDim2.new(0, 0, 0, 45)
    TimeLabel.Text = "00:00:00"; TimeLabel.Font = Enum.Font.GothamBold
    TimeLabel.TextColor3 = Color3.fromRGB(0, 255, 200); TimeLabel.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", PageEv)
    ToggleBtn.Size = UDim2.new(1, 0, 0, 50); ToggleBtn.Position = UDim2.new(0, 0, 0, 85)
    ToggleBtn.Text = "START SMART AUTO"; ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", ToggleBtn)

    -- TELEPORT LIST (PUTIH & BOLD - FIX VISIBILITY)
    local function buildTp()
        for _,v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        for name, data in pairs(TeleportModule.ISLANDS) do
            local btn = Instance.new("TextButton", PageTp)
            btn.Size = UDim2.new(0, 210, 0, 40)
            btn.Text = name
            btn.Font = Enum.Font.GothamBold -- BOLD
            btn.TextColor3 = Color3.fromRGB(255, 255, 255) -- PUTIH TERANG
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Instance.new("UICorner", btn)
            
            btn.MouseButton1Click:Connect(function()
                for _,v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
                local back = Instance.new("TextButton", PageTp)
                back.Size = UDim2.new(0, 210, 0, 30); back.Text = "← KEMBALI"; back.Font = Enum.Font.GothamBold
                back.TextColor3 = Color3.fromRGB(255, 255, 255); back.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
                Instance.new("UICorner", back).MouseButton1Click:Connect(buildTp)
                for _,s in pairs(data) do
                    local sb = Instance.new("TextButton", PageTp)
                    sb.Size = UDim2.new(0, 210, 0, 40); sb.Text = s[1]; sb.Font = Enum.Font.GothamBold
                    sb.TextColor3 = Color3.fromRGB(255, 255, 255); sb.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    Instance.new("UICorner", sb).MouseButton1Click:Connect(function() TeleportModule.To(s[2]) end)
                end
            end)
        end
    end
    buildTp()

    -- LOGIKA MINIMIZE (LINGKARAN S MELAYANG)
    local minimized = false
    local FloatingS = nil

    MiniBtn.MouseButton1Click:Connect(function()
        minimized = true
        MainFrame.Visible = false
        FloatingS = Instance.new("TextButton", ScreenGui)
        FloatingS.Size = UDim2.new(0, 60, 0, 60)
        FloatingS.Position = UDim2.new(0, 20, 0.5, -30) -- Posisi kiri layar
        FloatingS.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
        FloatingS.Text = "S"; FloatingS.Font = Enum.Font.GothamBold; FloatingS.TextSize = 30
        Instance.new("UICorner", FloatingS).CornerRadius = UDim.new(1, 0)
        
        FloatingS.MouseButton1Click:Connect(function()
            minimized = false
            MainFrame.Visible = true
            FloatingS:Destroy()
        end)
    end)

    -- TAB SWITCH LOGIC
    TabEv.MouseButton1Click:Connect(function() PageEv.Visible, PageTp.Visible = true, false end)
    TabTp.MouseButton1Click:Connect(function() PageEv.Visible, PageTp.Visible = false, true end)
    
    ToggleBtn.MouseButton1Click:Connect(function()
        EventModule._G_Enabled = not EventModule._G_Enabled
        ToggleBtn.Text = EventModule._G_Enabled and "STOP AUTO" or "START SMART AUTO"
        ToggleBtn.BackgroundColor3 = EventModule._G_Enabled and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(40, 40, 40)
    end)

    EventModule.StartLoop(StatusLabel, TimeLabel)
end

return UI
