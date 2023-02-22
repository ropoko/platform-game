local World = {
	bodies = {
		roof = {
			w = 300,
			h = 50
		},
		ground = {
			w = 300,
			h = 50
		}
	},
	instance = {}
}

function World:load()
	local world = love.physics.newWorld(0, 9.81*64, true)

	self.bodies.ground.body = love.physics.newBody(world, 400/2, 500-self.bodies.ground.h/2, 'static')
	self.bodies.ground.shape = love.physics.newRectangleShape(self.bodies.ground.w, self.bodies.ground.h)
	self.bodies.ground.fixture = love.physics.newFixture(self.bodies.ground.body, self.bodies.ground.shape)

	self.bodies.roof.body = love.physics.newBody(world, 400/2, 100-self.bodies.roof.h/2, 'static')
	self.bodies.roof.shape = love.physics.newRectangleShape(self.bodies.roof.w, self.bodies.roof.h)
	self.bodies.roof.fixture = love.physics.newFixture(self.bodies.roof.body, self.bodies.roof.shape)

	self.instance = world
end

function World:update(dt)
	self.instance:update(dt)
end

function World:draw()
	love.graphics.setColor(1,0.5,0.3)

	for _,body in pairs(self.bodies) do
		love.graphics.polygon('fill', body.body:getWorldPoints(body.shape:getPoints()))
	end
end

function World:get_bodies_position()
	local bodies = {}

	for k,body in pairs(self.bodies) do
		bodies[k] = {}

		bodies[k].body = body.body

		bodies[k].w, bodies[k].h = body.w, body.h
		bodies[k].x, bodies[k].y = body.body:getPosition()
	end

	return bodies
end

return World
