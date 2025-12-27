local TeleportModule = {}

TeleportModule.ISLANDS = {
    ["Christmas Island"] = {
        {"Spot 1", CFrame.new(1019.05, 3.59, 1254.61) * CFrame.Angles(0, math.rad(-176.21), 0)},
        {"Spot 2", CFrame.new(1145.67, 24.55, 1529.65) * CFrame.Angles(0, math.rad(-148.56), 0)},
    },
    ["Icemoon"] = {
        {"Spot 1", CFrame.new(582.48, -573.63, 8835.42)},
        {"Spot 2", CFrame.new(612.35, -573.63, 8882.89)},
        {"Spot 3", CFrame.new(608.01, -573.63, 8927.97)}
    },
    ["Kohana Island"] = {
        {"Kohana Spot 1", CFrame.new(-654.44, 17.25, 491.49)},
        {"Kohana Spot 2", CFrame.new(-847.73, 18.70, 373.03)},
        {"Kohana Spot 3", CFrame.new(-911.85, 55.50, 160.77)}
    },
    ["Isle Patung"] = {
        {"Spot 1", CFrame.new(-3659.85, -135.07, -928.12)},
        {"Spot 2", CFrame.new(-3737.82, -135.07, -1010.63)}
    },
    ["Treasure Room"] = {
        {"Spot 1", CFrame.new(-3599.30, -279.70, -1634.21)},
        {"Spot 2", CFrame.new(-3548.21, -279.07, -1646.76)}
    },
    ["Koral"] = {
        {"Spot 1", CFrame.new(-2956.15, 2.76, 2067.67)},
        {"Spot 2", CFrame.new(-3104.19, 6.47, 2218.17)}
    },
    ["Crater"] = {
        {"Spot 1", CFrame.new(984.92, 41.37, 5082.91)},
        {"Spot 2", CFrame.new(1060.04, 2.20, 5129.95)}
    },
    ["Esoteric"] = {
        {"Spot 1", CFrame.new(3218.64, -1293.60, 1366.42)},
        {"Spot 2", CFrame.new(3229.27, -1302.10, 1457.49)}
    },
    ["Tropical"] = {
        {"Spot 1", CFrame.new(-2155.96, 7.04, 3676.44)},
        {"Spot 2", CFrame.new(-2136.48, 82.10, 3670.78)}
    },
    ["Fisherman"] = {
        {"Spot 1", CFrame.new(27.15, 2.67, 2762.31)},
        {"Spot 2", CFrame.new(210.02, 3.26, 2812.87)}
    },
    ["Vulcano"] = {
        {"Spot 1", CFrame.new(-525.94, 37.71, 103.56)},
        {"Spot 2", CFrame.new(-648.62, 45.75, 167.80)}
    },
    ["Ancient"] = {
        {"Jungle Spot 1", CFrame.new(1481.18, 11.14, -298.90)},
        {"Jungle Spot 2", CFrame.new(1599.07, 5.27, -367.52)},
        {"Jungle Spot 3", CFrame.new(1496.05, 7.42, -437.42)},
        {"Kuil Spot 1", CFrame.new(1428.70, 4.87, -589.05)},
        {"Kuil Spot 2", CFrame.new(1469.92, -21.91, -618.17)},
        {"Underground Cellar", CFrame.new(2115.85, -91.20, -733.93)},
        {"Ruin Spot 1", CFrame.new(6046.69, -588.60, 4609.24)},
        {"Ruin Spot 2", CFrame.new(6039.91, -585.92, 4714.49)}
    }
}

function TeleportModule.To(cf)
    local lp = game.Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
        lp.Character.HumanoidRootPart.CFrame = cf
    end
end

return TeleportModule
