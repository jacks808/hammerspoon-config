print('==================================================')
require "headphone.headphone"
require "hotkey.hotkey"
require "ime.ime"
require "reload.reload"
require "usb.usb"
require "wifi.wifi"
require "window.window"
require "clipboard.clipboard"
-- require "statuslets.statuslets"
require "volume.volume"
require "weather.weather"
require "proxy.proxy"
-- require "speaker.speaker"
require "battery.battery"
-- require "pomodoor.pomodoor"
require "time.time"
require "wallpaper.BingWallpaper"

-- Private use
if (hs.host.localizedName() == 'Keen\'s MBP 16') then
	require("autoscript.autoscript")
end
