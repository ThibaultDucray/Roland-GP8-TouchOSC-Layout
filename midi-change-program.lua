-- midi-change-program.lua

function checksum(t)
    local cs = 0
    for i = 6, #t
    do
      cs = cs + t[i]
    end
    return 0x80 - (cs % 0x80)
  end

function wait40ms()
    local t1 = getMillis()
    local t2 = t1
    while t2 - t1 < 40 do
        t2 = getMillis()
    end
end

function requestValues(channel, gbn)
    local address = (gbn * 0x40) + 0x2000
    local addressMSB = math.floor(address / 0x80)
    local addressLSB = address % 0x80
    local t = { 0xF0, 0x41, channel - 1, 0x13, 0x11, addressMSB, addressLSB, 0x0, 0x32 }
    t[#t + 1] = checksum(t)
    t[#t + 1] = 0xF7
    sendMIDI(t)
end

function onValueChanged(x)
    if x == "x" and self.values.x == 0 then
        local gbn = 0
        if self.parent.children.group.values.text == "B" then
        gbn = 64
        end
        gbn = gbn + (tonumber(self.parent.children.bank.values.text) - 1) * 8 + (tonumber(self.parent.children.number.values.text) - 1)
        self.parent.children.label4.values.text = tostring(gbn)

        sendMIDI({ MIDIMessageType.PROGRAMCHANGE - 1 + tonumber(self.parent.children.channel.values.text), gbn })
        wait40ms()
        requestValues(tonumber(self.parent.children.channel.values.text), gbn)
    end
end
