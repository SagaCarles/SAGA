local EventModule = { 
    Running = false,
    LastState = nil,
    -- Koordinat dari skrip Anda
    STANDBY_SPOT = Vector3.new(1156.37, 23.79, 1575.65),
    ICEMOON_COORDS = {
        Vector3.new(603.65, -580.58, 8928.17),
        Vector3.new(749.98, -487.11, 8926.19),
    }
}

-- Logika: Jam Ganjil DAN Menit 01 - 30
function EventModule.IsIcemoonTime()
    local d = os.date("*t")
    local isOddHour = (d.hour % 2 ~= 0)
    local isTargetMinute = (d.min >= 1 and d.min <= 30)
    return isOddHour and isTargetMinute
end

function EventModule.StartLoop(StatusLabel, TimeLabel)
    task.spawn(function()
        while task.wait(1) do
            local d = os.date("*t")
            -- Update Label Waktu (Real Time)
            if TimeLabel then 
                TimeLabel.Text = string.format("Real: %02d:%02d:%02d", d.hour, d.min, d.sec) 
            end

            if EventModule.Running then
                local currentState = EventModule.IsIcemoonTime()
                
                -- Deteksi Perubahan Status untuk Teleport Sekali Saja
                if currentState ~= EventModule.LastState then
                    local lp = game.Players.LocalPlayer
                    local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                    
                    if root then
                        if currentState == true then
                            -- Menit 1-30 Jam Ganjil: TP ke Icemoon
                            if StatusLabel then StatusLabel.Text = "EVENT: TP RANDOM" end
                            local randomCoord = EventModule.ICEMOON_COORDS[math.random(1, #EventModule.ICEMOON_COORDS)]
                            root.CFrame = CFrame.new(randomCoord + Vector3.new(0, 5, 0))
                        else
                            -- Di luar waktu tersebut: TP Balik Standby
                            if StatusLabel then StatusLabel.Text = "OVER: TP BACK" end
                            root.CFrame = CFrame.new(EventModule.STANDBY_SPOT + Vector3.new(0, 5, 0))
                        end
                    end
                    EventModule.LastState = currentState
                end
                
                -- Update Label Status
                if StatusLabel then
                    if currentState then StatusLabel.Text = "AT ICEMOON (ACTIVE)" 
                    else StatusLabel.Text = "STANDBY (WAITING)" end
                end
            end
        end
    end)
end

return EventModule
