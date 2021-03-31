
local lang = {
	common = {
		title 		= "BANK ROBBERY ",
		help_msg 	= "Press ~INPUT_RELOAD~ to rob ~b~{1}~w~ beware, the police will be alerted!",
		robbing 	= "Robbing: ~r~{1}~w~ seconds remaining",
		progress 	= "Robbery in progress at {1}",
		hold 		= "Stand Your Ground for ^1{1}^0 minutes and the money is all yours!",
		wait = {
			opt_1 = "This has already been robbed recently. Please wait another: ^2{1}^0 seconds.",
			opt_2 = "Patience you still have ^2{1}^0 seconds left",
			opt_2 = "Chill!! You can't do that yet ",
		},
		cancel = {
			opt_1 = "Robbery was cancelled!",
			opt_2 = "Robbery was cancelled! They couldn't handle the pressure.",
			opt_3 = "Robbers Gave Up!",
		},
	},
	cops = {
		error = {
			cop_1 = "~r~Cops should't break the law!",
			cop_2 = "~r~what happened to serve and protect",
			cop_3 = "~r~Should you be doing that?",
		},
		not_enough = "~r~You need at least {1} cops online",
	},
	news = {
		heading 	= "<b>Breaking News</b>",
		body 		= "{1} has just been robbed!!!!",
		footer 		= "~r~${1}~w~ was stolen!",
		rob = {
			header = "Weazel News",
			body 	= "Robbery in progress at ^1{1}^1",
		},
	},
}

return lang
