-- Hammerspoon Language Switcher for ZMK keyboard
-- Save this file to ~/.hammerspoon/init.lua or add its contents there

-- Common modifier chord to launch favorite apps
local hyper = {"cmd", "alt", "ctrl"}

local previousLayout = nil

local function findLayout(layoutName)
    local layouts = hs.keycodes.layouts()

    -- Try exact match first
    for _, layout in ipairs(layouts) do
        if layout == layoutName then
            return layout
        end
    end

    -- Fallback to partial match
    local target = string.lower(layoutName)
    for _, layout in ipairs(layouts) do
        if string.find(string.lower(layout), target, 1, true) then
            return layout
        end
    end

    return nil
end

local function switchToLayout(layoutName)
    local layout = findLayout(layoutName)
    if not layout then
        return
    end

    local currentLayout = hs.keycodes.currentLayout()
    if currentLayout == layout then
        return
    end

    previousLayout = currentLayout
    hs.keycodes.setLayout(layout)
end

-- Function to return to the previously active layout
local function switchToPreviousLayout()
    if not previousLayout then
        return
    end

    local layout = findLayout(previousLayout)
    previousLayout = nil

    if layout then
        hs.keycodes.setLayout(layout)
    end
end

-- Bind Ctrl+Alt+1 to switch to English
hs.hotkey.bind({"ctrl", "alt"}, "1", function()
    switchToLayout("ABC")  -- or "U.S." depending on your system
end)

-- Bind Ctrl+Alt+2 to switch to Russian
hs.hotkey.bind({"ctrl", "alt"}, "2", function()
    switchToLayout("Russian")
end)

-- Bind Ctrl+Alt+3 to return to the previously active layout
hs.hotkey.bind({"ctrl", "alt"}, "3", function()
    switchToPreviousLayout()
end)

hs.hotkey.bind(hyper, "1", function()
    hs.application.launchOrFocus("Firefox")
end)

hs.hotkey.bind(hyper, "2", function()
    hs.application.launchOrFocus("Arc")
end)

hs.hotkey.bind(hyper, "3", function()
    hs.application.launchOrFocus("Google Chrome")
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
