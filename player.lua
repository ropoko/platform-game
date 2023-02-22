local Utils = require('utils')
local World = require('world')

local Player = {
	world = {},
	x = 100,
	y = 150,
	width = 50,
	height = 50,
	mass = 50,
	-- ----------
	rope = nil,
	shoot_speed = 5
}

local destiny_rope = {
	x = 0,
	y = 0
}

function Player:load(world)
	self.world = world

	self.body = love.physics.newBody(self.world, self.x, self.y, 'dynamic')
	self.shape = love.physics.newRectangleShape(self.width, self.height)
	self.fixture = love.physics.newFixture(self.body, self.shape)

	self.body:setMass(self.mass)
end

function Player:update(dt)
	self.x, self.y = self.body:getPosition()
	-- print(World.instance:getJointCount())
end

function Player:draw()
	love.graphics.setColor(0,0.5,1)
	love.graphics.polygon('line', self.body:getWorldPoints(self.shape:getPoints()))

	if self.rope ~= nil then
		self:draw_line(self.rope.x, self.rope.y)
	end
end

function love.mousepressed(x,y,btn)
	if btn == 1 then
		destiny_rope = {
			x = x,
			y = y
		}

		if Player.rope ~= nil and Player.rope.body ~= nil then
			Player.rope.body:destroy()
		end

		Player:draw_line(Player.x, Player.y)
	end

	if btn == 2 and Player.rope ~= nil and Player.rope.body ~= nil then
		-- for k,joint in pairs(World.instance:getJoints()) do
		-- 	joint:destroy()
		-- end

		Player.rope.body:destroy()
		Player.rope = nil
	end
end

function Player:draw_line(x,y)
	for _,body in pairs(World:get_bodies_position()) do
		if Utils:has_collision(x,y,1,1,body.x/2, body.y-body.h/2, body.w, body.h) then
			if self.rope.body == nil then
				self.rope.body = love.physics.newRopeJoint(self.body, body.body, self.x, self.y, x, y, 100, true)
			end
			love.graphics.line(self.rope.body:getAnchors())
			return
		else
			if y > destiny_rope.y then
				y = y - self.shoot_speed
			end

			if y < destiny_rope.y then
				y = y + self.shoot_speed
			end

			if x > destiny_rope.x then
				x = x - self.shoot_speed
			end

			if x < destiny_rope.x then
				x = x + self.shoot_speed
			end

			self.rope = {
				x = x,
				y = y
			}

			love.graphics.line(Player.x, Player.y, self.rope.x,self.rope.y)
		end
	end
end

return Player
