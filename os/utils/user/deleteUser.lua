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

-- deleteUser.lua

local function readCurrentUser()
    if not fs.exists("/users/current_user") then
        return
    end

    local currentUserFile = fs.open("/users/current_user", "r")
    local currentUser = currentUserFile.readLine()
    currentUserFile.close()

    return currentUser
end

local function authenticateRoot(username, password)
    return username == "root" and password == "root"
end

local function promptRootLogin()
    print("Enter root username:")
    local username = read()
    print("Enter root password:")
    local password = read("*")

    if authenticateRoot(username, password) then
        return true
    else
        print("Invalid root username or password.")
        sleep(1)
        shell.run("os/menus/utils")
        return false
    end
end

local function deleteUser(currentUser, username)
    if username == "root" then
        print("The root user cannot be deleted.")
        sleep(1)
        shell.run("os/menus/utils")
        return
    end

    if fs.exists("/users/" .. username) then
        fs.delete("/users/" .. username)
        print("User '" .. username .. "' has been deleted.")
        if currentUser == username then
            print("Logging out in 1 second...")
            sleep(1)
            shell.run("/os/utils/user/login")
        end
    else
        print("User '" .. username .. "' does not exist.")
    end
end

local currentUser = readCurrentUser()

if currentUser ~= "root" then
    print("You must be signed in as the root user to delete a user.")
    if not promptRootLogin() then
        return
    end
end

print("Enter the username of the user to delete:")
local usernameToDelete = read()

deleteUser(currentUser, usernameToDelete)
sleep(1)
shell.run("os/menus/utils")
