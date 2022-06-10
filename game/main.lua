
push = require "lib/push"
Class = require "lib/class"
Timer = require 'lib/knife.timer'

require 'src.states.BaseState'
require 'src.states.GameOverState'
require 'src.states.StartState'
require 'src.states.PlayState'
require 'src.StateMachine'
require 'src.Paddle'
require 'src.Util'
require 'src.Ball'
require 'src.states.VictoryState'
require 'src.states.ServeState'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200


function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('ZARK')
    

    math.randomseed(os.time())

    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
        ['cool'] = love.graphics.newFont('fonts/BlakaHollow-Regular.ttf',48),
        ['coolmedium'] = love.graphics.newFont('fonts/BlakaHollow-Regular.ttf', 16),
        ['coolsmall'] = love.graphics.newFont('fonts/BlakaHollow-Regular.ttf', 8),
        ['inter'] = love.graphics.newFont('fonts/Inter-VariableFont_slnt,wght.ttf', 8)
    }
    
    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['serve'] = function() return ServeState() end,
        ['game-over'] = function() return GameOverState() end,
        ['victory'] = function() return VictoryState() end
    }
    gStateMachine:change('start')


    gTextures = {
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['main'] = love.graphics.newImage('graphics/models.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png')
    }

    
    gFrames = {
        ['balls'] = GenerateQuadsBalls(gTextures['main']),
        ['paddles'] = GenerateQuadsPaddles(gTextures['main']),
        ['hearts'] = GenerateQuads(gTextures['hearts'], 10, 9)
    }
    
    gStateMachine:change('start', {
        score = 0,
        gameMode = 'normal'
    })

    love.keyboard.keysPressed = {}

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)

    gStateMachine:update(dt)

end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.draw()
    push:apply('start')

    local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    love.graphics.draw(gTextures['background'], 
        -- draw at coordinates 0, 0
        0, 0, 
        -- no rotation
        0,
        -- scale factors on X and Y axis so it fills the screen
        VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))

    gStateMachine:render()
    
    -- display FPS for debugging; simply comment out to remove
    displayFPS()
    
    
    push:apply('end')
    
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end

function renderScore(score)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Score:', (VIRTUAL_WIDTH /2)-20, 5)
    love.graphics.printf(tostring(score), VIRTUAL_WIDTH /2, 5, 40, 'center')
end

function renderHealth(health)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('HP:', (VIRTUAL_WIDTH -60), 5)
    love.graphics.printf(tostring(health), VIRTUAL_WIDTH-60, 5, 40, 'right')
end
