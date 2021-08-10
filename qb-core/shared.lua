QBShared = {}

local StringCharset = {}
local NumberCharset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(StringCharset, string.char(i)) end
for i = 97, 122 do table.insert(StringCharset, string.char(i)) end

QBShared.RandomStr = function(length) -- QBShared.RandomStr falls under GPL License here: [esxlicense]/LICENSE
	if length > 0 then
		return QBShared.RandomStr(length-1) .. StringCharset[math.random(1, #StringCharset)]
	else
		return ''
	end
end

QBShared.RandomInt = function(length)
	if length > 0 then
		return QBShared.RandomInt(length-1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

QBShared.SplitStr = function(str, delimiter)
	local result = { }
	local from  = 1
	local delim_from, delim_to = string.find( str, delimiter, from  )
	while delim_from do
		table.insert( result, string.sub( str, from , delim_from-1 ) )
		from  = delim_to + 1
		delim_from, delim_to = string.find( str, delimiter, from  )
	end
	table.insert( result, string.sub( str, from  ) )
	return result
end

QBShared.StarterItems = {
    ["apple"] = {amount = 3, item = "apple"},
    ["lantern"] = {amount = 1, item = "lantern"},
}

QBShared.Items = {
--[[
	Template			The name that the					The weight of the	What sort of item it	If the item is					The imagie used for the item		Is the item			Can you actively	 The required level				The description of the item
	Spawn name			player sees in his inv				item (inventory)	is (item | weapon)		supposed to have ammo			(inventory)							stackable?			use the item?		 to use the item(if useable)	(inventory)				 ]]
	["cannedbeans"] 	= {["name"] = "cannedbeans", 	["label"] = "Beans in a can",	["weight"] = 0.1,	["type"] = "item", 		["ammotype"] = nil, 			["image"] = "cannedbeans.png",		["unique"] = false,	["useable"] = true,	["level"] = 0,		["description"] = "Canned beans, not something somebody would want to eat willingly. Atleast I can now make a bean joke about it."},
	
	["apple"] 			= {["name"] = "apple", 			["label"] = "Apple",			["weight"] = 0.1,	["type"] = "item", 		["ammotype"] = nil, 			["image"] = "apple.png",			["unique"] = false,	["useable"] = true,	["level"] = 0,		["description"] = "An apple a day keeps my stomach filled. No worries about a fricking scurvy. It is only natural that it keeps the doctor away."},
	["lantern"] 		= {["name"] = "lantern", 		["label"] = "Lantern",			["weight"] = 0.1,	["type"] = "item", 		["ammotype"] = nil, 			["image"] = "lantern.png",			["unique"] = false,	["useable"] = true,	["level"] = 0,		["description"] = "Illuminate your path to becoming the best cowboy the wildwest has ever seen"},
}

-- // HASH WEAPON ITEMS, NEED SOMETIMES TO GET INFO FOR CLIENT

QBShared.Weapons = {

}

-- Gangs
QBShared.Gangs = {
	["none"] = {
		label = "No Gang"
	}
}

-- Jobs
QBShared.Jobs = {
	["unemployed"] = {
		label = "Civilian",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Freelancer",
                payment = 10
            },
        },
	},
	["police"] = {
		label = "Law Enforcement",
		bossmenu = vector3(448.4, -973.2, 30.6),
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 50
            },
			['1'] = {
                name = "Officer",
                payment = 75
            },
			['2'] = {
                name = "Sergeant",
                payment = 100
            },
			['3'] = {
                name = "Lieutenant",
                payment = 125
            },
			['4'] = {
                name = "Chief",
                payment = 150
            },
        },
	},
	["ambulance"] = {
		label = "EMS",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Recruit",
                payment = 50
            },
			['1'] = {
                name = "Paramedic",
                payment = 75
            },
			['2'] = {
                name = "Doctor",
                payment = 100
            },
			['3'] = {
                name = "Surgeon",
                payment = 125
            },
			['4'] = {
                name = "Chief",
                payment = 150
            },
        },
	},
	["judge"] = {
		label = "Honorary",
		defaultDuty = true,
		grades = {
            ['0'] = {
                name = "Judge",
                payment = 100
            },
        },
	}
}

-- Vehicles
QBShared.Vehicles = {

}
