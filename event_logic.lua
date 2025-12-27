local EventModule = {
    _G_Enabled = false,
    lastState = nil,
    STANDBY_SPOT = Vector3.new(1156.37, 23.79, 1575.65),
    ICEMOON_COORDS = {
        Vector3.new(603.65, -580.58, 8928.17),
        Vector3.new(749.98, -487.11, 8926.19),
    }
}

-- MENGGUNAKAN JAM LOKAL (Sesuai jam di komputer Anda)
function EventModule.getTime()
    return os.date("*t") -- Mengambil waktu lokal perangkat pemain
end

function EventModule.isIcemoonTime()
    local d = EventModule.getTime()
    -- LOGIKA ANDA: Jam Ganjil & Menit 01-30
    local isOdd = (d.hour % 2 ~= 0)
    local isMin = (d.min >= 1 and d.min <= 30)
    return isOdd and isMin
end

function EventModule.StartLoop(StatusLabel, TimeLabel)
    task.spawn(function()
        while true do
            local d = EventModule.getTime()
            
            -- Update teks waktu di UI agar sama dengan jam di Windows Anda
            if TimeLabel then 
                TimeLabel.Text = string.format("Real: %02d:%02d:%02d", d.hour, d.min, d.sec) 
            end
            
            if EventModule._G_Enabled then
                local currentState = EventModule.isIcemoonTime()
                
                if currentState ~= EventModule.lastState then
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
                    EventModule.lastState = currentState
                end
                
                if StatusLabel then
                    if currentState then StatusLabel.Text = "AT ICEMOON (ACTIVE)" 
                    else StatusLabel.Text = "STANDBY (WAITING)" end
                end
            end
            task.wait(1)
        end
    end)
end

return EventModule
