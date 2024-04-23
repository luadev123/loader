repeat task.wait() until game:IsLoaded();
task.wait(0.12);
repeat
    setthreadidentity(8);
    task.wait();
until getthreadidentity() == 8;

local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local LuaName = "Echo"

StarterGui:SetCore("SendNotification", {
	Title = LuaName,
	Text = "Intializing Authentication...",
	Duration = 5
})

--* Configuration *--
local initialized = false
local sessionid = ""


--* Application Details *--
Name = "Loader" --* Application Name
Ownerid = "oDXb1U2wsp" --* OwnerID
APPVersion = "1.0"     --* Application Version

local req = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. Name .. '&ownerid=' .. Ownerid .. '&type=init&ver=' .. APPVersion)

if req == "KeyAuth_Invalid" then 
   print(" Error: Application not found.")

   StarterGui:SetCore("SendNotification", {
	   Title = LuaName,
	   Text = " Error: Application not found.",
	   Duration = 3
   })

   return false
end

local data = HttpService:JSONDecode(req)

if data.success == true then
   initialized = true
   sessionid = data.sessionid
   --print(req)
elseif (data.message == "invalidver") then
   print(" Error: Wrong application version..")

   StarterGui:SetCore("SendNotification", {
	   Title = LuaName,
	   Text = " Error: Wrong application version..",
	   Duration = 3
   })

   return false
else
   print(" Error: " .. data.message)
   return false
end

print("\n\n Licensing... \n")
local req = game:HttpGet('https://keyauth.win/api/1.1/?name=' .. Name .. '&ownerid=' .. Ownerid .. '&type=license&key=' .. License ..'&ver=' .. APPVersion .. '&sessionid=' .. sessionid)
local data = HttpService:JSONDecode(req)


if data.success == false then 
    StarterGui:SetCore("SendNotification", {
	    Title = LuaName,
	    Text = " Error: " .. data.message,
	    Duration = 5
    })

    return false
end

StarterGui:SetCore("SendNotification", {
	Title = LuaName,
	Text = " Successfully Authorized.",
	Duration = 5
})

pcall(function()
	-- Script to PlaceId table
	local PlaceIdToScriptTable = {
		[10371908957] = "https://raw.githubusercontent.com/Blastbrean/PascalCase-ddev/main/Compiler/Output.lua",
		[4878988249] = "https://raw.githubusercontent.com/urmom1313/Echo_Hub_Loader/main/Compiler/Output.lua", -- 14067600077
		[140369122388] = "https://raw.githubusercontent.com/urmom1313/Echo_Hub_Loader/main/Compiler/Output.lua", -- 14067600077
		[8350658333] = "https://raw.githubusercontent.com/urmom1313/Echo_Hub_Loader/main/Compiler/Output.lua", 
	}

	-- Attempt to get a URL to load from with our PlaceId...
	local ScriptString = PlaceIdToScriptTable[game.PlaceId]
	if not ScriptString then
		return warn("Script does not have a script for your current game!")
	else
		warn(ScriptString)
	end

	-- Load script...
	loadstring(game:HttpGet(ScriptString))()
end)

if Config.Debug == true then
	print(' Logged In!')
    print(' User Data')
    print(' Username:' .. data.info.username)
    print(' Created at:' .. data.info.createdate)
    print(' Last login at:' .. data.info.lastlogin)
end
