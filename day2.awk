# Part 1 -> simple matching and parsing
#BEGIN {
#    depth = 0
#    poz = 0
#}
#/forward/ { poz += $2 }
#/down/ { depth += $2 }
#/up/ { depth -= $2 }
#END {
#    print "depth " depth
#    print "poz " poz
#    print depth * poz
#}

# Part 2 -> Still simple matching. Liking the stream processing so far 
BEGIN {
    poz = 0
    depth = 0
    aim = 0
}
/down/ { aim += $2 }
/up/ { aim -= $2 }
/forward/ { 
    poz += $2
    depth += aim * $2
}
END {
    print "aim " aim
    print "depth " depth
    print "poz " poz
    print depth * poz
}
