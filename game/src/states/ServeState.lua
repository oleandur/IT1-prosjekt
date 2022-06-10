--[[
    GD50
    Breakout Remake

    -- ServeState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The state in which we are waiting to serve the ball; here, we are
    basically just moving the paddle left and right with the ball until we
    press Enter, though everything in the actual game now should render in
    preparation for the serve, including our current health and score, as
    well as the level we're on.
]]

ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
    self.paddle = params.paddle
    self.health = params.health
    self.score = params.score
    self.gameMode =params.gameMode
    
    self.ball = Ball(1)
    
end

function ServeState:update(dt)

    self.paddle:update(dt)
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

    if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('return') then
        
        gStateMachine:change('play', {
            paddle = self.paddle,
            health = self.health,
            score = self.score,
            ball = self.ball,
            gameMode =self.gameMode
        })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function ServeState:render()
    self.paddle:render()
    self.ball:render()


    renderScore(self.score)
    renderHealth(self.health)

    love.graphics.setFont(gFonts['large'])

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to serve!', 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
end