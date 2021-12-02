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
COBOL ?
BASIC
Julia
Lua
Raku? (was Perl)
Smalltalk
Ballerina ?
Scala
Modula-3 ?

#### Used once or twice
Prolog
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
Python2.7/3.10 
Bash
~~AWK~~
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

