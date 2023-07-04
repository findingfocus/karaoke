push = require '/dependencies/push'
Class = require 'dependencies/class'

require '/dependencies/StateMachine'
require '/dependencies/BaseState'
require '/dependencies/tesound'

require '/states/PlayState'

WINDOW_WIDTH = 811
WINDOW_HEIGHT = 480

VIRTUAL_WIDTH = 811
VIRTUAL_HEIGHT = 480

--405x
--240y

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	love.window.setTitle('Karaoke Wheel')

	pixelFont = love.graphics.newFont('fonts/Pixel.ttf', 40)
	love.graphics.setFont(pixelFont)

    wheel = love.graphics.newImage('pics/wheel1.png')
    wheel2 = love.graphics.newImage('pics/wheel2.png')
    arrow = love.graphics.newImage('pics/arrow1.png')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = false,
		fullscreen = true,
		resizable = false
	})

	gStateMachine = StateMachine {
		['playState'] = function() return PlayState() end,
	}

	gStateMachine:change('playState')

	love.keyboard.keysPressed = {}
end

function love.resize(w, h)
	push:resize(w,h)
end

function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
	if key == 'escape' then
		love.event.quit()
	end
end

function love.keyboard.wasPressed(key)
	if love.keyboard.keysPressed[key] then
		return true
	else
		return false
	end
end

function love.update(dt)
	gStateMachine:update(dt)

	love.keyboard.keysPressed = {}

    TEsound.cleanup()
end



function love.draw()
	push:start()

	gStateMachine:render()

	displayFPS()

	push:finish()
end

function displayFPS()
	love.graphics.setFont(pixelFont)
	love.graphics.setColor(0/255, 255/255, 0/255, 255/255)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end
