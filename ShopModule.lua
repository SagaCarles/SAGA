local ShopModule = {}
ShopModule.SelectedWeather = "Clear"
ShopModule.AutoBuyEnabled = false
ShopModule.WeatherList = {"Clear", "Rain", "Fog", "Thunderstorm", "Snow", "Windy"}

-- Fungsi ini hanya jalan saat tombol di klik, bukan saat loading
function ShopModule.BuyWeather()
    if not ShopModule.AutoBuyEnabled then return end
    
    pcall(function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local net = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net
        local remote = net:FindFirstChild("RF/WeatherMachineVote")
        if remote then
            remote:InvokeServer(ShopModule.SelectedWeather)
        end
    end)
end

task.spawn(function()
    while true do
        task.wait(10)
        if ShopModule.AutoBuyEnabled then ShopModule.BuyWeather() end
    end
end)

return ShopModule
