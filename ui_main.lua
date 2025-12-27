local UI = {}

function UI.Load(TeleportModule, EventModule)
    local sg = Instance.new("ScreenGui", game.CoreGui)
    local mf = Instance.new("Frame", sg)
    mf.Size, mf.Position = UDim2.new(0, 230, 0, 320), UDim2.new(0.5, -115, 0.3, 0)
    mf.BackgroundColor3, mf.Active, mf.Draggable = Color3.fromRGB(15, 15, 15), true, true
    Instance.new("UICorner", mf)
    Instance.new("UIStroke", mf).Color = Color3.fromRGB(60, 60, 60)

    -- Tombol Close
    local close = Instance.new("TextButton", mf)
    close.Size, close.Position, close.Text = UDim2.new(0, 25, 0, 25), UDim2.new(1, -30, 0, 5), "X"
    close.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    close.MouseButton1Click:Connect(function() sg:Destroy() end)

    -- Navigasi Tab
    local tabEv = Instance.new("TextButton", mf)
    tabEv.Size, tabEv.Position, tabEv.Text = UDim2.new(0.5, -7, 0, 30), UDim2.new(0, 5, 0, 40), "Auto Event"
    tabEv.BackgroundColor3 = Color3.fromRGB(30, 100, 200)

    local tabTp = Instance.new("TextButton", mf)
    tabTp.Size, tabTp.Position, tabTp.Text = UDim2.new(0.5, -7, 0, 30), UDim2.new(0.5, 2, 0, 40), "Teleport"
    tabTp.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

    -- Kontainer Halaman
    local pEv = Instance.new("Frame", mf)
    pEv.Size, pEv.Position, pEv.Visible = UDim2.new(1, -10, 1, -85), UDim2.new(0, 5, 0, 80), true
    pEv.BackgroundTransparency = 1

    local pTp = Instance.new("ScrollingFrame", mf)
    pTp.Size, pTp.Position, pTp.Visible = UDim2.new(1, -10, 1, -85), UDim2.new(0, 5, 0, 80), false
    pTp.BackgroundTransparency, pTp.CanvasSize = 1, UDim2.new(0, 0, 0, 800)
    Instance.new("UIListLayout", pTp).HorizontalAlignment = "Center"

    -- Toggle Auto Event
    local tog = Instance.new("TextButton", pEv)
    tog.Size, tog.Text = UDim2.new(0.9, 0, 0, 45), "Auto Icemoon: OFF"
    tog.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    tog.MouseButton1Click:Connect(function()
        EventModule.Running = not EventModule.Running
        tog.Text = EventModule.Running and "Auto Icemoon: ON" or "Auto Icemoon: OFF"
        tog.BackgroundColor3 = EventModule.Running and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
    end)

    -- Build Menu Teleport
    local function buildMenu()
        for _, c in pairs(pTp:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        for name, data in pairs(TeleportModule.ISLANDS) do
            local btn = Instance.new("TextButton", pTp)
            btn.Size, btn.Text = UDim2.new(0, 190, 0, 35), name
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            btn.MouseButton1Click:Connect(function()
                for _, c in pairs(pTp:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
                local back = Instance.new("TextButton", pTp)
                back.Size, back.Text, back.BackgroundColor3 = UDim2.new(0, 190, 0, 30), "BACK", Color3.fromRGB(100, 40, 40)
                back.MouseButton1Click:Connect(buildMenu)
                for _, spot in pairs(data) do
                    local sb = Instance.new("TextButton", pTp)
                    sb.Size, sb.Text = UDim2.new(0, 190, 0, 35), spot[1]
                    sb.MouseButton1Click:Connect(function() TeleportModule.To(spot[2]) end)
                end
            end)
        end
    end
    buildMenu()

    -- Tab Logic
    tabEv.MouseButton1Click:Connect(function() pEv.Visible, pTp.Visible = true, false end)
    tabTp.MouseButton1Click:Connect(function() pEv.Visible, pTp.Visible = false, true end)
end

return UI
