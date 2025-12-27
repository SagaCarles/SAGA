local EventModule = { 
    Running = false,
    LastState = nil,
    STANDBY_SPOT = Vector3.new(1156.37, 23.79, 1575.65),
    ICEMOON_COORDS = {
        Vector3.new(749.98, -487.11, 8926.19),
    }
}

-- FUNGSI WAKTU AKURAT (WIB)
function EventModule.GetWIB()
    -- os.time() adalah UTC, ditambah 25200 detik (7 jam) untuk ke WIB
    local totalSeconds = os.time() + (7 * 3600)
    return os.date("*t", totalSeconds)
end

-- Logika: Jam Ganjil DAN Menit 01 - 30
function EventModule.IsIcemoonTime()
    local wib = EventModule.GetWIB()
    local hour = wib.hour
    local min = wib.min
    
    -- Cek apakah Jam Ganjil (1,3,5,7,9,11,13,15,17,19,21,23)
    local isOddHour = (hour % 2 ~= 0)
    -- Cek apakah berada di Menit 1 sampai 30
    local isTargetMinute = (min >= 1 and min <= 30)
    
    return isOddHour and isTargetMinute
end

function EventModule.StartLoop(StatusLabel, TimeLabel)
    task.spawn(function()
        while task.wait(1) do
            local wib = EventModule.GetWIB()
            
            -- Update Tampilan Jam di UI agar Anda bisa cek apakah sudah sama dengan jam HP
            if TimeLabel then 
                TimeLabel.Text = string.format("WIB: %02d:%02d:%02d", wib.hour, wib.min, wib.sec) 
            end

            if EventModule.Running then
                local currentState = EventModule.IsIcemoonTime()
                
                -- Hanya Teleport jika ada PERUBAHAN status
                if currentState ~= EventModule.LastState then
                    local lp = game.Players.LocalPlayer
                    local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                    
                    if root then
                        if currentState == true then
                            -- MASUK JADWAL: Teleport ke Icemoon
                            if StatusLabel then StatusLabel.Text = "EVENT START: TP..." end
                            local randomCoord = EventModule.ICEMOON_COORDS[math.random(1, #EventModule.ICEMOON_COORDS)]
                            root.CFrame = CFrame.new(randomCoord + Vector3.new(0, 5, 0))
                        else
                            -- HABIS JADWAL: Teleport Balik
                            if StatusLabel then StatusLabel.Text = "EVENT END: BACK..." end
                            root.CFrame = CFrame.new(EventModule.STANDBY_SPOT + Vector3.new(0, 5, 0))
                        end
                    end
                    EventModule.LastState = currentState
                end
                
                -- Update Label Status agar tahu skrip sedang di mode apa
                if StatusLabel then
                    if currentState then 
                        StatusLabel.Text = "STATUS: AT EVENT" 
                        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Hijau
                    else 
                        StatusLabel.Text = "STATUS: STANDBY" 
                        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Putih
                    end
                end
            end
        end
    end)
end

return EventModule
