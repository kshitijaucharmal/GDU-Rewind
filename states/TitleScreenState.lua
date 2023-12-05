Class = require 'libraries/class'
TitleScreenState = Class { __includes = BaseState }

button_width = virtual_WIDTH / 3
button_height = 32
local buttons = {}

local function next()
    for i, button in ipairs(buttons) do
        if (button.selected) then
            button.selected = false
            selectNo = i
            return selectNo
        end
    end
end

local function newButton(text, fn, selected)
    return {
        text = text,
        fn = fn,
        selected = selected,
    }
end

function TitleScreenState:init()
    table.insert(buttons, newButton(
        "Start Game",
        function()
            gStateMachine:change("level1")
        end,
        true
    ))

    table.insert(buttons, newButton(
        "Settings",
        function()
            print("Settings")
        end,
        false
    ))

    table.insert(buttons, newButton(
        "Quit",
        function()
            love.event.quit(0)
        end,
        false
    ))
end

function TitleScreenState:update(dt)

end

function TitleScreenState:draw()
    local margin = 20
    local total_height = (button_height + margin) * #buttons

    local cursor_y = 0

    for i, button in ipairs(buttons) do
        local bx = virtual_WIDTH / 2 - button_width / 2
        local by = virtual_HEIGHT / 2 - button_height / 2 - total_height / 2 + cursor_y
        local color = { 0.4, 0.4, 0.5, 1.0 }

        local mx, my = love.mouse.getPosition()
        local hovered = mx > bx and mx < bx + button_width and
            my > by and my < by + button_height

        if hovered then
            color = { 0.8, 0.8, 0.9, 1.0 }
        end

        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hovered then
            button.fn()
        end

        button.last = button.now
        if button.selected then
            love.graphics.setColor(1, 0.4, 0.5, 1.0)
            love.graphics.rectangle(
                "fill",
                bx - 5,
                by - 5,
                button_width + 10,
                button_height + 10
            )
        end
        love.graphics.setColor(unpack(color))
        love.graphics.rectangle(
            "fill",
            bx,
            by,
            button_width,
            button_height
        )

        cursor_y = cursor_y + (button_height + margin)

        local font = love.graphics.newFont(14)

        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)

        love.graphics.setColor(0, 0, 0, 1)
        love.graphics.print(
            button.text,
            font,
            virtual_WIDTH / 2 - textW / 2,
            by + textH / 2
        )
    end
end

function TitleScreenState:check_keypressed(key)
    if key == "down" then
        selectNo = next()
        print(selectNo)
        buttons[(selectNo) % #buttons + 1].selected = true
    end

    if key == "return" then
        for i, button in ipairs(buttons) do
            if (button.selected) then
                button.fn()
            end
        end
    end

    -- if key == "up" then
    --     selectNo = next()
    --     print(selectNo)
    --     buttons[-1*((selectNo) % #buttons-1)].selected = true
    -- end
end
