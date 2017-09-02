local RAKOMETR = LibStub("AceAddon-3.0"):NewAddon("RAKOMETR", "AceEvent-3.0")

_G.RAKOMETR = RAKOMETR

RAKOMETR.DATA = {}
RAKOMETR.DATA.UNITS = {}
RAKOMETR.DATA.WAIT = {} 
RAKOMETR.DATA.PERIODIC = {} 

RAKOMETR.DEFAULTS = {

  profile = {
  
    position1 = {
		
		point = "CENTER",
		relativePoint = "CENTER",
		x = 0,
		y = 0,
		
	},
	
	position2 = {
		
		point = "CENTER",
		relativePoint = "CENTER",
		x = 0,
		y = 0,
		
	},
	
	announce = true,
	announceChannel = 'me'
	
  }
  
}

function RAKOMETR:OnInitialize()
	
	self.db = LibStub("AceDB-3.0"):New("RAKOMETR_DB", self.DEFAULTS)
	
end