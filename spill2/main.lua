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
    smallFont = love.graphics.newFont('font.ttf', 8)

    math.randomseed(os.time())

    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
    })

    FirY = VIRTUAL_HEIGHT / 2 - 2
    FirX = VIRTUAL_WIDTH / 2 - 2
    Fir2Y = math.random(0, VIRTUAL_HEIGHT/2)
    Fir2X = math.random(0, VIRTUAL_WIDTH / 2)

    circleY = FirY + 10
    circleX = FirX + 10
    radius = 0
    


    gameStateMain = 'start'
end



function love.update(dt)
    circleX = FirX + 10
    circleY = FirY + 10

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

    if love.keyboard.isDown('up') then
        Fir2Y = Fir2Y + -SPEED * dt
    elseif love.keyboard.isDown('down') then
        Fir2Y= Fir2Y + SPEED * dt
    end

    if love.keyboard.isDown('left') then
        Fir2X = Fir2X + -SPEED * dt
    elseif love.keyboard.isDown('right') then

        Fir2X=Fir2X + SPEED * dt
    end

    if gameState == 'circle' then
        radius = math.min(50  , radius + SPEED/4 * dt)
    end
    if gameState == 'circleReverse' then
        radius = math.max(-50,radius +-SPEED/4 * dt)
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

    if Fir2X < 0 then
        Fir2X = VIRTUAL_WIDTH
    elseif Fir2X > VIRTUAL_WIDTH then
        Fir2X = 0
    end
    if Fir2Y < 0 then
        Fir2Y = VIRTUAL_HEIGHT
    elseif Fir2Y > VIRTUAL_HEIGHT then
        Fir2Y = 0
    end
end

function love.keypressed(key)
    
        
        if key == 'a' then 
            gameState2 ='left'
    

        elseif key == 'd' then 
            gameState2 ='right'
    

        elseif key == 'w' then 
            gameState2 ='up'
    

        elseif key == 's' then 
            gameState2 ='down'
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

    love.graphics.clear(40, 40, 40, 255)
    
    
    love.graphics.setFont(smallFont)
    
    love.graphics.circle('line',circleX, circleY, radius)
    love.graphics.rectangle('fill', FirX, FirY, 20, 20)
    love.graphics.rectangle('fill', Fir2X, Fir2Y, 10, 10)
    love.graphics.printf('Yeah Firkant', 0, 50, VIRTUAL_WIDTH, 'center')
    
    
    push:finish()
end

