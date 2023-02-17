
local Player = {
	world = {},
	x = 300,
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

		Player:draw_line(Player.x, Player.y)
	end
end

function Player:draw_line(x,y)
	-- remove this and check collision
	if math.ceil(x) == math.ceil(destiny_rope.x) and math.ceil(y) == math.ceil(destiny_rope.y) then
		love.physics.newRopeJoint(self.body, self.world.roof.body, x, y, destiny_rope.x, destiny_rope.y, 50, true)
		return
	end

	if x > destiny_rope.x then
		x = x - self.shoot_speed
	end

	if x < destiny_rope.x then
		x = x + self.shoot_speed
	end

	if y > destiny_rope.y then
		y = y - self.shoot_speed
	end

	if y < destiny_rope.y then
		y = y + self.shoot_speed
	end

	self.rope = {
		x = x,
		y = y
	}

	love.graphics.line(Player.x, Player.y, self.rope.x,self.rope.y)
end

return Player
