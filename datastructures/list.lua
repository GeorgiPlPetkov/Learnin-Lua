---@class List
local list = {}
list.__index = list

list.count = -1


---@param array table? table used as an array
---@return List
function list.new(array)
    local new_list = setmetatable({}, list)

    new_list.count = 0

    if array then
        for index, value in ipairs(array) do
            new_list[index] = value
        end

        new_list.count = #array
    end

    return new_list
end

---@param value any
function list:add(value)
    self.count = self.count + 1

    self[self.count] = value
end

---@param range table table used as an array
function list:add_range(range)
    for index, value in ipairs(range) do
        self[self.count + index] = value
    end

    self.count = self.count + #range
end

---@param element any
---@return integer index of the element or -1
function list:contains(element)
    for index, value in ipairs(self) do
        if element == value then
            return index
        end
    end

    return -1
end

function list:remove()
    if self.count < 1 then
        return
    end

    self[self.count] = nil

    self.count = self.count - 1
end

function list:remove_at(index)
    if self.count < index or self.count < 1 then
        return
    end

    for li = index, self.count - 1 do
        self[li] = self[li + 1]
    end

    self[self.count] = nil
    self.count = self.count - 1
end

-- under constructions 
function list:remove_range(starting_index, number_of_elements)
    if not (self.count > 0
        and starting_index >= 0 and starting_index <= self.count
        and number_of_elements > 0
        and starting_index + number_of_elements - 1 <= self.count) then
        return
    end

    local range_end_index = starting_index + number_of_elements
    local number_of_leftover_values = self.count - range_end_index
    if number_of_leftover_values >= 0 then
        for index_offset = 0, number_of_leftover_values, 1 do
            self[starting_index + index_offset] = self[range_end_index + index_offset]
        end

        starting_index = range_end_index + 1
        number_of_elements = number_of_leftover_values
    end
    print("start:"..starting_index, "steps:"..number_of_elements)
    for index_offset = 0, number_of_elements - 1, 1 do
        self[starting_index + index_offset] = nil
    end

    self.count = self.count - number_of_elements
end

function list:clear()
    for index = 1, self.count, 1 do
        self[index] = nil
    end

    self.count = 0
end

local arr = {3, 2, 1}
local lt = list.new(arr)
--lt:add_range(arr)
lt:remove_range(1, 2)
for index, value in ipairs(lt) do
    print("["..index.."] "..value)
end

print("Count: "..lt.count)

