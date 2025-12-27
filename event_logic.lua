local EventModule = {
    _G_Enabled = false,
    lastState = nil,
    STANDBY_SPOT = Vector3.new(1156.37, 23.79, 1575.65),
    ICEMOON_COORDS = {
        Vector3.new(603.65, -580.58, 8928.17),
        Vector3.new(749.98, -487.11, 8926.19),
    }
}

-- FUNGSI UNTUK MENDAPATKAN WAKTU WIB YANG AKURAT
function EventModule.getWIBTime()
    -- os.time() adalah waktu UTC universal
    -- Kita tambah 25200 detik (7 jam * 3600 detik) untuk menjadi WIB
    local wibSeconds = os.time() + 25200
    return os.date("!*t", wibSeconds) -- Menggunakan format UTC (!) agar penambahan manual kita tidak kacau
end

function EventModule.isIcemoonTime()
    local d = EventModule.getWIBTime()
    -- SYARAT: Jam Ganjil (1, 3, 5, 7, 9, 11, dst)
    local isOddHour = (d.hour % 2 ~= 0)
    -- SYARAT: Menit 01 sampai 30
    local isTargetMinute = (d.min >= 1 and d.min <= 30)
    
    return isOddHour and isTargetMinute
end

function EventModule.StartLoop(StatusLabel, TimeLabel)
    task.spawn(function()
        while true do
            -- Ambil data waktu WIB terbaru setiap detik
            local d = EventModule.getWIBTime()
            
            -- Update teks waktu di UI agar sama dengan jam HP Anda
            if TimeLabel then 
                TimeLabel.Text = string.format("WIB: %02d:%02d:%02d", d.hour, d.min, d.sec) 
            end
            
            if EventModule._G_Enabled then
                local currentState = EventModule.isIcemoonTime()
                
                -- Logika Transisi (Teleport hanya saat status berubah)
                if currentState ~= EventModule.lastState then
                    local lp = game.Players.LocalPlayer
                    local char = lp.Character
                    local root = char and char:FindFirstChild("HumanoidRootPart")
                    
                    if root then
                        if currentState == true then
                            -- Waktunya Event (Ganjil & Menit 1-30)
                            if StatusLabel then StatusLabel.Text = "EVENT: TELEPORTING..." end
                            local randomCoord = EventModule.ICEMOON_COORDS[math.random(1, #EventModule.ICEMOON_COORDS)]
                            root.CFrame = CFrame.new(randomCoord + Vector3.new(0, 5, 0))
                        else
                            -- Waktu Event Selesai (Menit > 30 atau Jam Genap)
                            if StatusLabel then StatusLabel.Text = "OVER: GOING BACK..." end
                            root.CFrame = CFrame.new(EventModule.STANDBY_SPOT + Vector3.new(0, 5, 0))
                        end
                    end
                    EventModule.lastState = currentState
                end
                
                -- Update Label Status di layar
                if StatusLabel then
                    if currentState then 
                        StatusLabel.Text = "STATUS: AT ICEMOON" 
                    else 
                        StatusLabel.Text = "STATUS: STANDBY" 
                    end
                end
            end
            task.wait(1)
        end
    end)
end

return EventModule
