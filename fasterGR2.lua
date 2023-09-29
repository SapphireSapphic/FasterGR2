LUAGUI_NAME = 'Faster Grim Reaper 2'
LUAGUI_AUTH = 'SapphireSapphic'
LUAGUI_DESC = 'Removes GR2 HP gates'

function _OnInit()
	if (GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301) and ENGINE_TYPE == "ENGINE" then --PCSX2
		canExecute=true
		ConsolePrint("Faster GR2 PCSX2 Ver")
		Save = 0x032BB30 --Save File
		Btl0Pointer = 0x1C61AFC --00battle.bin Pointer Address
		Now = 0x032BAE0 --Current Location
		Slot1    = 0x1C6C750 --Unit Slot 1
		NextSlot = 0x268
	elseif GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		onPC=true
		ConsolePrint("Faster GR2 Lua")
		Offset = 0x56450E
		Oofseet = 0x56454E
		Save = 0x09A7070 - Offset
		Btl0Pointer = 0x2AE3558 - 0x56454E
		Now = 0x0714DB8 - offset
		Slot1    = 0x2A20C58 - Offset
		NextSlot = 0x278
		local ReadInput = 0x1ACF3C
	end
	Slot2  = Slot1 - NextSlot
	Slot3  = Slot2 - NextSlot
	Slot4  = Slot3 - NextSlot
	Slot5  = Slot4 - NextSlot
	Slot6  = Slot5 - NextSlot
	Slot7  = Slot6 - NextSlot
	Slot8  = Slot7 - NextSlot
	Slot9  = Slot8 - NextSlot
	Slot10 = Slot9 - NextSlot
	Slot11 = Slot10 - NextSlot
	Slot12 = Slot11 - NextSlot
	Slots = {Slot1, Slot2, Slot3, Slot4, Slot5, Slot6, Slot7, Slot8, Slot9, Slot10, Slot11, Slot12}
end

function _OnFrame()
	Place  = ReadShort(Now+0x00)
	if Place == 0xFFFF or not MSN then
		if not OnPC then
			Obj0 = ReadInt(Obj0Pointer)
			Sys3 = ReadInt(Sys3Pointer)
			Btl0 = ReadInt(Btl0Pointer)
			MSN = 0x04FA440
		else
			Obj0 = ReadLong(Obj0Pointer)
			Sys3 = ReadLong(Sys3Pointer)
			Btl0 = ReadLong(Btl0Pointer)
			MSN = 0x0BF08C0 - 0x56450E
		end
	end
	grimReaper2 = Btl0+0x2E52C
	WriteShort(grimReaper2+0x48, 0x0045)
	WriteShort(grimReaper2+0x4A, 0x0045)
	WriteShort(grimReaper2+0x4C, 0x0045)
	WriteShort(grimReaper2+0x4E, 0x0045)
	WriteShort(grimReaper2+0x50, 0x0045)
	WriteShort(grimReaper2+0x52, 0x0045)
	WriteShort(grimReaper2+0x54, 0x0045)
	
	for s = 1, 12 do
		--ConsolePrint(ReadByte(Slots[s]+0x1A8).." | "..ReadByte(Slots[s]+0x1A9).." | "..ReadByte(Slots[s]+0x1AA).." | "..ReadByte(Slots[s]+0x1AB).." | "..ReadByte(Slots[s]+0x1AC).." | "..ReadByte(Slots[s]+0x1AD).." | "..ReadByte(Slots[s]+0x1AE))
		if ReadByte(Slots[s]+0x1A8) == 0x45 and ReadByte(Slots[s]+0x1A9) == 0x45 and ReadByte(Slots[s]+0x1AA) == 0x45 and ReadByte(Slots[s]+0x1AB) == 0x45 and ReadByte(Slots[s]+0x1AC) == 0x45 and ReadByte(Slots[s]+0x1AD) == 0x45 then
			--ConsolePrint("Rewriting GR2 HP Gates at Slot "..s)
			WriteShort(Slots[s]+8,0x0000)
			WriteByte(Slots[s]+0x01AE,0x45)
			if s >=2 then
				WriteShort(Slots[s-1]+8,0x0000)
			end
			if s>=3 then
				WriteShort(Slots[s-2]+8,0x0000)
			end
			if s<=11 then
				WriteShort(Slots[s+1]+8,0x0000)
				WriteByte(Slots[s+1]+0x01AE,0x45)
			end
			if s<=10 then
				WriteShort(Slots[s+2]+8,0x0000)
				WriteByte(Slots[s+2]+0x01AE,0x45)
			end
		end
	end
end
