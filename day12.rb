class String
    def upper?
        self == self.upcase
    end
end

nodes = {}

File.foreach("day12.in") { |line| 
    edge = line.strip().split("-")
    if nodes[edge[0]] then
        nodes[edge[0]].append(edge[1]) 
    else
        nodes[edge[0]] = [edge[1]]
    end

    if nodes[edge[1]] then
        nodes[edge[1]].append(edge[0]) 
    else
        nodes[edge[1]] = [edge[0]]
    end
}

totalPaths = 0
stack = [["start", Array.new]]
while not stack.empty?
    # puts "stack: #{stack}"
    nxt = stack.pop
    # puts "next: #{nxt}"
    node = nxt[0]
    if node == "end" then
        totalPaths += 1
        next
    end

    visited = nxt[1].dup
    visited.append(node)
    # puts "seen: #{visited}"

    edges = nodes[node] || []
    # puts "edges: #{edges} from #{nodes}"
    for n in edges
        if n == "end" then
            # puts "path! #{visited}"
            totalPaths += 1
            next
        end
        if n.upper? or not visited.include?(n)
            # puts "adding #{[n, visited]}"
            stack.append([n, visited])
        end
    end
    # puts "------------"
end

puts totalPaths
