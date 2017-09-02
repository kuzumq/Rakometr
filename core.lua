local DiesalGUI   = LibStub('DiesalGUI-1.0')
-- to local
local tsort = table.sort
local tinsert = table.insert
local UnitIsPlayer = UnitIsPlayer
local UnitClass = UnitClass
local GetSpellInfo = GetSpellInfo
local UnitGroupRolesAssigned = UnitGroupRolesAssigned
local UnitPlayerOrPetInParty = UnitPlayerOrPetInParty

local function GetClassColor(unit)
	
	if not UnitIsPlayer(unit) then return unit end
	
	local class = select(2, UnitClass(unit))
	local color = RAID_CLASS_COLORS[class].colorStr
	local name = UnitName(unit)
	
	return '|c'..color..''..name..'|r'
	
end

function RAKOMETR:Reset()

	wipe(RAKOMETR.DATA.UNITS)
	self:Construct()
	
end

local function groupCheck()

	if IsInRaid() then 
	
		return 'RAID'
		
	else
	
		return 'PARTY'
	
	end	
	
end

local function SendMessage(msg,ch)

end

function RAKOMETR:GoAnnounce(name,total,spell,count)

	if not self.db.profile.announce then return false end

	local spellName = GetSpellInfo(spell) or spell

	if self.db.profile.announceChannel == 'me' then
		print('|cfff57f40[RAKOMETR]|r:  '..GetClassColor(name)..'   Strike!   |cffff7178'..spellName..'|r('..count..')   TOTAL: '..total)
	elseif self.db.profile.announceChannel == 'say' then
		SendChatMessage('RAKOMETR: '..name..' Strike! '..spellName..'('..count..') TOTAL: '..total, 'SAY')
	elseif self.db.profile.announceChannel == 'group' then
		SendChatMessage('RAKOMETR: '..name..' Strike! '..spellName..'('..count..') TOTAL: '..total, groupCheck())
	elseif self.db.profile.announceChannel == 'guild' then
		SendChatMessage('RAKOMETR: '..name..' Strike! '..spellName..'('..count..') TOTAL: '..total, 'GUILD')
	end
	
end

function RAKOMETR:SendReport(ch)
	
	local temp = {}
	local num = 0
	
	for name, t in pairs(self.DATA.UNITS) do
		
		tinsert(temp, {name = name, total = t.total})
		count = count + 1
	
	end
	
	tsort(temp, function(a,b) return a.total > b.total end)
	
	SendChatMessage('[RAKOMETR TOP]:', ch)
	
	if #temp >= 6 then
		
		num = 6
	
	else
		
		num = #temp
	
	end
	
	for i=1, num do
		
		local obj = temp[i]
		SendChatMessage(obj.total..' '..obj.name)
	
	end

end

function RAKOMETR:OnEnable()

	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	local MainFrame = DiesalGUI:Create('Window')
	RAKOMETR.MainFrame = MainFrame
	RAKOMETR.parentMainFrame = MainFrame.frame
	--stop resize
	MainFrame.sizerBR:Hide()
	MainFrame.sizerBR:Hide()
	MainFrame.sizerB:Hide()
	MainFrame.sizerR:Hide()
	--
	MainFrame:SetTitle('RAKOMETR')
	MainFrame:SetPoint(RAKOMETR.db.profile.position1.point, UIParent, RAKOMETR.db.profile.position1.relativePoint, RAKOMETR.db.profile.position1.x, RAKOMETR.db.profile.position1.y)
	MainFrame:SetPoint(RAKOMETR.db.profile.position2.point, UIParent, RAKOMETR.db.profile.position2.relativePoint, RAKOMETR.db.profile.position2.x, RAKOMETR.db.profile.position2.y)
	MainFrame:SetWidth(120)
	MainFrame:SetHeight(30)
	MainFrame.closeButton:Hide()

	MainFrame:SetEventListener("OnDragStop", function(self)

		RAKOMETR.db.profile.position1.point, _, RAKOMETR.db.profile.position1.relativePoint, RAKOMETR.db.profile.position1.x, RAKOMETR.db.profile.position1.y = self:GetPoint(1)
		RAKOMETR.db.profile.position2.point, _, RAKOMETR.db.profile.position2.relativePoint, RAKOMETR.db.profile.position2.x, RAKOMETR.db.profile.position2.y = self:GetPoint(2)

	end)
	
	local MenuButton = DiesalGUI:Create('Button')
	MainFrame:AddChild(MenuButton)
	MenuButton:SetParentObject(MainFrame)
	MenuButton:SetWidth(17)
	MenuButton:SetHeight(10)
	MenuButton:SetText('M')
	MenuButton.text:SetJustifyH('CENTER')
	MenuButton:SetPoint('CENTER', MainFrame.closeButton, 'CENTER', 0, -1)
	MenuButton:SetEventListener("OnEnter", function(self)
	
		GameTooltip:SetOwner(MenuButton.frame, "ANCHOR_RIGHT")
		GameTooltip:SetText("Menu")
		GameTooltip:Show()
		
	end)
	MenuButton:SetEventListener("OnLeave", function(self)

		GameTooltip:Hide()

	end)

	MenuButton:SetEventListener("OnClick", function(button)

		local menu = {
			{
				text = ' - Send report: - ',
				notCheckable = 1,
				isTitle = true
			},
			{
				text = 'to say',
				notCheckable = 1,
				func = function()
				RAKOMETR:SendReport('SAY')
				end
			},
			{
				text = 'to party/raid',
				notCheckable = 1,
				func = function()
				RAKOMETR:SendReport(prCheck())
				end
			},
			{
				text = 'to guild',
				notCheckable = 1,
				func = function()
				RAKOMETR:SendReport('GUILD')
				end
			},
			{
                text = 'Announces settings:',
                notCheckable = 1,
				isTitle = true
            },
			{
                text = ' turn on/off',
                notCheckable = 1,
                disabled = true
            },
			{
                text = ' on',
                checked = RAKOMETR.db.profile.announce == true,
                func = function()
					RAKOMETR.db.profile.announce = true
                end
            },
			{
                text = ' off',
                checked = RAKOMETR.db.profile.announce == false,
                func = function()
					RAKOMETR.db.profile.announce = false
                end
            },
			{
                text = 'Set channel:',
                notCheckable = 1,
                disabled = true
            },
            {
                text = 'only for me',
                checked = RAKOMETR.db.profile.announceChannel == 'me',
                func = function()
					RAKOMETR.db.profile.announceChannel = 'me'
                end
            },
            {
                text = "to say",
                checked = RAKOMETR.db.profile.announceChannel == 'say',
                func = function()
					RAKOMETR.db.profile.announceChannel = 'say'
                end
            },
            {
                text = 'to party/raid',
                checked = RAKOMETR.db.profile.announceChannel == 'group',
                func = function()
					RAKOMETR.db.profile.announceChannel = 'group'
                end
            },
			{
                text = 'to guild',
                checked = RAKOMETR.db.profile.announceChannel == 'guild',
                func = function()
					RAKOMETR.db.profile.announceChannel = 'guild'
                end
            },
			{
                text = ' ',
                notCheckable = 1,
				disabled = true
            },
            {
                text = 'Close',
                notCheckable = 1
            },
		}
		
		local menuFrame = CreateFrame("Frame", "rakometr_dropdownmenu", UIParent, "UIDropDownMenuTemplate")
		menuFrame:SetPoint("CENTER", UIParent, "Center")
		menuFrame:Hide()
		local menuWidget = EasyMenu(menu, menuFrame, "cursor", 0 , 0, "MENU");
		
	end)
	
	local ResetButton = DiesalGUI:Create('Button')
	MainFrame:AddChild(ResetButton)
	ResetButton:SetParentObject(MainFrame)
	ResetButton:SetWidth(17)
	ResetButton:SetHeight(10)
	ResetButton:SetText('C')
	ResetButton.text:SetJustifyH('CENTER')
	ResetButton:SetPoint('CENTER', MenuButton.frame, 'LEFT', -3, 0)
	
	ResetButton:SetEventListener("OnEnter", function(self)
	
		GameTooltip:SetOwner(ResetButton.frame, "ANCHOR_RIGHT")
		GameTooltip:SetText("Clean/Reset")
		GameTooltip:Show()
		
	end)
	ResetButton:SetEventListener("OnLeave", function(self)

		GameTooltip:Hide()

	end)
	
	ResetButton:SetEventListener("OnClick", function()

		RAKOMETR:Reset()
		
	end)
	
	local scroll = DiesalGUI:Create('ScrollFrame')
	RAKOMETR.scroll = scroll
	MainFrame:AddChild(scroll)
	scroll:SetParentObject(MainFrame)
	scroll:SetAllPoints(MainFrame.content)
	scroll:SetContentHeight(2)
	scroll:VerticallyScroll(1)

end

function RAKOMETR:CreateDetailed(name)
	
	local temp = {}
	
	local DetailedFrame = DiesalGUI:Create('Window')
	RAKOMETR.DetailedFrame = DetailedFrame
	DetailedFrame:SetTitle(GetClassColor(name)..' details:')
	DetailedFrame:SetWidth(700)
	DetailedFrame:SetHeight(100)
	
	local scroll = DiesalGUI:Create('ScrollFrame')
	DetailedFrame:AddChild(scroll)
	scroll:SetParentObject(DetailedFrame)
	scroll:SetAllPoints(DetailedFrame.content)
	scroll:SetContentHeight(2)
	scroll:VerticallyScroll(1)
	
	for name, t in pairs(self.DATA.UNITS[name].Spell) do
		
		tinsert(temp, {name = name, total = t.total, encounter = t.encounter})
	
	end
	
	tsort(temp, function(a,b) return a.total > b.total end)
	
	local offset = 0

	for i=1, #temp do
	
		local obj = temp[i]
		local spellName = GetSpellInfo(obj.name) or obj.name
		local spellID = ''
		
		if type(obj.name) == 'number' then
			
			spellID = obj.name
			
		end

		local Object = DiesalGUI:Create('Button')
		scroll:AddChild(Object)
		Object:SetParentObject(scroll)
		Object:SetWidth(700)
		Object:SetHeight(10)
		Object.text:SetJustifyH('LEFT')
		Object:SetText(obj.total..' : |cffff7178Spell|r = '..spellName..'('..spellID..'), |cff7fbfffEncounter|r = '..obj.encounter)
		Object:SetPoint('TOPLEFT', 0, offset)
	
		offset = offset - 12
		
	end

end

local offset = 0
function RAKOMETR:AddObject(name, total)

	local Object = DiesalGUI:Create('Button')
	self.scroll:AddChild(Object)
	Object:SetParentObject(self.scroll)
	Object:SetWidth(100)
	Object:SetHeight(10)
	Object.text:SetJustifyH('LEFT')
	Object:SetText(total..' - '..GetClassColor(name))
	Object:SetPoint('TOPLEFT', 0, offset)
	Object:SetEventListener("OnClick", function(Object) 
	
		if self.DetailedFrame then 
			self.DetailedFrame:ReleaseChildren()
			self.DetailedFrame:Release()
		end
		
		RAKOMETR:CreateDetailed(name)
	
	end)
	
	offset = offset - 10
	
end

function RAKOMETR:Construct()
	
	local temp = {}
	local count = 0
	offset = 0
	
	self.scroll:ReleaseChildren()
	
	for name, t in pairs(self.DATA.UNITS) do
	
		tinsert(temp, {name = name, total = t.total})
		count = count + 1
	
	end
	
	tsort(temp, function(a,b) return a.total > b.total end)
	
	self.MainFrame:SetHeight(30)
	
	if #temp > 1 and #temp < 10 then

		self.MainFrame:SetHeight(20+#temp*10)
	
	elseif #temp >= 10 then
	
		self.MainFrame:SetHeight(120)

	end
	
	if count > 0 then
		
		for i=1, #temp do
	
			local obj = temp[i]
		
			self:AddObject(obj.name, obj.total)
		
		end
		
		self.scroll:Show()
		
	else

		self.scroll:Hide()
		
	end
	
end

function RAKOMETR:AddPlayer(pname, spell, encounter)

	if self.DATA.UNITS[pname] then
	
		self.DATA.UNITS[pname].total = self.DATA.UNITS[pname].total + 1
		
		if self.DATA.UNITS[pname].Spell[spell] then
		
			self.DATA.UNITS[pname].Spell[spell].total = self.DATA.UNITS[pname].Spell[spell].total + 1
			
		else
			
			
			self.DATA.UNITS[pname].Spell[spell] = {total = 1, encounter = encounter}
			
		end
	
	else
	
		self.DATA.UNITS[pname] = {total = 1, Spell = {}}
		self.DATA.UNITS[pname].Spell[spell] = {total = 1, encounter = encounter}
		
	end
	
	self:Construct()
	
	RAKOMETR:GoAnnounce(pname,RAKOMETR.DATA.UNITS[pname].total,spell,RAKOMETR.DATA.UNITS[pname].Spell[spell].total)
	
end

function RAKOMETR:COMBAT_LOG_EVENT_UNFILTERED(_, _, subtype, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellID, spellName, _, dmg)

	local stamp = GetTime()
	
	if not UnitIsPlayer(destName) then return end -- игнорируем если цель не игрок

	if destName and (self.SPELLTABLE[spellName] or self.SPELLTABLE[spellID]) then
	
		local destRole = UnitGroupRolesAssigned(destName)
		local encounter
		local tableRole
		local frendlyfire
		local dmgtype 
		
		if self.SPELLTABLE[spellName] then 
		
			encounter = self.SPELLTABLE[spellName].encounter
			tableRole = self.SPELLTABLE[spellName].role
			frendlyfire = self.SPELLTABLE[spellName].frendlyfire
			dmgtype = self.SPELLTABLE[spellName].dmgtype
			
		elseif self.SPELLTABLE[spellID] then
		
			encounter = self.SPELLTABLE[spellID].encounter
			tableRole = self.SPELLTABLE[spellID].role
			frendlyfire = self.SPELLTABLE[spellID].frendlyfire
			dmgtype = self.SPELLTABLE[spellID].dmgtype
			
		end
		
		if tableRole:match(destRole) == destRole or destRole == 'NONE' then
			print(spellName)
			if frendlyfire then
		
				self:AddPlayer(sourceName, spellID, encounter)
					
			elseif not frendlyfire and (not UnitPlayerOrPetInParty(sourceName)) then -- игнорируем если источник игрок и нет ФФ
				
				if subtype == 'SPELL_DAMAGE' or subtype == 'SPELL_PERIODIC_DAMAGE' then

					if dmg > 1 then -- игнор если не получил урона
					
						if dmgtype:match('hit') == 'hit' then
							
							self:AddPlayer(destName, spellID, encounter)
						
						elseif dmgtype:match('dot') == 'dot' then
						
							local _, maxTicks, timePeriod = strsplit(';', dmgtype, 3)
							local maxTicks, timePeriod = tonumber(maxTicks), tonumber(timePeriod)
						
							if self.DATA.PERIODIC[destName] then
							
								if self.DATA.PERIODIC[destName][spellID] then
								
									local currentTime = GetTime()
									
									self.DATA.PERIODIC[destName][spellID].total = self.DATA.PERIODIC[destName][spellID].total + 1
								
									
									--if self.DATA.PERIODIC[destName][spellID].total >= maxTicks then
									
										if currentTime - self.DATA.PERIODIC[destName][spellID].lastHitTime >= timePeriod then -- Если получает больше N тиков за X промежуток времени
									
											self.DATA.PERIODIC[destName] = nil -- Обнуляем
											self:AddPlayer(destName, spellID, encounter)
									
										end
									
									--else
										
										--self.DATA.PERIODIC[destName][spellID].lastHitTime = stamp
									
									--end
									
									
								else
								
									self.DATA.PERIODIC[destName][spellID] = {}
									self.DATA.PERIODIC[destName][spellID] = {total = 1, lastHitTime = stamp}
								
								end
								
							else
							
								self.DATA.PERIODIC[destName] = {}
								self.DATA.PERIODIC[destName][spellID] = {}
								self.DATA.PERIODIC[destName][spellID] = {total = 1, lastHitTime = stamp}
							
							end
							
						
						end
					
					end
					
				else
					
					self:AddPlayer(destName, spellID, encounter)
					
				end
			
			end

		end

	end
	
end

function RAKOMETR:OnDisable()

	self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

end