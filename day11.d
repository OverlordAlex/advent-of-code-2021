import std.array, std.algorithm, std.stdio, std.file, std.conv;
alias grid = int[10][10];

int[10] parseLine(char[] line) {
    int[10] output;
    foreach(i, chr; line) {
        output[i] = to!int(to!string(chr));
    }
    return output;
}

grid pop(long r, long c, grid data) {
    foreach (row; r-1 .. r+2) {
        if (row < 0) continue;
        if (row > 9) continue; 
        foreach (col; c-1 .. c+2) {
            if (col < 0) continue;
            if (col > 9) continue;
            if (data[row][col] != 0) {
                data[row][col] += 1;
            }
        }
    }
    data[r][c] = 0;
    return data;
}

grid increase(grid data) {
    foreach (i, row; data) {
        data[i] = row[] += 1;
    }
    return data;
}

struct Point {
    long row;
    long col;
}
struct PointList {
    int length;
    Point[100] points;

    void add(long row, long col) {
        this.points[length++] = Point(row, col);
    }
}
PointList findNextPops(grid data) {
    PointList result;
    foreach (r, row; data) {
        foreach (c, num; row) {
            if (num > 9) {
                result.add(r, c);
            }
        }
    }
    return result;
}
bool allZero(grid data) {
    foreach (row; data) {
        foreach (pos; row) {
            if (pos != 0) return false;
        }
    }
    return true;
}

struct StepPair {
    grid data;
    int flashes;
}
StepPair doStep(grid data) {
    auto next = increase(data);
    auto popList = findNextPops(next);
    int flashes;
    while (popList.length > 0) {
        foreach (i; 0 .. popList.length) {
            auto point = popList.points[i];
            next = pop(point.row, point.col, next);
        }

        flashes += popList.length;
        popList = findNextPops(next);
    }

    return StepPair(next, flashes);
}

void main()
{
    auto file = File("day11.in");
    scope(exit) file.close();
    
    grid data = file.byLine().map!(parseLine).array;
        
    StepPair next = doStep(data);
    int totalFlashes = next.flashes;
    foreach (i; 1..300) {
        next = doStep(next.data);
        totalFlashes += next.flashes;

        if (allZero(next.data)) {
            writeln("Part2: ", i+1);
            break;
        }
    }
    writeln("Part1: ", totalFlashes);
}
