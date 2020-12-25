# 18 Operation Order

For part 2 I was thinking about writing an actual evaluator that respects the 
requested order of precedence, but then decided to reuse part 1. So I placed all 
addition-subexpressions in parentheses; 'faking the order of precedence'.

A potential improvement, could be to first remove all whitespace for the 
expression. That simplifies the code and make the solution more robust: 
additional whitespace currently breaks...

➕➖✖️➗
