gg.setVisible(false)  
_File = gg.getFile()
Hey = gg.toast 
local _ = gg.prompt 
Msg = gg.alert
gg.setVisible(false)                                                                                                                                                     
local Hack = true Hack = 0 Hack = {} Hack = 0xC + 0x5EC Hack_Float = gg.TYPE_FLOAT Hack_Qword = gg.TYPE_QWORD Hack= {
  	["MEO1"] = {Name = "ป้อมไม่ยิง", Switch = false, ["🔵เปิด"] = 2576980377, Type = gg.TYPE_FLOAT, Exec = function()
       Cheat(Hack["MEO1_2"])
      end
    },
  	["MEO1_2"] = {Name = " ",Switch = false,["🔵เปิด"] = 2576980377,Type = gg.TYPE_FLOAT,},
  	["MEO2"] = {Name = " น้ำแข็งไม่ละลาย ", Switch = false, ["🔵เปิด"] = 0x0, Type = Hack_Float,},
  	["MEO3"] = {Name = " ศัตรูไม่ออก ", Switch = false, ["🔵เปิด"] = 0x0, Type = Hack_Float,},
  	["MEO4"] = {Name = " บอสกิลด์เหรดไม่เดิน ", Switch = false, ["🔵เปิด"] = 0, Type = gg.TYPE_FLOAT, Exec = function()
	   Cheat(Hack["MEO4_2"])
      end
	},
	["MEO4_2"] = {Name = " ",Switch = false,["🔵เปิด"] = 0,Type = gg.TYPE_FLOAT,},
	["MEO5"] = {Name = " คริ 100% ", Switch = false, ["🔵เปิด"] = 168884986026393, Type = gg.TYPE_FLOAT, Exec = function()
		Cheat(Hack["MEO5_2"])
	   end
	 },
	["MEO5_2"] = {Name = " ",Switch = false,["🔵เปิด"] = 168884986026393,Type = gg.TYPE_FLOAT,},
	["MEO6"] = {Name = " ขีปนาวุธ999จุด ", Switch = false, ["🔵เปิด"] = 0x999, Type = Hack_Float,},
	["MEO7"] = {Name = " สกิลไม่คลูดาวน์ ", Switch = false, ["🔵เปิด"] = 2576980377, Type = gg.TYPE_FLOAT, Exec = function()
		Cheat(Hack["MEO7_2"])
	   end
	 },
	["MEO7_2"] = {Name = " ",Switch = false,["🔵เปิด"] = 2576980377,Type = gg.TYPE_FLOAT,},
  	["FOV"] = {Name = " Ptr_1 ",}}
function ForceExit()
	::force_exit:: os.exit() goto force_exit
end
function PopupBox(Caption, Text)
	if Text == nil then Text = "" end
	gg.alert(Caption .. '\n' .. Text)
end
function Bool2Switch(Bool)
	if not Bool then return "🔴ปิด" end
	return "🔵เปิด"
end
function Cheat(Hack)
	if Hack.Address ~= nil then
	if Hack.Alert ~= nil and Hack.Alert ~= 1 then  PopupBox("ข้อความ: ".. Hack.Name, Hack.Alert); Hack.Alert = 1 end
		if Hack.Exec ~=nil then Hack.Exec() end
		if Hack.Type ~= nil and Hack["🔴ปิด"] == nil then Hack["🔴ปิด"] = rpm(Hack.Address, Hack.Type) end 
        Hack.Switch = not Hack.Switch
		if Hack.Type ~= nil then
			wpm(Hack.Address, Hack.Type, Hack[Bool2Switch(Hack.Switch)])
			gg.toast("ฟังชั่น: " .. Hack.Name .. " -> " .. Bool2Switch(Hack.Switch))
			return true
		end
	end
	PopupBox("อุปมีปัญหา !", Hack.Name.." ไม่พบที่อยู่ Offset ") 
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
function rwmem(Address, SizeOrBuffer)
	_rw = {}
	if type(SizeOrBuffer) == "number" then
		_ = ""
		for _ = 1, SizeOrBuffer do _rw[_] = {address = (Address - 1) + _, flags = gg.TYPE_BYTE} end
		for v, __ in ipairs(gg.getValues(_rw)) do _ = _ .. string.format("%02X", __.value & 0xFF) end
		return _
	end
	Byte = {} SizeOrBuffer:gsub("..", function(x) 
		Byte[#Byte + 1] = x _rw[#Byte] = {address = (Address - 1) + #Byte, flags = gg.TYPE_BYTE, value = x .. "h"} 
	end)
	gg.setValues(_rw)
end
SPEED_LOG=function() gg.setVisible(false) end
function reverseAddress(address)
	return (address & 0x000000FF) << 24 | (address & 0x0000FF00) << 8 | (address & 0x00FF0000) >> 8 | (address & 0xFF000000) >> 24
end
function setjmp(address, target)
	local o_opsc = rwmem(address, 8)
	rwmem(address, "04F01FE5"..string.format("%08x", reverseAddress(target))) 
	return function() rwmem(address, o_opsc) end 
end
function prephook(address, writeoricode)
	local _alloc	= gg.allocatePage(gg.PROT_READ | gg.PROT_WRITE | gg.PROT_EXEC)
	gg.sleep(0)
	if writeoricode then rwmem(_alloc, _oriop) end
	return _alloc + (writeoricode == true and 0x8 or 0), address + 0x8 
end
function getregister(address, reg)
	_getregsc, n_address = prephook(address, true)														
	rwmem(_getregsc, "04"..string.format("%02X", (reg & 0xFF) << 4).."8FE504F01FE50000000000000000")	
	wpm(_getregsc + 0x8, 4, n_address)															
	local r_restorereg = setjmp(address, _getregsc - 0x8)  												
	return _getregsc + 0xC, r_restorereg								
end 
function GetLibraryTextBase(lib)
	for _, __ in pairs(gg.getRangesList(lib)) do
		if __["state"] == "Xa" then return __["start"], __["end"] end
	end
	return nil
end
function ChangeFOV(Hack)
gg.setVisible(false)
	nFOV = gg.prompt({"ปรับความเร็ว:[1.12-0.1]\nความเร็วปัจจุบัน "..cFOV..""}, {cFOV}, {"number"})
	if nFOV ~= nil then
	    wpm(Hack.Address, gg.TYPE_FLOAT, nFOV[1])
		gg.toast(cFOV .." -＞ ".. nFOV[1])
	end
end
SPEED_LOG() sXs = "ปกติ"
gg.toast("🔩 กำลังค้นหา โปรดรอ การค้นหาเร็ว 1000% ...", true) do gg.sleep(250) end
gg.sleep(0)
BaseAddress = GetLibraryTextBase("libgame.so")
if not isAddrValid(BaseAddress) then 
SPEED_LOG() 
	PopupBox("สคริปต์มีปัญหา:", "สคริปต์ไม่พบไฟล์\n\n1.libgame.so\n\nลองเข้าเกม Line Rangers เพื่อให้สคริปต์รันได้")
	os.exit()
end

Hack['MEO1'].Address = BaseAddress + 2881632 
Hack['MEO1_2'].Address = BaseAddress + 6264796
Hack['MEO2'].Address = BaseAddress + 0x1210124
Hack['MEO3'].Address = BaseAddress + 0x120a83c
Hack['MEO4'].Address = BaseAddress + 2872900
Hack['MEO4_2'].Address = BaseAddress + 6239096
Hack['MEO5'].Address = BaseAddress + 2974084
Hack['MEO5_2'].Address = BaseAddress + 6530752
Hack['MEO6'].Address = BaseAddress + 0x5cb834
Hack['MEO7'].Address = BaseAddress + 3064892
Hack['MEO7_2'].Address = BaseAddress + 6719040
Hack["FOV"].Address = BaseAddress + 0xe66ecc
SPEED_LOG() 
Msg("เเนะนำอย่านำไปใช้ใน PvP ระวังถูกเเบน",[[OK]]) 
 gg.setVisible(true)
while(true) do
	if gg.isVisible(true) 
  then SPEED_LOG()
  cFOV = rpm(Hack["FOV"].Address, gg.TYPE_FLOAT) 
		i = gg.prompt({
		"💥 Line Rangers  💥 ("..sXs..")",
		"1.[" .. Bool2Switch(not Hack["MEO1"].Switch) .. "] " .. Hack["MEO1"].Name,
		"2.[" .. Bool2Switch(not Hack["MEO2"].Switch) .. "] " .. Hack["MEO2"].Name,
		"3.[" .. Bool2Switch(not Hack["MEO3"].Switch) .. "] " .. Hack["MEO3"].Name,
		"4.[" .. Bool2Switch(not Hack["MEO4"].Switch) .. "] " .. Hack["MEO4"].Name,
		"5.[" .. Bool2Switch(not Hack["MEO5"].Switch) .. "] " .. Hack["MEO5"].Name,
		"6.[" .. Bool2Switch(not Hack["MEO6"].Switch) .. "] " .. Hack["MEO6"].Name,
		"7.[" .. Bool2Switch(not Hack["MEO7"].Switch) .. "] " .. Hack["MEO7"].Name,
		"8. ปรับความเร็ว ("..cFOV..")",
		"ปิดสคริปต์"
        },{"Line Ranger"},{
              "number",
              "checkbox",
              "checkbox",
              "checkbox",
			  "checkbox",
			  "checkbox",
			  "checkbox",
			  "checkbox",
			  "checkbox",
        })
        if i ~= nil then
            if i[1] then gg.setVisible(false) gg.toast("หวัดดี") gg.setVisible(true) end
            if i[2] then gg.setVisible(false) Cheat(Hack["MEO1"]) gg.setVisible(false) end
			if i[3] then gg.setVisible(false) Cheat(Hack["MEO2"]) gg.setVisible(false) end
			if i[4] then gg.setVisible(false) Cheat(Hack["MEO3"]) gg.setVisible(false) end
			if i[5] then gg.setVisible(false) Cheat(Hack["MEO4"]) gg.setVisible(false) end
			if i[6] then gg.setVisible(false) Cheat(Hack["MEO5"]) gg.setVisible(false) end
			if i[7] then gg.setVisible(false) Cheat(Hack["MEO6"]) gg.setVisible(false) end
			if i[8] then gg.setVisible(false) Cheat(Hack["MEO7"]) gg.setVisible(false) end
			if i[9] then gg.setVisible(false) ChangeFOV(Hack["FOV"]) gg.setVisible(false) end 
			if i[10] then gg.setVisible(false) break gg.setVisible(false) end
		end
	end
	gg.sleep(0) 
end
if gg.alert("🤯 ต้องการจะออกเหรอ ?\n\nถ้าออกสคริปไปเเล้วโปรยังทำงานอยู่เเต่สามารถปิดใด้ที่กดปิดโปรทุกฟังชั้น.\nต้องการจะปิดโปรก่อนไม่ก่อนออกจากระบบ", "🔔 ปิดทุกฟังชั่น", "⚠️ เปิดฟังชั่นทิ้งไว้") == 2 then
	gg.toast("📸 ฟังชั่นยังเปิดใช้งานไว้อยู่ !")
else
	for _ in pairs(Hack) do
		if Hack[_].Switch ~= nil then Hack[_].Switch = true
		if Hack[_].Alert ~= nil then Hack[_].Alert = 1 end 
		if Hack[_].Exec ~= nil then Hack[_].Exec = nil end
		if Hack[_].Address ~= nil then Cheat(Hack[_]) end
		end
	end
	gg.toast("📷 ปิดทุกฟังชั่นเเล้ว")
end
print("╔═════════════════")
print("╠❋► สร้างโดย SELL/3K")
print("╠❋► เขียนโดย SELL/3K")
print("╠❋► หาค่าโดย SELL/3K")
