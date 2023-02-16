local World = {
	ground = {},
	instanceof = {}
}

function World:load()
	local world = love.physics.newWorld(0, 9.81*64, true)

	self.ground.body = love.physics.newBody(world, 400, 500, 'static')
	self.ground.shape = love.physics.newRectangleShape(300, 50)
	self.ground.fixture = love.physics.newFixture(self.ground.body, self.ground.shape)

	self.instanceof = world
end

function World:update(dt)
	self.instanceof:update(dt)
end

function World:draw()
	love.graphics.setColor(1,0.5,0.3)
  love.graphics.polygon('fill', self.ground.body:getWorldPoints(self.ground.shape:getPoints()))
end

return World
