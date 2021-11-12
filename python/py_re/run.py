# https://docs.python.org/3/library/re.html
# https://www.programiz.com/python-programming/regex
# RegEx is a sequence of characters that defines a search pattern

import re

# all function names is bad in this case, they are just a name palce holder for the sections form the docs
def a_5():
    count = 0
    print("Pattern start * * :")
    # any five letter string starting with a and ending with s
    pattern = "^a...s$"
    print("Pattern - - - - - -  > " + pattern)
    list = ["abs", "alias", "abyss", "Alias", "An abacus"]
    for idx, val in enumerate(list):
        rv = re.match(pattern, val)
        # match returns true or none
        if rv:
            print("Match at " + str(idx) + " " + val)
            count +=1
        else:
            pass
            # print("na match ")
    print("Match vs list: " + str(count) + " ; " + str(len(list)))
    print("Pattern end * *  :")
    

a_5()

# Regular expression
# To specify regular expressions, metacharacters are used
# [] . ^ $ * + ? {} () \ |

def square_bra():
    count = 0
    print("Pattern start * *  :")
    # will match if the string you are trying to match contains any of the a, b or c.
    pattern = "[abc]"
    # [a-e] is the same as [abcde].
    # [1-4] is the same as [1234].
    # [0-39] is the same as [01239].
    # (invert)
    # [^abc] means any character except a or b or c.
    # [^0-9] means any non-digit character.
    print("Pattern - - - - - -  > " + pattern)
    list = ["a", "ac", "ac", "Hey Jude", "abc de ca"]
    for idx, val in enumerate(list):
        rv = re.match(pattern, val)
        # match returns true or none
        if rv:
            print("Match at " + str(idx) + " " + val)
            count +=1
        else:
            pass
            # print("na match ")
    print("Match vs list: " + str(count) + " ; " + str(len(list)))
    print("Pattern end * *  :")


square_bra()

def dot_or_periode():
    count = 0
    print("Pattern start * * :")
    # A period matches any single character (except newline '\n').
    pattern = ".."
    print("Pattern - - - - - -  > " + pattern)
    list = ["a", "ac", "ac", "acd" , "acde"]
    for idx, val in enumerate(list):
        rv = re.match(pattern, val)
        # match returns true or none
        if rv:
            print("Match at " + str(idx) + " " + val)
            count +=1
        else:
            pass
            # print("na match ")
    print("Match vs list: " + str(count) + " ; " + str(len(list)))
    print("Pattern end * * :")

dot_or_periode()

def caret():
    count = 0
    print("Pattern start * * :")
    # The caret symbol ^ is used to check if a string starts with a certain character.
    pattern = "^ac"
    print("Pattern - - - - - -  > " + pattern)
    list = ["a", "ac", "bac", "acd" , "acde"]
    for idx, val in enumerate(list):
        rv = re.match(pattern, val)
        # match returns true or none
        if rv:
            print("Match at " + str(idx) + " " + val)
            count +=1
        else:
            pass
            # print("na match ")
    print("Match vs list: " + str(count) + " ; " + str(len(list)))
    print("Pattern end * * :")

caret()


def dollar():
    count = 0
    print("Pattern start * * :")
    # The dollar symbol $ is used to check if a string ends with a certain character.
    pattern = "^a$"
    print("Pattern - - - - - -  > " + pattern)
    list = ["a", "ac", "bac", "acd" , "acde"]
    for idx, val in enumerate(list):
        rv = re.match(pattern, val)
        # match returns true or none
        if rv:
            print("Match at " + str(idx) + " " + val)
            count +=1
        else:
            pass
            # print("na match ")
    print("Match vs list: " + str(count) + " ; " + str(len(list)))
    print("Pattern end * * :")

dollar()

def star():
    count = 0
    print("Pattern start * * :")
    # The star symbol * matches zero or more occurrences of the pattern left to it.
    pattern = "ma*n"
    print("Pattern - - - - - -  > " + pattern)
    list = ["mn", "man", "maan", "main" , "ama", "amani"]
    for idx, val in enumerate(list):
        rv = re.match(pattern, val)
        # match returns true or none
        if rv:
            print("Match at " + str(idx) + " " + val)
            count +=1
        else:
            pass
            # print("na match ")
    print("Match vs list: " + str(count) + " ; " + str(len(list)))
    print("Pattern end * * :")

star()