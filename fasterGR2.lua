LUAGUI_NAME = 'Faster Grim Reaper 2'
LUAGUI_AUTH = 'SapphireSapphic'
LUAGUI_DESC = 'Removes GR2 HP gates'

function _OnInit()
	if (GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301) and ENGINE_TYPE == "ENGINE" then --PCSX2
		canExecute=true
		ConsolePrint("Faster GR2 PCSX2 Ver")
		Save = 0x032BB30 --Save File
		Btl0 = 0x1CE5D80 --00battle.bin
		Slot1    = 0x1C6C750 --Unit Slot 1
		NextSlot = 0x268
	elseif GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		canExecute=true
		ConsolePrint("Faster GR2 Lua")
		Save = 0x09A7070 - 0x56450E
		Btl0 = 0x2A74840 - 0x56450E
		Slot1    = 0x2A20C58 - 0x56450E
		NextSlot = 0x278
	end
	grimReaper2 = Btl0+0x2E52C
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
	WriteShort(grimReaper2+0x48, 0x0045)
	WriteShort(grimReaper2+0x4A, 0x0045)
	WriteShort(grimReaper2+0x4C, 0x0045)
	WriteShort(grimReaper2+0x4E, 0x0045)
	WriteShort(grimReaper2+0x50, 0x0045)
	WriteShort(grimReaper2+0x52, 0x0045)
	WriteShort(grimReaper2+0x54, 0x0045)
	
	for s = 1, 12 do
		ConsolePrint(ReadByte(Slots[s]+0x1A8).." | "..ReadByte(Slots[s]+0x1A9).." | "..ReadByte(Slots[s]+0x1AA).." | "..ReadByte(Slots[s]+0x1AB).." | "..ReadByte(Slots[s]+0x1AC).." | "..ReadByte(Slots[s]+0x1AD).." | "..ReadByte(Slots[s]+0x1AE))
		if ReadByte(Slots[s]+0x1A8) == 0x45 and ReadByte(Slots[s]+0x1A9) == 0x45 and ReadByte(Slots[s]+0x1AA) == 0x45 and ReadByte(Slots[s]+0x1AB) == 0x45 and ReadByte(Slots[s]+0x1AC) == 0x45 and ReadByte(Slots[s]+0x1AD) == 0x45 then
			
			ConsolePrint("Rewriting GR2 HP Gates at Slot "..s)
			WriteInt(Slots[s]+8,0)
		end
	end
end
