local UI = {}

function UI.Load(TeleportModule, EventModule)
    local sg = Instance.new("ScreenGui", game.CoreGui)
    local mf = Instance.new("Frame", sg)
    mf.Size, mf.Position = UDim2.new(0, 200, 0, 250), UDim2.new(0.5, -100, 0.4, 0)
    mf.BackgroundColor3, mf.Active, mf.Draggable = Color3.fromRGB(20, 20, 20), true, true
    Instance.new("UICorner", mf)

    -- Tombol Close & Mini (S)
    local close = Instance.new("TextButton", mf)
    close.Size, close.Position, close.Text = UDim2.new(0, 25, 0, 25), UDim2.new(1, -30, 0, 5), "X"
    close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    close.MouseButton1Click:Connect(function() sg:Destroy() end)

    -- TAB NAVIGATION
    local tEv = Instance.new("TextButton", mf)
    tEv.Size, tEv.Position, tEv.Text = UDim2.new(0.5, -5, 0, 30), UDim2.new(0, 3, 0, 35), "EVENT"
    tEv.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

    local tTp = Instance.new("TextButton", mf)
    tTp.Size, tTp.Position, tTp.Text = UDim2.new(0.5, -5, 0, 30), UDim2.new(0.5, 2, 0, 35), "TELEPORT"
    tTp.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

    -- PAGES
    local pEv = Instance.new("Frame", mf)
    pEv.Size, pEv.Position, pEv.Visible = UDim2.new(1, -10, 1, -75), UDim2.new(0, 5, 0, 70), true
    pEv.BackgroundTransparency = 1

    local pTp = Instance.new("ScrollingFrame", mf)
    pTp.Size, pTp.Position, pTp.Visible = UDim2.new(1, -10, 1, -75), UDim2.new(0, 5, 0, 70), false
    pTp.BackgroundTransparency, pTp.CanvasSize = 1, UDim2.new(0, 0, 0, 1000)
    Instance.new("UIListLayout", pTp).HorizontalAlignment = "Center"

    -- CONTENT EVENT
    local StatusLabel = Instance.new("TextLabel", pEv)
    StatusLabel.Size, StatusLabel.Position, StatusLabel.Text = UDim2.new(1,0,0,20), UDim2.new(0,0,0,5), "READY"
    StatusLabel.TextColor3, StatusLabel.BackgroundTransparency = Color3.new(1,1,1), 1

    local TimeLabel = Instance.new("TextLabel", pEv)
    TimeLabel.Size, TimeLabel.Position, TimeLabel.Text = UDim2.new(1,0,0,20), UDim2.new(0,0,0,25), "00:00"
    TimeLabel.TextColor3, TimeLabel.BackgroundTransparency = Color3.fromRGB(0, 255, 200), 1

    local tog = Instance.new("TextButton", pEv)
    tog.Size, tog.Position, tog.Text = UDim2.new(0.9,0,0,35), UDim2.new(0.05,0,0,50), "START SMART AUTO"
    tog.BackgroundColor3 = Color3.fromRGB(40,40,40)
    tog.MouseButton1Click:Connect(function()
        EventModule.Running = not EventModule.Running
        tog.Text = EventModule.Running and "STOP AUTO" or "START SMART AUTO"
        tog.BackgroundColor3 = EventModule.Running and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(40,40,40)
    end)

    -- CONTENT TELEPORT (Membangun List dari TeleportModule)
    local function build()
        for _,v in pairs(pTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        for name, data in pairs(TeleportModule.ISLANDS) do
            local b = Instance.new("TextButton", pTp)
            b.Size, b.Text = UDim2.new(0, 160, 0, 30), name
            b.BackgroundColor3 = Color3.fromRGB(40,40,40)
            b.MouseButton1Click:Connect(function()
                for _,v in pairs(pTp:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
                local back = Instance.new("TextButton", pTp); back.Size, back.Text = UDim2.new(0,160,0,25), "BACK"; back.BackgroundColor3 = Color3.fromRGB(80,20,20)
                back.MouseButton1Click:Connect(build)
                for _,spot in pairs(data) do
                    local sb = Instance.new("TextButton", pTp); sb.Size, sb.Text = UDim2.new(0,160,0,30), spot[1]
                    sb.MouseButton1Click:Connect(function() TeleportModule.To(spot[2]) end)
                end
            end)
        end
    end
    build()

    -- Tab Switch
    tEv.MouseButton1Click:Connect(function() pEv.Visible, pTp.Visible = true, false end)
    tTp.MouseButton1Click:Connect(function() pEv.Visible, pTp.Visible = false, true end)

    EventModule.StartLoop(StatusLabel, TimeLabel, TeleportModule)
end

return UI
