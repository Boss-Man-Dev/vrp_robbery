local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")
--[[##########################--]]
local store_robbery = class("store_robbery", vRP.Extension)
--[[##########################--]]
store_robbers = {}
last_store = {}
local info = {}
--[[##########################--]]
store_robbery.event = {}
--[[##########################--]]
store_robbery.tunnel = {}
--[[##########################--]]
function store_robbery:__construct()
	vRP.Extension.__construct(self)
  
	self.cfg = module("vrp_storerobbery", "cfg/cfg")
	
	-- load lang
	self.luang = Luang()
	self.luang:loadLocale(vRP.cfg.lang, module("vrp_storerobbery", "cfg/lang/"..vRP.cfg.lang))
	self.lang = self.luang.lang[vRP.cfg.lang]
	
end
--[[##############################
			special function
##############################--]]
function comma_value(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end
--[[##########################--]]
function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end
--[[##############################
			Event
##############################--]]
function store_robbery.event:playerSpawn(user, first_spawn)
	if first_spawn then
		for k,v in pairs(self.cfg.store) do
			local x,y,z = table.unpack(v.pos)
			
			local enter
			local function enter(user)
				v.robb = k 	
				self.remote._init(user.source, v)
			end

			local ment = clone(self.cfg.marker)
			ment[2].title = "Store Heists"
			ment[2].pos = {x,y,z-1}
			vRP.EXT.Map.remote._addEntity(user.source, ment[1], ment[2])
			
			user:setArea("vRP:Store_Heists:"..k,x,y,z,1,1.5,enter)
		end
	end
end
--[[##############################
			Tunnel
##############################--]]
function store_robbery.tunnel:cancelRobbery(robb)
	local player = source
	local user = vRP.users_by_source[source]
	if(store_robbers[source])then
		store_robbers[source] = nil
		canceled = true
		TriggerClientEvent('chatMessage', player, self.lang.common.title(), {255, 0, 0}, self.lang.common.cancel.opt_1())
	end
end
--[[##########################--]]
function store_robbery.tunnel:startRobbery(robb)
	local user = vRP.users_by_source[source]
	
	if user and user:isReady() then
		local canceled = false
		local player = source
		local cops = vRP.EXT.Group:getUsersByPermission(self.cfg.cops)
		local s_robbery = self.cfg.store[robb]
		if user:hasPermission(self.cfg.cops) then
			self.remote._StoreRobberyComplete(player)
			vRP.EXT.Base.remote._notify(user.source, self.lang.cops.cop_3())
		else
			if s_robbery then
				if #cops >= s_robbery.cops then
					if last_store[robb] then
						local past = os.time() - last_store[robb]
						local wait = s_robbery.wait
						if past <  wait then
							TriggerClientEvent('chatMessage', player, self.lang.common.title(), {255, 0, 0}, self.lang.common.wait.opt_1({wait - past}))
							self.remote._StoreRobberyComplete(player)
							canceled = true
						end
					end
					if not canceled then
						local f_hold
						amount = s_robbery.rob/60
						f_hold = round(amount, 0)
						TriggerClientEvent('chatMessage', -1, self.lang.news.rob.header(), {255, 0, 0}, self.lang.news.rob.body({s_robbery.name}))
						TriggerEvent("cooldownt")
						last_store[robb] = os.time()
						store_robbers[player] = robb
						
						local x,y,z = vRP.EXT.Base.remote.getPosition(user.source)
						vRP.EXT.Phone:sendServiceAlert(nil, "police" ,x,y,z, self.lang.common.progress({s_robbery.name})) -- send service alert (call request)
						vRP.EXT.Base.remote._notifyPicture(user.source, self.cfg.notifyPicture, 1, "WARNING", "Alarm Triggered", "The police were alerted!")
						
						local savedSource = player
						SetTimeout(s_robbery.rob*1000, function()
							if(store_robbers[savedSource])then
								if user then
									local reward = math.random(s_robbery.min,s_robbery.max)
									if self.cfg.dirty then
										user:tryGiveItem("dirty_money",reward) 
									else
										user:tryGiveItem("money", reward,false)
									end
									self.remote._StoreRobberyComplete(savedSource)
									
									local formatted
									formatted = comma_value(reward)						
									
									info.main 	= self.lang.news.body({s_robbery.name})
									info.footer = self.lang.news.footer({formatted})
									info.header = self.lang.news.heading()
									self.remote._NewsBulletin(-1, info)
								end
							end
						end)
					end
				else
					self.remote._StoreRobberyComplete(player)
					vRP.EXT.Base.remote._notify(user.source, self.lang.cops.not_enough({s_robbery.cops}))
				end
			end
		end
	end
end

vRP:registerExtension(store_robbery)
