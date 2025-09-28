--Coding Game
local noflashy
local flip = false
local noteY = {50,550}
local noteYdis = {-100,700}

--[[function Spotlight1up(nametag1,nametag2,name1Alpha,name2Alpha,nameDone1,nameDone2,time,ease)
    setProperty(nametag1 ,'.angle',-40)
    setProperty(nametag2 ,'.angle',40)
    setProperty(nametag1 ,'.alpha',1)
    setProperty(nametag2 ,'.alpha',1)
    doTweenAlpha(name1Alpha,name1,0,time + 0.12,ease)
    doTweenAlpha(name2Alpha,name2,0,time + 0.12,ease)
    doTweenAngle(nameDone1,nameDone1,0,time,ease)
    doTweenAngle(nameDone2,nameDone2,0, time,ease)
end]]
function onSongStart()
    LightAngle = 17

    doTweenAngle('SpotLights1Angle','SpotLights1',LightAngle,2,'sineInOut')
    doTweenAngle('SpotLights2Angle','SpotLights2',LightAngle,2,'sineInOut')
    doTweenAngle('SpotLights3Angle','SpotLights3',-LightAngle,2,'sineInOut')
    doTweenAngle('SpotLights4Angle','SpotLights4',-LightAngle,2,'sineInOut')
    doTweenAngle('SpotLights5Angle','SpotLights5',-LightAngle,2,'sineInOut')
    doTweenAngle('SpotLights6Angle','SpotLights6',LightAngle,2,'sineInOut')

end
function onTweenCompleted( tag )
    if tag == "SpotLights1Angle" then
        doTweenAngle('SpotLights1Angles','SpotLights1',LightAngle,2,'sineInOut')
    end
    if tag == "SpotLights1Angles" then
        doTweenAngle('SpotLights1Angle','SpotLights1',0,2,'sineInOut')
    end
    --
    if tag == "SpotLights2Angle" then
        doTweenAngle('SpotLights2Angles','SpotLights2',LightAngle,2,'sineInOut')
    end
    if tag == "SpotLights2Angles" then
        doTweenAngle('SpotLights2Angle','SpotLights2',0,2,'sineInOut')
    end
    --
    if tag == "SpotLights3Angle" then
        doTweenAngle('SpotLights3Angles','SpotLights3',-LightAngle,2,'sineInOut')
    end
    if tag == "SpotLights3Angles" then
        doTweenAngle('SpotLights3Angle','SpotLights3',0,2,'sineInOut')
    end
    --
    if tag == "SpotLights4Angle" then
        doTweenAngle('SpotLights4Angles','SpotLights4',-LightAngle,2,'sineInOut')
    end
    if tag == "SpotLights4Angles" then
        doTweenAngle('SpotLights4Angle','SpotLights4',0,2,'sineInOut')
    end
    --
    if tag == "SpotLights5Angle" then
        doTweenAngle('SpotLights5Angles','SpotLights5',-LightAngle,2,'sineInOut')
    end
    if tag == "SpotLights5Angles" then
        doTweenAngle('SpotLights5Angle','SpotLights5',0,2,'sineInOut')
    end
    --
    if tag == "SpotLights6Angle" then
        doTweenAngle('SpotLights6Angles','SpotLights6',LightAngle,2,'sineInOut')
    end
    if tag == "SpotLights6Angles" then
        doTweenAngle('SpotLights6Angle','SpotLights6',0,2,'sineInOut')
    end
    --
end

function onBack(time,ease)
        noteTweenX('5pX', 4, defaultPlayerStrumX0, time,ease)
        noteTweenX('6pX', 5, defaultPlayerStrumX1, time,ease)
        noteTweenX('7pX', 6, defaultPlayerStrumX2, time,ease)
        noteTweenX('8pX', 7, defaultPlayerStrumX3, time,ease)

        noteTweenX('5OpX', 0, defaultOpponentStrumX0, time,ease)
        noteTweenX('6OpX', 1, defaultOpponentStrumX1, time,ease)
        noteTweenX('7OpX', 2, defaultOpponentStrumX2, time,ease)
        noteTweenX('8OpX', 3, defaultOpponentStrumX3, time,ease)
end
function Flip(time,ease)
    noteTweenX('5pX', 4, defaultOpponentStrumX0, time,ease)
    noteTweenX('6pX', 5, defaultOpponentStrumX1, time,ease)
    noteTweenX('7pX', 6, defaultOpponentStrumX2, time,ease)
    noteTweenX('8pX', 7, defaultOpponentStrumX3, time,ease)

    noteTweenX('5OpX', 0, defaultPlayerStrumX0, time,ease)
    noteTweenX('6OpX', 1, defaultPlayerStrumX1, time,ease)
    noteTweenX('7OpX', 2, defaultPlayerStrumX2, time,ease)
    noteTweenX('8OpX', 3, defaultPlayerStrumX3, time,ease)
end
function onStepHit()
    if getPropertyFromClass('flixel.FlxG','save.data.noFlashy') == false then
        setProperty('SpotLights1.color', getProperty('win.color'))
        setProperty('SpotLights2.color', getProperty('win.color'))
        setProperty('SpotLights3.color', getProperty('win.color'))
        setProperty('SpotLights4.color', getProperty('win.color'))
        setProperty('SpotLights5.color', getProperty('win.color'))
        setProperty('SpotLights6.color', getProperty('win.color'))
    end
    
    setProperty('SpotLights1.alpha', getProperty('win.alpha')-0.35)
    setProperty('SpotLights2.alpha', getProperty('win.alpha')-0.35)
    setProperty('SpotLights3.alpha', getProperty('win.alpha')-0.35)
    setProperty('SpotLights4.alpha', getProperty('win.alpha')-0.35)
    setProperty('SpotLights5.alpha', getProperty('win.alpha')-0.35)
    setProperty('SpotLights6.alpha', getProperty('win.alpha')-0.35)
    if getPropertyFromClass('flixel.FlxG','save.data.noFlashy') == true then
        setProperty('SpotLights1.color', getProperty('win.color'))
        setProperty('SpotLights2.color', getProperty('win.color'))
        setProperty('SpotLights3.color', getProperty('win.color'))
        setProperty('SpotLights4.color', getProperty('win.color'))
        setProperty('SpotLights5.color', getProperty('win.color'))
        setProperty('SpotLights6.color', getProperty('win.color'))
        if curStep %16 == 0 then
            --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
            doTweenColor('winColor','win','0000ff',0.01)
        elseif curStep %16 == 4 then
            doTweenColor('winColor','win','00ffff',0.01)
        elseif curStep %16 == 8 then
            doTweenColor('winColor','win','ff0000',0.01)
        elseif curStep %16 == 12 then
            doTweenColor('winColor','win','ffff00',0.01)
        elseif curStep %16 == 16 then
            doTweenColor('winColor','win','ff8100',0.01)   
        end
        setProperty('win.alpha',1)
    end    
    if getPropertyFromClass('flixel.FlxG','save.data.noFlashy') == false then
        if curStep == 3 or curStep == 6 or curStep == 9 or curStep == 12 or curStep == 14 or curStep == 16 or curStep == 19 or curStep == 22 or curStep == 25 or curStep == 28 or curStep == 31 or curStep == 34 or curStep == 37 or curStep == 40 or curStep == 43 or curStep == 46 or curStep == 48 or curStep == 51 or curStep == 54 or curStep == 57 or curStep == 60 
        or curStep == 767 or curStep == 772 or curStep == 776 or curStep == 780 or curStep == 784 or curStep == 788 or curStep == 792 or curStep == 796 or curStep == 800 or curStep == 804 or curStep == 808 or curStep == 812 or curStep == 816 or curStep == 820 or curStep == 824 or curStep == 828 or curStep == 832 or curStep == 836 or curStep == 840 or curStep == 844 or curStep == 848 or curStep == 852 or curStep == 856 or curStep == 860 or curStep == 864 or curStep == 868 or curStep == 872 or curStep == 876 or curStep == 880 or curStep == 884 or curStep == 888 or curStep == 892
        then
        --    if curStep %6 == 0 then
        --        --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
        --        doTweenColor('winColor','win','0000ff',0.01)
        --    elseif curStep %6 == 1 then
        --        doTweenColor('winColor','win','00ffff',0.01)
        --    elseif curStep %6 == 2 then
        --        doTweenColor('winColor','win','ff0000',0.01)
        --    elseif curStep %6 == 3 then
        --        doTweenColor('winColor','win','ffff00',0.01)
        --    elseif curStep %6 == 4 then
        --        doTweenColor('winColor','win','ff8100',0.01)   
        --    end
        end
        if curStep == 64  or curStep == 3954 or curStep == 5951 then
            setProperty('win.alpha',1)
            doTweenAlpha('winAlpha','win',0.75,0.4)
        end
        if curStep == 128 or curStep == 3841 or curStep == 5886 then
            setProperty('win.alpha',0)
        end

        if curStep == 78 or curStep == 84 or curStep == 86 or curStep == 89 or curStep == 96 or curStep == 110 or curStep == 118 or curStep == 121 
        or curStep == 200 or curStep == 208 or curStep == 211 or curStep == 214 or curStep == 216 or curStep == 224 or curStep == 232 or curStep == 242 or curStep == 245 or curStep == 248 or curStep == 251 or curStep == 254 or curStep == 256 or curStep == 264 or curStep == 272 or curStep == 288
        or curStep == 384 or curStep == 392 or curStep == 400 or curStep == 416 or curStep == 424 or curStep == 448 or curStep == 456
        or curStep == 512 or curStep == 526 or curStep == 528 or curStep == 531 or curStep == 534 or curStep == 536 or curStep == 543 or curStep == 558 or curStep == 563 or curStep == 566 or curStep == 569 
        or curStep == 1120 or curStep == 1122 or curStep == 1128 or curStep == 1130 or curStep == 1136 or curStep == 1138 or curStep == 1141 then
            if curStep %6 == 0 then
                --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
                doTweenColor('winColor','win','0000ff',0.01)
            elseif curStep %6 == 1 then
                doTweenColor('winColor','win','00ffff',0.01)
            elseif curStep %6 == 2 then
                doTweenColor('winColor','win','ff0000',0.01)
            elseif curStep %6 == 3 then
                doTweenColor('winColor','win','ffff00',0.01)
            elseif curStep %6 == 4 then
                doTweenColor('winColor','win','ff8100',0.01)   
            end

            setProperty('win.alpha',1)
            doTweenAlpha('winAlpha','win',0.75,0.4)
        end
        if curStep == 192 or curStep == 1263 or curStep == 1265 or curStep == 1267 or curStep == 1268 or curStep == 1269 or curStep == 1270 or curStep == 1272
        or curStep == 1295 or curStep == 1297 or curStep == 1298 or curStep == 1299 or curStep == 1300 or curStep == 1302 then
            if curStep %6 == 0 then
                --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
                doTweenColor('winColor','win','0000ff',0.01)
            elseif curStep %6 == 1 then
                doTweenColor('winColor','win','00ffff',0.01)
            elseif curStep %6 == 2 then
                doTweenColor('winColor','win','ff0000',0.01)
            elseif curStep %6 == 3 then
                doTweenColor('winColor','win','ffff00',0.01)
            elseif curStep %6 == 4 then
                doTweenColor('winColor','win','ff8100',0.01)   
            end

            setProperty('win.alpha',1)
            doTweenAlpha('winAlpha','win',0.75,0.8)
        end
        if curStep == 639 or curStep == 644 or curStep == 648 or curStep == 652 or curStep == 656 or curStep == 660 or curStep == 664 or curStep == 668 or curStep == 672 or curStep == 676 or curStep == 680 or curStep == 684 or curStep == 688 or curStep == 692 or curStep == 696 or curStep == 700 or curStep == 704 or curStep == 708 or curStep == 712 or curStep == 716 or curStep == 720 or curStep == 724 or curStep == 728 or curStep == 732 or curStep == 736
        or curStep == 1248 or curStep == 0 or curStep == 1280 or curStep == 1304 or curStep == 1312 or curStep == 1316 or curStep == 1318 or curStep == 1322 or curStep == 1325 or curStep == 1329 or curStep == 1332 or curStep == 1334 or curStep == 1338 or curStep == 1341 or curStep == 1343
        then
            if curStep %6 == 0 then
                --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
                doTweenColor('winColor','win','0000ff',0.01)
            elseif curStep %6 == 1 then
                doTweenColor('winColor','win','00ffff',0.01)
            elseif curStep %6 == 2 then
                doTweenColor('winColor','win','ff0000',0.01)
            elseif curStep %6 == 3 then
                doTweenColor('winColor','win','ffff00',0.01)
            elseif curStep %6 == 4 then
                doTweenColor('winColor','win','ff8100',0.01)   
            end
            setProperty('win.alpha',1)
            doTweenAlpha('winAlpha','win',0.55,0.4)
        end
        if curStep == 290 then
            doTweenAlpha('winAlpha','win',0.75,2)

        end
        if curStep == 378 or curStep == 624 or curStep == 1216 or curStep == 1361 then
            doTweenAlpha('winAlpha','win',0,0.2)

        end
        if curStep == 1377 then
            setProperty('win.alpha',1)
            doTweenAlpha('winAlpha','win',0,0.5)

        end
        if curStep == 1224 then
            doTweenAlpha('winAlpha','win',1,0.2)

        end
        if curStep == 1578 then
            doTweenAlpha('winAlpha','win',0,0.3)
        end

        if curStep == 2529 then
            setProperty('win.alpha',1)
            doTweenAlpha('winAlpha','win',0,5)
        end
        
        if curStep > 333 and curStep < 378 and curStep %1 == 0 
        or curStep > 575 and curStep < 605 and curStep %3 == 0
        or curStep > 608 and curStep < 624 and curStep %2 == 0 
        or curStep > 744 and curStep < 766 and curStep %1 == 0 
        or curStep > 896 and curStep < 1016 and curStep %8 == 0 
        or curStep > 1023 and curStep < 1116 and curStep %4 == 0 
        or curStep > 1144 and curStep < 1152 and curStep %2 == 0 
        or curStep > 1152 and curStep < 1216 and curStep %16 == 0 
        or curStep > 1224 and curStep < 1248 and curStep %1 == 0 
        or curStep > 1345 and curStep < 1361 and curStep %1 == 0 
        or curStep > 1536 and curStep < 1665 and curStep %4 == 0 
        or curStep > 1697 and curStep < 1720 and curStep %2 == 0 
        or curStep > 1889 and curStep < 1983 and curStep %2 == 0 
        or curStep > 2017 and curStep < 2201 and curStep %8 == 0 
        or curStep > 2208 and curStep < 2255 and curStep %4 == 0 
        or curStep > 2256 and curStep < 2273 and curStep %1 == 0 
        or curStep > 2461 and curStep < 2528 and curStep %1 == 0 
        or curStep > 2737 and curStep < 2866 and curStep %4 == 0 
        or curStep > 3010 and curStep < 3145 and curStep %8 == 0 
        or curStep > 4049 and curStep < 4097
        or curStep > 4097 and curStep < 4288 and curStep %8 == 0 
        or curStep > 4289 and curStep < 4512 and curStep %4 == 0 
        or curStep > 4529 and curStep < 4561
        or curStep > 4577 and curStep < 4961 and curStep %4 == 0 
        or curStep > 4993 and curStep < 5148 and curStep %3 == 0 

        then
            if curStep %3 == 0 then
                --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
                doTweenColor('winColor','win','0000ff',0.01)
            elseif curStep %3 == 1 then
                doTweenColor('winColor','win','00ffff',0.01)
            elseif curStep %3 == 2 then
                doTweenColor('winColor','win','ff0000',0.01)
            elseif curStep %3 == 3 then
                doTweenColor('winColor','win','ffff00',0.01)
            elseif curStep %3 == 4 then
                doTweenColor('winColor','win','ff8100',0.01)   
            end
            setProperty('win.alpha',1)

        end
        if curStep > 1865 and curStep < 1879 and curStep %1 == 0 
        then
            if curStep %3 == 0 then
                --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
                doTweenColor('winColor','win','0000ff',0.01)
            elseif curStep %3 == 1 then
                doTweenColor('winColor','win','00ffff',0.01)
            elseif curStep %3 == 2 then
                doTweenColor('winColor','win','ff0000',0.01)
            elseif curStep %3 == 3 then
                doTweenColor('winColor','win','ffff00',0.01)
            elseif curStep %3 == 4 then
                doTweenColor('winColor','win','ff8100',0.01)   
            end
            setProperty('win.alpha',1)
        end
        if curStep > 5617 and curStep < 5681
        
        then
            if curStep %3 == 0 then
                --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
                doTweenColor('winColor','win','0000ff',0.01)
            elseif curStep %3 == 1 then
                doTweenColor('winColor','win','00ffff',0.01)
            elseif curStep %3 == 2 then
                doTweenColor('winColor','win','ff0000',0.01)
            elseif curStep %3 == 3 then
                doTweenColor('winColor','win','ffff00',0.01)
            elseif curStep %3 == 4 then
                doTweenColor('winColor','win','ff8100',0.01)   
            end
            setProperty('win.alpha',0.6)
        end
        if curStep > 5925 and curStep < 5948
        
        then
            if curStep %3 == 0 then
                --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
                doTweenColor('winColor','win','0000ff',0.01)
            elseif curStep %3 == 1 then
                doTweenColor('winColor','win','00ffff',0.01)
            elseif curStep %3 == 2 then
                doTweenColor('winColor','win','ff0000',0.01)
            elseif curStep %3 == 3 then
                doTweenColor('winColor','win','ffff00',0.01)
            elseif curStep %3 == 4 then
                doTweenColor('winColor','win','ff8100',0.01)   
            end
            setProperty('win.alpha',0.6)
            doTweenAlpha('winAlpha','win',1,0.006)

        end

        if curStep > 5745 and curStep < 5884 and curStep %1 == 0 
        then
            if curStep %3 == 0 then
                --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
                doTweenColor('winColor','win','0000ff',0.01)
            elseif curStep %3 == 1 then
                doTweenColor('winColor','win','00ffff',0.01)
            elseif curStep %3 == 2 then
                doTweenColor('winColor','win','ff0000',0.01)
            elseif curStep %3 == 3 then
                doTweenColor('winColor','win','ffff00',0.01)
            elseif curStep %3 == 4 then
                doTweenColor('winColor','win','ff8100',0.01)   
            end
            setProperty('win.alpha',1)
            doTweenAlpha('winAlpha','win',0.8,0.1)

        end
        if curStep > 3154 and curStep < 3168 and curStep %1 == 0 
        or curStep > 3185 and curStep < 3200 and curStep %1 == 0
        or curStep > 3217 and curStep < 3248 and curStep %1 == 0
        
        then
            if curStep %3 == 0 then
                --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
                doTweenColor('winColor','win','0000ff',0.01)
            elseif curStep %3 == 1 then
                doTweenColor('winColor','win','00ffff',0.01)
            elseif curStep %3 == 2 then
                doTweenColor('winColor','win','ff0000',0.01)
            elseif curStep %3 == 3 then
                doTweenColor('winColor','win','ffff00',0.01)
            elseif curStep %3 == 4 then
                doTweenColor('winColor','win','ff8100',0.01)   
            end
            setProperty('win.alpha',1)
            doTweenAlpha('winAlpha','win',0.1,0.1)

        end
        if curStep > 3281 and curStep < 3473 and curStep %4 == 0 
        or curStep > 3585 and curStep < 3713 and curStep %16 == 0 
        or curStep > 3721 and curStep < 3841 and curStep %8 == 0 
        --or curStep > 3841 and curStep < 3953 and curStep %4 == 0 
        or curStep > 5248 and curStep < 5505 and curStep %4 == 0
        then
            if curStep %3 == 0 then
                --setProperty('win.color',math.random(getColorFromHex('0000ff','00ffff','ff0000','ffff00','ff8100')))-- very random
                doTweenColor('winColor','win','0000ff',0.01)
            elseif curStep %3 == 1 then
                doTweenColor('winColor','win','00ffff',0.01)
            elseif curStep %3 == 2 then
                doTweenColor('winColor','win','ff0000',0.01)
            elseif curStep %3 == 3 then
                doTweenColor('winColor','win','ffff00',0.01)
            elseif curStep %3 == 4 then
                doTweenColor('winColor','win','ff8100',0.01)   
            end
            setProperty('win.alpha',1)
            doTweenAlpha('winAlpha','win',0.1,0.4)

        end
        if curStep == 5950 then
            setProperty('win.alpha',1)
            doTweenAlpha('winAlpha','win',0,7)
        end-----------------------------------Spotlight(old Concept)
    --    if curStep == 64 or curStep == 96 or curStep == 192 or curStep == 200 or curStep == 224 or curStep == 232 or curStep == 256 or curStep == 264 then --flash
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',1)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',1)
    --
    --        setProperty('SpotLights1.angle',-30)
    --        setProperty('SpotLights2.angle',30)
    --        setProperty('SpotLights3.angle',-30)
    --        setProperty('SpotLights4.angle',30)
    --        setProperty('SpotLights5.angle',-30)
    --        setProperty('SpotLights6.angle',30)
    --
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0,0.5,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',5,0.6,'ExpoOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-5,  0.6,'ExpoOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',7, 0.6,'ExpoOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',-7, 0.6,'ExpoOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',10,  0.6,'ExpoOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',-10,  0.6,'ExpoOut')
    --
    --       
    --    end
    --    if curStep == 128 then
    --        setProperty('SpotLights1.angle',-30)
    --        setProperty('SpotLights2.angle',30)
    --        setProperty('SpotLights3.angle',-30)
    --        setProperty('SpotLights4.angle',30)
    --        setProperty('SpotLights5.angle',-30)
    --        setProperty('SpotLights6.angle',30)
    --        
    --
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',1,2.5,'QuartOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',1,2.5,'QuartOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',1,2.5,'QuartOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',1,2.5,'QuartOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',1,2.5,'QuartOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',1,2.5,'QuartOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',5,5.2,'ExpoOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-5,  5.2,'ExpoOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',7, 5.2,'ExpoOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',-7, 5.2,'ExpoOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',10,  5.2,'ExpoOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',-10,  5.2,'ExpoOut')
    --    end
    --    if curStep == 160 then
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0,4.3,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0,4.3,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0,4.3,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0,4.3,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0,4.3,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0,4.3,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',-40,4.08,'Circin')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',40, 4.08,'Circin')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-40,4.08,'Circin')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',40, 4.08,'Circin')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-40,4.08,'Circin')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',40, 4.08,'Circin')
    --    end
    --    if curStep == 70 or curStep == 78 or curStep == 83 or curStep == 102 or curStep == 110 or curStep == 116
    --    or curStep == 208 or curStep == 216
    --    or curStep == 242 or curStep == 251 
    --    or curStep == 512 or curStep == 530 or curStep == 536 or curStep == 559 or curStep == 566
    --    or curStep == 575 or curStep == 579 or curStep == 581 or curStep == 585 or curStep == 588 or curStep == 592 or curStep == 594 or curStep == 598 or curStep == 601 or curStep == 603 then
    --        --Spotlight1up('SpotLights1','SpotLights2','SpotLights1Alpha','SpotLights2Alpha','SpotLights1AngleDone','SpotLights2AngleDone',0.5,'CircOut')
    --        setProperty('SpotLights1.angle',-40)
    --        setProperty('SpotLights2.angle',40)
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0,0.5,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',5,0.3,'CircOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-5,0.3,'CircOut')
    --    end
    --    if curStep == 71 or curStep == 80 or curStep == 86 or curStep == 103 or curStep == 112 or curStep == 118
    --    or curStep == 211
    --    or curStep == 245 or curStep == 254
    --    or curStep == 526 or curStep == 531 or curStep == 543 or curStep == 561 or curStep == 569
    --    or curStep == 590 or curStep == 605 then
    --        --Spotlight1up('SpotLights3','SpotLights4','SpotLights3Alpha','SpotLights4Alpha','SpotLights3AngleDone','SpotLights4AngleDone',0.5,'CircOut')
    --
    --        setProperty('SpotLights3.angle',-40)
    --        setProperty('SpotLights4.angle',40)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',1)
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0,0.5,'QuartinOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',5,0.3,'CircOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',-5,0.3,'CircOut')
    --    end
    --    if curStep == 72 or curStep == 82 or curStep == 89 or curStep == 104 or curStep == 114 or curStep == 121
    --    or curStep == 214
    --    or curStep == 248
    --    or curStep == 526 or curStep == 534 or curStep == 559 or curStep == 563 then
    --        --Spotlight1up('SpotLights5','SpotLights6','SpotLights5Alpha','SpotLights6Alpha','SpotLights5AngleDone','SpotLights6AngleDone',0.5,'CircOut')
    --
    --        setProperty('SpotLights5.angle',-40)
    --        setProperty('SpotLights6.angle',40)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',14)
    --        doTweenAlpha('SpotLight5Alpha','SpotLights5',0, 0.5,'QuartinOut')
    --        doTweenAlpha('SpotLight6Alpha','SpotLights6',0, 0.5,'QuartinOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',5,0.3,'CircOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',-5,0.3,'CircOut')
    --    end
    --    if curStep == 639 or curStep == 652 or curStep == 656 or curStep == 660 or curStep == 672 or curStep == 684 or curStep == 708 or curStep == 720 or curStep == 732 then
    --        setProperty('SpotLights1.angle',-5)
    --        setProperty('SpotLights2.angle',5)
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        doTweenAlpha('SpotLight1Alpha','SpotLights1',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight2Alpha','SpotLights2',0, 0.26,'QuartinOut')
    --    end
    --    if curStep == 648 or curStep == 656 or curStep == 664 or curStep == 672 or curStep == 680 or curStep == 712 or curStep == 720 or curStep == 728 then
    --        setProperty('SpotLights3.angle',-7)
    --        setProperty('SpotLights4.angle',7)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',14)
    --        doTweenAlpha('SpotLight3Alpha','SpotLights3',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight4Alpha','SpotLights4',0, 0.26,'QuartinOut')
    --    end
    --    if curStep == 644 or curStep == 656 or curStep == 668 or curStep == 672 or curStep == 676 or curStep == 716 or curStep == 720 or curStep == 724 then
    --        setProperty('SpotLights5.angle',-10)
    --        setProperty('SpotLights6.angle',10)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',1)
    --        doTweenAlpha('SpotLight5Alpha','SpotLights5',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight6Alpha','SpotLights6',0, 0.26,'QuartinOut')
    --    end
    --    if curStep == 272 then
    --        setProperty('SpotLights1.angle',-30)
    --        setProperty('SpotLights2.angle',30)
    --        setProperty('SpotLights3.angle',-30)
    --        setProperty('SpotLights4.angle',30)
    --        setProperty('SpotLights5.angle',-30)
    --        setProperty('SpotLights6.angle',30)
    --        setProperty('SpotLights1.alpha',0)
    --        setProperty('SpotLights2.alpha',0)
    --        setProperty('SpotLights3.alpha',0)
    --        setProperty('SpotLights4.alpha',0)
    --        setProperty('SpotLights5.alpha',0)
    --        setProperty('SpotLights6.alpha',0)
    --
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',1,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',1,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',1,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',1,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',1,0.5,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',1,0.5,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',7,1.3,'ExpoOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-7,  1.3,'ExpoOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',10, 1.3,'ExpoOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',-10, 1.3,'ExpoOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',12,  1.3,'ExpoOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',-12,  1.3,'ExpoOut')
    --    end
    --    if curStep == 285 or curStep == 374 then
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',7,0.7,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',-7,0.7,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',7,0.7,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',-7,0.7,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',7,0.7,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',-7,0.7,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',-40,0.5,'Circin')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',40, 0.5,'Circin')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-40,0.5,'Circin')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',40, 0.5,'Circin')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-40,0.5,'Circin')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',40, 0.5,'Circin')
    --    end
    --    if curStep == 336 then
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',1,0.3,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',1,0.3,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',1,0.3,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',1,0.3,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',1,0.3,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',1,0.3,'QuartinOut')
    --    end
    --    if curStep > 336 and curStep < 372 then
    --        songPos = getSongPosition()
    --        local currentBeat = (songPos/200)*(curBpm/60)
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',5 - 15* math.sin(((currentBeat / 10) + 1*0.25) * math.pi),0.2)
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-5 + 15* math.sin(((currentBeat / 10) + 4*0.25) * math.pi), 0.2)
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',5 - 15* math.sin(((currentBeat / 10) + 7*0.25) * math.pi),0.2)
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',-5 + 15* math.sin(((currentBeat / 10) + 1*0.25) * math.pi), 0.2)
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',5 - 15* math.sin(((currentBeat / 10) + 4*0.25) * math.pi),0.2)
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',-5 + 15* math.sin(((currentBeat / 10) + 7*0.25) * math.pi), 0.2)
    --    end
    --    if curStep == 384 or curStep == 416 or curStep == 448 then
    --        setProperty('SpotLights1.angle',6)
    --        setProperty('SpotLights2.angle',-6)
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        doTweenAlpha('SpotLight1Alpha','SpotLights1',0, 0.66,'QuartinOut')
    --        doTweenAlpha('SpotLight2Alpha','SpotLights2',0, 0.66,'QuartinOut')
    --        setProperty('SpotLights3.angle',-6)
    --        setProperty('SpotLights4.angle',6)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',1)
    --        doTweenAlpha('SpotLight3Alpha','SpotLights3',0, 0.66,'QuartinOut')
    --        doTweenAlpha('SpotLight4Alpha','SpotLights4',0, 0.66,'QuartinOut')
    --        setProperty('SpotLights5.angle',-7)
    --        setProperty('SpotLights6.angle',7)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',1)
    --        doTweenAlpha('SpotLight5Alpha','SpotLights5',0, 0.66,'QuartinOut')
    --        doTweenAlpha('SpotLight6Alpha','SpotLights6',0, 0.66,'QuartinOut')
    --    end
    --    if curStep == 392 or curStep == 424 or curStep == 456 then
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0,0.6,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0,0.6,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0,0.6,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0,0.6,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0,0.6,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0,0.6,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',-40,0.6)
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',40, 0.6)
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-40,0.6)
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',40, 0.6)
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-40,0.6)
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',40, 0.6)
    --    end
    --    if curStep == 620 or curStep == 637 then
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0,0.429,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',-40,0.429,'CircOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',40, 0.429,'CircOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-40,0.429,'CircOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',40, 0.429,'CircOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-40,0.429,'CircOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',40, 0.429,'CircOut')
    --    end
    --    if curStep == 624 then
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',1,0.429,'QuartOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',1,0.429,'QuartOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',1,0.429,'QuartOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',1,0.429,'QuartOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',1,0.429,'QuartOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',1,0.429,'QuartOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',5,0.429,'CircOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-5, 0.429,'CircOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-5,0.429,'CircOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',5, 0.429,'CircOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-5,0.429,'CircOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',5, 0.429,'CircOut')
    --    end
    --
    --    if curStep == 772 or curStep == 784 or curStep == 796
    --    or curStep == 804 or curStep == 816 or curStep == 828
    --    or curStep == 836 or curStep == 848 or curStep == 860
    --    or curStep == 868 then
    --        setProperty('SpotLights1.angle',-30)
    --        setProperty('SpotLights2.angle',30)
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        doTweenAlpha('SpotLight1Alpha','SpotLights1',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight2Alpha','SpotLights2',0, 0.26,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',5,0.4,'ExpoOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-5, 0.4,'ExpoOut')
    --
    --    end
    --    if curStep == 776 or curStep == 788
    --    or curStep == 808 or curStep == 820
    --    or curStep == 840 or curStep == 852
    --    or curStep == 872 then
    --        setProperty('SpotLights3.angle',-30)
    --        setProperty('SpotLights4.angle',30)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',14)
    --        doTweenAlpha('SpotLight3Alpha','SpotLights3',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight4Alpha','SpotLights4',0, 0.26,'QuartinOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',7, 0.4,'ExpoOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',-7, 0.4,'ExpoOut')
    --    end
    --    if curStep == 780 or curStep == 792
    --    or curStep == 812 or curStep == 824
    --    or curStep == 844 or curStep == 856
    --    or curStep == 876 then
    --        setProperty('SpotLights5.angle',-30)
    --        setProperty('SpotLights6.angle',30)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',1)
    --        doTweenAlpha('SpotLight5Alpha','SpotLights5',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight6Alpha','SpotLights6',0, 0.26,'QuartinOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',10,  0.4,'ExpoOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',-10,  0.4,'ExpoOut')
    --    end
    --    if curStep == 767 or curStep == 800 or curStep == 832 or curStep == 864 then
    --        setProperty('SpotLights1.angle',-30)
    --        setProperty('SpotLights2.angle',30)
    --        setProperty('SpotLights3.angle',-30)
    --        setProperty('SpotLights4.angle',30)
    --        setProperty('SpotLights5.angle',-30)
    --        setProperty('SpotLights6.angle',30)
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',1)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',1)
    --
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0,0.54,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0,0.54,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0,0.54,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0,0.54,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0,0.54,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0,0.54,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',7,0.3,'ExpoOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-7,  0.3,'ExpoOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-7, 0.3,'ExpoOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',7, 0.3,'ExpoOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-10,  0.3,'ExpoOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',10,  0.3,'ExpoOut')
    --    end
    --
    --    if curStep == 896 or curStep == 908 or curStep == 911 or curStep == 918 or curStep == 922 or curStep == 933 or curStep == 939 or curStep == 946 or curStep == 953 or curStep == 968 or curStep == 971 or curStep == 980 or curStep == 986 then
    --        setProperty('SpotLights1.angle',5)
    --        setProperty('SpotLights2.angle',-5)
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        doTweenAlpha('SpotLight1Alpha','SpotLights1',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight2Alpha','SpotLights2',0, 0.26,'QuartinOut')
    --    end
    --    if curStep == 900 or curStep == 904 or curStep == 914 or curStep == 921 or curStep == 932 or curStep == 936 or curStep == 943 or curStep == 953 or curStep == 956 or curStep == 966 or curStep == 970 or curStep == 978 or curStep == 985 then
    --        setProperty('SpotLights3.angle',6)
    --        setProperty('SpotLights4.angle',-6)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',14)
    --        doTweenAlpha('SpotLight3Alpha','SpotLights3',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight4Alpha','SpotLights4',0, 0.26,'QuartinOut')
    --    end
    --    if curStep == 901 or curStep == 905 or curStep == 915 or curStep == 924 or curStep == 928 or curStep == 938 or curStep == 947 or curStep == 950 or curStep == 960 or curStep == 964 or curStep == 975 or curStep == 982 or curStep == 988 then
    --        setProperty('SpotLights5.angle',7)
    --        setProperty('SpotLights6.angle',-7)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',1)
    --        doTweenAlpha('SpotLight5Alpha','SpotLights5',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight6Alpha','SpotLights6',0, 0.26,'QuartinOut')
    --    end
    --    if curStep > 1023 and curStep < 1114 then
    --        songPos = getSongPosition()
    --        local currentBeat = (songPos/200)*(curBpm/120)
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0.44,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0.44,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0.44,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0.44,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0.44,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0.44,0.05,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',5 - 5* math.sin(((currentBeat / 10) + 1*0.25) * math.pi),0.2)
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-5 + 5* math.sin(((currentBeat / 10) + 2*0.25) * math.pi), 0.2)
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',5 - 5* math.sin(((currentBeat / 10) + 3*0.25) * math.pi),0.2)
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',-5 + 5* math.sin(((currentBeat / 10) + 1*0.25) * math.pi), 0.2)
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',5 - 5* math.sin(((currentBeat / 10) + 2*0.25) * math.pi),0.2)
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',-5 + 5* math.sin(((currentBeat / 10) + 3*0.25) * math.pi), 0.2)
    --    end
    --    if curStep == 1116 then
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0,0.429,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',-40,0.229,'CircOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',40, 0.229,'CircOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-40,0.229,'CircOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',40, 0.229,'CircOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-40,0.229,'CircOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',40, 0.229,'CircOut')
    --    end
    --    if curStep == 1120 or curStep == 1128 or curStep == 1136 then
    --        cancelTween('SpotLights1AngleDone')
    --        cancelTween('SpotLights2AngleDone')
    --        cancelTween('SpotLights3AngleDone')
    --        cancelTween('SpotLights4AngleDone')
    --        cancelTween('SpotLights5AngleDone')
    --        cancelTween('SpotLights6AngleDone')
    --
    --        setProperty('SpotLights1.angle',5)
    --        setProperty('SpotLights2.angle',-5)
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        doTweenAlpha('SpotLight1Alpha','SpotLights1',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight2Alpha','SpotLights2',0, 0.26,'QuartinOut')
    --    end
    --    if curStep == 1122 or curStep == 1131 or curStep == 1138 then
    --        setProperty('SpotLights3.angle',6)
    --        setProperty('SpotLights4.angle',-6)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',14)
    --        doTweenAlpha('SpotLight3Alpha','SpotLights3',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight4Alpha','SpotLights4',0, 0.26,'QuartinOut')
    --        setProperty('SpotLights5.angle',7)
    --        setProperty('SpotLights6.angle',-7)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',1)
    --        doTweenAlpha('SpotLight5Alpha','SpotLights5',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight6Alpha','SpotLights6',0, 0.26,'QuartinOut')
    --    end
    --    if curStep == 1152 or curStep == 1184 then
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',1)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',1)
    --
    --        setProperty('SpotLights1.angle',-30)
    --        setProperty('SpotLights2.angle',30)
    --        setProperty('SpotLights3.angle',-30)
    --        setProperty('SpotLights4.angle',30)
    --        setProperty('SpotLights5.angle',-30)
    --        setProperty('SpotLights6.angle',30)
    --
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0,1.2,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0,1.2,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0,1.2,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0,1.2,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0,1.2,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0,1.2,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',7,0.6,'ExpoOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-7,  0.6,'ExpoOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-7, 0.6,'ExpoOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',7, 0.6,'ExpoOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-8,  0.6,'ExpoOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',8,  0.6,'ExpoOut')
    --
    --       
    --    end
    --    if curStep > 1224 and curStep < 1242 then
    --        songPos = getSongPosition()
    --        local currentBeat = (songPos/200)*(curBpm/40)
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0.54,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0.54,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0.54,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0.54,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0.54,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0.54,0.05,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',5 - 5* math.sin(((currentBeat / 10) + 1*0.25) * math.pi),0.1)
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-5 + 5* math.sin(((currentBeat / 10) + 2*0.25) * math.pi), 0.1)
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-5 - 5* math.sin(((currentBeat / 10) + 3*0.25) * math.pi),0.1)
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',5 + 5* math.sin(((currentBeat / 10) + 1*0.25) * math.pi), 0.1)
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-5 - 5* math.sin(((currentBeat / 10) + 2*0.25) * math.pi),0.1)
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',5 + 5* math.sin(((currentBeat / 10) + 3*0.25) * math.pi), 0.1)
    --    end
    --    if curStep == 1243 then
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0,0.429,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',-40,0.429,'CircOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',40, 0.429,'CircOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-40,0.429,'CircOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',40, 0.429,'CircOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-40,0.429,'CircOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',40, 0.429,'CircOut')
    --    end
    --    if curStep == 1248 or curStep == 1280 then
    --        setProperty('SpotLights1.angle',7)
    --        setProperty('SpotLights2.angle',-7)
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        doTweenAlpha('SpotLight1Alpha','SpotLights1',0, 0.48,'QuartinOut')
    --        doTweenAlpha('SpotLight2Alpha','SpotLights2',0, 0.48,'QuartinOut')
    --        setProperty('SpotLights3.angle',-6)
    --        setProperty('SpotLights4.angle',6)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',14)
    --        doTweenAlpha('SpotLight3Alpha','SpotLights3',0, 0.48,'QuartinOut')
    --        doTweenAlpha('SpotLight4Alpha','SpotLights4',0, 0.48,'QuartinOut')
    --        setProperty('SpotLights5.angle',-7)
    --        setProperty('SpotLights6.angle',7)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',1)
    --        doTweenAlpha('SpotLight5Alpha','SpotLights5',0, 0.48,'QuartinOut')
    --        doTweenAlpha('SpotLight6Alpha','SpotLights6',0, 0.48,'QuartinOut')
    --    end
    --    if curStep == 1263 or curStep == 1268 or curStep == 1286 or curStep == 1291 or curStep == 1297 or curStep == 1302
    --     or curStep == 1312 or curStep == 1321 or curStep == 1328 or curStep == 1337 then
    --        setProperty('SpotLights1.angle',7)
    --        setProperty('SpotLights2.angle',-7)
    --        setProperty('SpotLights1.alpha',1)
    --        setProperty('SpotLights2.alpha',1)
    --        doTweenAlpha('SpotLight1Alpha','SpotLights1',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight2Alpha','SpotLights2',0, 0.26,'QuartinOut')
    --    end
    --    if curStep == 1265 or curStep == 1270 or curStep == 1287 or curStep == 1295 or curStep == 1298 or curStep == 1304
    --     or curStep == 1316 or curStep == 1324 or curStep == 1332 or curStep == 1340 then
    --        setProperty('SpotLights3.angle',-6)
    --        setProperty('SpotLights4.angle',6)
    --        setProperty('SpotLights3.alpha',1)
    --        setProperty('SpotLights4.alpha',14)
    --        doTweenAlpha('SpotLight3Alpha','SpotLights3',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight4Alpha','SpotLights4',0, 0.26,'QuartinOut')
    --    end
    --    if curStep == 1266 or curStep == 1272 or curStep == 1288 or curStep == 1296 or curStep == 1299
    --     or curStep == 1318 or curStep == 1327 or curStep == 1334 or curStep == 1342 then
    --        setProperty('SpotLights5.angle',-7)
    --        setProperty('SpotLights6.angle',7)
    --        setProperty('SpotLights5.alpha',1)
    --        setProperty('SpotLights6.alpha',1)
    --        doTweenAlpha('SpotLight5Alpha','SpotLights5',0, 0.26,'QuartinOut')
    --        doTweenAlpha('SpotLight6Alpha','SpotLights6',0, 0.26,'QuartinOut')
    --    end
    --    if curStep > 1344 and curStep < 1356 then
    --        songPos = getSongPosition()
    --        local currentBeat = (songPos/200)*(curBpm/30)
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0.6,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0.6,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0.6,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0.6,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0.6,0.05,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0.6,0.05,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',5 - 15* math.sin(((currentBeat / 10) + 1*0.25) * math.pi),0.1)
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-5 + 15* math.sin(((currentBeat / 10) + 2*0.25) * math.pi), 0.1)
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',5 - 15* math.sin(((currentBeat / 10) + 3*0.25) * math.pi),0.1)
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',-5 + 15* math.sin(((currentBeat / 10) + 1*0.25) * math.pi), 0.1)
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',5 - 15* math.sin(((currentBeat / 10) + 2*0.25) * math.pi),0.1)
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',-5 + 15* math.sin(((currentBeat / 10) + 3*0.25) * math.pi), 0.1)
    --    end
    --    if curStep == 1357 then
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0,0.429,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',-40,0.429,'CircOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',40, 0.429,'CircOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-40,0.429,'CircOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',40, 0.429,'CircOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-40,0.429,'CircOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',40, 0.429,'CircOut')
    --    end
    --    --[[if curStep == 1357 then
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',1,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',1,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',1,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',1,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',1,0.429,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',1,0.429,'QuartinOut')
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',5,0.429,'CircOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-5, 0.429,'CircOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',5,0.429,'CircOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',-5, 0.429,'CircOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',5,0.429,'CircOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',-5, 0.429,'CircOut')
    --    end]]
    --    if curStep == 1376 then
    --        doTweenAngle('SpotLights1AngleDone','SpotLights1',7,0.2,'CircOut')
    --        doTweenAngle('SpotLights2AngleDone','SpotLights2',-7, 0.2,'CircOut')
    --        doTweenAngle('SpotLights3AngleDone','SpotLights3',-5,0.2,'CircOut')
    --        doTweenAngle('SpotLights4AngleDone','SpotLights4',7, 0.2,'CircOut')
    --        doTweenAngle('SpotLights5AngleDone','SpotLights5',-7,0.2,'CircOut')
    --        doTweenAngle('SpotLights6AngleDone','SpotLights6',9, 0.2,'CircOut')
    --        doTweenAlpha('SpotLights1Alpha','SpotLights1',0.4,0.2,'QuartinOut')
    --        doTweenAlpha('SpotLights2Alpha','SpotLights2',0.4,0.3,'QuartinOut')
    --        doTweenAlpha('SpotLights3Alpha','SpotLights3',0.4,0.3,'QuartinOut')
    --        doTweenAlpha('SpotLights4Alpha','SpotLights4',0.4,0.3,'QuartinOut')
    --        doTweenAlpha('SpotLights5Alpha','SpotLights5',0.4,0.3,'QuartinOut')
    --        doTweenAlpha('SpotLights6Alpha','SpotLights6',0.4,0.3,'QuartinOut')
    --    end
    --    if curStep > 1413 and curStep < 1503 then
    --        if curStep > 1413 and curStep < 1497 and curStep %6 == 6 then
    --            doTweenAlpha('SpotLights1Alpha','SpotLights1',0.0,0.2,'QuartinOut') --
    --            doTweenAlpha('SpotLights2Alpha','SpotLights2',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights3Alpha','SpotLights3',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights4Alpha','SpotLights4',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights5Alpha','SpotLights5',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights6Alpha','SpotLights6',0.4,0.001,'QuartinOut')
    --        end
    --        if curStep > 1414 and curStep < 1498 and curStep %6 == 6 then
    --            doTweenAlpha('SpotLights1Alpha','SpotLights1',0.0,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights2Alpha','SpotLights2',0.4,0.2,'QuartinOut') -- 
    --            doTweenAlpha('SpotLights3Alpha','SpotLights3',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights4Alpha','SpotLights4',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights5Alpha','SpotLights5',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights6Alpha','SpotLights6',0.4,0.001,'QuartinOut')
    --        end
    --        if curStep > 1415 and curStep < 1499 and curStep %6 == 6 then
    --            doTweenAlpha('SpotLights1Alpha','SpotLights1',0.0,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights2Alpha','SpotLights2',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights3Alpha','SpotLights3',0.4,0.2,'QuartinOut') --
    --            doTweenAlpha('SpotLights4Alpha','SpotLights4',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights5Alpha','SpotLights5',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights6Alpha','SpotLights6',0.4,0.001,'QuartinOut')
    --        end
    --        if curStep > 1416 and curStep < 1500 and curStep %6 == 6 then
    --            doTweenAlpha('SpotLights1Alpha','SpotLights1',0.0,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights2Alpha','SpotLights2',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights3Alpha','SpotLights3',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights4Alpha','SpotLights4',0.4,0.2,'QuartinOut')
    --            doTweenAlpha('SpotLights5Alpha','SpotLights5',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights6Alpha','SpotLights6',0.4,0.001,'QuartinOut')
    --        end
    --        if curStep > 1417 and curStep < 1501 and curStep %6 == 6 then
    --            doTweenAlpha('SpotLights1Alpha','SpotLights1',0.0,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights2Alpha','SpotLights2',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights3Alpha','SpotLights3',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights4Alpha','SpotLights4',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights5Alpha','SpotLights5',0.4,0.2,'QuartinOut')
    --            doTweenAlpha('SpotLights6Alpha','SpotLights6',0.4,0.001,'QuartinOut')
    --        end
    --        if curStep > 1418 and curStep < 1502 and curStep %6 == 6 then
    --            doTweenAlpha('SpotLights1Alpha','SpotLights1',0.0,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights2Alpha','SpotLights2',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights3Alpha','SpotLights3',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights4Alpha','SpotLights4',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights5Alpha','SpotLights5',0.4,0.001,'QuartinOut')
    --            doTweenAlpha('SpotLights6Alpha','SpotLights6',0.4,0.2,'QuartinOut')
    --        end
    --    end

    --------------------Winnn Alpha--------------------Winnn Alpha
    end
end
function onUpdate()
    TimeBar = {'timeBar','timeBarBG', 'timeTxt'}
    for x = 1,3 do
        setProperty(TimeBar[x]..'.x', 100) 
    end
    setProperty('camZooming',false)
    noflashy = getPropertyFromClass('flixel.FlxG','save.data.noFlashy')
end
