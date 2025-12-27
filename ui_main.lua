local UI = {}

function UI.Load(TeleportModule, EventModule)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    
    -- Ukuran disesuaikan agar muat menu Teleport dan Smart Auto
    MainFrame.Size = UDim2.new(0, 230, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -115, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    
    -- Tombol Close (X) dan Minimize (S)
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 25, 0, 25); CloseBtn.Position = UDim2.new(1, -30, 0, 5)
    CloseBtn.Text = "X"; CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    Instance.new("UICorner", CloseBtn); CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local MiniBtn = Instance.new("TextButton", MainFrame)
    MiniBtn.Size = UDim2.new(0, 25, 0, 25); MiniBtn.Position = UDim2.new(1, -60, 0, 5)
    MiniBtn.Text = "S"; MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    local RC = Instance.new("UICorner", MiniBtn); RC.CornerRadius = UDim.new(1, 0)

    -- SISTEM TAB (Agar menu tidak hilang)
    local TabEvent = Instance.new("TextButton", MainFrame)
    TabEvent.Size = UDim2.new(0.5, -7, 0, 30); TabEvent.Position = UDim2.new(0, 5, 0, 40)
    TabEvent.Text = "SMART AUTO"; TabEvent.BackgroundColor3 = Color3.fromRGB(30, 100, 200)
    Instance.new("UICorner", TabEvent)

    local TabTp = Instance.new("TextButton", MainFrame)
    TabTp.Size = UDim2.new(0.5, -7, 0, 30); TabTp.Position = UDim2.new(0.5, 2, 0, 40)
    TabTp.Text = "TELEPORT"; TabTp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", TabTp)

    -- HALAMAN SMART AUTO
    local PageEvent = Instance.new("Frame", MainFrame)
    PageEvent.Size = UDim2.new(1, -10, 1, -85); PageEvent.Position = UDim2.new(0, 5, 0, 80)
    PageEvent.BackgroundTransparency = 1; PageEvent.Visible = true

    local StatusLabel = Instance.new("TextLabel", PageEvent)
    StatusLabel.Size = UDim2.new(1, 0, 0, 30); StatusLabel.Position = UDim2.new(0, 0, 0, 10)
    StatusLabel.Text = "SYSTEM READY"; StatusLabel.TextColor3 = Color3.new(1, 1, 1); StatusLabel.BackgroundTransparency = 1

    local TimeLabel = Instance.new("TextLabel", PageEvent)
    TimeLabel.Size = UDim2.new(1, 0, 0, 20); TimeLabel.Position = UDim2.new(0, 0, 0, 40)
    TimeLabel.Text = "00:00:00"; TimeLabel.TextColor3 = Color3.fromRGB(0, 255, 200); TimeLabel.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", PageEvent)
    ToggleBtn.Size = UDim2.new(1, 0, 0, 40); ToggleBtn.Position = UDim2.new(0, 0, 0, 70)
    ToggleBtn.Text = "START SMART AUTO"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", ToggleBtn)

    -- HALAMAN TELEPORT (Data dari tp.lua)
    local PageTp = Instance.new("ScrollingFrame", MainFrame)
    PageTp.Size = UDim2.new(1, -10, 1, -85); PageTp.Position = UDim2.new(0, 5, 0, 80)
    PageTp.BackgroundTransparency = 1; PageTp.Visible = false; PageTp.CanvasSize = UDim2.new(0, 0, 0, 800)
    local layout = Instance.new("UIListLayout", PageTp); layout.HorizontalAlignment = "Center"; layout.Padding = UDim.new(0, 5)

    -- Fungsi Membangun Menu Teleport
    local function buildTp()
        for _, v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        for name, data in pairs(TeleportModule.ISLANDS) do
            local btn = Instance.new("TextButton", PageTp)
            btn.Size = UDim2.new(0, 180, 0, 35); btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                for _, v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
                local back = Instance.new("TextButton", PageTp); back.Size = UDim2.new(0, 180, 0, 30); back.Text = "BACK"; back.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
                back.MouseButton1Click:Connect(buildTp)
                for _, spot in pairs(data) do
                    local sBtn = Instance.new("TextButton", PageTp); sBtn.Size = UDim2.new(0, 180, 0, 35); sBtn.Text = spot[1]
                    sBtn.MouseButton1Click:Connect(function() TeleportModule.To(spot[2]) end)
                end
            end)
        end
    end
    buildTp()

    -- LOGIKA TAB & TOGGLE
    TabEvent.MouseButton1Click:Connect(function() PageEvent.Visible, PageTp.Visible = true, false end)
    TabTp.MouseButton1Click:Connect(function() PageEvent.Visible, PageTp.Visible = false, true end)

    ToggleBtn.MouseButton1Click:Connect(function()
        EventModule.Running = not EventModule.Running
        ToggleBtn.Text = EventModule.Running and "STOP AUTO" or "START SMART AUTO"
        ToggleBtn.BackgroundColor3 = EventModule.Running and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(40, 40, 40)
    end)

    -- Inisialisasi Loop
    EventModule.StartLoop(StatusLabel, TimeLabel)
end

return UI
