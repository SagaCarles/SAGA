local ShopModule = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Fungsi aman mencari Remote tanpa bikin UI stuck
local function GetWeatherRemote()
    local netPath = ReplicatedStorage:FindFirstChild("Packages")
    if netPath then
        local index = netPath:FindFirstChild("_Index")
        if index then
            -- Cari sleitnick_net secara dinamis
            for _, child in pairs(index:GetChildren()) do
                if child.Name:find("sleitnick_net") then
                    local net = child:FindFirstChild("net")
                    if net then
                        -- Tunggu maksimal 2 detik saja agar tidak Infinite Yield
                        return net:WaitForChild("RF/WeatherMachineVote", 2)
                    end
                end
            end
        end
    end
    return nil
end

ShopModule.SelectedWeather = "Clear"
ShopModule.AutoBuyEnabled = false
ShopModule.WeatherList = {"Clear", "Rain", "Fog", "Thunderstorm", "Snow", "Windy"}

function ShopModule.BuyWeather()
    if ShopModule.AutoBuyEnabled then
        local WeatherRF = GetWeatherRemote()
        if WeatherRF then
            pcall(function()
                WeatherRF:InvokeServer(ShopModule.SelectedWeather)
            end)
        end
    end
end

-- Loop berjalan di background agar tidak mengganggu loading UI
task.spawn(function()
    while true do
        task.wait(10)
        if ShopModule.AutoBuyEnabled then
            ShopModule.BuyWeather()
        end
    end
end)

return ShopModule
