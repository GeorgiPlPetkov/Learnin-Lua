---@class Queue
local queue= {}
queue.__index = queue

queue.first = -1
queue.last = -1
queue.size = -1
queue.count = -1

---@param size integer
---@param array? table
---@return Queue
function queue.new(size, array)
    local new_queue = setmetatable({}, queue)

    new_queue.first = 0
    new_queue.last = 0
    new_queue.size = size
    new_queue.count = 0

    if array then
        for index = 1, new_queue.size, 1 do
            new_queue[index] = array[index]
        end

        new_queue.first = 1
        new_queue.last = #array
    end

    return new_queue
end

---@param value any
function queue:enqueue(value)
    if self.count >= self.size then
        return
    end

    self.last = self.last + 1
    if self.last > self.size then
        self.last = 1
    end
    if self.first == 0 then
        self.first = 1
    end

    self.count = self.count + 1
    self[self.last] = value
end

---@return any
function queue:dequeue()
    if self.count < 1 then
        return nil
    end

    local result = self[self.first]
    self[self.first] = nil
    self.first = self.first + 1

    if self.first > self.size then
        self.first = 1
    end

    if self.first - 1 == self.last then
        self.first = 0
        self.last = 0
    end

    self.count = self.count - 1
    return result
end

function queue:peek()
    if self.first < 1 then
        return nil
    end

    return self[self.first]
end