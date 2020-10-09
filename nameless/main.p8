pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--==         notes          ==--

--= tabs                     =--
-- 1.controller handling
-- 2.objects controller
-- 3.gravity object
-- 4.player object
-- 5.button handling
-- 6.special callbacks

--= sprite flags             =--
-- 0.player sprite

--= todos                    =--

-->8
-- controller handling

conts={}
c={}

function set_cont(cont)
	if c.blur then c:blur() end
	c=cont
	if c.focus then c:focus() end
end
-->8
-- objects controller
conts.objects={
	-- the object that the player
	--  is controlling
	p={},
	-- the list of objects
	objects={},
	-- add an object
	addo=function(s,obj)
		add(s.objects,obj)
	end,
	setp=function(s,p)
		s.p=p
	end,
	-- called on _update
	update=function(s)
		for obj in all(s.objects) do
			if obj.update then
				obj:update()
			end
		end
	end,
	-- called on _draw
	draw=function(s)
		for obj in all(s.objects) do
			if obj.draw then
				obj:draw()
			end
		end
	end,
	-- when switching to this
	focus=function(s)
	end,
	-- when switching from this
	blur=function(s)
	end,
	-- when up is held down
	⬆️=function(s)
		if s.p.⬆️ then s.p:⬆️() end
	end,
	-- when up is pressed
	⬆️p=function(s)
		if s.p.⬆️p then s.p:⬆️p() end
	end,
	-- when down is held down
	⬇️=function(s)
		if s.p.⬇️ then s.p:⬇️() end
	end,
	-- when down is pressed
	⬇️p=function(s)
		if s.p.⬇️p then s.p:⬇️p() end
	end,
	-- when left is held down
	⬅️=function(s)
	 if s.p.⬅️ then s.p:⬅️() end
	end,
	-- when left is pressed
	⬅️p=function(s)
		if s.p.⬅️p then s.p:⬅️p() end
	end,
	-- when right is held down
	➡️=function(s)
		if s.p.➡️ then s.p:➡️() end
	end,
	-- when right is pressed
	➡️p=function(s)
		if s.p.➡️p then s.p:➡️p() end
	end
}

-- simpler way to call addo
function add_object(obj)
	conts.objects:addo(obj)
end

-- simpler way to call setp
function set_player(p)
 conts.objects:setp(p)
end
-->8
-- gravity object
-- an object with gravity
-- use sx,gx,etc. for position
function make_go(x,y)
	return {
		x=x,
		y=y,
		-- get x
		gx=function(s)
			return s.x
		end,
		-- get y
		gy=function(s)
			return s.y
		end,
		-- set position
		sp=function(s,x,y)
			s.x=x
			s.y=y
		end,
		-- move x by xv pixels
		-- move y by yv pixels
		move=function(s,xv,yv)
			s.x+=xv
			s.y+=yv
		end
	}
end
-->8
-- player object

p={
	x=0,
	y=0,
	yv=0,
	g=1,
	w=3,
	h=3,
	spd=2,
	move=function(s,xv,yv)
		s.x+=xv
		s.y+=yv
		if s.y>100 then
			s.y=100
			s.yv=0
		end
	end,
	draw=function(s)
		rect(s.x,s.y,
			s.x+s.w,s.y+s.h,7)
	end,
	update=function(s)
		s:move(0,s.yv)
		s.yv+=s.g
	end,
	⬆️p=function(s)
		if s.yv<0 then return end
		s.yv=-5
	end,
	⬅️=function(s)
		s:move(-s.spd,0)
	end,
	➡️=function(s)
		s:move(s.spd,0)
	end
}

add_object(p)
set_player(p)
-->8
-- button handling

function h_btn()
	if btn(⬆️) and c.⬆️ then
		c:⬆️()
	end
	if btnp(⬆️) and c.⬆️p then
		c:⬆️p()
	end
	if btn(⬇️) and c.⬇️ then
		c:⬇️()
	end
	if btnp(⬇️) and c.⬇️p then
		c:⬇️p()
	end
	if btn(⬅️) and c.⬅️ then
		c:⬅️()
	end
	if btnp(⬅️) and c.⬅️p then
		c:⬅️p()
	end
	if btn(➡️) and c.➡️ then
		c:➡️()
	end
	if btnp(➡️) and c.➡️p then
		c:➡️p()
	end
	if btn(❎) and c.❎ then
		c:❎()
	end
	if btnp(❎) and c.❎p then
		c:❎p()
	end
	if btn(🅾️) and c.🅾️ then
		c:🅾️()
	end
	if btnp(🅾️) and c.🅾️p then
		c:🅾️p()
	end
end
-->8
-- special callbacks

function _init()
	set_cont(conts.objects)
end

function _update()
	h_btn()
	c:update()
end

function _draw()
	cls()
	c:draw()
end
__gfx__
00000000044444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000044ffff440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007004f1ff1f40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000ffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000ffeeff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700f888888f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000cccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000555005550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
