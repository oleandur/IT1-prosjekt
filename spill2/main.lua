push = require 'push'

Class = require 'class'

require 'Skudd'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


SPEED = 200
SKUDD_SPEED = 400

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Firkant')
    smallFont = love.graphics.newFont('font.ttf', 12)

    math.randomseed(os.time())

    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
    })
    FirY = VIRTUAL_HEIGHT / 2 - 2
    FirX = VIRTUAL_WIDTH / 2 - 2

    circleY = FirY + 10
    circleX = FirX + 10
    radius = 0
    
    skudd = Skudd(FirX, FirY, 5, 5)
    skudd2 = Skudd(FirX+ 10, FirY+ 10, 5, 5)
    skudd.x = FirX
    skudd.y = FirY


    gameStateMain = 'start'
    gameState3 = 'ikkeSkyt'
end



function love.update(dt)
    circleX = FirX + 10
    circleY = FirY + 10
    if gameStateMain == 'shoot' then
        if gameState2 == 'left' then
            skudd.x = skudd.x + -SKUDD_SPEED*dt
        end
        if gameState2 == 'right' then
            skudd.x = skudd.x + SKUDD_SPEED*dt
        end
        if gameState2 == 'up' then
            skudd.y = skudd.y+ -SKUDD_SPEED*dt
        end
        if gameState2 == 'down' then
            skudd.y = skudd.y + SKUDD_SPEED*dt
        end
    
    end
    if gameState3 == 'skyt2' then
        if gameState2 == 'left' then
            skudd2.x = skudd2.x + -SKUDD_SPEED*dt
        end
        if gameState2 == 'right' then
            skudd2.x = skudd2.x + SKUDD_SPEED*dt
        end
        if gameState2 == 'up' then
            skudd2.y = skudd2.y+ -SKUDD_SPEED*dt
        end
        if gameState2 == 'down' then
            skudd2.y = skudd2.y + SKUDD_SPEED*dt
        end
    end
    if gameStateMain == 'start' then
        skudd2.x = FirX + 20
        skudd2.y = FirY + 10
        skudd.x = FirX + 30
        skudd.y = FirY + 10
    end


    if love.keyboard.isDown('w') then
        FirY = FirY + -SPEED * dt
    elseif love.keyboard.isDown('s') then
        FirY= FirY + SPEED * dt
    end

    if love.keyboard.isDown('a') then
        FirX = FirX + -SPEED * dt
    elseif love.keyboard.isDown('d') then

        FirX=FirX + SPEED * dt
    end
    love.keyboard.keysPressed = {}
    if gameState == 'circle' then
        radius = math.min(100  , radius + SPEED/4 * dt)
    end
    if gameState == 'circleReverse' then
        radius = math.max(-100,radius +-SPEED/4 * dt)
    end

    if gameState == 'circleReversePlus' then
        radius = math.max(0, radius +-SPEED/3 *dt)
    
    
    elseif gameState =='circleReverseMinus' then
        radius = math.min(0, radius+SPEED/3 *dt)
    end

    if FirX < 0 then
        FirX = VIRTUAL_WIDTH
    elseif FirX > VIRTUAL_WIDTH then
        FirX = 0
    end
    if FirY < 0 then
        FirY = VIRTUAL_HEIGHT
    elseif FirY > VIRTUAL_HEIGHT then
        FirY = 0
    end

end

function love.keypressed(key)
    if gameStateMain == 'start' then
        
        if key == 'a' then 
            gameState2 ='left'
    

        elseif key == 'd' then 
            gameState2 ='right'
    

        elseif key == 'w' then 
            gameState2 ='up'
    

        elseif key == 's' then 
            gameState2 ='down'
        end
    end 
    if key == 'p' then
        gameStateMain = 'start'
    end
    if key == 'escape' then
        love.event.quit()
        
    end

    if key == 'lshift' then
        gameState = 'circle'
    end 
    if key == 'space' then
        gameStateMain = 'shoot'
        gameState3 = 'skyt2'
    end
    if key == 'enter' or key == 'return' then
        gameState = 'circleReverse'
    end

    if key =='backspace' then
        if gameState == 'circle' then
            gameState = 'circleReversePlus'
        elseif gameState == 'circleReverse' then
            gameState = 'circleReverseMinus'
        end
    end
end


function love.draw()

    push:start()

    love.graphics.clear(20, 20, 20, 20)
    
    
    love.graphics.setFont(smallFont)
    
    
    love.graphics.rectangle('fill', FirX, FirY, 20, 20)
    love.graphics.printf('Yeah Firkant', 0, 50, VIRTUAL_WIDTH, 'center')
    love.graphics.circle('line',circleX, circleY, radius)
    skudd:render()
    skudd2:render()
    
    push:finish()
end

