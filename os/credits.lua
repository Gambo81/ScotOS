os.pullEvent = os.pullEventRaw
image = paintutils.loadImage("/os/backgrounds/gray.nfp")
paintutils.drawImage(image, 1, 1)
term.setCursorPos(1,1)
term.clear()

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

print("MCJack123: Battleship.")
print("Open AI: Calculator.")
print("HPWebcamAble: File explorer.")

os.pullEvent("mouse_click") 
    term.setTextColor(colors.white)
    shell.execute("os/menus/desktop")
    return