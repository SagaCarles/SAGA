local ShopModule = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Gunakan pcall dan timeout agar tidak Infinite Yield
local function GetWeatherRemote()
    local success, net = pcall(function()
        return ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net
    end)
    
    if success and net then
        -- Tunggu hanya 5 detik, jika tidak ada jangan bikin stuck
        return net:WaitForChild("RF/WeatherMachineVote", 5)
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
                print("✅ [Shop] Auto Bought Weather: " .. ShopModule.SelectedWeather)
            end)
        else
            warn("⚠️ [Shop] Weather Machine tidak ditemukan di server ini.")
        end
    end
end

-- Loop pengecekan
task.spawn(function()
    while true do
        task.wait(10)
        if ShopModule.AutoBuyEnabled then
            ShopModule.BuyWeather()
        end
    end
end)

return ShopModule
