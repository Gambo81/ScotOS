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

-- createUser.lua
local args = {...}

local function hashPassword(password)
    -- Implement a simple hashing function, or use a library for better security
    return password -- For simplicity, we're not hashing in this example
end

if #args < 2 then
    print("Usage: createUser <username> <password>")
    return
end

local username = args[1]
local password = args[2]

local hashedPassword = hashPassword(password)

if fs.exists("users/" .. username) then
    print("User already exists.")
    sleep(1)
    shell.run("/os/menus/utils")
else
    fs.makeDir("users/" .. username)
    local userFile = fs.open("users/" .. username .. "/userdata", "w")
    userFile.writeLine(hashedPassword)
    userFile.close()

    -- Create user-specific folders
    fs.makeDir("users/" .. username .. "/programs")
    fs.makeDir("users/" .. username .. "/paint")
    fs.makeDir("users/" .. username .. "/notepad")

    print("User account created.")
    sleep(1)
    shell.run("/os/menus/utils")
end
