function love.conf(t)
    -- where you save data
    t.identity = "data/saves"
    -- The LÖVE version this game was made for (string)
    t.version = "11.4"
    t.window.title = "Game of life"
    t.window.width = 500
    t.window.height = 500
    t.window.icon = "icon/gficon.png"
end