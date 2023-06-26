PlayState = Class{__includes = BaseState}

function PlayState:init()
    degrees = 0
    velocity = 0
    click = 0
    threshold = 1
end

function PlayState:update(dt)
    if velocity > 0 then
        click = click + dt
        if velocity > 16 then
            threshold = .09
        elseif velocity > 11 then
            threshold = .2
        elseif velocity > 5 then
            threshold = .3
        elseif velocity > 3 then
            threshold = .5
        elseif velocity > 1 then
            threshold = .6
        end
    end

    if click > threshold then
        TEsound.play('sounds/click.mp3', 'static')
        click = 0
    end
    if love.keyboard.isDown('space') then
           velocity = math.min(velocity + .2, 19)
           degrees = math.floor((degrees + velocity) % 360)
    else
        velocity = math.max(velocity - .1, 0)
        degrees = math.floor((degrees + velocity) % 360)
    end

    radians = degrees * (math.pi/180)
end

function PlayState:render()
	love.graphics.clear(50/255, 50/255, 200/255, 255/255)
    love.graphics.draw(wheel, 960, 540, radians, 1, 1, 500, 500)
    love.graphics.draw(arrow, 835, -130)
    --[[
    love.graphics.print('degrees: ' .. tostring(degrees), 5, 5)
    love.graphics.print('velocity: ' .. tostring(velocity), 5, 80)
    love.graphics.print('click: ' .. tostring(click), 5, 150)
    love.graphics.print('threshold: ' .. tostring(threshold), 5, 250)
    --]]
end

