push = require 'push'

Class = require 'class'

require 'Skudd'
require 'firkant'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 480
VIRTUAL_HEIGHT = 270


SPEED = 200
SKUDD_SPEED = 200





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
    FirY = VIRTUAL_HEIGHT -20
    FirX = VIRTUAL_WIDTH / 2 - 2
    firkant.width = 20
    firkant.height = 20
    firkant = firkant(FirX,FirY, firkant.width, firkant.height)
    
    skudd = Skudd(FirX, FirY, 5, 5)
    skudd.x = FirX
    skudd.y = FirY


    gameState = 'start'

end



function love.update(dt)
   


    if love.keyboard.isDown("space") then
        gameState = "skyt"
        
    end
    
    if gameState == 'skyt' then
        skudd.y = skudd.y + -SKUDD_SPEED*dt
    end
    if gameState== 'start' then
        skudd.x = firkant.x
    end




    if love.keyboard.isDown('a') then
        firkant.x = firkant.x + -SPEED * dt
    elseif love.keyboard.isDown('d') then

        firkant.x = firkant.x + SPEED * dt
    end

    if firkant.x < 0 then
        firkant.x = 0
    elseif firkant.x > VIRTUAL_WIDTH - 20 then
        firkant.x = VIRTUAL_WIDTH - 20
    end


end

function love.keypressed(key)

    if key == 'p' then
        gameState = 'start'
    end
    if key == 'escape' then
        love.event.quit()
        
    end

end


function love.draw()

    push:start()

    love.graphics.clear(50, 50, 50, 200)
    
    
    love.graphics.setFont(smallFont)

    love.graphics.setColor(0, 0, 200, 200)
    skudd:render()
    firkant:render()
    love.graphics.setColor(50, 100, 255, 200)
    love.graphics.printf('Spill', 0, 50, VIRTUAL_WIDTH, 'center')

    
    push:finish()
end

