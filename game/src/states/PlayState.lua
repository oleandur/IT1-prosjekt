--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}




function PlayState:init()
    self.paddle = Paddle()

    -- initialize ball with skin #1; different skins = different sprites
    self.ball = Ball(1)

    -- give ball random starting velocity
    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    -- give ball position in the center
    self.ball.x = VIRTUAL_WIDTH / 2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42

    self.score = 0
end

function PlayState:update(dt)
   --[[  if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        
        return
    end ]]
    


    
    --[[ if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            
        else
            return
        end    
    
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        return
    end ]]
    --[[ if love.keyboard.wasPressed('space') then
        if self.paused == true then
            return 
        else
            self.paused = true
        end
    end ]]

    -- update positions based on velocity
    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:collides(self.paddle) then
        -- raise ball above paddle in case it goes below it, then reverse dy
            if self.ball.x - 4 > self.paddle.x -8 then
                self.ball.dx = 50 + (4*math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
            elseif self.ball.x + 4 < self.paddle.x then
                self.ball.dx = -50 - (4*math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
            end

        if self.ball.y - 4 > self.paddle.y - 8 then
            self.ball.dy = 50 + (4*math.abs(self.paddle.y + self.paddle.width / 2 - self.ball.y))
        
        elseif self.ball.y + 4 < self.paddle.y + 8 then
            self.ball.dy = -50 - (4*math.abs(self.paddle.y + self.paddle.width / 2 - self.ball.y))
        end
        self.score = self.score + 20
    end



    if self.score >= 1000 then
        gStateMachine:change('game-over', {
            score = self.score })
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    self.paddle:render()
    self.ball:render()

    renderScore(self.score)
    
    --[[ if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end ]]
end