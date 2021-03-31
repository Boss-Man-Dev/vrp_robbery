local keys = {["E"] = 206,}
--[[##########################--]]
local cooldown = 0
local ispriority = false
local ishold = false

robb = ""
s_robbery = false
in_store = false
s_stars = false
--[[##########################--]]
s_timer = 0
timer = 0
--[[##########################--]]
local store_robbery = class("store_robbery", vRP.Extension)
--[[##############################
		Draw txt and help msg
##############################--]]
function HelpText(str)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(str)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end
--[[##########################--]]
function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
--[[##############################
		Functions
##############################--]]
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if s_robbery then
			if s_timer ~= 0 then
				s_timer = s_timer - 1
				
				local minutes = math.floor( s_timer  / 60 )
				local seconds = s_timer  % 60
				
				if seconds < 10 then
					timer = minutes..":0"..seconds
				else
					timer = minutes..":"..seconds
				end
			end
		end
	end
end)
--[[##########################--]]
function store_robbery:init(v,enter)
	Citizen.CreateThread(function()
		while true do
			local pos = GetEntityCoords(GetPlayerPed(-1), true)

			if s_robbery then
				s_stars = robb

				d_lang = "Robbing: ~r~{1}~w~ seconds remaining"
				drawTxt(0.66, 1.44, 1.0,1.1,0.4, string.gsub(d_lang, "{1}", timer), 255, 255, 255, 255)
				local ped = GetPlayerPed(-1)			local health = GetEntityHealth(ped)
				
				if(Vdist(pos.x, pos.y, pos.z, v.pos[1], v.pos[2], v.pos[3]) > v.dist) or health <= 120 then
					self.remote._cancelRobbery(robb)
					robb = ""					s_timer = 0
					s_robbery = false			in_store = false
				end
			else
				if(Vdist(pos.x, pos.y, pos.z, v.pos[1], v.pos[2], v.pos[3]) < v.dist) then
					if(Vdist(pos.x, pos.y, pos.z, v.pos[1], v.pos[2], v.pos[3]) < 2.0)then
						if (in_store == false) then
							h_lang = "Press ~INPUT_FRONTEND_RB~ to rob ~b~{1}~w~ beware, the police will be alerted!"
							HelpText(string.gsub(h_lang, "{1}", v.name))
						end
						if(IsControlJustReleased(1, keys["E"]))then
							in_store = true				robb = v.robb
							s_timer = v.rob				s_robbery = true
							self.remote._startRobbery(robb)
							SetPlayerWantedLevel(PlayerId(), 2, 0)
		    				SetPlayerWantedLevelNow(PlayerId(), 0)
						end
					end
				end
			end
			Citizen.Wait(0)
		end
	end)
end
--[[##########################--]]
function store_robbery:StoreRobberyComplete()
	self.coma = false	robb = ""	s_timer = 0	
	s_robbery = false		in_store = false
end
--[[##############################			News banner for robbed location
		 Announcement
##############################--]]
function store_robbery:NewsBulletin(info)
	MainBody 	= info.main 
	Footer 		= info.footer
	Header		= info.header
	
	breakingnews(MainBody,Footer,Header)
end
--[[##########################--]]
function breakingnews(MainBody,Footer,Header)
	scaleform = RequestScaleformMovie("breaking_news")
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	
	PushScaleformMovieFunction(scaleform, "SET_TEXT")
	PushScaleformMovieFunctionParameterString(MainBody)
	PushScaleformMovieFunctionParameterString(Footer)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "SET_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterString(Header)
	PopScaleformMovieFunctionVoid()
	
	PushScaleformMovieFunction(scaleform, "DISPLAY_SCROLL_TEXT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PopScaleformMovieFunctionVoid()
	DrawNews = true
end
--[[##########################--]]
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if DrawNews then
        	DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
        end
    end
end)
--[[##########################--]]
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if DrawNews then
        	Citizen.Wait((15*1000))
        	DrawNews = false
        end
    end
end)
--[[##############################
			Tunnel
##############################--]]
store_robbery.tunnel = {}

store_robbery.tunnel.init 					= store_robbery.init
store_robbery.tunnel.StoreRobberyComplete 	= store_robbery.StoreRobberyComplete
store_robbery.tunnel.NewsBulletin 			= store_robbery.NewsBulletin

vRP:registerExtension(store_robbery)