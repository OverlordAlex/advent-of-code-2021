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
~~Dyalog APL~~
~~05AB1E~~
~~Lua~~
~~D~~
BASIC
Raku? (was Perl)
Smalltalk
Ballerina ?
Scala
Modula-3 ?

#### Used once or twice
~~SWI-Prolog~~
~~F#~~
~~Ruby~~
Nim
Javascript
Go
Dart
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

## Day 6 - Dyalog APL (https://www.dyalog.com/)
An APL based language was actually very interesting to use! I think I was just too dumb to get loops working - the syntax described online (and even in the IDE) straight up didn't work for me. Just imagine the 256 lines in the middle are instead wrapped in a :Repeat block. No ways I will use a pure APL flavour in the future - verbose commands > terse code pages.

Solving the problem essentially tested array rotation, which is what made an array-based language so natural to use. I had some precision problems with large numbers so setting the floating point precision higher as well as the printing size to avoid scientific notation.

Seems like you cant run Dyalog through the command line? At least it was easy to install and the IDE symbol explenations are pretty great. Error messages totally unhelpful.

    To run: open Dyalog, copy-paste the command block in,
      make sure to pass input like:
        input←1,1,1,2,1,5,1...
--------

## Day 7 - 05AB1E (https://github.com/Adriandmen/05AB1E)
A stack-based golfing language, it's still in active use which means the operations chosen were modern, and input/output are treated way better than some of the other languages. Overall I enjoyed this more than Dyalog, and I think it was due to the intuitive nature of the stack over the array, as well as a much more sensible code page.

It was important to recognise the mathematical operators in the problem - median, mean, and the triangle numbers. All of these are natively built into 05AB1E making the challenge a breeze. One trouble I had which was with my solution logic, is that I was unsure whether to use floor, ceil, or round - I got different results with the example input and my own input.

I did not attempt to run 05AB1E locally since the instructions looked too daunting for just AoC, but I instead used https://tio.run/#osabie. It worked flawlessly (once I figured out that the default is LEGACY 05AB1E, switching to the mainstream version solved everything).

    Go to Try It Online (https://tio.run/#osabie)
    Copy the code into the `Code` section
    Copy input into the `Input` section, and wrap it as an array (`[..]`)
--------

## Day 8 - TBD
Attempting Curry

xxx

xxx

    curry
--------

## Day 9 - Lua (https://www.lua.org/)
Lua actually turned out pretty cool; I liked the table data structure (except for lacking a coherent length function, and the 1-indexing). Another thing was a lack of "continue" statement. Otherwise a very easy language to use and I regret avoiding it when doing game programming as a kid.

I think this is the first day where I could use my solution from part1 to kickstart part2. I had to do some stringyfying to get the table to work as a hashmap/set correctly, however it was still _blazingly_ fast. I didn't want to temp the memory management gods so I went with managing the "stack" myself. 

Lua was trivial to install, and the documentation is actually really great!

    $ lua day9.lua
--------

## Day 10 - F#  (https://fsharp.org/)
F-sharp remains my favourite functional language by a country mile. It's got the right mix of first class functions, types, and pattern matching that is really a joy to write. For my imperitive background it just makes sense.

The only hiccup I had was putting functions below their first reference, a big nono the compiler complained about. Also had to crib a string reverse function from a blog post. Part2 got me with integer overflow, again. Still waiting for a warning from some language about this.

Installing F# was easy - it's still a relatively modern language that just required .Net (annoying, but eh)

    $ dotnet fsi day10.fsx
--------

## Day 11 - D (https://dlang.org/)
D actually turned out to be kind of cool. I like the alias functionality and the autotyping (which remains strict). The only minor gripe is the semi-colon line endings. Passing structs around felt cool.

Overall I felt like I could have been more functional. I also avoided using pointers which made it much less efficient, but it was at least still fast. Part2 should have been done with a while-loop, but I was lazy and the interations were low.

Another modern language that was a breeze to install and run. Documentation is also amazing. Google was the WORST for this - no google, "Dlang" should *not* be corrected to "golang".

    $ dmd -run day11.d
--------

## Day 12 - Ruby (https://www.ruby-lang.org/)
I enjoy Ruby about as much as Python. After some of the more terse languages it felt almost _too_ verbose, but I think it's met the stated goal of a natural syntax that's easy to read.

Shadowing the string class to add a new method was nice to do, however the declaration scares me as there was no indication that I was overriding a type... I also felt the lack of an elvis operator, even though I liked the -if and -unless syntax.

Ruby came pre-installed, albeit not the latest (as is tradition). Probably the easiest to write and run so far.

    $ ruby day12.rb
--------

