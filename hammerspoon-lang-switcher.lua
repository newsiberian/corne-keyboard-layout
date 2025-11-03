-- Hammerspoon Language Switcher for ZMK keyboard
-- Save this file to ~/.hammerspoon/init.lua or add its contents there

-- Common modifier chord to launch favorite apps
local hyper = {"cmd", "alt", "ctrl"}

-- Function to switch to a specific layout
local function switchToLayout(layoutName)
    local currentSource = hs.keycodes.currentSourceID()

    -- Get list of all available layouts
    local layouts = hs.keycodes.layouts()

    -- Search for the needed layout
    for _, layout in pairs(layouts) do
        if string.find(string.lower(layout), string.lower(layoutName)) then
            hs.keycodes.setLayout(layout)
            return
        end
    end

    -- If not found by partial match, try exact match
    hs.keycodes.setLayout(layoutName)
end

-- Bind Ctrl+Alt+1 to switch to English
hs.hotkey.bind({"ctrl", "alt"}, "1", function()
    switchToLayout("ABC")  -- or "U.S." depending on your system
end)

-- Bind Ctrl+Alt+2 to switch to Russian
hs.hotkey.bind({"ctrl", "alt"}, "2", function()
    switchToLayout("Russian")
end)

-- Optional function to show current layout
hs.hotkey.bind({"ctrl", "alt"}, "3", function()
    local currentLayout = hs.keycodes.currentLayout()
    hs.alert.show("Current layout: " .. currentLayout)
end)

hs.hotkey.bind(hyper, "1", function()
    hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind(hyper, "2", function()
    hs.application.launchOrFocus("Arc")
end)

hs.hotkey.bind(hyper, "3", function()
    hs.application.launchOrFocus("Chrome")
end)

hs.hotkey.bind(hyper, "4", function()
    hs.application.launchOrFocus("Webstorm")
end)

hs.hotkey.bind(hyper, "5", function()
    hs.application.launchOrFocus("Slack")
end)

hs.hotkey.bind(hyper, "6", function()
    hs.application.launchOrFocus("Finder")
    hs.osascript.applescript([[
        tell application "Finder"
            make new Finder window to (path to home folder)
            activate
        end tell
    ]])
end)

-- Debug: show all available layouts
-- Uncomment these lines to see the list of available layouts
-- local layouts = hs.keycodes.layouts()
-- print("Available layouts:")
-- for i, layout in pairs(layouts) do
--     print(i, layout)
-- end
