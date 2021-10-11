(*
Christian Henry, Chris Tullier
04/12/21
CSC 330 - 001
Spring '21'
Project 1
*)

(*
Christian Henry: Made check_next function to see if there was a char coming up.
Chris Tullier: Developed lex function that read file and printed out string.
Both were involved in making the two recursion functions. 
*)

(* Main lex function *)
fun lex(file_name) =
    let
        val instream = TextIO.openIn(file_name)
        val myString = ""
        val myList = []

        (* Function that checks if there is a char coming up | option -> bool *)
        fun check_next(SOME x) = if ord(x) >= 65 andalso ord(x) <= 122 then true else false
            | check_next(NONE) = false

        (* Function that takes value and evaulates its value based on ascii | option -> str *)
        fun tok(SOME x) =
            if ord(x) >= 65 andalso ord(x) <= 122 then
                if check_next(TextIO.lookahead(instream)) = true then
                    str(x)^tok(TextIO.input1(instream))
                else
                    str(x)
            else if ord(x) = 42 orelse ord(x) = 43 orelse ord(x) = 45 orelse ord(x) = 47 orelse ord(x) = 61 orelse ord(x) = 32 then
                str(x)
            else
                "#"

            | tok(NONE) = ""

        (* Function that checks string value and inserts into list | str -> (str * str) list *)
        fun tup(x) = if x <> ""  orelse x = " " then (*Try adding a boolen parameter to show if a number has been inserted yet or not .. then in the big else part address it .. if false then return empty list, if true return regular the intended list*)
            if x = "#" then [("error", "unreconized input")] else
                if x = "+" then [(x, "PL")]@tup(tok(TextIO.input1(instream))) else
                    if x = "-" then [(x, "MI")]@tup(tok(TextIO.input1(instream))) else
                        if x = "*" then [(x, "TI")]@tup(tok(TextIO.input1(instream))) else
                            if x = "/" then [(x, "DI")]@tup(tok(TextIO.input1(instream))) else
                                if x = "=" then [(x, "EQ")]@tup(tok(TextIO.input1(instream))) else
                                    if x = " " then []@tup(tok(TextIO.input1(instream))) else
                                    [(x, "ID")]@tup(tok(TextIO.input1(instream)))
            else
                []
    in
        tup(tok(TextIO.input1(instream)))
    end;
