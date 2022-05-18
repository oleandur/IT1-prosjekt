
push = require 'push'

WINDOW_WIDTH = 480
WINDOW_HEIGHT = 480




function love.load()

	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

	player = {
		grid_x = 0,
		grid_y = 0,
		act_x = 0,
		act_y = 0,
	}
	map = {
		{ 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 1, 0, 1, 0, 1, 0, 1, 0 },
		{ 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 1, 0, 1, 0, 1, 0, 1, 0 },
		{ 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 1, 0, 1, 0, 1, 0, 1, 0 },
		{ 0, 1, 0, 1, 0, 1, 0, 1 },
		{ 1, 0, 1, 0, 1, 0, 1, 0 }

	}
	gameState = 'start'
	
end

function love.update(dt) 
	
end

function love.keypressed(key) 
	if key == 'enter' or key == 'return'then 
		gameState = 'play'
	end
	
end
function love.draw()
	love.graphics.setBackgroundColor(100, 100, 0, 100)
	for y=1, #map do
		for x=1, #map[y] do
			if map[y][x] == 0 then
				love.graphics.setColor(255,255,255,255)
				love.graphics.rectangle("fill", x * 48, y * 48, 48, 48)
			elseif map[y][x] == 1 then
				love.graphics.setColor(0,0,0,255)
				love.graphics.rectangle("fill", x * 48, y * 48, 48, 48)	
			end
		end
	end
	if gameState == 'start' then 
		love.graphics.printf('Press Enter to begin!', 0, 20, WINDOW_WIDTH, 'center')
	
	elseif gameState == 'play' then 
		
	end
end


