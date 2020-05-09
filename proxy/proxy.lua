local proxyMenubar = hs.menubar.new()

function updateMenubarForProxy(title, tip)
    proxyMenubar:setTitle(title)
    proxyMenubar:setTooltip(tip)
end

function proxyOn()
    cmd = "/usr/sbin/networksetup -setsocksfirewallproxystate Wi-fi on"
    print(cmd)
    updateMenubarForProxy("✅", "Proxy is on, CLICK or PARSE ⌃⌥⌘ + P to switch")

    hs.notify.new({
        title = "Proxy is turn on, ✅✅✅",
        -- informativeText = "✅✅✅",
        hasActionButton = false,
        autoWithdraw = true,
    }):send()

    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    print(result)
end

function proxyOff(state)
    cmd = "/usr/sbin/networksetup -setsocksfirewallproxystate Wi-fi off"
    print(cmd)
    updateMenubarForProxy("❌", "Proxy is off, CLICK or PARSE ⌃⌥⌘ + P to switch")

    hs.notify.new({
            title = "Proxy is turn off, ❌❌❌",
            hasActionButton = false,
            autoWithdraw = true,
    }):send()
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    print(result)
end

-- get proxy stat
-- return 1 when proxy is on, return 0 when proxy is off
function getProxyStat()
    cmd = "networksetup -getsocksfirewallproxy Wi-fi"
    result,o = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    -- hs.alert(o)
    if string.find(o, "No") == 10
    then
        return 0
    end

    if string.find(o, "Yes") == 10
    then
        return 1
    end
end

function switchProxy()
    s = getProxyStat()

    if s == 0
    then
        proxyOn()
    end

    if s == 1
    then
        proxyOff()
    end
end

function init()
    s = getProxyStat()
    if s == 0
    then
        updateMenubarForProxy("❌", "Proxy is off, CLICK or PARSE ⌃⌥⌘ + P to switch")
    end

    if s == 1
    then
        updateMenubarForProxy("✅", "Proxy is on, CLICK or PARSE ⌃⌥⌘ + P to switch")
    end

    proxyMenubar:setClickCallback(switchProxy)
end

-- init
init()

-- bind hotkey
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "P", function()
    switchProxy()
end)
