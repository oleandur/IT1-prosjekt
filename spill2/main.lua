push = require 'push'

Class = require 'class'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720




SPEED = 800
SKUDD_SPEED = 400

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('SPILL')
    

    math.randomseed(os.time())

    
    push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true,
    })

    FirY = WINDOW_HEIGHT / 2 - 2
    FirX = WINDOW_WIDTH / 2 - 2
    Fir2Y = math.random(0, WINDOW_HEIGHT/2)
    Fir2X = math.random(0, WINDOW_WIDTH / 2)

    circleY = FirY + 30
    circleX = FirX + 30
    radius = 0
    radius2 = 20
    radius3 = 0

    
    gameStateMain = 'start'
end



function love.update(dt)
    
    if gameStateMain == "play" then
    circleX = FirX
    circleY = FirY 

    if radius2 == 100 then
        radius2 = math.max(20  , radius + -SPEED/4 * dt)
    else 
        radius2 = math.min(200  , radius + SPEED/4 * dt)
    end

    if FirX == Fir2X and FirY == Fir2X then
        radius2 = math.min(100, radius2 + SPEED * dt)
        radius3 = math.min(20, radius3 + SPEED /10 *dt)
        gameStateMain = 'start'
    end

    if love.keyboard.isDown('w') and love.keyboard.isDown('s') then
        
    elseif love.keyboard.isDown('w') then
        FirY = FirY + -SPEED * dt
    elseif love.keyboard.isDown('s') then
        FirY= FirY + SPEED * dt
    end

    if love.keyboard.isDown('d') and love.keyboard.isDown('a') then
        
    elseif love.keyboard.isDown('a') then
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
        FirX = WINDOW_WIDTH
    elseif FirX > WINDOW_WIDTH then
        FirX = 0
    end
    if FirY < 0 then
        FirY = WINDOW_HEIGHT
    elseif FirY > WINDOW_HEIGHT then
        FirY = 0
    end

    if Fir2X < 0 then
        Fir2X = WINDOW_WIDTH
    elseif Fir2X > WINDOW_WIDTH then
        Fir2X = 0
    end
    if Fir2Y < 0 then
        Fir2Y = WINDOW_HEIGHT
    elseif Fir2Y > WINDOW_HEIGHT then
        Fir2Y = 0
    end

    
    
end
end


function love.keypressed(key)
    
    if key == 'space' then
        gameStateMain = 'play'
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

    

    
    love.graphics.clear(155, 155, 155, 0)
    
    
    love.graphics.setNewFont(20)

    
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.circle('line',circleX, circleY, radius)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.arc('fill', FirX, FirY, 30, 80, 300, 5)
    love.graphics.circle('line', Fir2X, Fir2Y, radius2)
    love.graphics.arc("fill",Fir2X, Fir2Y, radius3, 30, 270, 6)
    
    if gameStateMain == 'start' then 
		love.graphics.printf('Press Space to begin', 0, 20, WINDOW_WIDTH, 'center')
    elseif gameStateMain == 'play' then
        
    end
    
end

