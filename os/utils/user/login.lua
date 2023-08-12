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

-- Call the function to set the text color
setTextColorFromFile()

-- login.lua
local function hashPassword(password)
    -- Same as the createUser.lua script
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

local function loginPrompt()
    print("Enter username:")
    local username = read()
    print("Enter password:")
    local password = read("*")
    
    if authenticate(username, password) then
        return username
    else
        print("Invalid username or password.")
        return nil
    end
end

local function setCurrentUser(username)
    local currentUserFile = fs.open("users/current_user", "w")
    currentUserFile.writeLine(username)
    currentUserFile.close()
    shell.run("/os/menus/desktop")
end

local loggedInUser = nil
local failedAttempts = 0
while not loggedInUser do
    loggedInUser = loginPrompt()
    if loggedInUser then
        setCurrentUser(loggedInUser)
    else
        failedAttempts = failedAttempts + 1
        if failedAttempts >= 3 then
            print("Too many failed attempts. System will shut down.")
            os.shutdown()
        end
    end
end

-- loggedInUser now contains the authenticated user's username
-- Proceed with loading user-specific settings, data, and environment
