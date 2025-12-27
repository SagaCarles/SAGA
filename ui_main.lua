local UI = {}

function UI.Load(TeleportModule, EventModule)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 230, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -115, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame)

    -- Tombol Close & Mini S (Persis gambar Anda)
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 25, 0, 25); CloseBtn.Position = UDim2.new(1, -30, 0, 5)
    CloseBtn.Text = "X"; CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Instance.new("UICorner", CloseBtn); CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    local MiniBtn = Instance.new("TextButton", MainFrame)
    MiniBtn.Size = UDim2.new(0, 25, 0, 25); MiniBtn.Position = UDim2.new(1, -60, 0, 5)
    MiniBtn.Text = "S"; MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    local RC = Instance.new("UICorner", MiniBtn); RC.CornerRadius = UDim.new(1, 0)

    -- Tab Menu
    local TabEv = Instance.new("TextButton", MainFrame)
    TabEv.Size = UDim2.new(0.5, -7, 0, 30); TabEv.Position = UDim2.new(0, 5, 0, 40)
    TabEv.Text = "AUTO EVENT"; TabEv.BackgroundColor3 = Color3.fromRGB(30, 100, 200)
    Instance.new("UICorner", TabEv)

    local TabTp = Instance.new("TextButton", MainFrame)
    TabTp.Size = UDim2.new(0.5, -7, 0, 30); TabTp.Position = UDim2.new(0.5, 2, 0, 40)
    TabTp.Text = "TELEPORT"; TabTp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", TabTp)

    -- Container
    local PageEv = Instance.new("Frame", MainFrame)
    PageEv.Size = UDim2.new(1, -10, 1, -85); PageEv.Position = UDim2.new(0, 5, 0, 80)
    PageEv.BackgroundTransparency = 1; PageEv.Visible = true

    local PageTp = Instance.new("ScrollingFrame", MainFrame)
    PageTp.Size = UDim2.new(1, -10, 1, -85); PageTp.Position = UDim2.new(0, 5, 0, 80)
    PageTp.BackgroundTransparency = 1; PageTp.Visible = false; PageTp.CanvasSize = UDim2.new(0, 0, 0, 800)
    Instance.new("UIListLayout", PageTp).HorizontalAlignment = "Center"

    -- SMART AUTO CONTENT (Dari skrip Anda)
    local StatusLabel = Instance.new("TextLabel", PageEv)
    StatusLabel.Size = UDim2.new(1, 0, 0, 30); StatusLabel.Position = UDim2.new(0, 0, 0, 10)
    StatusLabel.Text = "SYSTEM READY"; StatusLabel.TextColor3 = Color3.new(1, 1, 1); StatusLabel.BackgroundTransparency = 1

    local TimeLabel = Instance.new("TextLabel", PageEv)
    TimeLabel.Size = UDim2.new(1, 0, 0, 20); TimeLabel.Position = UDim2.new(0, 0, 0, 40)
    TimeLabel.Text = "00:00:00"; TimeLabel.TextColor3 = Color3.fromRGB(0, 255, 200); TimeLabel.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", PageEv)
    ToggleBtn.Size = UDim2.new(1, 0, 0, 40); ToggleBtn.Position = UDim2.new(0, 0, 0, 70)
    ToggleBtn.Text = "START SMART AUTO"; ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", ToggleBtn)

    -- TELEPORT CONTENT (Membangun Menu)
    local function buildTp()
        for _,v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        for name, data in pairs(TeleportModule.ISLANDS) do
            local btn = Instance.new("TextButton", PageTp)
            btn.Size = UDim2.new(0, 190, 0, 35); btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                for _,v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
                local back = Instance.new("TextButton", PageTp); back.Size = UDim2.new(0,190,0,30); back.Text = "BACK"; back.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
                back.MouseButton1Click:Connect(buildTp)
                for _,s in pairs(data) do
                    local sb = Instance.new("TextButton", PageTp); sb.Size = UDim2.new(0,190,0,35); sb.Text = s[1]
                    sb.MouseButton1Click:Connect(function() TeleportModule.To(s[2]) end)
                end
            end)
        end
    end
    buildTp()

    -- LOGIKA
    TabEv.MouseButton1Click:Connect(function() PageEv.Visible, PageTp.Visible = true, false end)
    TabTp.MouseButton1Click:Connect(function() PageEv.Visible, PageTp.Visible = false, true end)

    ToggleBtn.MouseButton1Click:Connect(function()
        EventModule._G_Enabled = not EventModule._G_Enabled
        EventModule.lastState = nil
        ToggleBtn.Text = EventModule._G_Enabled and "STOP AUTO" or "START SMART AUTO"
        ToggleBtn.BackgroundColor3 = EventModule._G_Enabled and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(40, 40, 40)
    end)

    local isMinimized = false
    MiniBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        MainFrame:TweenSize(isMinimized and UDim2.new(0, 230, 0, 35) or UDim2.new(0, 230, 0, 320), "Out", "Quad", 0.3, true)
        StatusLabel.Visible, TimeLabel.Visible, ToggleBtn.Visible, TabEv.Visible, TabTp.Visible, PageTp.Visible = not isMinimized, not isMinimized, not isMinimized, not isMinimized, not isMinimized, (not isMinimized and PageTp.Visible)
    end)

    EventModule.StartLoop(StatusLabel, TimeLabel)
end

return UI
