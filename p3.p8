pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
phase1 = true
pause = false
phase2 = false

kick_lvl = 2
last_pressed = 1

timer_e = 0
wait_time_e = rnd(50) + 10
timer_f = 0
wait_time_f = rnd(50) + 10

player = {}
player.x = 56
player.y = 56
player.dx = 2
player.dy = 2
player.size = 16
player.sprite = 4
player.direct = 4
player.sprite_mod = 0
player.push = false
player.pull = false

pulling_e = false
pulling_f = false

f_block = {}
f_block.x = 86
f_block.y = 26
f_block.dx = 1
f_block.dy = 1
f_block.size = 16
f_block.sprite = 33

e_block = {}
e_block.x = 00
e_block.y = 00
e_block.dx = 1
e_block.dy = 1
e_block.direction = flr(rnd(5))
e_block.size = 16
e_block.sprite = 35






-----------------------
-- update  functions --
-----------------------

function _update()
 update_player()
end

function update_player()
	-- 4 directions
	player_directions()
	
	-- pull
	player_pull()
	
	if pulling_e == false and not collision_with(e_block.x, e_block.y) then
 	if e_block.direction == 0 and e_block.x > 0 then
 		e_block.x -= e_block.dx
 	elseif e_block.direction == 1 and e_block.x + 16 < 128then
 		e_block.x += e_block.dx
 	elseif e_block.direction == 2 and e_block.y > 0 then
 		e_block.y -= e_block.dy
 	elseif e_block.direction == 3 and e_block.y + 16 < 128 then
 		e_block.y += e_block.dy
 	end
 end
	
	timer_e += 1
	if timer_e >= wait_time_e then
		wait_time_e = rnd(30) + 10
		e_block.direction = flr(rnd(4))
		timer_e = 0
	end
	
		if pulling_f == false and not collision_with(f_block.x, f_block.y) then
 	if f_block.direction == 0 and f_block.x > 0 then
 		f_block.x -= f_block.dx
 	elseif f_block.direction == 1 and f_block.x + 16 < 128then
 		f_block.x += f_block.dx
 	elseif f_block.direction == 2 and f_block.y > 0 then
 		f_block.y -= f_block.dy
 	elseif f_block.direction == 3 and f_block.y + 16 < 128 then
 		f_block.y += f_block.dy
 	end
 end
	
	timer_f += 1
	if timer_f >= wait_time_f then
		wait_time_f = rnd(30) + 10
		f_block.direction = flr(rnd(4))
		timer_f = 0
	end
end
		
function player_directions()
-- left
	pulling_e = false
	pulling_f = false
	if btn(0) and player.x > 0 then
		player.direct = 0
		if collision_with(e_block.x, e_block.y) then
			if player.pull == false and player.x + player.size -2 < e_block.x  then
				player.x -= player.dx
			else 
				if (e_block.x > 0) then
 				pulling = true
 				player.x -= player.dx
 				e_block.x -= player.dx
				end
			end
		
		else if collision_with(f_block.x, f_block.y) then
			if player.pull == false and player.x + player.size -2 < f_block.x  then
				player.x -= player.dx
			else 
				if (f_block.x > 0) then
 				player.x -= player.dx
 				f_block.x -= player.dx
 				pulling_f = true
				end
			end
			
		else
			player.x -= player.dx
		end
	end
end
	
	-- right
	if btn(1) and player.x < 128 - player.size then
		player.direct = 2
		pulling_e = false
		pulling_f = false
		if collision_with(e_block.x, e_block.y) then
			if player.pull == false and player.x+2 >e_block.x+16 then
				player.x += player.dx
			else 
				if (e_block.x + 16 < 128) then
 				pulling_e = true
 				player.x += player.dx
 				e_block.x += player.dx
				end
			end
		else if collision_with(f_block.x, f_block.y) then
			if player.pull == false and player.x+2 >f_block.x+16 then
				player.x += player.dx
			else 
				if (f_block.x + 16 < 128) then
 				player.x += player.dx
 				f_block.x += player.dx
 				pulling_f = true
				end
			end
		else
			player.x += player.dx
		end
	end
end
	
	-- up
	if btn(2) and player.y > 0 then
		player.direct = 4
		pulling_e = false
		pulling_f = false
		if collision_with(e_block.x, e_block.y) then
			if player.pull == false and player.y + 16 - 2 < e_block.y then
				player.y -= player.dy
			else 
				if (e_block.y > 0) then
 				player.y -= player.dy
 				pulling_e = true
 				e_block.y -= player.dy
				end
			end
		else if collision_with(f_block.x, f_block.y) then
			if player.pull == false and player.y + 16 - 2 < f_block.y then
				player.y -= player.dy
			else 
				if (f_block.y > 0) then
 				player.y -= player.dy
 				f_block.y -= player.dy
 				pulling_f = true
				end
			end
		else
			player.y -= player.dy
		end
	end
end
	
	-- down
	if btn(3) and player.y < 128 - player.size then
		player.direct = 6
		pulling_e = false
		pulling_f = false
		if collision_with(e_block.x, e_block.y) then
			if player.pull == false and player.y + 2 > e_block.y + 16 then
				player.y += player.dy
			else 
				if (e_block.y + 16 < 128) then
 				player.y += player.dy
 				e_block.y += player.dy
 				pulling_e = true
				end
			end
			
		else if collision_with(f_block.x, f_block.y) then
			if player.pull == false and player.y + 2 > f_block.y + 16 then
				player.y += player.dy
			else 
				if (f_block.y + 16 < 128) then
 				player.y += player.dy
 				f_block.y += player.dy
 				pulling_f = true
				end
			end
			
		else
			player.y += player.dy
		end
		
	end
end
end

function collision_with(x1, y1)
	if x1 <= player.x + 16 and x1 + 16 >= player.x and y1 <= player.y + player.size and y1 + 16 >= player.y then
		return true
	else 
		return false
	end
end

function player_pull()
	if btn(4) then
		if player.pull == false then
			player.pulldir = player.direct
		end
		
		player.pull = true
		player.sprite_mod = 8
	else 
		player.pull = false
		player.sprite_mod = 0
	end
	
	if player.pull == true then
		player.sprite = player.pulldir + player.sprite_mod 
	else 
		player.sprite = player.direct + player.sprite_mod
	end
end
	


	 

-----------------------
-- drawing functions --
-----------------------

function _draw()
	cls()
	mapdraw(0, 0, 0, 0, 16, 16)
	
	print("move to push, x to pull", 2, 121, 3)

	draw_player()
	draw_friend()
	draw_enemy()
	
	rectfill(63, 105, 65, 110, 7)
	
	if check_f() == true and check_e() == false then
		rectfill(65, 105, 95, 110, 12)
	end
	if check_e() == true and check_f() == false then
		rectfill(33, 105, 63, 110, 8)
	end
end
	

function draw_player()
	spr(player.sprite, player.x, player.y, 2, 2)
end

function draw_friend()
	spr(f_block.sprite, f_block.x, f_block.y, 2, 2)
end

function draw_enemy()
	spr(e_block.sprite, e_block.x, e_block.y, 2, 2)
end

function check_f()
	if f_block.x + 16 > 24 and f_block.x < 104 and f_block.y + 16> 24 and f_block.y < 104 then
		return true
	else
		return false
	end
end

function check_e()
	if e_block.x + 16 > 24 and e_block.x < 104 and e_block.y + 16> 24 and e_block.y < 104 then
		return true
	else
		return false
	end
end
__gfx__
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7777777777777777777777777777777777777777777777777777777777777777
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb77bbbbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbbb77bbbbbb77bbbbbbbbbbbbbb7
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7bb7bbbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbb7bb7bbbbb77bbbbbbbbbbbbbb7
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7bbbb7bbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbb7bbbb7bbbb77bbbbbbbbbbbbbb7
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb7
bbb7bbbbbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7bb7bbbbbbbbbbb77bbbbbbbbbbb7bb77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb7
bb7bbbbbbbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7b7bbbbbbbbbbbb77bbbbbbbbbbbb7b77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb7
b7bbbbbbbbbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb77bbbbbbbbbbbbb77bbbbbbbbbbbbb777bbbbbbbbbbbbbb77bbbbbbbbbbbbbb7
b7bbbbbbbbbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb77bbbbbbbbbbbbb77bbbbbbbbbbbbb777bbbbbbbbbbbbbb77bbbbbbbbbbbbbb7
bb7bbbbbbbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7b7bbbbbbbbbbbb77bbbbbbbbbbbb7b77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb7
bbb7bbbbbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7bb7bbbbbbbbbbb77bbbbbbbbbbb7bb77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb7
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb7
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7bbbb7bbbbb7bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbb7bbbb7bbbb7
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7bb7bbbbbb7bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbb7bb7bbbbb7
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb77bbbbbbb7bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbbbbbbbbbbb77bbbbbb77bbbbbb7
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7777777777777777777777777777777777777777777777777777777777777777
11111111cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333cccccccccccccccc88888888888888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
2020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203030303030303030303020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203030303030303030303020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203030303030303030303020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203030303030303030303020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203030303030303030303020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203030303030303030303020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203030303030303030303020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203030303030303030303020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203030303030303030303020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020203030303030303030303020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
