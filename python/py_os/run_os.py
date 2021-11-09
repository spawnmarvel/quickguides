import os

print(os.name) # nt win

print(os.environ) # The os.environ value is known as a mapping object that returns a dictionary of the user’s environmental variables.
print(os.environ["OS"])
print(os.environ["TMP"])
dom = os.environ["USERDOMAIN"]
if dom == "MYTECH":
    print("MYTECH is is..")
else:
    print("Warning domain not found..")

# You could also use the os.getenv function to access this environmental variable:
# lsvirtualenv
print(os.getenv("aenv"))

cur = os.getcwd()
print(cur)
chg = os.chdir(r"C:\Users\jekl\AppData\Local\Temp")
cur = os.getcwd()
print(cur)

# os.mkdir() and os.makedirs()
# os.remove() and os.rmdir()
# os.rename(src, dst)
# os.startfile()

path = (r"c:\giti2021")
for root, dirs, files in os.walk(path):
    print(root)

# os.path


