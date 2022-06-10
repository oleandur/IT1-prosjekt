--[[
    GD50
    Breakout Remake

    -- GameOverState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The state in which we've lost all of our health and get our score displayed to us. Should
    transition to the EnterHighScore state if we exceeded one of our stored high scores, else back
    to the StartState.
]]

VictoryState = Class{__includes = BaseState}

function VictoryState:enter(params)
    self.score = params.score
end

function VictoryState:update(dt)
     --[[ if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end  ]]

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function VictoryState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('YOU WON', 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Final Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
    --[[ love.graphics.printf('Press Enter!', 0, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center') ]]
end