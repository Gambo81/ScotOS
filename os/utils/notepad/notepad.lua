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

local function readCurrentUser()
    if not fs.exists("/users/current_user") then
        return
    end

    local currentUserFile = fs.open("/users/current_user", "r")
    local currentUser = currentUserFile.readLine()
    currentUserFile.close()

    return currentUser
end

local currentUser = readCurrentUser()

if not currentUser then
    print("No current user found.")
    return
end

print("Please type the name of your Notepad file or a new name to make a new Notepad file.")
term.setCursorPos(1,3)
print(" ")
term.write("name> ")

local name = read()
shell.run("cd", "/users/" .. currentUser .. "/notepad")
shell.run("edit", name)
shell.run("cd", "/")
shell.run("/os/menus/notepad")
