-- midi-receive.lua

-- root.children.midiactions:notify("DF", 1)
function enableMIDI(b)
    if (b) then
        root.children.midiactions.values.x = 1
    else
        root.children.midiactions.values.x = 0
    end
end

function odd(v)
    return 2 * (math.floor(v/2)) ~= v
end

function effectsMSB(v)
    local a = v
    for i = 1, 4 do
        if i == 1 then
            root.children.phaser.children.phaser.values.x = odd(a)
        elseif i == 2 then
            root.children.eq.children.eq.values.x = odd(a)
        elseif i == 3 then
            root.children.dd.children.dd.values.x = odd(a)
        elseif i == 4 then
            root.children.chorus.children.chorus.values.x = odd(a)
        end
        a = math.floor(a / 2)
    end
end

function effectsLSB(v)
    local a = v
    for i = 1, 4 do
        if i == 1 then
            root.children.df.children.df.values.x = odd(a)
        elseif i == 2 then
            root.children.comp.children.comp.values.x = odd(a)
        elseif i == 3 then
            root.children.od.children.od.values.x = odd(a)
        elseif i == 4 then
            root.children.dist.children.dist.values.x = odd(a)
        end
        a = math.floor(a / 2)
    end
end

function setValues(t)
    local s = 0x8
    local v = 0
    local name = ""
    for i = 1, #t do
        v = t[i]
        -- effects
        if i == s + 0x0 then
            effectsMSB(v)
        elseif i == s + 0x1 then
            effectsLSB(v)
        -- df
        elseif i == s + 0x2 then
            root.children.df.children.dfsens.values.x = v / 100
        elseif i == s + 0x3 then
            root.children.df.children.dfcutoff.values.x = v / 100
        elseif i == s + 0x4 then
            root.children.df.children.dfq.values.x = v / 100
        elseif i == s + 0x5 then
            local a = "DOWN"
            if v > 50 then
                a = "UP"
            end
            root.children.df.children.updown.values.text = a
        -- comp
        elseif i == s + 0x6 then
            root.children.comp.children.compattack.values.x = v / 100
        elseif i == s + 0x7 then
            root.children.comp.children.compsustain.values.x = v / 100
        -- od
        elseif i == s + 0x8 then
            root.children.od.children.fodtone.values.x = v / 100
        elseif i == s + 0x9 then
            root.children.od.children.foddrive.values.x = v / 100
        elseif i == s + 0xA then
            local a = "STD"
            if v > 50 then
                a = "TURBO"
            end
            root.children.od.children.turbo.values.text = a
        -- dist
        elseif i == s + 0xB then
            root.children.dist.children.disttone.values.x = v / 100
        elseif i == s + 0xC then
            root.children.dist.children.distdrive.values.x = v / 100
        -- phaser
        elseif i == s + 0xD then
            root.children.phaser.children.phaserrate.values.x = v / 100
        elseif i == s + 0xE then
            root.children.phaser.children.phaserdepth.values.x = v / 100
        elseif i == s + 0xF then
            root.children.phaser.children.phaserresonance.values.x = v / 100
        -- eq
        elseif i == s + 0x10 then
            root.children.eq.children.eqhigh.values.x = v / 100
        elseif i == s + 0x11 then
            root.children.eq.children.eqmid.values.x = v / 100
        elseif i == s + 0x12 then
            root.children.eq.children.eqlow.values.x = v / 100
        elseif i == s + 0x13 then
            root.children.eq.children.eqvol.values.x = v / 100
        -- dd
        elseif i == s + 0x14 then
            root.children.dd.children.fddlevel.values.x = v / 100
        elseif i == s + 0x15 then
            root.children.dd.children.ddtime.values.x = 128 * v / 1000
        elseif i == s + 0x16 then
            root.children.dd.children.ddtime.values.x = root.children.dd.children.ddtime.values.x + v / 1000
        elseif i == s + 0x17 then
            root.children.dd.children.ddfeedback.values.x = v / 100
        -- chorus
        elseif i == s + 0x18 then
            root.children.chorus.children.chorusrate.values.x = v / 100
        elseif i == s + 0x19 then
            root.children.chorus.children.chorusdepth.values.x = v / 100
        elseif i == s + 0x1A then
            root.children.chorus.children.choruslevel.values.x = v / 100
        elseif i == s + 0x1B then
            root.children.chorus.children.choruspredelay.values.x = v / 100
        elseif i == s + 0x1C then
            root.children.chorus.children.chorusfeedback.values.x = v / 100
        -- other
        elseif i == s + 0x1D then
            root.children.other.children.mastervol.values.x = v / 100
        elseif i == s + 0x1E then
            root.children.other.children.eparam.values.text = tostring(v)
        -- ext 1 & 2
        elseif i == s + 0x1F then
            root.children.ext1.children.ext1.values.x = (v > 50)
        elseif i == s + 0x20 then
            root.children.ext2.children.ext2.values.x = (v > 50)
        -- name
        elseif i == s + 0x31 then
            root.children.string16.values.text = name
        elseif (i > s + 0x20) and (i < s + 0x21 + 16) then
            name = name .. string.char(v)
        end
    end
end

-- test
function test(x)
    setValues({240, 65, 0, 19, 18, 64, 0, 15, 15, 20, 30, 40, 0, 80, 90, 10, 20, 0, 70, 80, 50, 60, 70, 20, 30, 40, 50, 90, 6, 32, 70, 30, 40, 50, 60, 70, 70, 14, 100, 100, 65, 66, 67, 68, 69, 70, 32, 78, 97, 109, 101, 32, 32, 58, 45, 41, 0, 0, 56})
end

-- main 
function onReceiveMIDI(message, connections)
    if (#message > 57) and (message[1] == 0xF0) and (message[2] == 0x41) and (message[4] == 0x13) and (message[5] == 0x12) then
        enableMIDI(false)
        setValues(message)
        enableMIDI(true)
        return true
    else
        return false
    end
end
