local EventModule = { 
    Running = false,
    LastState = nil,
    -- Koordinat baru dari skrip Smart Transition
    STANDBY_SPOT = Vector3.new(1156.37, 23.79, 1575.65),
    ICEMOON_COORDS = {
        Vector3.new(603.65, -580.58, 8928.17),
        Vector3.new(749.98, -487.11, 8926.19),
    }
}

-- Logika Smart: Jam Ganjil & Menit 1-28
function EventModule.IsIcemoonTime()
    local d = os.date("*t")
    return (d.hour % 2 ~= 0) and (d.min >= 1 and d.min <= 28)
end

function EventModule.StartLoop(TeleportModule, StatusLabel)
    task.spawn(function()
        while task.wait(1) do
            if EventModule.Running then
                local currentState = EventModule.IsIcemoonTime()
                
                -- Deteksi Perubahan Status (Transisi)
                if currentState ~= EventModule.LastState then
                    local lp = game.Players.LocalPlayer
                    local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                    
                    if root then
                        if currentState == true then
                            if StatusLabel then StatusLabel.Text = "EVENT: TP RANDOM" end
                            local randomCoord = EventModule.ICEMOON_COORDS[math.random(1, #EventModule.ICEMOON_COORDS)]
                            root.CFrame = CFrame.new(randomCoord + Vector3.new(0, 5, 0))
                        else
                            if StatusLabel then StatusLabel.Text = "OVER: TP BACK" end
                            root.CFrame = CFrame.new(EventModule.STANDBY_SPOT + Vector3.new(0, 5, 0))
                        end
                    end
                    EventModule.LastState = currentState
                end
                
                -- Update Status Text
                if StatusLabel then
                    if currentState then StatusLabel.Text = "AT ICEMOON (SMART)" 
                    else StatusLabel.Text = "STANDBY (SMART)" end
                end
            end
        end
    end)
end

return EventModule
