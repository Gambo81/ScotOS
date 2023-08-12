os.pullEvent = os.pullEventRaw
term.clear()
image = paintutils.loadImage("/os/backgrounds/gray.nfp")
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

local function setTextColorFromFile()
    local textColor = readColorFromFile()
    term.setTextColor(textColor)
end

-- Call the function to set the text color
setTextColorFromFile()

local function hashPassword(password)
    -- This should be the same hashing function used in your createUser.lua and login.lua scripts
    return password
end

local function authenticate(username, password)
    local hashedPassword = hashPassword(password)
    local userFile = fs.open("users/" .. username .. "/userdata", "r")
    if not userFile then
        return false
    end
    local storedPassword = userFile.readLine()
    userFile.close()
    return hashedPassword == storedPassword
end

local function getCurrentUser()
    if not fs.exists("users/current_user") then
        return nil
    end

    local currentUserFile = fs.open("users/current_user", "r")
    local username = currentUserFile.readLine()
    currentUserFile.close()

    return username
end

local function isRootUser(username)
    return username == "root"
end

local function confirm(prompt)
    print(prompt .. " (y/n)")
    while true do
        local response = read():lower()
        if response == "y" or response == "yes" then
            return true
        elseif response == "n" or response == "no" then
            return false
        else
            print("Invalid input. Please enter 'y' or 'n'.")
        end
    end
end

local function uninstall()
    shell.run("delete","os")
    shell.run("delete","startup")
    shell.run("delete","back.lua")
    shell.run("delete","selected_background")
    shell.run("delete","text_color")
    shell.run("delete","/users/current_user")
    shell.run("delete","/users/back.lua")
end

local currentUser = getCurrentUser()

if not isRootUser(currentUser) then
    print("Please enter root username:")
    local rootUsername = read()
    print("Please enter root password:")
    local rootPassword = read("*")

    if not authenticate(rootUsername, rootPassword) or not isRootUser(rootUsername) then
        print("Invalid root credentials. Uninstall operation cancelled.")
        return
    end
end

if confirm("Are you sure you want to uninstall everything except the user folder? This action cannot be undone.") then
    uninstall()
    print("Uninstall complete.")
    sleep(1)
    os.reboot()
else
    print("Uninstall operation cancelled.")
    sleep(1)
    shell.run("/os/menus/desktop")
end
