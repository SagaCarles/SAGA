local UI = {}

function UI.Load(TeleportModule, EventModule, ShopModule)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "SmartTransitionUI_V2"
    ScreenGui.ResetOnSpawn = false
    
    -- FRAME UTAMA
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 260, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -130, 0.3, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.Active = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Color = Color3.fromRGB(0, 255, 200)
    Stroke.Thickness = 2

    -- TOMBOL CLOSE & MINIMIZE
    local CloseBtn = Instance.new("TextButton", MainFrame)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30); CloseBtn.Position = UDim2.new(1, -35, 0, 10)
    CloseBtn.Text = "X"; CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.TextColor3 = Color3.new(1,1,1)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50); CloseBtn.ZIndex = 100
    Instance.new("UICorner", CloseBtn)

    local MiniBtn = Instance.new("TextButton", MainFrame)
    MiniBtn.Size = UDim2.new(0, 30, 0, 30); MiniBtn.Position = UDim2.new(1, -70, 0, 10)
    MiniBtn.Text = "S"; MiniBtn.Font = Enum.Font.GothamBold; MiniBtn.TextColor3 = Color3.new(0,0,0)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 200); MiniBtn.ZIndex = 100
    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)

    -- TAB NAVIGATION (3 TABS)
    local function createTab(name, pos, active)
        local btn = Instance.new("TextButton", MainFrame)
        btn.Size = UDim2.new(0.33, -8, 0, 35)
        btn.Position = pos
        btn.Text = name
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.TextColor3 = Color3.new(1,1,1)
        btn.BackgroundColor3 = active and Color3.fromRGB(30, 100, 255) or Color3.fromRGB(40, 40, 40)
        Instance.new("UICorner", btn)
        return btn
    end

    local TabEv = createTab("EVENT", UDim2.new(0, 6, 0, 55), true)
    local TabTp = createTab("TELEPORT", UDim2.new(0.33, 4, 0, 55), false)
    local TabShop = createTab("SHOP", UDim2.new(0.66, 2, 0, 55), false)

    -- CONTENT CONTAINER
    local ContentFrame = Instance.new("ScrollingFrame", MainFrame)
    ContentFrame.Size = UDim2.new(1, -16, 1, -110)
    ContentFrame.Position = UDim2.new(0, 8, 0, 100)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = 2
    ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ContentFrame.CanvasSize = UDim2.new(0,0,0,0)
    ContentFrame.ZIndex = 5
    
    local UIList = Instance.new("UIListLayout", ContentFrame)
    UIList.HorizontalAlignment = "Center"
    UIList.Padding = UDim.new(0, 8)

    -- === PAGE: EVENT ===
    local function showEventPage()
        ContentFrame:ClearAllChildren()
        local list = Instance.new("UIListLayout", ContentFrame)
        list.HorizontalAlignment = "Center"; list.Padding = UDim.new(0, 8)

        local StatusLabel = Instance.new("TextLabel", ContentFrame)
        StatusLabel.Size = UDim2.new(1, 0, 0, 40); StatusLabel.Text = "SYSTEM READY"
        StatusLabel.Font = Enum.Font.GothamBold; StatusLabel.TextColor3 = Color3.new(1,1,1)
        StatusLabel.BackgroundTransparency = 1; StatusLabel.TextSize = 18

        local TimeLabel = Instance.new("TextLabel", ContentFrame)
        TimeLabel.Size = UDim2.new(1, 0, 0, 30); TimeLabel.Text = "00:00:00"
        TimeLabel.Font = Enum.Font.GothamBold; TimeLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
        TimeLabel.BackgroundTransparency = 1

        local ToggleBtn = Instance.new("TextButton", ContentFrame)
        ToggleBtn.Size = UDim2.new(0, 210, 0, 50); ToggleBtn.Text = EventModule._G_Enabled and "STOP AUTO" or "START SMART AUTO"
        ToggleBtn.Font = Enum.Font.GothamBold; ToggleBtn.TextColor3 = Color3.new(1,1,1)
        ToggleBtn.BackgroundColor3 = EventModule._G_Enabled and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(35, 35, 35)
        Instance.new("UICorner", ToggleBtn)
        
        ToggleBtn.MouseButton1Click:Connect(function()
            EventModule._G_Enabled = not EventModule._G_Enabled
            ToggleBtn.Text = EventModule._G_Enabled and "STOP AUTO" or "START SMART AUTO"
            ToggleBtn.BackgroundColor3 = EventModule._G_Enabled and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(35, 35, 35)
        end)
        
        EventModule.StartLoop(StatusLabel, TimeLabel)
    end

    -- === PAGE: TELEPORT ===
    local function showTeleportPage()
        ContentFrame:ClearAllChildren()
        local list = Instance.new("UIListLayout", ContentFrame)
        list.HorizontalAlignment = "Center"; list.Padding = UDim.new(0, 6); list.SortOrder = Enum.SortOrder.LayoutOrder

        for name, data in pairs(TeleportModule.ISLANDS) do
            local btn = Instance.new("TextButton", ContentFrame)
            btn.Size = UDim2.new(0, 210, 0, 40); btn.Text = name:upper(); btn.Font = Enum.Font.GothamBold
            btn.TextColor3 = Color3.new(1,1,1); btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Instance.new("UICorner", btn)
            
            btn.MouseButton1Click:Connect(function()
                ContentFrame:ClearAllChildren()
                local l2 = Instance.new("UIListLayout", ContentFrame)
                l2.HorizontalAlignment = "Center"; l2.Padding = UDim.new(0, 6); l2.SortOrder = Enum.SortOrder.LayoutOrder

                local back = Instance.new("TextButton", ContentFrame)
                back.Size = UDim2.new(0, 210, 0, 40); back.Text = "← KEMBALI"; back.Font = Enum.Font.GothamBold
                back.TextColor3 = Color3.new(1,1,1); back.BackgroundColor3 = Color3.fromRGB(150, 0, 0); back.LayoutOrder = -1
                Instance.new("UICorner", back).MouseButton1Click:Connect(showTeleportPage)

                for i, s in pairs(data) do
                    local sb = Instance.new("TextButton", ContentFrame)
                    sb.Size = UDim2.new(0, 210, 0, 40); sb.Text = s[1]:upper(); sb.Font = Enum.Font.GothamBold
                    sb.TextColor3 = Color3.new(1,1,1); sb.BackgroundColor3 = Color3.fromRGB(55, 55, 55); sb.LayoutOrder = i
                    Instance.new("UICorner", sb).MouseButton1Click:Connect(function() TeleportModule.To(s[2]) end)
                end
            end)
        end
    end

    -- === PAGE: SHOP (WEATHER) ===
    local function showShopPage()
        ContentFrame:ClearAllChildren()
        local list = Instance.new("UIListLayout", ContentFrame)
        list.HorizontalAlignment = "Center"; list.Padding = UDim.new(0, 8)

        local Title = Instance.new("TextLabel", ContentFrame)
        Title.Size = UDim2.new(1, 0, 0, 30); Title.Text = "AUTO BUY WEATHER"; Title.Font = Enum.Font.GothamBold
        Title.TextColor3 = Color3.fromRGB(0, 255, 200); Title.BackgroundTransparency = 1; Title.TextSize = 14

        local BuyToggle = Instance.new("TextButton", ContentFrame)
        BuyToggle.Size = UDim2.new(0, 210, 0, 45)
        BuyToggle.Text = ShopModule.AutoBuyEnabled and "STATUS: ACTIVE" or "STATUS: DISABLED"
        BuyToggle.Font = Enum.Font.GothamBold; BuyToggle.TextColor3 = Color3.new(1,1,1)
        BuyToggle.BackgroundColor3 = ShopModule.AutoBuyEnabled and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(45, 45, 45)
        Instance.new("UICorner", BuyToggle)

        BuyToggle.MouseButton1Click:Connect(function()
            ShopModule.AutoBuyEnabled = not ShopModule.AutoBuyEnabled
            BuyToggle.Text = ShopModule.AutoBuyEnabled and "STATUS: ACTIVE" or "STATUS: DISABLED"
            BuyToggle.BackgroundColor3 = ShopModule.AutoBuyEnabled and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(45, 45, 45)
        end)

        local Divider = Instance.new("Frame", ContentFrame)
        Divider.Size = UDim2.new(0.9, 0, 0, 2); Divider.BackgroundColor3 = Color3.fromRGB(0, 255, 200); Divider.BorderSizePixel = 0

        -- List Weather Buttons
        for _, wName in pairs(ShopModule.WeatherList) do
            local wBtn = Instance.new("TextButton", ContentFrame)
            wBtn.Size = UDim2.new(0, 210, 0, 35)
            wBtn.Text = "BUY: " .. wName:upper()
            wBtn.Font = Enum.Font.GothamBold; wBtn.TextColor3 = Color3.new(1,1,1)
            wBtn.BackgroundColor3 = (ShopModule.SelectedWeather == wName) and Color3.fromRGB(0, 100, 80) or Color3.fromRGB(30, 30, 30)
            Instance.new("UICorner", wBtn)

            wBtn.MouseButton1Click:Connect(function()
                ShopModule.SelectedWeather = wName
                showShopPage() -- Refresh UI to show selection
                print("Weather selected: "..wName)
            end)
        end
    end

    -- LOGIKA MINIMIZE (S CIRCLE)
    local FloatingS = Instance.new("TextButton", ScreenGui)
    FloatingS.Size = UDim2.new(0, 50, 0, 50); FloatingS.Position = UDim2.new(0, 20, 0.5, -25)
    FloatingS.BackgroundColor3 = Color3.fromRGB(10, 10, 10); FloatingS.Text = "S"
    FloatingS.Font = Enum.Font.GothamBold; FloatingS.TextColor3 = Color3.fromRGB(0, 255, 200); FloatingS.TextSize = 25
    FloatingS.Visible = false; FloatingS.Draggable = true; Instance.new("UICorner", FloatingS).CornerRadius = UDim.new(1, 0)
    local SStroke = Instance.new("UIStroke", FloatingS); SStroke.Color = Color3.fromRGB(0, 255, 200); SStroke.Thickness = 2

    MiniBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; FloatingS.Visible = true end)
    FloatingS.MouseButton1Click:Connect(function() MainFrame.Visible = true; FloatingS.Visible = false end)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- TAB SWITCHING LOGIC
    TabEv.MouseButton1Click:Connect(function()
        TabEv.BackgroundColor3 = Color3.fromRGB(30, 100, 255)
        TabTp.BackgroundColor3 = Color3.fromRGB(40, 40, 40); TabShop.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        showEventPage()
    end)
    TabTp.MouseButton1Click:Connect(function()
        TabTp.BackgroundColor3 = Color3.fromRGB(30, 100, 255)
        TabEv.BackgroundColor3 = Color3.fromRGB(40, 40, 40); TabShop.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        showTeleportPage()
    end)
    TabShop.MouseButton1Click:Connect(function()
        TabShop.BackgroundColor3 = Color3.fromRGB(30, 100, 255)
        TabEv.BackgroundColor3 = Color3.fromRGB(40, 40, 40); TabTp.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        showShopPage()
    end)

    -- DEFAULT LOAD
    showEventPage()
end

return UI
