local keys = {["E"] = 206,}
--[[##########################--]]
local cooldown = 0
local ispriority = false
local ishold = false

b_rob = ""
b_robbery = false
in_bank = false
b_stars = false
--[[##########################--]]
b_timer = 0
bank_timer = 0
--[[##########################--]]
local bank_robbery = class("bank_robbery", vRP.Extension)
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
		if b_robbery then
			if b_timer ~= 0 then
				b_timer = b_timer - 1
				
				local minutes = math.floor( b_timer  / 60 )
				local seconds = b_timer  % 60
				
				if seconds < 10 then
					bank_timer = minutes..":0"..seconds
				else
					bank_timer = minutes..":"..seconds
				end
			end
		end
	end
end)
--[[##########################--]]
function bank_robbery:init(v,enter)
	Citizen.CreateThread(function()
		while true do
			local pos = GetEntityCoords(GetPlayerPed(-1), true)

			if b_robbery then
				b_stars = b_rob
		
				d_lang = "Robbing: ~r~{1}~w~ seconds remaining"
				drawTxt(0.66, 1.44, 1.0,1.1,0.4, string.gsub(d_lang, "{1}", bank_timer), 255, 255, 255, 255)
				local ped = GetPlayerPed(-1)			local health = GetEntityHealth(ped)
				
				if(Vdist(pos.x, pos.y, pos.z, v.pos[1], v.pos[2], v.pos[3]) > v.dist) or health <= 120 then
					self.remote._cancelBankRobbery(b_rob)
					b_rob = ""				b_timer = 0
					b_robbery = false			in_bank = false
				end
			else
				if(Vdist(pos.x, pos.y, pos.z, v.pos[1], v.pos[2], v.pos[3]) < v.dist) then
					if(Vdist(pos.x, pos.y, pos.z, v.pos[1], v.pos[2], v.pos[3]) < 2.0)then
						if (in_bank == false) then
							h_lang = "Press ~INPUT_FRONTEND_RB~ to rob ~b~{1}~w~ beware, the police will be alerted!"
							HelpText(string.gsub(h_lang, "{1}", v.name))
						end
						if(IsControlJustReleased(1, keys["E"]))then
							in_bank = true				b_rob = v.b_rob
							b_timer = v.rob				b_robbery = true
							self.remote._startBankRobbery(b_rob)
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
function bank_robbery:BankRobberyComplete()
	self.coma = false	b_rob = ""	b_timer = 0	
	b_robbery = false		in_bank = false
end
--[[##############################
		 Announcement
##############################--]]
function bank_robbery:NewsBulletin(info)
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
bank_robbery.tunnel = {}

bank_robbery.tunnel.init 					= bank_robbery.init
bank_robbery.tunnel.BankRobberyComplete 	= bank_robbery.BankRobberyComplete
bank_robbery.tunnel.NewsBulletin 			= bank_robbery.NewsBulletin

vRP:registerExtension(bank_robbery)
