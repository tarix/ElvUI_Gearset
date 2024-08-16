local E, L, V, P, G = unpack(ElvUI);
local EEL = E:GetModule('ElvuiGearset')

local tinsert, format = tinsert, format

local function configOptions()
    E.Options.args.eel = {
		type = "group",
		name = EEL.title,
		childGroups = "tab",
		--desc = L["Nick test"],
        order = 6,
        args = {
			header1 = {
				order = 1,
				type = "header",
				name = format(L["%s v|cffff8000%s|r"], EEL.title, EEL.version),
            }
        }
    }
end

tinsert(EEL.config, configOptions)


