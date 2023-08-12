os.pullEvent = os.pullEventRaw
term.clear()
local backgroundHelper = dofile("/os/utils/background_helper.lua")
image = paintutils.loadImage(backgroundHelper.loadBackground())
paintutils.drawImage(image, 1, 1)
term.setBackgroundColor(colors.gray)
term.setTextColor(2)
term.setCursorPos(1,1)

-- settings.lua
os.pullEvent = os.pullEventRaw
term.clear()

local function readColorFromFile()
    if not fs.exists("/text_color") then
        return 2
    end

    local colorFile = fs.open("/text_color", "r")
    local color = tonumber(colorFile.readLine())
    colorFile.close()

    return color
end

local function setTextColorFromFile()
    local textColor = readColorFromFile()
    term.setTextColor(textColor)
end

local function setTextColorFromFile()
    local textColor = readColorFromFile()
    term.setTextColor(textColor)
end

-- Call the function to set the text color
setTextColorFromFile()

function printCentered( y, s, c)
    local w,h = term.getSize()
    local x = math.floor((w - string.len(s)) / 2)
    term.setCursorPos(x,y)
    term.clearLine()
    term.write( s )
end

local function loadBackground()
    if not fs.exists("/selected_background") then
        return "/os/backgrounds/gray.nfp"
    end

    local backgroundFile = fs.open("/selected_background", "r")
    local backgroundName = backgroundFile.readLine()
    backgroundFile.close()

    if not fs.exists(backgroundName) then
        print("Error: Background image not found at " .. backgroundName)
        sleep(3)
        return "/os/backgrounds/gray.nfp"
    end

    return backgroundName
end

local function saveSelectedBackground(backgroundName)
    local backgroundFile = fs.open("/selected_background", "w")
    backgroundFile.writeLine(backgroundName)
    backgroundFile.close()
end

local x, y = 2, 4
local choice1 = " Gray "
local choice2 = " Sunset "
local choice3 = " Day "
local choice4 = " Night "
local choice5 = " Back "
term.setCursorPos(x, y)
write(choice1)
term.setCursorPos(x, y + 2)
write(choice2)
term.setCursorPos(x, y + 4)
write(choice3)
term.setCursorPos(x, y + 6)
write(choice4)
term.setCursorPos(x, y + 14)
write(choice5)
term.setCursorPos(1, 1)
term.write("ScotOS:")

while true do
    local event, button, cx, cy = os.pullEvent()
    if event == "mouse_click" then
        if cx >= x and cx < x + choice1:len() and cy == y and button == 1 then
            saveSelectedBackground("/os/backgrounds/gray.nfp")
        elseif cx >= x and cx < x + choice2:len() and cy == y + 2 and button == 1 then
            saveSelectedBackground("/os/backgrounds/sunset.nfp")
        elseif cx >= x and cx < x + choice3:len() and cy == y + 4 and button == 1 then
            saveSelectedBackground("/os/backgrounds/day.nfp")
        elseif cx >= x and cx < x + choice4:len() and cy == y + 6 and button == 1 then
            saveSelectedBackground("/os/backgrounds/night.nfp")
        elseif cx >= x and cx < x + choice5:len() and cy == y + 14 and button == 1 then
            shell.run("/os/menus/utils2")
            return
        end
    end
end
return
