local E, L, V, P, G = unpack(ElvUI);
local EEL = E:GetModule("ElvuiGearset");
local SO = E:GetModule("SetOverlay");

local tsort = table.sort

P["eel"]["equipment"] = {
	['setoverlay'] = {
		['enable'] = false,
	},
}

local function GetAllEquipmentSets()
	local sets = { ["none"] = L["No Change"] }
	local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs();
	for key,value in pairs(equipmentSetIDs) do
		local name = C_EquipmentSet.GetEquipmentSetInfo(value)
		if name then
			sets[name] = name
		end
	end
	tsort(sets, function(a, b) return a < b end)
	return sets
end

-- local function UpdateTalentConfiguration()
--     local numSpecs = GetNumSpecializations(false, E.isPet);
--     local sex = E.isPet and UnitSex("pet") or UnitSex("player");

--     for i = 1, numSpecs do
--         local _, name, description, icon = GetSpecializationInfo(i, false, E.isPet, nil, sex);
--         E.Options.args.eel.args.equipment.args.specialization.args.specs.args["spec"..i].name = name
--     end
-- end

local function ConfigTable()
    local sets = GetAllEquipmentSets()
    local numSpecs = GetNumSpecializations(false, E.isPet);

	E.Options.args.eel.args.equipment = {
        order = 40,
        type = 'group',
        name = L['Equipment'],
        childGroups = 'tab',
        get = function(info) return E.private.eel.equipment[ info[#info] ] end,
		set = function(info, value) E.private.eel.equipment[ info[#info] ] = value end,
        args = {
			header1 = {
				order = 1,
				type = 'description',
				fontSize = 'medium',
				name = "\n"..L["Equipment related addons"],
            },
            header2 = {
				order = 2,
				type = "header",
				name = "",
            },
			setoverlay = {
				type = 'group',
				name = L['Equipment Set Overlay'],
				order = 8,
				get = function(info) return E.db.eel.equipment.setoverlay[ info[#info] ] end,
				set = function(info, value) E.db.eel.equipment.setoverlay[ info[#info] ] = value end,
				args = {
					header1 = {
						order = 1,
						type = 'description',
						fontSize = 'medium',
						name = L['Show the associated equipment sets for the items in your bags (or bank).'],
					},
					alert = {
						order = 2,
						type = 'description',
						fontSize = 'medium',
						name = "\n"..L["|cffff8000This feature only works with the ElvUI Bags module enabled.|r"],
						hidden = function() return E.private.bags.enable end,
					},
					spacer = {
						order = 3,
						type = "header",
						name = "",
					},
					enable = {
						type = "toggle",
						order = 5,
						name = L["Enable"],
						desc = L['Show the associated equipment sets for the items in your bags (or bank).'],
						disabled = function() return not E.private.bags.enable end,
						get = function(info) return E.db.eel.equipment.setoverlay.enable end,
						set = function(info, value) E.db.eel.equipment.setoverlay.enable = value; E:StaticPopup_Show("CONFIG_RL") end,
					}
				}
			},
        }
    }
    -- UpdateTalentConfiguration()
end

EEL.config["equipment"] = ConfigTable