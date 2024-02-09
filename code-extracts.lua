
function onValueChanged(x)
  if x == "x" then
    root.children.midiactions:notify("EFF", 1)
  end
end



function onValueChanged()
  local t = { "Off", "DF Sens", "DF Cutoff freq", "DF Q", "DF Up/Down", "Comp Attack", "Comp Sustain", "OD Tone", "OD Drive", "OD Turbo", "Dist Tone", "Dist Drive", "Phaser Rate", "Phaser Depth", "Phaser Resonance", "Eq High", "Eq Mid", "Eq Low", "Eq Volume", "DD Level", "DD Time", "DD Feedback", "Chorus Rate", "Chorus Depth", "Chorus Level", "Chorus Pre Delay", "Chorus Feedback", "Master Volume" }
  self.parent.children.eparamname.values.text = t[tonumber(self.values.text) + 1]

  -- propagate on midi
  root.children.midiactions:notify("EXP", 1)
end


-- slider for string16

function onValueChanged()
  local pos = 6
  local r = string.char(math.floor(self.values.x * 95 + 32))
  local str = self.parent.children.string16.values.text
  local new = string.sub(str, 1, pos - 1) .. r .. string.sub(str, pos + 1, 16)
  self.parent.children.string16.values.text = new
end

-- preset left or right

function onValueChanged(x)
  if x == "x" and self.values.x == 0 then
    local gbn = 0
    if self.parent.children.group.values.text == "B" then
      gbn = 64
    end
    gbn = gbn + (tonumber(self.parent.children.bank.values.text) - 1) * 8 + (tonumber(self.parent.children.number.values.text) - 1)
    gbn = gbn - 1 -- + 1 to go right
    if gbn < 0 then
      gbn = gbn + 128
    elseif gbn > 127 then
      gbn = gbn - 128
    end
    if gbn > 63 then
      gbn = gbn - 64
      self.parent.children.group.values.text = "B"
    else
      self.parent.children.group.values.text = "A"
    end
    local b = math.floor(gbn / 8) + 1
    self.parent.children.bank.values.text = b
    gbn = gbn - (b - 1) * 8 + 1
    self.parent.children.number.values.text = gbn
  end
end

