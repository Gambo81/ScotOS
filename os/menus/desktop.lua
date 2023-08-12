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
local x3, y3 = 2,8
local x4, y4 = 2,12
local x5, y5 = 2,14
local x6, y6 = 2,18
local choice1 = " Utils "
local choice2 = " Fun "
local choice3 = " chat "
local choice4 = " Shutdown Options"
local choice5 = " Uninstall "
local choice6 = " Credits "

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
write(choice3)
term.setCursorPos(x4,y4)
write(choice4)
term.setCursorPos(x5,y5)
if imagePath == "/os/backgrounds/gray.nfp" then
    term.setBackgroundColor(colors.gray)
else
    term.setBackgroundColor(colors.lime)
end
write(choice5)
term.setCursorPos(x6,y6)
local imagePath = backgroundHelper.loadBackground()
if imagePath == "/os/backgrounds/night.nfp" then
    term.setBackgroundColor(colors.lightGray)
elseif imagePath == "/os/backgrounds/day.nfp" then
    term.setBackgroundColor(colors.lightGray)
elseif imagePath == "/os/backgrounds/sunset.nfp" then
    term.setBackgroundColor(colors.lightGray)
else
    term.setBackgroundColor(colors.gray)
end
write(choice6)
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
term.write("ScotOS:")
term.setCursorPos(33,1)
shell.run("id")

while true do
    local event, button, cx, cy = os.pullEvent()
        if event == "mouse_click" then
            if cx >= x and cx < choice1:len() and cy == y and button == 1 then
                term.setCursorPos(28,6)
                shell.run("/os/menus/utils")
                return
            elseif cx >= x2 and cx < choice2:len() and cy == y2 and button == 1 then
                shell.run("/os/menus/fun")
                return
            elseif cx >= x3 and cx < choice3:len() and cy == y3 and button == 1 then
                shell.run("/os/menus/chat")
                return
            elseif cx >= x4 and cx < choice4:len() and cy == y4 and button == 1 then
                term.setCursorPos(28,6)
                shell.run("/os/menus/shutdown_options")
                return
            elseif cx >= x5 and cx < choice5:len() and cy == y5 and button == 1 then
                term.setCursorPos(28,6)
                shell.run("/os/uninstall")
            elseif cx >= x6 and cx < choice6:len() and cy == y6 and button == 1 then
                term.setCursorPos(28,6)
                shell.run("/os/credits")
                return
            end
        end
end
return