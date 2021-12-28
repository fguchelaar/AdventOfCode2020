# 19 [Monster Messages] 

Creating a regular expression is rather simple for part 1. 

Part 2 gave some extra challenge, especially for the rewriting of rule 11.

```
8: 42 | 42 8
11: 42 31 | 42 11 31
``` 

Rule 8 is basically just a `(42)+`, but rule 11 now has to have an even count for `{42}{31}`; ie: `{42}{42}{42}{31}{31}{31}`.

I dont' really now if this is expressibel in regex, therefor just gobbled together just enough cases for the solution to work:

```
( 42 {!} 31 {!} | 42 {@} 31 {@} | 42 {#} 31 {#} | 42 {$} 31 {$} | 42 {%} 31 {%} | 42 {^} 31 {^} )
``` 

*nb:*: the !, @, #, $, % and ^ are later replaced by 1, 2 , 3, 4, 5 and 6.

Hacky, but effective.
