os.pullEvent = os.pullEventRaw
term.clear()
image = paintutils.loadImage("/os/backgrounds/gray.nfp")
paintutils.drawImage(image, 1, 1)
term.setBackgroundColor(colors.gray)
term.setTextColor(2)
term.setCursorPos(1,1)

local function writeColorToFile(color)
    local colorFile = fs.open("/text_color", "w")
    colorFile.writeLine(color)
    colorFile.close()
end

local function readColorFromFile()
    if not fs.exists("/text_color") then
        return 2
    end

    local colorFile = fs.open("/text_color", "r")
    local color = tonumber(colorFile.readLine())
    colorFile.close()

    return color
end

local function getChoices()
    return {
        {label = " Black ", x = 2, y = 4, color = colors.black},
        {label = " White ", x = 2, y = 6, color = colors.white},
        {label = " Orange ", x = 2, y = 8, color = colors.orange},
        {label = " Red ", x = 2, y = 10, color = colors.red},
        {label = " Green ", x = 2, y = 12, color = colors.green},
        {label = " Blue ", x = 2, y = 14, color = colors.blue},
        {label = " Back ", x = 2, y = 16, color = readColorFromFile()}
    }
end

local function updateScreen()
    term.clear()
    paintutils.drawImage(image, 1, 1)
    term.setBackgroundColor(colors.gray)

    local textColor = readColorFromFile()
    term.setTextColor(textColor)

    local choices = getChoices()
    for _, choice in ipairs(choices) do
        term.setCursorPos(choice.x, choice.y)
        term.setTextColor(choice.color)
        term.write(choice.label)
    end

    term.setCursorPos(1, 1)
    term.setTextColor(textColor)
    term.write("ScotOS:")
    term.setCursorPos(33, 1)
    shell.run("id")
end

updateScreen()

while true do
    local event, button, cx, cy = os.pullEvent()
    if event == "mouse_click" then
        local choices = getChoices()
        for _, choice in ipairs(choices) do
            if cx >= choice.x and cx < choice.x + #choice.label and cy == choice.y and button == 1 then
                if choice.label == " Back " then
                    shell.run("/os/menus/utils2")
                    return
                else
                    writeColorToFile(choice.color)
                    updateScreen()
                end
            end
        end
    end
end
return