os.pullEvent = os.pullEventRaw
term.clear()
term.setCursorPos(1,1)

-- background_helper.lua

local function loadBackground()
    if not fs.exists("/selected_background") then
        return "/os/backgrounds/gray.nfp"
    end

    local backgroundFile = fs.open("/selected_background", "r")
    local backgroundName = backgroundFile.readLine()
    backgroundFile.close()

    if not fs.exists(backgroundName) then
        print("Error: Background image not found at " .. backgroundName)
        sleep(3)
        return "/os/backgrounds/gray.nfp"
    end

    return backgroundName
end

return {
    loadBackground = loadBackground
}
