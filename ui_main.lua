local UI = {}

function UI.Load(TeleportModule, EventModule)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "SmartTransitionUI"
    ScreenGui.ResetOnSpawn = false
    
    -- MAIN FRAME
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 250, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -125, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BackgroundTransparency = 0.2
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.ZIndex = 1 -- Dasar
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Color = Color3.fromRGB(0, 255, 200)
    Stroke.Thickness = 2

    -- TOMBOL CLOSE (X) - Diberi ZIndex Tinggi agar selalu bisa diklik
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 10)
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 16
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.ZIndex = 10 -- Menjamin tombol di atas segalanya
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

    -- TOMBOL MINIMIZE (S)
    local MiniBtn = Instance.new("TextButton", MainFrame)
    MiniBtn.Size = UDim2.new(0, 30, 0, 30)
    MiniBtn.Position = UDim2.new(1, -70, 0, 10)
    MiniBtn.Text = "S"
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    MiniBtn.ZIndex = 10
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)

    -- NAVIGATION TABS
    local TabEv = Instance.new("TextButton", MainFrame)
    TabEv.Size = UDim2.new(0.5, -12, 0, 35); TabEv.Position = UDim2.new(0, 8, 0, 55)
    TabEv.Text = "AUTO EVENT"; TabEv.Font = Enum.Font.GothamBold
    TabEv.TextColor3 = Color3.fromRGB(255, 255, 255); TabEv.BackgroundColor3 = Color3.fromRGB(30, 100, 255)
    TabEv.ZIndex = 2
    Instance.new("UICorner", TabEv)

    local TabTp = Instance.new("TextButton", MainFrame)
    TabTp.Size = UDim2.new(0.5, -12, 0, 35); TabTp.Position = UDim2.new(0.5, 4, 0, 55)
    TabTp.Text = "TELEPORT"; TabTp.Font = Enum.Font.GothamBold
    TabTp.TextColor3 = Color3.fromRGB(255, 255, 255); TabTp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabTp.ZIndex = 2
    Instance.new("UICorner", TabTp)

    -- PAGES CONTAINER
    local PageEv = Instance.new("Frame", MainFrame)
    PageEv.Size = UDim2.new(1, -16, 1, -110); PageEv.Position = UDim2.new(0, 8, 0, 100)
    PageEv.BackgroundTransparency = 1; PageEv.ZIndex = 2

    local PageTp = Instance.new("ScrollingFrame", MainFrame)
    PageTp.Size = UDim2.new(1, -16, 1, -110); PageTp.Position = UDim2.new(0, 8, 0, 100)
    PageTp.BackgroundTransparency = 1; PageTp.Visible = false; PageTp.ZIndex = 2; PageTp.ScrollBarThickness = 0
    Instance.new("UIListLayout", PageTp).HorizontalAlignment = "Center"

    -- CONTENT (WHITE & BOLD)
    local StatusLabel = Instance.new("TextLabel", PageEv)
    StatusLabel.Size = UDim2.new(1, 0, 0, 40); StatusLabel.Text = "SYSTEM READY"
    StatusLabel.Font = Enum.Font.GothamBold; StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusLabel.BackgroundTransparency = 1; StatusLabel.TextSize = 16; StatusLabel.ZIndex = 3

    local TimeLabel = Instance.new("TextLabel", PageEv)
    TimeLabel.Size = UDim2.new(1, 0, 0, 30); TimeLabel.Position = UDim2.new(0, 0, 0, 40)
    TimeLabel.Text = "00:00:00"; TimeLabel.Font = Enum.Font.GothamBold
    TimeLabel.TextColor3 = Color3.fromRGB(0, 255, 200); TimeLabel.BackgroundTransparency = 1; TimeLabel.ZIndex = 3

    local ToggleBtn = Instance.new("TextButton", PageEv)
    ToggleBtn.Size = UDim2.new(1, 0, 0, 50); ToggleBtn.Position = UDim2.new(0, 0, 0, 85)
    ToggleBtn.Text = "START SMART AUTO"; ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleBtn.ZIndex = 3
    Instance.new("UICorner", ToggleBtn)

    -- TELEPORT LIST
    local function buildTp()
        for _,v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        for name, data in pairs(TeleportModule.ISLANDS) do
            local btn = Instance.new("TextButton", PageTp)
            btn.Size = UDim2.new(0, 215, 0, 40); btn.Text = name; btn.Font = Enum.Font.GothamBold
            btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            btn.ZIndex = 4
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                for _,v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
                local back = Instance.new("TextButton", PageTp)
                back.Size = UDim2.new(0, 215, 0, 30); back.Text = "BACK"; back.Font = Enum.Font.GothamBold
                back.TextColor3 = Color3.new(1,1,1); back.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
                back.ZIndex = 4
                Instance.new("UICorner", back).MouseButton1Click:Connect(buildTp)
                for _,s in pairs(data) do
                    local sb = Instance.new("TextButton", PageTp)
                    sb.Size = UDim2.new(0, 215, 0, 40); sb.Text = s[1]; sb.Font = Enum.Font.GothamBold
                    sb.TextColor3 = Color3.new(1,1,1); sb.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    sb.ZIndex = 4
                    Instance.new("UICorner", sb).MouseButton1Click:Connect(function() TeleportModule.To(s[2]) end)
                end
            end)
        end
    end
    buildTp()

    -- LOGIKA MINIMIZE (LINGKARAN HITAM S HIJAU)
    local FloatingS = Instance.new("TextButton", ScreenGui)
    FloatingS.Size = UDim2.new(0, 50, 0, 50)
    FloatingS.Position = UDim2.new(0, 20, 0.5, -25)
    FloatingS.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    FloatingS.Text = "S"; FloatingS.Font = Enum.Font.GothamBold; FloatingS.TextSize = 25
    FloatingS.TextColor3 = Color3.fromRGB(0, 255, 200)
    FloatingS.Visible = false
    FloatingS.Active = true
    FloatingS.Draggable = true -- Bisa digeser
    Instance.new("UICorner", FloatingS).CornerRadius = UDim.new(1, 0)
    local SStroke = Instance.new("UIStroke", FloatingS); SStroke.Color = Color3.fromRGB(0, 255, 200); SStroke.Thickness = 2

    MiniBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        FloatingS.Visible = true
    end)

    FloatingS.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        FloatingS.Visible = false
    end)

    -- FIX CLOSE LOGIC
    CloseBtn.MouseButton1Click:Connect(function() 
        ScreenGui:Destroy() -- Menghapus seluruh UI
    end)

    -- TAB SWITCHING
    TabEv.MouseButton1Click:Connect(function() PageEv.Visible, PageTp.Visible = true, false end)
    TabTp.MouseButton1Click:Connect(function() PageEv.Visible, PageTp.Visible = false, true end)

    ToggleBtn.MouseButton1Click:Connect(function()
        EventModule._G_Enabled = not EventModule._G_Enabled
        ToggleBtn.Text = EventModule._G_Enabled and "STOP AUTO" or "START SMART AUTO"
        ToggleBtn.BackgroundColor3 = EventModule._G_Enabled and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(30, 30, 30)
    end)

    EventModule.StartLoop(StatusLabel, TimeLabel)
end

return UI
