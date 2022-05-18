firkant = Class{}



function firkant:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.dy = 0
    self.dx = 0
end

function firkant:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    
end