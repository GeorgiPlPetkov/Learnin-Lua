---@class Stack
local stack = {}
stack.__index = stack

stack.top = -1

---@param array table
---@return Stack
function stack.new(array)
    local new_stack = setmetatable({}, stack)

    new_stack.top = 0

    if array then
        for index, value in ipairs(array) do
            new_stack[index] = value
        end

        new_stack.top = #array
    end

    return new_stack
end

---@param value any
function stack:push(value)
    self.top = self.top + 1

    self[self.top] = value
end

---@return any result or -1
function stack:pop()
    if self.top < 1 then
        return nil
    end

    local result = self[self.top]
    self[self.top] = nil

    self.top = self.top - 1

    return result
end

---@return any
function stack:peek()
    if self.top < 1 then
        return nil
    end

    return self[self.top]
end