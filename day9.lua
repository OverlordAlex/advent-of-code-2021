file = io.open("day9.in", "r")
data = {}
for line in file:lines() do
    local l = {}
    for i = 0, #line do
        l[i] = line:sub(i,i)
    end
    table.insert (data, l)
end

function isLow (row, col) 
    local curr = data[row][col]
    -- top
    if row > 1 then
        if data[row-1][col] <= curr then
            return false
        end
    end
    -- bottom
    if row < #data then
        if data[row + 1][col] <= curr then
            return false
        end
    end
    -- left
    if col > 1 then
        if data[row][col - 1] <= curr then
            return false
        end
    end
    -- right
    if col < #data[1] then
        if data[row][col + 1] <= curr then
            return false
        end
    end
    return true
end

seen = {}
todo = {}
risk = 0

for r = 1, #data do
    for c = 1, #data[1] do
        if isLow(r, c) then
            table.insert (todo, {row = r, col = c})
            risk = risk + 1 + data[r][c]
        end
    end
end
print(risk)

function getTableSize(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end

sizes = {}
stack = {}
while #todo > 0 do
    start = table.remove (todo)
    seen = {}
    biggest = 1
    table.insert (stack, {row = start.row, col = start.col})
    while #stack > 0 do
        nxt = table.remove (stack)
        if not seen[nxt.row .. ":" .. nxt.col] then
            if not (data[nxt.row][nxt.col] == "9") then
            seen[nxt.row .. ":" .. nxt.col] = true
                -- add the neighbours
                if nxt.row > 1 then
                    table.insert (stack, {row = nxt.row - 1, col = nxt.col})
                end
                if nxt.row < #data then
                    table.insert (stack, {row = nxt.row + 1, col = nxt.col})
                end
                if nxt.col > 1 then
                    table.insert (stack, {row = nxt.row, col = nxt.col - 1})
                end
                if nxt.col < #data[1] then
                    table.insert (stack, {row = nxt.row, col = nxt.col + 1})
                end
            end
        end
    end
    table.insert (sizes, getTableSize(seen))
end
table.sort (sizes)
print(sizes[#sizes] * sizes[#sizes-1] * sizes[#sizes-2])
