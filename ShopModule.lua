local ShopModule = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Mencari Remote untuk Weather Machine
local Net = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net
local WeatherRF = Net:WaitForChild("RF/WeatherMachineVote")

ShopModule.SelectedWeather = "Clear"
ShopModule.AutoBuyEnabled = false

ShopModule.WeatherList = {
    "Clear", "Rain", "Fog", "Thunderstorm", "Snow", "Windy"
}

function ShopModule.BuyWeather()
    if ShopModule.AutoBuyEnabled then
        pcall(function()
            -- Invoke server untuk membeli weather (biaya biasanya 5k-20k koin)
            WeatherRF:InvokeServer(ShopModule.SelectedWeather)
            print("✅ [Shop] Auto Bought Weather: " .. ShopModule.SelectedWeather)
        end)
    end
end

-- Loop untuk mengecek dan membeli
task.spawn(function()
    while true do
        task.wait(10) -- Cek setiap 10 detik
        if ShopModule.AutoBuyEnabled then
            ShopModule.BuyWeather()
        end
    end
end)

return ShopModule
