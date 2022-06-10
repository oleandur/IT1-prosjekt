--[[
    GD50
    Breakout Remake

    -- StartState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state the game is in when we've just started; should
    simply display "Breakout" in large text, as well as a message to press
    Enter to begin.
]]

-- the "__includes" bit here means we're going to inherit all of the methods
-- that BaseState has, so it will have empty versions of all StateMachine methods
-- even if we don't override them ourselves; handy to avoid superfluous code!
StartState = Class{__includes = BaseState}

-- whether we're highlighting "Start" or "High Scores"
local highlighted = 0

function StartState:update(dt)
    if love.keyboard.wasPressed('down') then
        highlighted = 1 
    end
    if love.keyboard.wasPressed('u') then
        self.gameMode = 'unlimited'
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        

        if highlighted == 1 then
            gStateMachine:change('serve', {
                paddle = Paddle(),
                health = 9,
                score = 0,
                gameMode = self.gameMode
                
            })
        end
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    -- title
    love.graphics.setFont(gFonts['cool'])
    
    love.graphics.setColor(255, 255, 255, 255)
    
    
    love.graphics.printf("ZARK", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.print(('Press U to play with unlimited score'), VIRTUAL_WIDTH/3, VIRTUAL_HEIGHT - 20) 
    
    love.graphics.setColor(150,150,150,255)
    love.graphics.setFont(gFonts['coolmedium'])
    -- if we're highlighting 1, render that option blue
    if highlighted == 1 then
        love.graphics.setColor(0, 150, 250, 255)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70,
        VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(150, 150, 150, 255)

    
end