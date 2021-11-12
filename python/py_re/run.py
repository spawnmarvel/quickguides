# https://docs.python.org/3/library/re.html
# https://www.programiz.com/python-programming/regex
# RegEx is a sequence of characters that defines a search pattern

import re
p_tag = "10ETR0301/Y/PRIM"
i_tag = ""

# all function names is bad in this case, they are just a name palce holder for the sections form the docs
def a_5():
    count = 0
    a_5_pattern = "^a...s$"
    list = ["abs", "alias", "abyss", "Alias", "An abacus"]
    for l in list:
        rv = re.match(a_5_pattern, l)
        # match returns true or none
        if rv:
            print("match " + l)
            count +=1
        else:
            print("na match ")
    print(count)


a_5()
