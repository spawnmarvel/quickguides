print("\n 1 Python’s dict lets you perform all the dictionary operations listed at the beginning of this section: \n")

glossary = {"BDLF": "Benevolent Dictator For Life"}
glossary["GIL"] = "Global Interpreter Lock" # Add
glossary["BDLF"] = "Guido van Rossum" # Update
# del glossary # Delete
check = glossary["BDLF"] # Search

def search_dict(word):
    if check:
        return check
    else:
        return None

search = search_dict(check)
print(search)
print(glossary)