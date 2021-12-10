open System.IO
let readLines (filePath: string) = seq {
    use sr = new StreamReader (filePath)
    while not sr.EndOfStream do
        yield sr.ReadLine ()
}

let bracketEval (bracket: char) =
    match bracket with
    | ')' -> 3
    | ']' -> 57
    | '}' -> 1197
    | '>' -> 25137
    | _ -> 0

let bracketMatch (bracket: char) =
    match bracket with
    | '(' -> ')'
    | '[' -> ']'
    | '{' -> '}'
    | '<' -> '>'
    | _ -> ' '

let compEval (bracket: char): float =
    match bracket with
    | ')' -> 1
    | ']' -> 2
    | '}' -> 3
    | '>' -> 4
    | _ -> 0

let rec compilerEval (outstanding: string) (score: float): float =
    match outstanding with
    | "" -> score
    | _ -> 
        compilerEval outstanding.[1..] (5.0 * score + (compEval outstanding.[0]))
        

// stolen from somewhere online
open System
let reverse (s : string) = s |> Seq.toArray |> Array.rev |> System.String

let rec processBrackets (brackets: string) (outstanding: string) : float =
    match brackets with
    //part 1 | "" -> 0
    | "" -> compilerEval (reverse outstanding) 0
    | _ ->
        let br = bracketMatch(brackets.[0]) 
        match br with
        | ' ' -> // it's closing bracket!
            let closing = brackets.[0]
            if closing = outstanding.[outstanding.Length - 1] 
            then processBrackets brackets.[1..] outstanding[..(outstanding.Length - 2)]
            //part 1 else bracketEval closing
            else -1
        | closing -> processBrackets brackets.[1..] (outstanding + string closing)

let processLine (brackets: string) =
    processBrackets brackets ""

//part 1 let result: float = readLines "day10.in" |> Seq.map processLine |> Seq.sum
let result: list<float> = readLines "day10.in" |> Seq.map processLine |> Seq.sort |> Seq.filter (fun x -> x >= 0) |> Seq.toList
// part 2
printfn "%f" result.[result.Length / 2] 

