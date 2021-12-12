class String
    def upper?
        self == self.upcase
    end
end

nodes = {}

File.foreach("day12.in") { |line| 
    edge = line.strip().split("-")
    nodes[edge[0]] ? nodes[edge[0]].append(edge[1]) : nodes[edge[0]] = [edge[1]]
    nodes[edge[1]] ? nodes[edge[1]].append(edge[0]) : nodes[edge[1]] = [edge[0]]
}

totalPaths = 0
stack = [["start", [], false]]
while not stack.empty?
    nxt = stack.pop
    
    node = nxt[0]
    visited = nxt[1].dup
    duped = nxt[2]

    visited.append(node)
    edges = nodes[node] || []

    for n in edges
        next if n == "start"
        if n == "end" then
            totalPaths += 1
            next
        end
        if n.upper? 
            stack.append([n, visited, duped])
        elsif not duped or not visited.include?(n)
            stack.append([n, visited, (duped or visited.include?(n))])
        end
    end
end

puts totalPaths
