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

-- listUsers.lua

local function listUsers()
    if not fs.exists("/users") then
        print("No users found.")
        return
    end

    local users = fs.list("/users")
    if #users == 0 then
        print("No users found.")
    else
        print("Users:")
        for _, user in ipairs(users) do
            -- Skip the 'current_user' and 'back.lua' files, as they are not user directories
            if user ~= "current_user" and user ~= "back.lua" then
                print(user)
            end
        end
    end
end

listUsers()

os.pullEvent("mouse_click")
term.setTextColor(colors.white)
shell.execute("os/menus/user")
