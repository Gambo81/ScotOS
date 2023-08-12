os.pullEvent = os.pullEventRaw
term.clear()
local backgroundHelper = dofile("/os/utils/background_helper.lua")
image = paintutils.loadImage(backgroundHelper.loadBackground())
paintutils.drawImage(image, 1, 1)
term.setBackgroundColor(colors.gray)
term.setTextColor(2)
term.setCursorPos(1, 1)

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

-- readCurrentUser.lua
local function readCurrentUser()
    if not fs.exists("/users/current_user") then
        print("No current user found.")
        return
    end

    local currentUserFile = fs.open("/users/current_user", "r")
    local currentUser = currentUserFile.readLine()
    currentUserFile.close()

    return currentUser
end

local currentUser = readCurrentUser()
if currentUser then
    if currentUser == "root" then
        shell.run("/os/utils/file_explorer")
    else
        local function loginPrompt()
            print("Enter root username:")
            local username = read()
            print("Enter root password:")
            local password = read("*")

            if username == "root" and password == "root" then
                return username
            else
                print("Invalid username or password.")
                sleep(1)
                shell.run("/os/menus/utils")
                return nil
            end
        end

        local loggedInUser = loginPrompt()
        if loggedInUser then
            shell.run("/os/utils/file_explorer")
        end
    end
end
