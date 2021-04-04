local lang = vRP.lang
local Luang = module("vrp", "lib/Luang")
--[[##########################--]]
local bank_robbery = class("bank_robbery", vRP.Extension)
--[[##########################--]]
bank_robbers = {}
last_bank = {}
local info = {}
--[[##########################--]]
bank_robbery.event = {}
--[[##########################--]]
bank_robbery.tunnel = {}
--[[##########################--]]
function bank_robbery:__construct()
	vRP.Extension.__construct(self)
  
	self.cfg = module("vrp_bankrobbery", "cfg/cfg")
	
	-- load lang
	self.luang = Luang()
	self.luang:loadLocale(vRP.cfg.lang, module("vrp_bankrobbery", "cfg/lang/"..vRP.cfg.lang))
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
function bank_robbery.event:playerSpawn(user, first_spawn)
	if first_spawn then
		for k,v in pairs(self.cfg.banks) do
			local x,y,z = table.unpack(v.pos)
			
			local enter
			local function enter(user)
				v.b_rob = k
				self.remote._init(user.source, v)
			end
			
			local ment = clone(self.cfg.marker)
			ment[2].title = "Bank Heists"
			ment[2].pos = {x,y,z-1}
			vRP.EXT.Map.remote._addEntity(user.source, ment[1], ment[2])
			
			user:setArea("vRP:Bank_Heists:"..k,x,y,z,1,1.5,enter)
		end
	end
end
--[[##############################
			Tunnel
##############################--]]
function bank_robbery.tunnel:cancelBankRobbery(b_rob)
	local player = source
	local user = vRP.users_by_source[source]
	if(bank_robbers[source])then
		bank_robbers[source] = nil
		canceled = true
		TriggerClientEvent('chatMessage', player, self.lang.common.title(), {255, 0, 0}, self.lang.common.cancel.opt_1())
	end
end
--[[##########################--]]
function bank_robbery.tunnel:startBankRobbery(b_rob)
	local user = vRP.users_by_source[source]
	local canceled = false
	local player = source
	local cops = vRP.EXT.Group:getUsersByPermission(self.cfg.cops)
	local b_robbery = self.cfg.banks[b_rob]
		
	if user and user:isReady() then
		if user:hasPermission(self.cfg.cops) then
			self.remote._BankRobberyComplete(player)
			vRP.EXT.Base.remote._notify(user.source, self.lang.cops.cop_3())
		else
			if b_rob then
				if #cops >= b_robbery.cops then
					if last_bank[b_rob] then
						local past = os.time() - last_bank[b_rob]
						local wait = b_robbery.wait
						if past <  wait then
							TriggerClientEvent('chatMessage', player, self.lang.common.title(), {255, 0, 0}, self.lang.common.wait.opt_1({wait - past}))
							self.remote._BankRobberyComplete(player)
							canceled = true
						else
							canceled = false
						end
					end
					if not canceled then
						local f_hold
						amount = b_robbery.rob/60
						f_hold = round(amount, 0)
						TriggerClientEvent('chatMessage', -1, self.lang.news.rob.header(), {255, 0, 0}, self.lang.news.rob.body({b_robbery.name}))
						TriggerEvent("cooldownt")
						last_bank[b_rob] = os.time()
						bank_robbers[player] = b_rob
						
						local x,y,z = vRP.EXT.Base.remote.getPosition(user.source)
						vRP.EXT.Phone:sendServiceAlert(nil, "police" ,x,y,z, self.lang.common.progress({b_robbery.name})) -- send service alert (call request)
						vRP.EXT.Base.remote._notifyPicture(user.source, self.cfg.notifyPicture, 1, "WARNING", "Alarm Triggered", "The police were alerted!")
						
						local savedSource = player
						SetTimeout(b_robbery.rob*1000, function()
							if(bank_robbers[savedSource])then
								if user then
									local reward = math.random(b_robbery.min,b_robbery.max)
									if self.cfg.dirty then
										user:tryGiveItem("dirty_money",reward,false) 
									else
										user:tryGiveItem("money", reward,false)
									end
									self.remote._BankRobberyComplete(savedSource)
									
									local formatted
									formatted = comma_value(reward)
									
									info.main 	= self.lang.news.body({b_robbery.name})
									info.footer = self.lang.news.footer({formatted})
									info.header = self.lang.news.heading()
									self.remote._NewsBulletin(-1, info)
								end
							end
						end)
					end
				else
					self.remote._BankRobberyComplete(player)
					vRP.EXT.Base.remote._notify(user.source, self.lang.cops.not_enough({b_robbery.cops}))
				end
			end
		end
	end
end

vRP:registerExtension(bank_robbery)