PlayState = Class{__includes = BaseState}

function PlayState:init()
    degrees = 0
    velocity = 0
    click = 0
    threshold = 1
    lastVelocity = 0
    speedingUp = false
    TEXT_OFFSET = 80
    rAlphaVelocity = 85
    gAlphaVelocity = 40
    rOpacity = 0
    gOpacity = 0
    gModifier = 0
    gMod = 0
    mouseIsDown = false
end

function PlayState:update(dt)
    if love.mouse.isDown(1) then
        mouseIsDown = true
    end
    if not love.mouse.isDown(1) then
        mouseIsDown = false
    end

    if velocity > 0 then
        lastVelocity = velocity
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
    if love.keyboard.isDown('space') or mouseIsDown then
           velocity = math.min(velocity + .2, 19)
           degrees = math.floor((degrees + velocity) % 360)
    else
        velocity = math.max(velocity - .1, 0)
        degrees = math.floor((degrees + velocity) % 360)
    end

    radians = degrees * (math.pi/180)

    if velocity > lastVelocity then
        speedingUp = true
    elseif velocity == 19 then
        speedingUp = true
        if rOpacity >= 255 then
            rOpacity = 255
        end
        if gOpacity >= 255 then
            gOpacity = 255
        end
    else
        speedingUp = false
    end

    if speedingUp then
        gModifier = math.min(30, gModifier + dt * 12)
        gMod = math.floor(gModifier)
        gOpacity = math.min(80, gOpacity + (dt * gAlphaVelocity))
    elseif not speedingUp then
        gModifier = math.max(0, gModifier - dt * 40)
        gMod = math.floor(gModifier)
        gOpacity = math.max(0, gOpacity - (dt * gAlphaVelocity))
    end

    if velocity == 0 then
        gMod = 0
    end


end

function PlayState:render()
	love.graphics.clear(115/255, 110/255, 255/255, 255/255)
    love.graphics.draw(wheel3, VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, radians, 1, 1, 154, 155)
    love.graphics.draw(arrow, 232, -40, 0, 0.3, 0.3)

    --[[
--    love.graphics.print('degrees: ' .. tostring(degrees), 5, 5)
--    love.graphics.print('velocity: ' .. tostring(velocity), 5, 5 + TEXT_OFFSET)
 --   love.graphics.print('lastVelocity: ' .. tostring(lastVelocity), 5, 5 + TEXT_OFFSET * 2)
    love.graphics.print('speedingUp: ' .. tostring(speedingUp), 5, 5 + TEXT_OFFSET * 3)
    love.graphics.print('click: ' .. tostring(click), 5, 5 + TEXT_OFFSET * 4)
    love.graphics.print('threshold: ' .. tostring(threshold), 5, 5 + TEXT_OFFSET * 5)
    love.graphics.print('gOpacity: ' .. tostring(gOpacity), 5, 5 + TEXT_OFFSET * 6)
    love.graphics.print('gMod: ' .. tostring(gMod), 5, 5 + TEXT_OFFSET * 7)
    love.graphics.print('gIncreasing: ' .. tostring(gIncreasing), 5, 5 + TEXT_OFFSET * 8)
    love.graphics.print('mouseIsDown: ' .. tostring(mouseIsDown), 5, 5 + TEXT_OFFSET * 9)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5 + TEXT_OFFSET * 10)
    love.graphics.print('width: ' .. tostring(love.graphics.getWidth()), 5, 5 + TEXT_OFFSET)
    love.graphics.print('height: ' .. tostring(love.graphics.getHeight()), 5, 5 + TEXT_OFFSET * 2)
    --]]
--[[
    love.graphics.setColor(0/255, 255/255, 0/255, (gOpacity + gMod)/255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
--[[
    love.graphics.setColor(0/255, 255/255, 0/255, gOpacity/255)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    --]]
    --]]
end

