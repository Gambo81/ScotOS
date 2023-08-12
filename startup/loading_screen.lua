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

function printCentered( y, s, c)
    local w,h = term.getSize()
    local x = math.floor((w - string.len(s)) / 2)
    term.setCursorPos(x,y)
    term.clearLine()
    term.write( s )
end

printCentered( 4,"ScotOS")
sleep(0.3)
load = "##############################################"
for i = 1, #load,2 do
    printCentered( 15, load:sub(1, i))
    printCentered( 16, math.floor(((i+1)/#load)*100).."%")
    sleep(0.1)
end
sleep(1)
shell.run("/os/utils/user/login")
return