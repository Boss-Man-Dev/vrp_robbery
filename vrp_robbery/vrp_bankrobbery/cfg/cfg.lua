local cfg = {}

cfg.lang = "en" -- set your lang (file must exist on cfg/lang)

cfg.cops 			= "police.menu"	 							-- permission given to cops

cfg.notifyPicture	= "CHAR_LESTER"								-- notify picture change 

cfg.dirty 			= true										-- force dirty or clean money	

cfg.marker = {"PoI", {blip_id = 12, blip_color = 4, marker_id = 1, color={255, 0, 0,255}}}

cfg.banks = { -- list of robberies
	["Chumash"] = { 
	  name = "Chumash Fleeca Bank (5070)", 
	  pos = {-2957.6674804688, 481.45776367188, 15.697026252747}, 
	  dist = 10.0, rob = 10, wait = 20, cops = 0, min = 100000, max = 200000
	},
	["Grapeseed"] = { 
	  name = "Grapeseed Fleeca Bank (2007)", 
	  pos = {1647.97, 4851.42, 42.02}, 
	  dist = 10.0, rob = 10, wait = 20, cops = 0, min = 100000, max = 200000
	},
	["Blaine"] = { 
	  name = "Blaine County Savings Bank (1055)", 
	  pos = {-107.06505584717, 6474.8012695313, 31.62670135498}, 
	  dist = 15.0, rob = 10, wait = 20, cops = 0, min = 100000, max = 200000
	},
	["Morningwood"] = { 
	  name = "Morningwood Fleeca Bank (7175)", 
	  pos = {-1211.3924560547, -336.42221069336, 37.790794372559}, 
	  dist = 10.0, rob = 10, wait = 20, cops = 0, min = 100000, max = 200000
	},
	["Harmony"] = { 
	  name = "Harmony Fleeca Bank (4024)", 
	  pos = {1176.86865234375, 2711.91357421875, 38.097785949707}, 
	  dist = 10.0, rob = 10, wait = 20, cops = 0, min = 100000, max = 200000
	},
	["Rockford"] = { 
	  name = "Rockford Hills Fleeca Bank (7185)", 
	  pos = {-353.90753173828,-54.86417388916,49.036533355713}, 
	  dist = 10.0, rob = 10, wait = 20, cops = 0, min = 100000, max = 200000
	},
	["Downtown"] = { 
	  name = "Downtown Fleeca Bank (8170)", 
	  pos = {146.67059326172,-1045.6453857422,29.368028640747}, 
	  dist = 10.0, rob = 10, wait = 20, cops = 0, min = 100000, max = 200000
	},
	["Pacific"] = { 
	  name = "Pacific Standard Bank (7090)", 
	  pos = {255.001098632813, 225.855895996094, 101.105694274902}, 
	  dist = 30.0, rob = 10, wait = 20, cops = 0, min = 100000, max = 200000
	}
}

return cfg