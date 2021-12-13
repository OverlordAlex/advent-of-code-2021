<?php

$coords = array();
$folds = array();

$fileHandle = fopen("day13.in", "r");

// read coordinates
while (($line = fgets($fileHandle)) !== "\n") {
    preg_match('/([0-9]+),([0-9]+)/', $line, $coord);
    $coords[] = [intval($coord[1]), intval($coord[2])];
}

// read folds
while (($line = fgets($fileHandle)) !== false) {
    preg_match('/fold along ([xy])=([0-9]+)/', $line, $fold);
    $folds[] = [$fold[1], intval($fold[2])]; 
}

fclose($fileHandle);

// do one fold
function foldPaper($axis, $value, &$coords) {
    if ($axis == "x") {
        foreach ($coords as &$coord) {
            if ($coord[0] > $value) {
                $coord = [$coord[0] - 2*($coord[0]-$value), $coord[1]];
            }
        }
    } else {
        foreach ($coords as &$coord) {
            if ($coord[1] > $value) {
                $coord = [$coord[0], $coord[1] - 2*($coord[1]-$value)];
            }
        }
    }
}

foreach ($folds as $fold) {
    foldPaper($fold[0], $fold[1], $coords);
    $coords = array_unique($coords, SORT_REGULAR);
}

// Part 1
// echo count($coords)."\n";

function bounds($coords) {
    $maxX = 0;
    $maxY = 0;
    foreach ($coords as $coord) {
       $maxX = ($coord[0] > $maxX) ? $coord[0] : $maxX;
       $maxY = ($coord[1] > $maxY) ? $coord[1] : $maxY;
    }
    return [$maxX+1, $maxY+1];
}
$bounds = bounds($coords);
$grid = array_fill(0, $bounds[1], array_fill(0, $bounds[0], "."));
foreach ($coords as $coord) {
    $grid[$coord[1]][$coord[0]] = "#";
}
foreach ($grid as $row) {
    echo implode("", $row)."\n";
}
?>
