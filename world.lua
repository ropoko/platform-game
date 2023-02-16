local World = {
	ground = {},
	roof = {},
	instanceof = {}
}

function World:load()
	local world = love.physics.newWorld(0, 9.81*64, true)

	self.ground.body = love.physics.newBody(world, 400, 500, 'static')
	self.ground.shape = love.physics.newRectangleShape(300, 50)
	self.ground.fixture = love.physics.newFixture(self.ground.body, self.ground.shape)

	self.roof.body = love.physics.newBody(world, 400, 100, 'static')
	self.roof.shape = love.physics.newRectangleShape(300, 50)
	self.roof.fixture = love.physics.newFixture(self.roof.body, self.roof.shape)

	self.instanceof = world
end

function World:update(dt)
	self.instanceof:update(dt)
end

function World:draw()
	love.graphics.setColor(1,0.5,0.3)
  love.graphics.polygon('fill', self.ground.body:getWorldPoints(self.ground.shape:getPoints()))

	love.graphics.polygon('fill', self.roof.body:getWorldPoints(self.roof.shape:getPoints()))
end

return World
