local EventModule = { Running = false }

function EventModule.IsOddHour()
    local hour = os.date("!*t", os.time() + 25200).hour -- WIB (UTC+7)
    return hour % 2 ~= 0
end

function EventModule.StartLoop(TeleportModule)
    task.spawn(function()
        while task.wait(5) do
            if EventModule.Running and EventModule.IsOddHour() then
                -- Teleport ke Icemoon Spot 1
                local spot = TeleportModule.ISLANDS["Icemoon"][1][2]
                TeleportModule.To(spot)
                task.wait(60) -- Tunggu 1 menit agar tidak spam
            end
        end
    end)
end

return EventModule
