local EventModule = {
    _G_Enabled = false,
    lastState = nil,
    STANDBY_SPOT = Vector3.new(1156.37, 23.79, 1575.65),
    ICEMOON_COORDS = {
        Vector3.new(603.65, -580.58, 8928.17),
        Vector3.new(749.98, -487.11, 8926.19),
    }
}

-- FUNGSI FIX WIB (GMT+7)
function EventModule.getWIB()
    -- os.time() adalah UTC detik. Tambah 7 jam (25200 detik)
    local timestamp = os.time() + 25200
    local t = os.date("!*t", timestamp) -- Tanda '!' memaksa format UTC agar tidak tabrakan dengan zona waktu server
    return t
end

function EventModule.isIcemoonTime()
    local d = EventModule.getWIB()
    -- Logika Anda: Jam Ganjil DAN Menit 01-30
    local isOdd = (d.hour % 2 ~= 0)
    local isMin = (d.min >= 1 and d.min <= 30)
    return isOdd and isMin
end

function EventModule.StartLoop(StatusLabel, TimeLabel)
    task.spawn(function()
        while true do
            local d = EventModule.getWIB()
            
            -- Menampilkan jam di UI agar Anda bisa kroscek
            if TimeLabel then 
                TimeLabel.Text = string.format("WIB: %02d:%02d:%02d", d.hour, d.min, d.sec) 
            end
            
            if EventModule._G_Enabled then
                local currentState = EventModule.isIcemoonTime()
                
                -- Deteksi perubahan untuk Teleport (Smart Transition)
                if currentState ~= EventModule.lastState then
                    local lp = game.Players.LocalPlayer
                    local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                    
                    if root then
                        if currentState == true then
                            -- Jika Jam Ganjil & Menit 1-30
                            if StatusLabel then StatusLabel.Text = "EVENT: TP RANDOM" end
                            local randomCoord = EventModule.ICEMOON_COORDS[math.random(1, #EventModule.ICEMOON_COORDS)]
                            root.CFrame = CFrame.new(randomCoord + Vector3.new(0, 5, 0))
                        else
                            -- Jika sudah lewat menit 30 atau jam genap
                            if StatusLabel then StatusLabel.Text = "OVER: TP BACK" end
                            root.CFrame = CFrame.new(EventModule.STANDBY_SPOT + Vector3.new(0, 5, 0))
                        end
                    end
                    EventModule.lastState = currentState
                end
                
                -- Update Status
                if StatusLabel then
                    if currentState then StatusLabel.Text = "STATUS: AT ICEMOON" 
                    else StatusLabel.Text = "STATUS: STANDBY" end
                end
            end
            task.wait(1)
        end
    end)
end

return EventModule
