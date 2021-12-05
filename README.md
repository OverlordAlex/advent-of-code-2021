# Advent Of Code 2021
Doing advent of code in different languages.

> Advent of Code is an Advent calendar of small programming puzzles for a variety of skill sets and skill levels that can be solved in any programming language you like. https://adventofcode.com/2021/

For each language I'll be posting my thoughts about
* The language in general
* How much more difficult the language made the task
* Installation, and compilation/interpretation experience

### Possible languages
#### New
~~4tran~~
~~COBOL~~
~~Julia~~
BASIC
Lua
Raku? (was Perl)
Smalltalk
Ballerina ?
Scala
Modula-3 ?

#### Used once or twice
~~SWI-Prolog~~
Nim
F#
Javascript
Go
Dart
Ruby
PHP
Swift
Rust
Haskell

#### Familiar
~~AWK~~
Python2.7/3.10 
Bash
Java/Kotlin/Groovy
C

## Day 1 - Fortran (https://gcc.gnu.org/wiki/GFortran)
Wait, I have to leave 6 spaces at the start of lines because of PUNCH CARDS. How quaint! Absolutely delightful! I'm not sure why I'm so charmed by this. Oh gosh comments start with a 'c' in the first column?? I might come back to this language later...

Fortran doesn't have dynamic memory (go figure), so we really have to stream the file. The question is pretty easy, however Fortran was surprisingly easy to use!

Installing gfortran on a mac was awful, but only because it required xcode, and xcode required a whole new OS upgrade. Once installed compiling and running was a breeze.

    $ gfortran day1.f -o day1.out && ./day1.out

--------

## Day 2 - AWK (https://www.gnu.org/software/gawk/manual/gawk.html)
AWK is super straightforward. I first used it in university and I recall writing rather complex stream processing programs. It's a lot more powerful than what people normally use it for day to day

The problem is a perfect match for AWK - it's pattern matching and then stream processing. Absolutly trivial

No installation necessary, AWK is a corelib and I weep for any system that neglects to include it. /insert GNU+Linux copy-pasta here

    $ awk -f day2.awk day2.in
---------

## Day 3 - COBOL (https://gnucobol.sourceforge.io/)
COBOL was not as fun as Fortran. Same punch card origins but the syntax felt so much worse... so much more... business. I see now that it's reputation may be deserved...

Problem was a bit tricky - I hit some infinite loops because my counter was 1 digit instead of 2, so that was fun. Part2 was even harder - rather than figure out functions and/or pointers I just copy-pasted the code. I also managed to hit a SIGBUS which is actually new for me!

With gnuCOBOL it was easy to install using homebrew, and incridbly easy to compile and run

    $ cobc -x day3.cob -o day3.out && ./day3.out
--------

## Day 4 - Julia (https://julialang.org/)
Julia felt like it was trying to be both type-safe while still being flexible, and it ended up doing neither very well. Variable scoping feels inconsistent and weird. The language itself feels like a patchwork of idioms and at no point did I feel like I was writing idiomatic Julia, however looking on StackOverflow I could tell what was elegant and what 95% of people (incl. myself) were writing.

I chose Julia because I seemed to recall all my data-processing friends loved it for how it handled arrays, and it did okay. I still struggled with the subscripting feeling inconsistent, and the types being difficult to wrangle when working in multiple dimensions. However by the end I found a rythym and fortunately Part2 was trivial.

It's always nice when the brew-install just works (looking at you Factor). Running it was a breeze, and the interpreter was _generally_ helpful.

    $ julia day4.jl
--------

## Day 5 - SWI-Prolog (https://www.swi-prolog.org/)
Not much to say about Prolog. I found it a lot easier than I remember. It's another language where I found that I wrote imperitive code more than taking advantage of the language. I was also surprised at how slow tail recursion ended up being - the first solution ran out of memory (1GB) and the second solution took a good 20 minutes to complete part2.

Overall the problem itself was fairly straightforward, but I did feel like I missed having a hashmap. I'm particularly proud of my "zip" function. In fact the "helper" functions felt great to write and were a joy. As mentioned the only problem was the runtime of building a list of only duplicates. There's probably a more elegant solution.

SWI-Prolog can't be praised enough for making Prolog easy to get into, run, and use. Slight pain getting to run to/from file without dropping into an interpreter though.

    $ swipl -g main -t halt day5.pl
--------

