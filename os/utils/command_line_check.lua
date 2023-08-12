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

local function getRootPassword()
    if not fs.exists("/users/root/userdata") then
        return nil
    end

    local rootUserFile = fs.open("/users/root/userdata", "r")
    local rootPassword = rootUserFile.readLine()
    rootUserFile.close()

    return rootPassword
end

local currentUser = readCurrentUser()
if currentUser then
    if currentUser == "root" then
        shell.run("/startup/command_line")
    else
        local function loginPrompt()
            print("Enter root username:")
            local username = read()
            print("Enter root password:")
            local password = read("*")

            local rootPassword = getRootPassword()

            if username == "root" and password == rootPassword then
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
            shell.run("/startup/command_line")
            return
        end
    end
end
