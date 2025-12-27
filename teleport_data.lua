local TeleportModule = {}

-- Database Koordinat
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
        {"Kohana Spot 1", CFrame.new(-654.44, 17.25, 491.49) * CFrame.Angles(0, math.rad(-81.93), 0)},
        {"Kohana Spot 2", CFrame.new(-847.73, 18.70, 373.03) * CFrame.Angles(0, math.rad(88.00), 0)},
        {"Kohana Spot 3", CFrame.new(-911.85, 55.50, 160.77) * CFrame.Angles(0, math.rad(-87.52), 0)}
    },
    ["Isle Patung"] = {
        {"Spot 1", CFrame.new(-3659.85, -135.07, -928.12) * CFrame.Angles(0, math.rad(81.23), 0)},
        {"Spot 2", CFrame.new(-3737.82, -135.07, -1010.63) * CFrame.Angles(0, math.rad(-162.12), 0)}
    },
    ["Treasure Room"] = {
        {"Spot 1", CFrame.new(-3599.30, -279.70, -1634.21) * CFrame.Angles(0, math.rad(125.51), 0)},
        {"Spot 2", CFrame.new(-3548.21, -279.07, -1646.76) * CFrame.Angles(0, math.rad(89.03), 0)}
    },
    ["Koral"] = {
        {"Spot 1", CFrame.new(-2956.15, 2.76, 2067.67) * CFrame.Angles(0, math.rad(-0.68), 0)},
        {"Spot 2", CFrame.new(-3104.19, 6.47, 2218.17) * CFrame.Angles(0, math.rad(-103.54), 0)}
    },
    ["Crater"] = {
        {"Spot 1", CFrame.new(984.92, 41.37, 5082.91) * CFrame.Angles(0, math.rad(169.51), 0)},
        {"Spot 2", CFrame.new(1060.04, 2.20, 5129.95) * CFrame.Angles(0, math.rad(50.02), 0)}
    },
    ["Esoteric"] = {
        {"Spot 1", CFrame.new(3218.64, -1293.60, 1366.42) * CFrame.Angles(0, math.rad(-64.01), 0)},
        {"Spot 2", CFrame.new(3229.27, -1302.10, 1457.49) * CFrame.Angles(0, math.rad(-22.97), 0)}
    },
    ["Tropical"] = {
        {"Spot 1", CFrame.new(-2155.96, 7.04, 3676.44) * CFrame.Angles(0, math.rad(9.36), 0)},
        {"Spot 2", CFrame.new(-2136.48, 82.10, 3670.78) * CFrame.Angles(0, math.rad(-3.02), 0)}
    },
    ["Fisherman"] = {
        {"Spot 1", CFrame.new(27.15, 2.67, 2762.31) * CFrame.Angles(0, math.rad(-1.58), 0)},
        {"Spot 2", CFrame.new(210.02, 3.26, 2812.87) * CFrame.Angles(0, math.rad(-53.63), 0)}
     },
    ["Vulcano"] = {
        {"Spot 1", CFrame.new(-525.94, 37.71, 103.56) * CFrame.Angles(0, math.rad(23.78), 0)},
        {"Spot 2", CFrame.new(-648.62, 45.75, 167.80) * CFrame.Angles(0, math.rad(-170.93), 0)}
   },
    ["Ancient"] = {
        {"Jungle Spot 1", CFrame.new(1481.18, 11.14, -298.90) * CFrame.Angles(0, math.rad(-40.22), 0)},
        {"Jungle Spot 2", CFrame.new(1599.07, 5.27, -367.52) * CFrame.Angles(0, math.rad(-60.04), 0)},
        {"Jungle Spot 3", CFrame.new(1496.05, 7.42, -437.42) * CFrame.Angles(0, math.rad(-90.34), 0)},
        {"Kuil Spot 1", CFrame.new(1428.70, 4.87, -589.05) * CFrame.Angles(0, math.rad(-82.94), 0)},
        {"Kuil Spot 2", CFrame.new(1469.92, -21.91, -618.17) * CFrame.Angles(0, math.rad(121.72), 0)},
        {"Underground Cellar", CFrame.new(2115.85, -91.20, -733.93) * CFrame.Angles(0, math.rad(-123.50),0)},
        {"Ruin Spot 1", CFrame.new(6046.69, -588.60, 4609.24) * CFrame.Angles(0, math.rad(-155.96), 0)},
        {"Ruin Spot 2", CFrame.new(6039.91, -585.92, 4714.49) * CFrame.Angles(0, math.rad(-5.95), 0)}
    }
}

function TeleportModule.To(targetCF)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = targetCF
    end
end

return TeleportModule
