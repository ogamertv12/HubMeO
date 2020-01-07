  gg.alert('🗂️Welcome To MeONaJa Script', 'Enter !')
  gg.setVisible(false)
  Version = 'V6.2.0'
  _File = gg.getFile()
  Hey = gg.toast
  Msg = gg.alert
  gg.setVisible(false)
  Hack = {
    ['MEO1'] = {
      Name = ' ป้อมไม่ยิง ',
      Switch = false,
      ['✔️ เปิด'] = 2576980377,
      Type = gg.TYPE_FLOAT,
      Exec = function()
        Cheat(Hack['MEO1_2'])
      end
    },
    ['MEO1_2'] = {
      Name = ' ',
      Switch = false,
      ['✔️ เปิด'] = 2576980377,
      Type = gg.TYPE_FLOAT
    },
    ['MEO2'] = {
      Name = ' กิลด์เหรดไม่เดิน ',
      Switch = false,
      ['✔️ เปิด'] = 0,
      Type = gg.TYPE_FLOAT,
      Exec = function()
        Cheat(Hack['MEO2_2'])
      end
    },
    ['MEO2_2'] = {
      Name = ' ',
      Switch = false,
      ['✔️ เปิด'] = 0,
      Type = gg.TYPE_FLOAT
    },
    ['FOV'] = {
      Name = ' Ptr_1 '
    }
  }
  function ForceExit()
    while true do
      os.exit()
    end
  end
  function PopupBox(Caption, Text)
	if Text == nil then Text = "" end
	gg.alert(Caption .. '\n' .. Text)
end
  function ShowOff_On(A0_25)
    if not A0_25 then
      return '✔️ เปิด'
    end
    return '❌ ปิด'
  end
  function Return(...)
    gg.setVisible(true)
  end
  function HackSwitch(HS)
    if not HS then return "❌ ปิด" end
    return "✔️ เปิด"
  end
  function Cheat(Hack)
    if Hack.Address ~= nil then
    if Hack.Alert ~= nil and Hack.Alert ~= 1 then  PopupBox("ข้อความ: ".. Hack.Name, Hack.Alert); Hack.Alert = 1 end
      if Hack.Exec ~=nil then Hack.Exec() end
      if Hack.Type ~= nil and Hack["❌ ปิด"] == nil then Hack["❌ ปิด"] = rpm(Hack.Address, Hack.Type) end 
          Hack.Switch = not Hack.Switch
      if Hack.Type ~= nil then
        wpm(Hack.Address, Hack.Type, Hack[HackSwitch(Hack.Switch)])
        gg.toast("ฟังชั่น: " .. Hack.Name .. " -> " .. HackSwitch(Hack.Switch))
        return true
      end
    end
    PopupBox('อุปมีปัญหา !', Hack.Name .. ' ไม่พบที่อยู่ Offset ')
    return false
  end
  function isAddrValid(Address)
	if Address ~= nil and Address ~= 0 or Address then
		return true
	end
	return false
end
  function tohex(Data) 
	return Data:gsub(".", function(a) return string.format("%02X", (string.byte(a))) end):gsub(" ", "") 
end
  function wpm(Address, ggtype, data)
	if gg.setValues({{address = Address, flags = ggtype, value = data}}) then 
		return true 
	else 
		return false 
	end
end
  function rpm(Address, ggtype)
    res = gg.getValues({{address = Address, flags = ggtype}})
    if type(res) ~= "string" then
      if ggtype == gg.TYPE_BYTE then
        result = res[1].value & 0xFF
      elseif ggtype == gg.TYPE_WORD then
        result = res[1].value & 0xFFFF
      elseif ggtype == gg.TYPE_DWORD then
        result = res[1].value & 0xFFFFFFFF
      elseif ggtype == gg.TYPE_QWORD then
        result = res[1].value & 0xFFFFFFFFFFFFFFFF
      elseif ggtype == gg.TYPE_XOR then
        result = res[1].value & 0xFFFFFFFF
      else
        result = res[1].value
      end
      return result
    else
      return false
    end
  end
  function GODO()
    gg.setVisible(false)
  end
  function GetLibraryTextBase(lib)
	for _, __ in pairs(gg.getRangesList(lib)) do
		if __["state"] == "Xa" then return __["start"], __["end"] end
	end
	return nil
end
  function ChangeFOV(A0_39)
    gg.setVisible(false)
    nFOV = gg.prompt({
      'ปรับความเร็วเกมส์:[1.12 - 0.1]\nความเร็วปัจจุบัน ' .. cFOV .. ""
    }, {
      cFOV
    }, {
      'number'
    })
    if nFOV ~= nil then
      wpm(A0_39.Address, gg.TYPE_FLOAT, nFOV[1])
      gg.toast(cFOV .. ' -＞ ' .. nFOV[1])
    end
  end
  GODO()
  sXs = 'ปกติ'
  gg.sleep(0)
  BaseAddress = GetLibraryTextBase('libgame.so')
  if not isAddrValid(BaseAddress) then
    GODO()
    PopupBox('สคริปต์มีปัญหา:', 'สคริปต์ไม่พบไฟล์\n\n1.libgame.so\n\nลองเข้าเกม Line Rangers เพื่อให้สคริปต์รันได้')
    os.exit()
end

  Hack['MEO1'].Address = BaseAddress + 2881632
  Hack['MEO1_2'].Address = BaseAddress + 6264796
  Hack['MEO2'].Address = BaseAddress + 2872900
  Hack['MEO2_2'].Address = BaseAddress + 6239096
  Hack['FOV'].Address = BaseAddress + 15101644
  GODO()
  gg.setVisible(true)
          while true do
            if gg.isVisible(true) then
              GODO()
              cFOV = rpm(Hack['FOV'].Address, gg.TYPE_FLOAT)
              o = gg.prompt({
                '💥 Line Rangers 6.2.0 💥',
                '1. [' .. HackSwitch(not Hack['MEO1'].Switch) .. '] ' .. Hack['MEO1'].Name,
                '2. [' .. HackSwitch(not Hack['MEO2'].Switch) .. '] ' .. Hack['MEO2'].Name,
                '3. ปรับความเร็ว (' .. cFOV .. ')', 
                '🔚 ออก'
                
                },{"MeONaJa"},{
                "number",
                "checkbox",
                "checkbox",
                "checkbox",
                "checkbox",
                
                
          })
              if o ~= nil then
                if o[1] then gg.setVisible(false) gg.setVisible(false) end
                if o[2] then gg.setVisible(false) Cheat(Hack["MEO1"]) gg.setVisible(false) end
                if o[3] then gg.setVisible(false) Cheat(Hack["MEO2"]) gg.setVisible(false) end
                if o[4] then gg.setVisible(false) ChangeFOV(Hack["FOV"]) gg.setVisible(false) end
			    if o[5] then gg.setVisible(true) do break end gg.setVisible(true) end
		end
	end
	gg.sleep(0)
end
