local EventModule = { 
    Running = false, 
    LastState = nil,
    STANDBY_SPOT = Vector3.new(1156.37, 23.79, 1575.65),
    ICEMOON_COORDS = {
        Vector3.new(603.65, -580.58, 8928.17),
        Vector3.new(749.98, -487.11, 8926.19),
    }
}

function EventModule.StartLoop(StatusLabel, TimeLabel)
    task.spawn(function()
        while task.wait(1) do
            local d = os.date("*t", os.time() + 25200) -- WIB Fix
            if TimeLabel then TimeLabel.Text = string.format("WIB: %02d:%02d:%02d", d.hour, d.min, d.sec) end
            
            if EventModule.Running then
                local isOdd = (d.hour % 2 ~= 0)
                local isMinute = (d.min >= 1 and d.min <= 30)
                local currentState = (isOdd and isMinute)

                if currentState ~= EventModule.LastState then
                    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        if currentState then
                            local target = EventModule.ICEMOON_COORDS[math.random(1, #EventModule.ICEMOON_COORDS)]
                            root.CFrame = CFrame.new(target + Vector3.new(0, 5, 0))
                            if StatusLabel then StatusLabel.Text = "AT ICEMOON" end
                        else
                            root.CFrame = CFrame.new(EventModule.STANDBY_SPOT + Vector3.new(0, 5, 0))
                            if StatusLabel then StatusLabel.Text = "STANDBY" end
                        end
                    end
                    EventModule.LastState = currentState
                end
            end
        end
    end)
end

return EventModule
