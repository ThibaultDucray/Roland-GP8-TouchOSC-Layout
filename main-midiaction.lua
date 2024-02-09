function checksum(t)
  local cs = 0
  for i = 1, #t
  do
    cs = cs + t[i]
  end
  cs = cs % 0x80
  return (0x80 - cs) % 0x80
end
    
-- read effects MSB
function effectsMSB()
  local eff = 0
  if (root.children.phaser.children.phaser.values.x == 1) then
    eff = eff + 1
  end
  if (root.children.eq.children.eq.values.x == 1) then
    eff = eff + 2
  end
  if (root.children.dd.children.dd.values.x == 1) then
    eff = eff + 4
  end
  if (root.children.chorus.children.chorus.values.x == 1) then
    eff = eff + 8
  end
  return eff
end
  
-- read effects LSB
function effectsLSB()
  local eff = 0
  if (root.children.df.children.df.values.x == 1) then
    eff = eff + 1
  end
  if (root.children.comp.children.comp.values.x == 1) then
    eff = eff + 2
  end
  if (root.children.od.children.od.values.x == 1) then
    eff = eff + 4
  end
  if (root.children.dist.children.dist.values.x == 1) then
    eff = eff + 8
  end
  return eff
end

-- return all effects in 2 bytes
function effectsAllParams(t)
  t[#t + 1] = effectsMSB()
  t[#t + 1] = effectsLSB()
end

function effectsParams(v)
  t = { 0x0 }
  if v < 5 then
    t[#t + 1] = 0x1
    t[#t + 1] = effectsLSB()
  else
    t[#t + 1] = 0x0
    t[#t + 1] = effectsMSB()
  end
  return t
end
    
-- read DF params 1= sens, 2 = cutoff, 3 = Q, 4 = updown
function dfAllParams(t)
  t[#t + 1] = tonumber(root.children.df.children.sens.values.text)
  t[#t + 1] = tonumber(root.children.df.children.cutoff.values.text)
  t[#t + 1] = tonumber(root.children.df.children.q.values.text)
  if root.children.df.children.updown.values.text == "UP" then
    t[#t + 1] = 0x64 -- 100
  else
    t[#t + 1] = 0x0 -- down
  end
end

function dfParams(n)
  local t = { }
  local p = { }
  if root.children.df.children.df.values.x == 1 then
    dfAllParams(p)
    t[#t + 1] = 0x0 
    t[#t + 1] = n + 0x1
    t[#t + 1] = p[n]
  end
  return t
end

-- read COMP params 1= attack, 2 = sustain
function compAllParams(t)
  t[#t + 1] = tonumber(root.children.comp.children.attack.values.text)
  t[#t + 1] = tonumber(root.children.comp.children.sustain.values.text)
end

function compParams(n)
  local t = {  }
  local p = { }
  if root.children.comp.children.comp.values.x == 1 then
    compAllParams(p)
    t[#t + 1] = 0x0
    t[#t + 1] = n + 0x5
    t[#t + 1] = p[n]
  end
  return t
end
  
-- read OD params 1= tone, 2 = drive, 3 = turbo
function odAllParams(t)
  t[#t + 1] = tonumber(root.children.od.children.odtone.values.text)
  t[#t + 1] = tonumber(root.children.od.children.oddrive.values.text)
  if root.children.od.children.turbo.values.text == "TURBO" then
    t[#t + 1] = 0x64 -- 100
  else
    t[#t + 1] = 0x0 -- std
  end
end

-- read OD params 1= tone, 2 = drive, 3 = turbo
function odParams(n)
  local t = {  }
  local p = { }
  if root.children.od.children.od.values.x == 1 then
    odAllParams(p)
    t[#t + 1] = 0x0
    t[#t + 1] = n + 0x7
    t[#t + 1] = p[n]
  end
  return t
end

-- read DIST params 1= tone, 2 = drive
function distAllParams(t)
  t[#t + 1] = tonumber(root.children.dist.children.dtone.values.text)
  t[#t + 1] = tonumber(root.children.dist.children.ddrive.values.text)
end

function distParams(n)
  local t = {  }
  local p = { }
  if root.children.dist.children.dist.values.x == 1 then
    distAllParams(p)
    t[#t + 1] = 0x0
    t[#t + 1] = n + 0xA
    t[#t + 1] = p[n]
  end
  return t
end

-- read PHASER params  1= rate, 2= depth, 3= resonance
function phaserAllParams(t)
  t[#t + 1] = tonumber(root.children.phaser.children.prate.values.text)
  t[#t + 1] = tonumber(root.children.phaser.children.pdepth.values.text)
  t[#t + 1] = tonumber(root.children.phaser.children.resonance.values.text)
end

function phaserParams(n)
  local t = {  }
  local p = { }
  if root.children.phaser.children.phaser.values.x == 1 then
    phaserAllParams(p)
    t[#t + 1] = 0x0
    t[#t + 1] = n + 0xC
    t[#t + 1] = p[n]
  end
  return t
end

-- read EQ params  1= high, 2= mid, 3= low, 4= vol
function eqAllParams(t)
  t[#t + 1] = tonumber(root.children.eq.children.high.values.text)
  t[#t + 1] = tonumber(root.children.eq.children.mid.values.text)
  t[#t + 1] = tonumber(root.children.eq.children.low.values.text)
  t[#t + 1] = tonumber(root.children.eq.children.volume.values.text)
end

function eqParams(n)
  local t = {  }
  local p = { }
  if root.children.eq.children.eq.values.x == 1 then
    eqAllParams(p)
    t[#t + 1] = 0x0
    t[#t + 1] = n + 0xF
    t[#t + 1] = p[n]
  end
  return t
end

-- read DD params 1= level, 2= time (2 bytes), 3= feedback
function ddAllParams(t)
  t[#t + 1] = tonumber(root.children.dd.children.ddlevel.values.text)
  local n = tonumber(root.children.dd.children.time.values.text)
  local msb = math.floor(n / 128)
  local lsb = n % 0x80
  t[#t + 1] = msb
  t[#t + 1] = lsb
  t[#t + 1] = tonumber(root.children.dd.children.feedback.values.text)
end

function ddParams(n)
  local t = {  }
  local p = { }
  if root.children.dd.children.dd.values.x == 1 then
    ddAllParams(p)
    t[#t + 1] = 0x0
    if n == 3 then
      n = 4
    end
    t[#t + 1] = n + 0x13
    t[#t + 1] = p[n]
    if n == 2 then
      t[#t + 1] = p[n + 1]
    end
  end
  return t
end

-- read CHORUS params 1= rate, 2= depth, 3= level, 4= predelay, 5= feedback
function chorusAllParams(t)
  t[#t + 1] = tonumber(root.children.chorus.children.crate.values.text)
  t[#t + 1] = tonumber(root.children.chorus.children.cdepth.values.text)
  t[#t + 1] = tonumber(root.children.chorus.children.clevel.values.text)
  t[#t + 1] = tonumber(root.children.chorus.children.predelay.values.text)
  t[#t + 1] = tonumber(root.children.chorus.children.cfeedback.values.text)
end

function chorusParams(n)
  local t = {  }
  local p = { }
  if root.children.chorus.children.chorus.values.x == 1 then
    chorusAllParams(p)
    t[#t + 1] = 0x0
    t[#t + 1] = n + 0x17
    t[#t + 1] = p[n]
  end
  return t
end

-- read MASTER VOLUME param 1= master volume
function volAllParams(t)
  t[#t + 1] = tonumber(root.children.other.children.volume.values.text)
end

function volParams(n)
  local t = { 0x0 }
  local p = { }
  volAllParams(p)
  t[#t + 1] = n + 0x1C
  t[#t + 1] = p[n]
  return t
end

-- read EXP param 1= config from 0(Off) to 27(vol)
function expAllParams(t)
  t[#t + 1] = tonumber(root.children.other.children.eparam.values.text)
end

function expParams(n)
  local t = { 0x0 }
  local p = { }
  expAllParams(p)
  t[#t + 1] = n + 0x1D
  t[#t + 1] = p[n]
  return t
end

-- read EXT1 param 1= ext1 on/off
function ext1AllParams(t)
  if root.children.ext1.children.ext1.values.x == 1 then
    t[#t + 1] = 0x64
  else
    t[#t + 1] = 0x0
  end
end

function ext1Params(n)
  local t = { 0x0 }
  local p = { }
  ext1AllParams(p)
  t[#t + 1] = n + 0x1E
  t[#t + 1] = p[n]
  return t
end

-- read EXT2 param 1= ext1 on/off
function ext2AllParams(t)
  if root.children.ext2.children.ext2.values.x == 1 then
    t[#t + 1] = 0x64
  else
    t[#t + 1] = 0x0
  end
end

function ext2Params(n)
  local t = { 0x0 }
  local p = { }
  ext2AllParams(p)
  t[#t + 1] = n + 0x1F
  t[#t + 1] = p[n]
  return t
end

-- read NAME
function nameParam(t)
  local str = root.children.string16.values.text
  for i = 1, 16 do
    t[#t + 1] = string.byte(str, i)
  end
  t[#t + 1] = 0x0
end

-- send bytes of data at the given roland address
-- this fuction creates the sysex header and happends checksum and end of sysex then sends to MIDI
function sendOneParam(data)
  if #data == 0 or self.values.x == 0 then
    return
  end
  
  local cs = checksum(data)
  local ch = tonumber(root.children.global.children.channel.values.text)
  local frame = { 0xF0, 0x41, ch-1, 0x13, 0x12 } -- sys excl, roland id, channel, model id, command id
  for i = 1, #data
  do
    frame[#frame + 1] = data[i]
  end
  frame[#frame + 1] = cs
  frame[#frame + 1] = 0xF7 -- end of sysex
  sendMIDI(frame)
end

-- send all params in GP8 memory (given group-bank-number id)
function writeAll(gbn)
  if self.values.x == 0 then
    return
  end
  local address = (gbn * 0x40) + 0x2000
  local addressMSB = math.floor(address / 0x80)
  local addressLSB = address % 0x80
  local t = { addressMSB, addressLSB }

  effectsAllParams(t)
  dfAllParams(t)
  compAllParams(t)
  odAllParams(t)
  distAllParams(t)
  phaserAllParams(t)
  eqAllParams(t)
  ddAllParams(t)
  chorusAllParams(t)
  volAllParams(t)
  expAllParams(t)
  ext1AllParams(t)
  ext2AllParams(t)
  nameParam(t)
  t[#t + 1] = 0x0 -- end of string
  sendOneParam(t)
end

-- notif of changed values
function onReceiveNotify(key, value)
  if key == "EFF" then
    sendOneParam(effectsParams(value))
  elseif key == "DF" then
    sendOneParam(dfParams(value))
  elseif key == "COMP" then
    sendOneParam(compParams(value))
  elseif key == "OD" then
    sendOneParam(odParams(value))
  elseif key == "DIST" then
    sendOneParam(distParams(value))
  elseif key == "PHASER" then
    sendOneParam(phaserParams(value))
  elseif key == "EQ" then
    sendOneParam(eqParams(value))
  elseif key == "DD" then
    sendOneParam(ddParams(value))
  elseif key == "CHORUS" then
    sendOneParam(chorusParams(value))
  elseif key == "VOL" then
    sendOneParam(volParams(value))
  elseif key == "EXP" then
    sendOneParam(expParams(value))
  elseif key == "EXT1" then
    sendOneParam(ext1Params(value))
  elseif key == "EXT2" then
    sendOneParam(ext2Params(value))
  elseif key == "WRITE" then
    writeAll(value)
  end
end