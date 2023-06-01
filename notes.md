1.  interactivity is not possible in BASH, with strings as return value. 

    There are workarounds in this case. 

    1. You can return numbers with newly defined set of rules that will work as hash codes. 
    2. You can use a global helper variable. 

    The first one is minimal but overly complex. The second one creates some weird rules. 
    But the 2nd rule can be generalized with introducing some conventions.

    To achieve the 2nd goal, you can introduce a global variable $RETURN_VALUE, which will
    store the return value of the last called function. In this case, it will be the same 
    as passing reference in C, and using void function to manipulate the dereferenced
    variable's value.