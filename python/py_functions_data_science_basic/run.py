# https://data36.com/python-built-in-functions-methods-python-data-science-basics-3/

# The most important built-in Python functions for data projects
a = "Data Science"
print(str(len(a)))

# returns the absolute value of a numeric value (e.g. integer or float)
rv = abs(-4/3) # 1.333333
print(str(rv))
# returns the rounded value of a numeric value.
rv = round(-4/3) # -1
print(str(rv))
# returns the smallest item of a list or of the typed-in arguments
rv = min([10,15,2]) # 2
print(str(rv))
rv = min("a", "b", "c") # a
print(str(rv))
# max()
# sorts a list into ascending order
rv = [12,5,6,9]
result = sorted(rv)
print(result)
# sums a list
rv = [5,12,8]
result = sum(rv)
print(result)

rv = [5.33,12.44,8.78]
result = sum(rv)
print(result)
# returns the type of the variable
rv = True
result = type(rv)
print(result)

# The most important built-in Python methods
