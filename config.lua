Config = {}
Config.ServiceExtensionOnEscape		= 8
Config.ServiceLocation = vector3(168.46, -992.45, 30.09)
Config.ReleaseLocation = vector4(424.30, -978.60, 30.71, 90.67)

Config.ServiceLocations = {
	{ type = "cleaning", coords = vector3(170.0, -1006.0, 29.34) },
	{ type = "cleaning", coords = vector3(177.0, -1007.94, 29.33) },
	{ type = "cleaning", coords = vector3(181.58, -1009.46, 29.34) },
	{ type = "cleaning", coords = vector3(189.33, -1009.48, 29.34) },
	{ type = "cleaning", coords = vector3(195.31, -1016.0, 29.34) },
	{ type = "cleaning", coords = vector3(169.97, -1001.29, 29.34) },
	{ type = "cleaning", coords = vector3(164.74, -1008.0, 29.43) },
	{ type = "cleaning", coords = vector3(163.28, -1000.55, 29.35) },
	{ type = "gardening", coords = vector3(181.38, -1000.05, 29.29) },
	{ type = "gardening", coords = vector3(188.43, -1000.38, 29.29) },
	{ type = "gardening", coords = vector3(194.81, -1002.0, 29.29) },
	{ type = "gardening", coords = vector3(198.97, -1006.85, 29.29) },
	{ type = "gardening", coords = vector3(201.47, -1004.37, 29.29) }
}

Config.Uniforms = {
	['male'] = {
		outfitData = {
			['t-shirt'] = {item = 15, texture = 0},
			['torso2']  = {item = 352, texture = 0},
			['arms']    = {item = 86, texture = 0},
			['pants']   = {item = 27, texture = 2},
			['shoes']   = {item = 71, texture = 6},
		}
	},
	['female'] = {
	 	outfitData = {
			['t-shirt'] = {item = 36, texture = 0},
			['torso2']  = {item = 262, texture = 18},
			['arms']    = {item = 105, texture = 0},
			['pants']   = {item = 106, texture = 4},
			['shoes']   = {item = 79, texture = 8},
	 	}
	},
}