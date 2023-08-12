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

print("Please type the name of the chat you would like to join. ScotOS has its own chat. To use it just")
term.setCursorPos(1,3)
print("type 'ScotOS_Chat'.")
term.setCursorPos(1,4)
print(" ")
term.write("chat> ")

chat = read()

term.clear()
term.setCursorPos(1,1)

print("Please type what you want your username to be.")
term.setCursorPos(1,3)
print(" ")
term.write("username> ")

username = read()

term.clear()
term.setCursorPos(1,1)
shell.run("background","chat","join",chat,username)
shell.run("os/menus/desktop")
return