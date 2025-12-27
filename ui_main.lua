local UI = {}

function UI.Load(TeleportModule, EventModule)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    
    -- Main Frame dengan Transparansi
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 240, 0, 330)
    MainFrame.Position = UDim2.new(0.5, -120, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainFrame.BackgroundTransparency = 0.2 -- Sedikit Transparan
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0, 12)
    
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(0, 180, 255)
    MainStroke.Thickness = 1.5

    -- Tombol Minimize Lingkaran "S" (Saat Terbuka)
    local MiniBtn = Instance.new("TextButton", MainFrame)
    MiniBtn.Size = UDim2.new(0, 30, 0, 30)
    MiniBtn.Position = UDim2.new(1, -70, 0, 8)
    MiniBtn.Text = "S"
    MiniBtn.Font = Enum.Font.GothamBold -- Text Bold
    MiniBtn.TextColor3 = Color3.new(0, 0, 0)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    local MiniRound = Instance.new("UICorner", MiniBtn)
    MiniRound.CornerRadius = UDim.new(1, 0) -- Bentuk Lingkaran

    -- Tombol Close X
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 8)
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

    -- Tab Buttons
    local TabEv = Instance.new("TextButton", MainFrame)
    TabEv.Size = UDim2.new(0.5, -10, 0, 35)
    TabEv.Position = UDim2.new(0, 7, 0, 50)
    TabEv.Text = "AUTO EVENT"
    TabEv.Font = Enum.Font.GothamBold
    TabEv.BackgroundColor3 = Color3.fromRGB(30, 100, 255)
    TabEv.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", TabEv)

    local TabTp = Instance.new("TextButton", MainFrame)
    TabTp.Size = UDim2.new(0.5, -10, 0, 35)
    TabTp.Position = UDim2.new(0.5, 3, 0, 50)
    TabTp.Text = "TELEPORT"
    TabTp.Font = Enum.Font.GothamBold
    TabTp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabTp.TextColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", TabTp)

    -- Container Pages
    local PageEv = Instance.new("Frame", MainFrame)
    PageEv.Size = UDim2.new(1, -14, 1, -100)
    PageEv.Position = UDim2.new(0, 7, 0, 95)
    PageEv.BackgroundTransparency = 1

    local PageTp = Instance.new("ScrollingFrame", MainFrame)
    PageTp.Size = UDim2.new(1, -14, 1, -100)
    PageTp.Position = UDim2.new(0, 7, 0, 95)
    PageTp.BackgroundTransparency = 1
    PageTp.Visible = false
    PageTp.ScrollBarThickness = 0
    Instance.new("UIListLayout", PageTp).HorizontalAlignment = "Center"

    -- Text Elements (Bold & Visible)
    local StatusLabel = Instance.new("TextLabel", PageEv)
    StatusLabel.Size = UDim2.new(1, 0, 0, 40)
    StatusLabel.Text = "SYSTEM READY"
    StatusLabel.Font = Enum.Font.GothamBold
    StatusLabel.TextSize = 16
    StatusLabel.TextColor3 = Color3.new(1, 1, 1)
    StatusLabel.BackgroundTransparency = 1

    local TimeLabel = Instance.new("TextLabel", PageEv)
    TimeLabel.Size = UDim2.new(1, 0, 0, 30)
    TimeLabel.Position = UDim2.new(0, 0, 0, 40)
    TimeLabel.Text = "00:00:00"
    TimeLabel.Font = Enum.Font.GothamBold
    TimeLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
    TimeLabel.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", PageEv)
    ToggleBtn.Size = UDim2.new(1, 0, 0, 45)
    ToggleBtn.Position = UDim2.new(0, 0, 0, 80)
    ToggleBtn.Text = "START SMART AUTO"
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", ToggleBtn)

    -- Teleport List Builder
    local function buildTp()
        for _,v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        for name, data in pairs(TeleportModule.ISLANDS) do
            local btn = Instance.new("TextButton", PageTp)
            btn.Size = UDim2.new(0, 200, 0, 38)
            btn.Text = name
            btn.Font = Enum.Font.GothamBold
            btn.TextColor3 = Color3.fromRGB(0, 180, 255)
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                for _,v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
                local back = Instance.new("TextButton", PageTp)
                back.Size = UDim2.new(0, 200, 0, 30); back.Text = "← KEMBALI"; back.Font = Enum.Font.GothamBold
                back.BackgroundColor3 = Color3.fromRGB(80, 20, 20); back.TextColor3 = Color3.new(1, 1, 1)
                Instance.new("UICorner", back).MouseButton1Click:Connect(buildTp)
                for _,s in pairs(data) do
                    local sb = Instance.new("TextButton", PageTp)
                    sb.Size = UDim2.new(0, 200, 0, 38); sb.Text = s[1]; sb.Font = Enum.Font.GothamBold
                    sb.BackgroundColor3 = Color3.fromRGB(35, 35, 35); sb.TextColor3 = Color3.new(1,1,1)
                    Instance.new("UICorner", sb).MouseButton1Click:Connect(function() TeleportModule.To(s[2]) end)
                end
            end)
        end
    end
    buildTp()

    -- Logika Minimize (Lingkaran S Melayang)
    local minimized = false
    local function toggleMinimize()
        minimized = not minimized
        MainFrame.Visible = not minimized
        
        if minimized then
            local FloatingS = Instance.new("TextButton", ScreenGui)
            FloatingS.Name = "FloatingS"
            FloatingS.Size = UDim2.new(0, 50, 0, 50)
            FloatingS.Position = MainFrame.Position
            FloatingS.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
            FloatingS.Text = "S"
            FloatingS.Font = Enum.Font.GothamBold
            FloatingS.TextSize = 24
            FloatingS.TextColor3 = Color3.new(0, 0, 0)
            Instance.new("UICorner", FloatingS).CornerRadius = UDim.new(1, 0)
            
            FloatingS.MouseButton1Click:Connect(function()
                minimized = false
                MainFrame.Visible = true
                FloatingS:Destroy()
            end)
        end
    end

    MiniBtn.MouseButton1Click:Connect(toggleMinimize)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    TabEv.MouseButton1Click:Connect(function() PageEv.Visible, PageTp.Visible = true, false end)
    TabTp.MouseButton1Click:Connect(function() PageEv.Visible, PageTp.Visible = false, true end)

    ToggleBtn.MouseButton1Click:Connect(function()
        EventModule._G_Enabled = not EventModule._G_Enabled
        ToggleBtn.Text = EventModule._G_Enabled and "STOP AUTO" or "START SMART AUTO"
        ToggleBtn.BackgroundColor3 = EventModule._G_Enabled and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(20, 20, 20)
    end)

    EventModule.StartLoop(StatusLabel, TimeLabel)
end

return UI
