local speedHackActive = false
local aimGepengOpticActive = false
local revertSpeedHack = nil
local revertAimGepengOptic = nil

function getPackageName()
    local info = gg.getTargetInfo()
    if info ~= nil then
        return info.packageName
    else
        return "Unknown Package"
    end
end

function getARMArchitecture()
    local info = gg.getTargetInfo()
    if info ~= nil then
        return info.x64 and "ARM64" or "ARM32"
    else
        return "Unknown ARM"
    end
end

function main()
    local packageName = getPackageName()
    local armArchitecture = getARMArchitecture()
    local currentTime = os.date("*t")
    local emojiTime = getEmojiForTime(currentTime.hour)
    local formattedDate = string.format("%02d/%02d/%04d", currentTime.day, currentTime.month, currentTime.year)
    local formattedTime = string.format("%02d:%02d", currentTime.hour, currentTime.min)

    local menuText1 = speedHackActive and "[ SPEED HACK (Rawan) ] [ (🟢) ]" or "[ SPEED HACK (Rawan) ] [ (🔴) ]"
    local menuText2 = aimGepengOpticActive and "[ AIM GEPENG (OPTIC)  ] [ (🟢) ]" or "[ AIM GEPENG (OPTIC)  ] [ (🔴) ]"

    local menu = gg.choice({
        "☯︎ "..menuText1,
        "☯︎ "..menuText2,
        "☯︎ [ EXIT ]"
    }, nil, string.format([[
╔═════════════════════╗
  •▶[ ⚙️ Pkg: %s
  •▶[ ⚙️ Arm: %s
  •▶[ %s Time: %s
  •▶[ 🗓️ Date: %s
  •▶[ 🌐 Tg: @WanBloodStrike
╚═════════════════════╝]], packageName, armArchitecture, emojiTime, formattedTime, formattedDate))

    if menu == 1 then
        if speedHackActive then
            revertSpeedHackValues()
        else
            activateSpeedHack()
        end
    elseif menu == 2 then
        if aimGepengOpticActive then
            revertAimGepengOpticValues()
        else
            activateAimGepengOptic()
        end
    elseif menu == 3 then
        gg.toast("Wait...")
        gg.sleep(2000) 
        local countdown = 3 
        while countdown > 0 do
            gg.toast(string.format("Keluar dalam %d detik...", countdown))
            gg.sleep(1000)
            countdown = countdown - 1
        end
        gg.clearResults()
        os.exit()
    end
end

function getEmojiForTime(hour)
    if hour == 1 or hour == 13 then
        return "🕐"
    elseif hour == 2 or hour == 14 then
        return "🕑"
    elseif hour == 3 or hour == 15 then
        return "🕒"
    elseif hour == 4 or hour == 16 then
        return "🕓"
    elseif hour == 5 or hour == 17 then
        return "🕔"
    elseif hour == 6 or hour == 18 then
        return "🕕"
    elseif hour == 7 or hour == 19 then
        return "🕖"
    elseif hour == 8 or hour == 20 then
        return "🕗"
    elseif hour == 9 or hour == 21 then
        return "🕘"
    elseif hour == 10 or hour == 22 then
        return "🕙"
    elseif hour == 11 or hour == 23 then
        return "🕚"
    elseif hour == 12 or hour == 0 then
        return "🕛"
    end
end

function activateSpeedHack()
    gg.setVisible(false)
    gg.searchNumber("1071715040A;1134526464A:37", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)
    
    revertSpeedHack = gg.getResults(1) 
    local t = gg.getResults(1)
    
    for i, v in ipairs(t) do
        if v.flags == gg.TYPE_DWORD then
            v.value = "1071760040"
        end
    end
    
    gg.setValues(t)
    gg.clearResults()
    gg.setVisible(false)
    speedHackActive = true
    gg.toast("SPEED HACK (🟢)")
    gg.sleep(1000)
end

function revertSpeedHackValues()
    if revertSpeedHack ~= nil then
        for i, v in ipairs(revertSpeedHack) do
            v.value = "1071715040"
        end
        gg.setValues(revertSpeedHack)
        gg.toast("SPEED HACK (🔴)")
        gg.sleep(1000)
        speedHackActive = false
    else
        gg.toast("Tidak ada nilai untuk dikembalikan")
    end
    gg.clearResults()
end

function activateAimGepengOptic()
    gg.setVisible(false)
    gg.searchNumber("1.0F;4.59177481e-39F:17", gg.TYPE_FLOAT, false, gg.SIGN_EQUAL, 0, -1)  -- Ganti VALUE_TO_SEARCH_FOR_AIM_GEPENG dengan nilai sebenarnya
    
    revertAimGepengOptic = gg.getResults(1)
    local t = gg.getResults(1)
    
    for i, v in ipairs(t) do
        if v.flags == gg.TYPE_FLOAT then
            v.value = "1.003"
        end
    end
    
    gg.setValues(t)
    gg.clearResults()
    gg.setVisible(false)
    aimGepengOpticActive = true
    gg.toast("AIM GEPENG OPTIC (🟢)")
    gg.sleep(1000)
end

function revertAimGepengOpticValues()
    if revertAimGepengOptic ~= nil then
        for i, v in ipairs(revertAimGepengOptic) do
            v.value = "1.0"            
        end
        gg.setValues(revertAimGepengOptic)
        gg.toast("AIM GEPENG OPTIC (🔴)")
        gg.sleep(1000)
        aimGepengOpticActive = false
    else
        gg.toast("Tidak ada nilai untuk dikembalikan")
    end
    gg.clearResults()
end

while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        main()
    end
end
