local world = require('world')
local player = require('player')

function love.load()
	world:load()
	player:load(world.instanceof)
end

function love.update(dt)
	player:update(dt)
	world:update(dt)
end

function love.draw()
	world:draw()
	player:draw()
end
