import urllib.parse
inp = input()
print(inp)
rv = urllib.parse.quote(inp, safe='')
print(rv)