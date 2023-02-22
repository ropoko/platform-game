local world = require('world')
local player = require('player')

function love.load()
	love.window.setMode(800,600)

	world:load()
	player:load(world.instance)
end

function love.update(dt)
	player:update(dt)
	world:update(dt)
end

function love.draw()
	world:draw()
	player:draw()
end
