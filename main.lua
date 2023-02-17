local world = require('world')
local player = require('player')

-- local rope = {}

function love.load()
	world:load()
	player:load(world.instanceof)

	-- rope = love.physics.newRopeJoint(player.body, world.roof.body, player.x, player.y, 500, 100, 200, true)
end

function love.update(dt)
	player:update(dt)
	world:update(dt)
end

function love.draw()
	world:draw()
	player:draw()

	-- love.graphics.setColor(1,0,0)
	-- love.graphics.line(rope:getAnchors())
	-- love.graphics.setColor(1,1,1)
end
