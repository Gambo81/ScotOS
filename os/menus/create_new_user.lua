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

print("Please type the username for your new user.")
term.setCursorPos(1,2)
term.write("> ")
local username = read()

term.setCursorPos(1,4)
print("Please type the password for your new user.")
term.setCursorPos(1,5)
term.write("> ")
local password = read()

term.setCursorPos(1,7)
print("Are the credentials for your new user correct?")
term.setCursorPos(1,8)
print("Username =", username)
term.setCursorPos(1,9)
print("Password =", password)
term.setCursorPos(1,10)
term.write("Y/N> ")
local yn = read()
if yn == "Y" then
    shell.run("/os/utils/user/createUser", username, password)
elseif yn == "y" then
    shell.run("/os/utils/user/createUser", username, password)
else
    shell.run("/os/menus/create_new_user")
end