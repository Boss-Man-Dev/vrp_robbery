local cfg = {}

cfg.lang = "en" -- set your lang (file must exist on cfg/lang)

cfg.cops 			= "police.menu"	 							-- permission given to cops

cfg.notifyPicture	= "CHAR_LESTER"								-- notify picture change 

cfg.dirty 			= true										-- force dirty or clean money	

cfg.marker = {"PoI", {blip_id = 12, blip_color = 4, marker_id = 1, color={255, 0, 0,255}}}

cfg.store = { -- list of stores to rob
	["10026_247"] = { 
	  	name = "24/7 LSIA (10026)", 
	  	pos = {-1100.7233886719,-2588.7587890625,13.925135612488}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["9094_LTD"] = { 
	  	name = "LTD Grove St. (9094)", 
	  	pos = {-43.407146453857,-1748.4020996094,29.421012878418}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["9046_247"] = { 
	  	name = "24/7 Grove St. (9046)", 
	  	pos = {28.190195083618,-1339.2845458984,29.497026443481}, 
	  	dist = 10.0, rob = 10, wait = 1500, cops = 0, min = 5000, max = 7500 --100-200
	},
	["7326_liquor"] = { 
	  	name = "Rob's Liquor (7326)", 
	  	pos = {1126.8431396484,-980.25897216797,45.415775299072}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["8140_LTD"] = { 
	  	name = "LTD Little Seoul (8140)", 
	  	pos = {-709.65167236328,-904.08026123047,19.215595245361}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["8093_liquor"] = { 
	  	name = "Rob's Liquor (8093)", 
	  	pos = {-1220.7459716797,-915.95690917969,11.326323509216}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["7302_LTD"] = { 
	  	name = "LTD Mirror Park (7302)", 
	  	pos = {1159.5494384766,-314.0276184082,69.205123901367}, 
	  	dist = 15.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["7093_247"] = { 
	  	name = "24/7 Clinton Ave. (7093)", 
	  	pos = {378.14349365234,333.31994628906,103.56639099121}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["7355_247"] = { 
	  	name = "24/7 Route 15. (7355)", 
	  	pos = {378.14349365234,333.31994628906,103.56639099121}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["5067_liquor"] = { 
	  	name = "Rob's Liquor (5067)", 
	  	pos = {-2959.5505371094,387.17807006836,14.043279647827}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["5016_LTD"] = { 
	  	name = "LTD N. Rockford Dr. (5016)", 
	  	pos = {-1829.16796875,798.81616210938,138.19027709961}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["5037_247"] = { 
	  	name = "24/7 Barbareno Rd. (5037)", 
	  	pos = {-3249.798828125,1004.3371582031,12.830709457397}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["4019_247"] = { 
	  	name = "24/7 Route 68 (4019)", 
	  	pos = {546.32098388672,2663.0471191406,42.156497955322}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["4024_liquor"] = { 
	  	name = "Scoops Liquor Bar (4024)", 
	  	pos = {1169.0457763672,2717.7854003906,37.157634735107}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["3051_247"] = { 
	  	name = "24/7 Route 13 (3051)", 
	  	pos = {2672.8674316406,3286.5832519531,55.241138458252}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["3008_247"] = { 
	  	name = "24/7 Alhambra Dr. (3008)", 
	  	pos = {1959.2180175781,3748.8515625,32.34375}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},	
	["2006_LTD"] = { 
	  	name = "LTD Grapeseed (2006)", 
	  	pos = {1707.9283447266,4920.3759765625,42.06364440918}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	},
	["1012_247"] = { 
	  	name = "Don's County Store (1012)", 
	  	pos = {168.92114257813,6644.6708984375,31.71063041687}, 
	  	dist = 10.0, rob = 240, wait = 1500, cops = 3, min = 5000, max = 7500 --100-200
	}
}

return cfg