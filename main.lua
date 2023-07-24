_G.love = require("love")


local cellSize = 1
local gridWidth, gridHeight = 500, 500
local grid = {}

function initializeGrid()
    for x = 1, gridWidth do
        grid[x] = {}
        for y = 1, gridHeight do
            grid[x][y] = math.random() > 0.7 and 1 or 0 -- Initialize with some random live cells
        end
    end
end

function countAliveNeighbors(x, y)
    local count = 0
    for dx = -1, 1 do
        for dy = -1, 1 do
            if dx ~= 0 or dy ~= 0 then
                local nx, ny = x + dx, y + dy
                if nx >= 1 and nx <= gridWidth and ny >= 1 and ny <= gridHeight then
                    count = count + grid[nx][ny]
                end
            end
        end
    end
    return count
end

function updateGrid()
    local newGrid = {}
    for x = 1, gridWidth do
        newGrid[x] = {}
        for y = 1, gridHeight do
            local aliveNeighbors = countAliveNeighbors(x, y)
            if grid[x][y] == 1 then
                newGrid[x][y] = (aliveNeighbors == 2 or aliveNeighbors == 3) and 1 or 0
            else
                newGrid[x][y] = (aliveNeighbors == 3) and 1 or 0
            end
        end
    end
    grid = newGrid
end


function love.load()
    initializeGrid()
end
function love.update(dt)
    if love.keyboard.isDown('r') then
        initializeGrid()
    end

    updateGrid()
end

function love.draw()
    for x = 1, gridWidth do
        for y = 1, gridHeight do
            if grid[x][y] == 1 then
                love.graphics.setColor(1, 1, 1)
                love.graphics.rectangle('fill', (x - 1) * cellSize, (y - 1) * cellSize, cellSize, cellSize)
            end
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Press 'r' to reset", 10, love.graphics.getHeight() - 30)
end