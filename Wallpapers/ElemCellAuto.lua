math.randomseed(ly.clock())

--[[
-- Elementary Cellular Automata by RadsammyT
--
-- NOTES:
-- 	-	The animation assumes these config parameters:
-- 		- box_position_h = 0.5
-- 		- box_position_v = 0.4 # You get more leeway with this param, however
--
--]]

-- Config
local FPS_COUNT = 10 -- How many iterations of a rule per second
local RULE_TIME = 10 -- Seconds for each rule before rolling a new one
local RULE = 195 -- The starting rule
-- Config

local function FPS()
	return (1/FPS_COUNT)*1000000
end


local t = table
local bit = bit
local string = string

local using_byte = false
local timer = 0
local hue = 0
local clock = ly.clock()

local pixels = {}
for i = 1, ly.height do
	pixels[i] = {}
end
for i = 1, ly.width do
	pixels[1][i] = math.random(0,1)
end

local function BIT(val, idx)
	if bit.band(val, bit.lshift(1, idx)) > 0 then
		return 1
	else
		return 0
	end
end

local perf_clock = ly.clock()

local function hue2rgb(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1 / 6 then return p + (q - p) * 6 * t end
    if t < 1 / 2 then return q end
    if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
    return p
end
local function hslToRgb(h, s, l)
    h = h / 360
    s = s / 100
    l = l / 100

    local r, g, b

    if s == 0 then
        r, g, b = l, l, l -- achromatic
    else

        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = hue2rgb(p, q, h + 1 / 3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1 / 3)
    end

    if not a then a = 1 end
    return r * 255, g * 255, b * 255, a * 255
end

function draw()
	 -- The actual update to the animation
	if clock + FPS() < ly.clock() then
		timer = timer + 1
		if timer > FPS_COUNT * RULE_TIME then
			RULE = math.random(0,255)
			timer = 0
		end
		local p = {}
		local check = false
		for _,v in ipairs(pixels[1]) do
			if v == 1 then
				check = true
			end
		end
		if not check then 
			for i = 1, ly.width do
				pixels[1][i] = math.random(0,1)
			end
		end
		for i = 2, ly.width-1 do
			local surrounding = (pixels[1][i-1]*4) + (pixels[1][i]*2) + pixels[1][i+1]
			p[i] = BIT(RULE, surrounding)
		end
		local r, g, b, a = hslToRgb(hue, 50, 50)
		p.c = {
			r = r,
			g = g,
			b = b,
			a = a
		}
		hue = hue + 1
		if hue >= 360 then hue = 0 end
		t.insert(pixels, 1, p)
		t.remove(pixels, ly.height+1)
		clock = ly.clock()
	end

	-- Actually drawing the animation + some sanity checks
	for i = 1, ly.height do
		for j = 1, ly.width do
			if pixels[i][j] == nil then
				pixels[i][j] = 0
			end
		end
	end
	for x = 0, ly.width-1 do
		for y = 0, ly.height-1 do
			if pixels[y+1][x+1] == 1 then
				local col = pixels[y+1].c
				local val = 0xff
				if col == nil then
					val = 0x111111
				else
					val = bit.bor(
						math.floor(col.b),
						bit.bor(
							bit.lshift(math.floor(col.r), 16),
							bit.lshift(math.floor(col.g), 8)
						)
					)
				end
				ly.putCell(string.byte' ', 0, val, x, math.abs(y-ly.height+1))
			else 
				ly.putCell(string.byte' ', 0, 0x00000000, x, math.abs(y-ly.height+1))
			end
		end
	end
	ly.putRect(string.byte' ', 0, 0xFFFFFF, ly.width/3, 0, (ly.width/2 - ly.width/3) * 2, ly.height)
	ly.putRect(string.byte' ', 0, 0, ly.width/3+1, 0, (ly.width/2 - ly.width/3) * 2 - 2, ly.height)
	local timerWidth = (timer / (FPS_COUNT * RULE_TIME)) * ((ly.width/2 - ly.width/3) * 2 - 2)
	if timerWidth < 0 then timerWidth = 0 end
	ly.putRect(string.byte' ', 0, 0xFFFFFF, ly.width/3+1, ly.height-3, timerWidth, 3)
	ly.putRect(string.byte' ', 0, 0xFFFFFF, ly.width/3+1, 0, timerWidth, 3)
	local str = "RULE "..RULE
	ly.putLabel(str, 0x00FFFFFF, 0, ly.width/2 - string.len(str)/2, ly.height - 2)
	local perf_new = ly.clock()
	str = "FT: "..((perf_new-perf_clock)/1000).."ms"
	ly.putLabel(str, 0x00FFFFFF, 0, ly.width/2 - string.len(str)/2, ly.height-1)
	perf_clock = perf_new
end
