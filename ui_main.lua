local UI = {}

function UI.Load(TeleportModule, EventModule)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "SmartTransitionUI"
    
    -- MAIN FRAME
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 250, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -125, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BackgroundTransparency = 0.2
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Color = Color3.fromRGB(0, 255, 200)
    Stroke.Thickness = 2

    -- TOMBOL MINIMIZE (S) - Saat Menu Terbuka
    local MiniBtn = Instance.new("TextButton", MainFrame)
    MiniBtn.Size = UDim2.new(0, 30, 0, 30)
    MiniBtn.Position = UDim2.new(1, -70, 0, 10)
    MiniBtn.Text = "S"
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)

    -- TOMBOL CLOSE (X)
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 10)
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

    -- NAVIGATION TABS
    local TabEv = Instance.new("TextButton", MainFrame)
    TabEv.Size = UDim2.new(0.5, -10, 0, 35); TabEv.Position = UDim2.new(0, 7, 0, 50)
    TabEv.Text = "AUTO EVENT"; TabEv.Font = Enum.Font.GothamBold
    TabEv.TextColor3 = Color3.fromRGB(255, 255, 255); TabEv.BackgroundColor3 = Color3.fromRGB(30, 100, 255)
    Instance.new("UICorner", TabEv)

    local TabTp = Instance.new("TextButton", MainFrame)
    TabTp.Size = UDim2.new(0.5, -10, 0, 35); TabTp.Position = UDim2.new(0.5, 3, 0, 50)
    TabTp.Text = "TELEPORT"; TabTp.Font = Enum.Font.GothamBold
    TabTp.TextColor3 = Color3.fromRGB(255, 255, 255); TabTp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", TabTp)

    -- PAGES
    local PageEv = Instance.new("Frame", MainFrame)
    PageEv.Size = UDim2.new(1, -14, 1, -105); PageEv.Position = UDim2.new(0, 7, 0, 100)
    PageEv.BackgroundTransparency = 1

    local PageTp = Instance.new("ScrollingFrame", MainFrame)
    PageTp.Size = UDim2.new(1, -14, 1, -105); PageTp.Position = UDim2.new(0, 7, 0, 100)
    PageTp.BackgroundTransparency = 1; PageTp.Visible = false; PageTp.ScrollBarThickness = 0
    Instance.new("UIListLayout", PageTp).HorizontalAlignment = "Center"

    -- CONTENT (BOLD & WHITE)
    local StatusLabel = Instance.new("TextLabel", PageEv)
    StatusLabel.Size = UDim2.new(1, 0, 0, 40); StatusLabel.Text = "SYSTEM READY"
    StatusLabel.Font = Enum.Font.GothamBold; StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    StatusLabel.BackgroundTransparency = 1; StatusLabel.TextSize = 16

    local TimeLabel = Instance.new("TextLabel", PageEv)
    TimeLabel.Size = UDim2.new(1, 0, 0, 30); TimeLabel.Position = UDim2.new(0, 0, 0, 40)
    TimeLabel.Text = "00:00:00"; TimeLabel.Font = Enum.Font.GothamBold
    TimeLabel.TextColor3 = Color3.fromRGB(0, 255, 200); TimeLabel.BackgroundTransparency = 1

    local ToggleBtn = Instance.new("TextButton", PageEv)
    ToggleBtn.Size = UDim2.new(1, 0, 0, 50); ToggleBtn.Position = UDim2.new(0, 0, 0, 80)
    ToggleBtn.Text = "START SMART AUTO"; ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", ToggleBtn)

    -- TELEPORT LIST BUILDER
    local function buildTp()
        for _,v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        for name, data in pairs(TeleportModule.ISLANDS) do
            local btn = Instance.new("TextButton", PageTp)
            btn.Size = UDim2.new(0, 210, 0, 40); btn.Text = name; btn.Font = Enum.Font.GothamBold
            btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Instance.new("UICorner", btn)
            btn.MouseButton1Click:Connect(function()
                for _,v in pairs(PageTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
                local back = Instance.new("TextButton", PageTp)
                back.Size = UDim2.new(0, 210, 0, 30); back.Text = "BACK"; back.Font = Enum.Font.GothamBold
                back.TextColor3 = Color3.new(1,1,1); back.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
                Instance.new("UICorner", back).MouseButton1Click:Connect(buildTp)
                for _,s in pairs(data) do
                    local sb = Instance.new("TextButton", PageTp)
                    sb.Size = UDim2.new(0, 210, 0, 40); sb.Text = s[1]; sb.Font = Enum.Font.GothamBold
                    sb.TextColor3 = Color3.new(1,1,1); sb.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    Instance.new("UICorner", sb).MouseButton1Click:Connect(function() TeleportModule.To(s[2]) end)
                end
            end)
        end
    end
    buildTp()

    -- LOGIKA MINIMIZE (S CIRCLE)
    local FloatingS = Instance.new("TextButton", ScreenGui)
    FloatingS.Size = UDim2.new(0, 45, 0, 45)
    FloatingS.Position = UDim2.new(0, 50, 0.5, -22)
    FloatingS.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- Background Hitam
    FloatingS.Text = "S"
    FloatingS.Font = Enum.Font.GothamBold
    FloatingS.TextSize = 22
    FloatingS.TextColor3 = Color3.fromRGB(0, 255, 200) -- Huruf S Hijau
    FloatingS.Visible = false
    FloatingS.Draggable = true
    Instance.new("UICorner", FloatingS).CornerRadius = UDim.new(1, 0) -- Lingkaran Sempurna
    
    -- Stroke untuk Floating S agar persis gambar
    local SStroke = Instance.new("UIStroke", FloatingS)
    SStroke.Color = Color3.fromRGB(0, 255, 200)
    SStroke.Thickness = 1.5

    MiniBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        FloatingS.Visible = true
    end)

    FloatingS.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        FloatingS.Visible = false
    end)

    -- LAIN-LAIN
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
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
