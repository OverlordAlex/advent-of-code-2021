lines = open("day4.in", "r") do file
  readlines(file)
end

global calls = parse.(Int, split(lines[1], ","))
global cards = Vector{BitMatrix}()
global cardCount = 0
global numberHash = Dict()
global origCards = Vector{Vector{Vector{Int64}}}()

let i = 3
    while i < length(lines)
        global cardCount += 1
        card = map(x -> parse.(Int, split(x)), lines[i:i+4])
        push!(origCards, card)
        for (row_idx, row) in enumerate(card)
            for (col_idx, val) in enumerate(row)
                positions = pop!(numberHash, val, Vector())
                push!(positions, (cardCount, row_idx, col_idx))
                numberHash[val] = positions
            end
        end

        push!(cards, falses(5,5))
        i += 6
    end
end

function checkwin(card::BitMatrix, row::Int64, col::Int64, call)::Bool
    rowc = count(x -> x==1, card[row, :])
    colc = count(x -> x==1, card[:,col])
    if rowc == 5 || colc == 5 
      return true
    end
    false
end

global wins = Set()
while !isempty(calls)
  call = popfirst!(calls)
  tups = numberHash[call]
  for (card, row_idx, col_idx) in numberHash[call]
    cards[card][row_idx, col_idx] = 1
    if !(card in wins) && checkwin(cards[card], row_idx, col_idx, call)
        push!(wins, card)
        if length(wins) != cardCount
            continue
        end
        total = 0
        for r = 1:5
            for c = 1:5
                if cards[card][r,c] == 0
                    total += origCards[card][r][c] 
                end
            end
        end
        result = call * total
        println("call $call * total $total = $result")
        return
    end
  end
end
