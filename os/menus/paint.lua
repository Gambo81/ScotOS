os.pullEvent = os.pullEventRaw
term.clear()
local backgroundHelper = dofile("/os/utils/background_helper.lua")
image = paintutils.loadImage(backgroundHelper.loadBackground())
paintutils.drawImage(image, 1, 1)
term.setBackgroundColor(colors.gray)
term.setTextColor(2)
term.setCursorPos(1,1)

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

-- Call the function to set the text color
setTextColorFromFile()

local x, y = 2,4
local x2, y2 = 2,6
local x3, y3 = 2,10
local choice1 = " Paint "
local choice2 = " Delete file "
local choice3 = " Back "

local imagePath = backgroundHelper.loadBackground()
if imagePath == "/os/backgrounds/night.nfp" then
    term.setBackgroundColor(colors.gray)
elseif imagePath == "/os/backgrounds/day.nfp" then
    term.setBackgroundColor(colors.cyan)
elseif imagePath == "/os/backgrounds/sunset.nfp" then
    term.setBackgroundColor(colors.cyan)
else
    term.setBackgroundColor(colors.gray)
end
term.setCursorPos(x,y)
write(choice1)
term.setCursorPos(x2,y2)
write(choice2)
term.setCursorPos(x3,y3)
local imagePath = backgroundHelper.loadBackground()
if imagePath == "/os/backgrounds/night.nfp" then
    term.setBackgroundColor(colors.gray)
elseif imagePath == "/os/backgrounds/day.nfp" then
    term.setBackgroundColor(colors.cyan)
elseif imagePath == "/os/backgrounds/sunset.nfp" then
    term.setBackgroundColor(colors.white)
else
    term.setBackgroundColor(colors.gray)
end
write(choice3)

local imagePath = backgroundHelper.loadBackground()
if imagePath == "/os/backgrounds/night.nfp" then
    term.setBackgroundColor(colors.gray)
elseif imagePath == "/os/backgrounds/day.nfp" then
    term.setBackgroundColor(colors.cyan)
elseif imagePath == "/os/backgrounds/sunset.nfp" then
    term.setBackgroundColor(colors.cyan)
else
    term.setBackgroundColor(colors.gray)
end
term.setCursorPos(1,1)
term.write("Gambo OS:")
term.setCursorPos(33,1)
shell.run("id")

while true do
    local event, button, cx, cy = os.pullEvent()
        if event == "mouse_click" then
            if cx >= x and cx < choice1:len() and cy == y and button == 1 then
                term.setCursorPos(28,6)
                shell.run("os/utils/paint/paint")
                return
            elseif cx >= x2 and cx < choice2:len() and cy == y2 and button == 1 then
                shell.run("os/utils/paint/paintdelete")
                return
            elseif cx >= x3 and cx < choice3:len() and cy == y3 and button == 1 then
                shell.run("os/menus/utils2")
                return
            end
        end
end