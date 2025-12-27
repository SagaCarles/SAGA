local ShopModule = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Fungsi mencari Remote dengan batas waktu (Timeout)
local function GetWeatherRemote()
    -- Langsung return nil jika tidak ketemu dalam 1 detik agar tidak stuck
    local success, net = pcall(function()
        return ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net
    end)
    
    if success and net then
        -- Menambahkan angka 1 di sini sangat penting agar tidak Infinite Yield
        return net:WaitForChild("RF/WeatherMachineVote", 1) 
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

-- Jalankan loop di thread terpisah
task.spawn(function()
    while true do
        task.wait(10)
        if ShopModule.AutoBuyEnabled then
            ShopModule.BuyWeather()
        end
    end
end)

return ShopModule
