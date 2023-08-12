os.pullEvent = os.pullEventRaw
term.clear()
image = paintutils.loadImage("/os/backgrounds/gray.nfp")
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

io.close()

print("Command line.")
print("Type back to exit to the desktop.")
print("---------------------------------")
term.setCursorPos(1,4)
