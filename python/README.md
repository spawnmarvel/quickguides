# quickguides
quickguides, markdown, nutshell reference

https://www.python.org/dev/peps/pep-0008/

https://realpython.com/python-pep8/#naming-styles


| Type | Description | Example |
| ---- | ----------- | ------- |
| Function | Use a lowercase word or words. Separate words by underscores to improve readability | function, my_function |
| Variable | Use a lowercase single letter, word, or words. Separate words with underscores to improve readability | x, var, my_variable
| Class | Start each word with a capital letter. Do not separate words with underscores. This style is called camel case | Model, MyClass
| Method | Use a lowercase word or words. Separate words with underscores to improve readability | class_method, method
| Constant | Use an uppercase single letter, word, or words. Separate words with underscores to improve readability | CONSTANT, MY_CONSTANT, MY_LONG_CONSTANT
| Module | Use a short, lowercase word or words. Separate words with underscores to improve readability | module.py, my_module.py
| Package | Use a short, lowercase word or words. Do not separate words with underscores | package, mypackage


https://stackoverflow.com/questions/14000762/what-does-low-in-coupling-and-high-in-cohesion-mean

## Loose coupling:

Loose coupling: Among different classes/modules should be minimal dependency.

Low coupling suggest that class should have least possible dependencies. 
Also, dependencies that must exist should be weak dependencies - prefer dependency on interface rather than dependency on concrete class, 
prefer composition over inheritance 

Coupling refers to the degree to which the different modules/classes depend on each other, 
it is suggested that all modules should be independent as far as possible, that's why low coupling. 
It has to do with the elements among different modules/classes.

## High cohesion:

High cohesion: Elements within one class/module should functionally belong together and do one particular thing.

In software design high cohesion means that class should do one thing and one thing very well.

Cohesion refers to the degree to which the elements of a module/class belong together, 
it is suggested that the related code should be close to each other, 
so we should strive for high cohesion and bind all related code together as close as possible. 
It has to do with the elements within the module/class.

https://dzone.com/articles/software-design-principles-dry-and-kiss

## The DRY Principle: Don't Repeat Yourself

DRY stand for "Don't Repeat Yourself," a basic principle of software development aimed at reducing repetition of information. 
DRY principle is stated as, "Every piece of knowledge or logic must have a single, unambiguous representation within a system."

How to Achieve DRY

To avoid violating the DRY principle, divide your system into pieces. Divide your code and logic into smaller 
reusable units and use that code by calling it where you want. Don't write lengthy methods, but divide logic 
and try to use the existing piece in your method.
DRY Benefits

Less code is good: It saves time and effort, is easy to maintain, and also reduces the chances of bugs.

One good example of the DRY principle is the helper class in enterprise libraries, 
in which every piece of code is unique in the libraries and helper classes.

## KISS: Keep It Simple, Stupid

The KISS principle is descriptive to keep the code simple and clear, making it easy to understand. 
After all, programming languages are for humans to understand ??? computers can only understand 0 and 1 ??? 
so keep coding simple and straightforward. Keep your methods small. Each method should never be more than 40-50 lines.

Each method should only solve one small problem, not many use cases. If you have a lot of conditions in the method, 
break these out into smaller methods. It will not only be easier to read and maintain, but it can help find bugs a lot faster.