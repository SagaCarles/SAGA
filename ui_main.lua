local UI = {}

function UI.Load(EventModule)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 180, 0, 150)
    MainFrame.Position = UDim2.new(0.5, -90, 0.4, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", MainFrame)

    -- Tombol Close (X)
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 25, 0, 25); CloseBtn.Position = UDim2.new(1, -30, 0, 5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); CloseBtn.Text = "X"
    Instance.new("UICorner", CloseBtn); CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- Tombol Minimize (S) Lingkaran
    local MiniBtn = Instance.new("TextButton", MainFrame)
    MiniBtn.Size = UDim2.new(0, 25, 0, 25); MiniBtn.Position = UDim2.new(1, -60, 0, 5)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200); MiniBtn.Text = "S"
    local Round = Instance.new("UICorner", MiniBtn); Round.CornerRadius = UDim.new(1, 0)

    -- Labels
    local StatusLabel = Instance.new("TextLabel", MainFrame)
    StatusLabel.Size = UDim2.new(1, 0, 0, 30); StatusLabel.Position = UDim2.new(0, 0, 0, 35)
    StatusLabel.Text = "SYSTEM READY"; StatusLabel.TextColor3 = Color3.new(1, 1, 1); StatusLabel.BackgroundTransparency = 1

    local TimeLabel = Instance.new("TextLabel", MainFrame)
    TimeLabel.Size = UDim2.new(1, 0, 0, 20); TimeLabel.Position = UDim2.new(0, 0, 0, 65)
    TimeLabel.Text = "00:00:00"; TimeLabel.TextColor3 = Color3.fromRGB(0, 255, 200); TimeLabel.BackgroundTransparency = 1

    -- Toggle Button
    local ToggleBtn = Instance.new("TextButton", MainFrame)
    ToggleBtn.Size = UDim2.new(0, 160, 0, 40); ToggleBtn.Position = UDim2.new(0, 10, 0, 95)
    ToggleBtn.Text = "START SMART AUTO"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", ToggleBtn)

    ToggleBtn.MouseButton1Click:Connect(function()
        EventModule.Running = not EventModule.Running
        EventModule.LastState = nil -- Reset state agar langsung cek waktu saat klik
        ToggleBtn.Text = EventModule.Running and "STOP AUTO" or "START SMART AUTO"
        ToggleBtn.BackgroundColor3 = EventModule.Running and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(40, 40, 40)
    end)

    -- Minimize Logic
    local mini = false
    MiniBtn.MouseButton1Click:Connect(function()
        mini = not mini
        MainFrame:TweenSize(mini and UDim2.new(0, 180, 0, 35) or UDim2.new(0, 180, 0, 150), "Out", "Quad", 0.3, true)
        StatusLabel.Visible, TimeLabel.Visible, ToggleBtn.Visible = not mini, not mini, not mini
    end)

    -- Jalankan Loop dengan mereferensikan label UI
    EventModule.StartLoop(StatusLabel, TimeLabel)
end

return UI
