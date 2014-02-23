

# §6 --- Speaking Python

So far we have been talking to the shell, and our programs have been a sequence of commands that the shell has executed one after the other.  But there are many other languages we can talk to the computer ---assuming, that is, that we are running a program that understands them.

Python is a great language to learn.  Invented by [Guido van Rossum](http://en.wikipedia.org/wiki/Guido_van_Rossum) in the late 1980s, it has become extremely popular.  It emphasizes readability, making it simple to write programs that will be easy to read an understand by other programmers (including you, some months after you wrote the program).  It is clear, concise, and it runs pretty much everywhere.  It is often recommended as the best language to learn programming, but it is also a very powerful language: it runs many web sites, and it is the language of choice for many scientists and engineers.

I won't be able to give you a full account of Python.  My goal is to help you understand what programming in Python looks like, and how it is done in the context of the shell.   By the end of this chapter you'll have written and run a first Python program, and you'll be on your way to learning much more.

{#L410AC28C-9211-4B4B-A642-E7C4BCF155A2}
## Running Python


You can start playing with Python simply by running it:

{lang="sh"}
~~~~~~~~
python
~~~~~~~~

Now you are talking to Python.  In particular, the program you are talking to is called the Python interpreter, because it will interpret python commands as they arrive.  You'll see that the prompt is different than the one you got on the shell: by default, it will be `>>>`.  Let's explore a bit what you can ask python to do:

{lang="python"}
~~~~~~~~
232 + 345.0/14.0
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 256.642857143
A> ~~~~~~~~

{#LEFB46343-E073-4740-8012-15076EC87192}
## Functions in Python


Let's say we want to do something a bit more exciting: how much is 2 to the 34th power?  Python has a *function* to do that.  A function is a piece of code that will do something for you.  You call it by name, followed by the *arguments* to the function ---the values to which the function will be applied--- enclosed by parentheses.

For example, Python has a function called `pow` that will compute the power of two numbers for you.  You call it with two arguments: the number that you want to raise, and the number to which you want to raise.  So if you ask for this,

{lang="python"}
~~~~~~~~
pow(2, 34)
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 17179869184
A> ~~~~~~~~

you get {$$}2^{34}{/$$}.

How about a square root?  Python also has a function to do that, but it is not loaded by default.  In order to use it you first need to ask Python to import its `math` library,

{lang="python"}
~~~~~~~~
import math
~~~~~~~~

To start using the functions coming in the `math` library you need to prepend their name with `math.`, so that Python will know where to look for them.  You use them like this:

{lang="python"}
~~~~~~~~
math.sqrt(12) / math.cos(2 * math.pi)
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 3.46410161514
A> ~~~~~~~~

Note that we've also used `math.pi`.  This is not a function, but a variable that Python has preloaded for you with the value of {$$}\pi{/$$} with many decimals,

{lang="python"}
~~~~~~~~
math.pi
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 3.14159265359
A> ~~~~~~~~

{#L26D24CA5-A153-446F-9E05-C12B6868C05E}
## Variables in Python


You will have noticed that we didn't have to prepend the `math.pi` with a dollar sign, as we had to do when we wanted the value of shell variables.  Python is simpler in that way: you just assign a value to a name,

{lang="python"}
~~~~~~~~
diameter = 23.0
~~~~~~~~

then use the name of the variable wherever you would have used the value it contains,

{lang="python"}
~~~~~~~~
diameter * math.pi
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 72.2566310326
A> ~~~~~~~~

{#LBCB8154E-C098-4908-851F-C3D3BEA5359E}
## Defining your own functions


Python, like most languages, lets you define functions.  This one will compute the longitude of a circle given its diameter:

{lang="python"}
~~~~~~~~
def longitude_circle(diameter):
    return math.pi * diameter
~~~~~~~~

Write it down to the Python interpreter just as it is shown here, respecting the spaces before the second line, and do not forget the colon after the closing parenthesis of the first line.

Python is a bit peculiar with spaces at the beginning of lines: whenever a piece of code belongs to a higher instance, it has to be indented a fixed amount with respect to it.  In this case, the line implementing the function belongs to the function definition that started in the first line.  There is a colon at the end of the first line, saying "here comes my content", and then the content gets shifted to the right.  This rule ---forced indentations of blocks--- makes programs very readable.

Let's call the function, for example, with the diameter of the earth (12742 km, or 7918 miles):

{lang="python"}
~~~~~~~~
longitude_circle(12742)
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 40030.173592
A> ~~~~~~~~

When Python has seen `longitude_circle`, followed by something in parentheses, it has understood that you were calling a function.  It has searched among the functions it knows about (including the ones that are always available, like `pow`, the ones you might have imported, and the ones you might have defined, like `longitude_circle`), and has promptly found a definition for it.  It has checked that the number of arguments you are giving (one) matches the number of arguments that the definition of the function is expecting (one, named `diameter`), and it has started to run the function.

The first thing it has done is to create a new variable named `diameter`, and assign to it the value with which you are calling the function, `12742`.  With this it has done the math as you have defined it, and it has returned the result.

Let's do another example.  Say we want to know how long it would take to go around a circle at a given speed.  We can first compute the longitude, then divide by the speed:

{lang="python"}
~~~~~~~~
def time_to_circle(diameter, speed):
    length = math.pi * diameter
    return length / speed
~~~~~~~~

There's something ugly about this function.  Want to try to figure out what it is?

We've actually told Python how to compute the longitude of a circle *again*.  That is a bad idea.  In general, it's much better and safer to use the functions we've already defined: this is why we write them in the first place.  Check this out:

{lang="python"}
~~~~~~~~
def time_to_circle(diameter, speed):
    return longitude_circle(diameter) / speed
~~~~~~~~

Isn't it much better, and more readable?  Let's try it.  How may hours would it take to circle the earth at 120 km/h?

{lang="python"}
~~~~~~~~
time_to_circle(12742, 120)
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 333.584779934
A> ~~~~~~~~

Not bad, but how many days is that?

But wait again; I don't know about you, but I am getting tired of writing the diameter of the earth time and again, mostly because I don't remember it between one time and the next.  Let's make a variable for it,

{lang="python"}
~~~~~~~~
earth_diameter = 12742
~~~~~~~~

And now we compute the number of days, simply dividing by 24 the value returned by `time_to_circle`:

{lang="python"}
~~~~~~~~
time_to_circle(earth_diameter, 120) / 24.
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 13.8993658306
A> ~~~~~~~~

{#L680363FB-3440-43EA-BA7A-83C38D26E2F6}
## Exit Python: the end of file, `C-d`


When you are done interacting with Python you may exit the interpreter with `C-d` (press `d` while holding control).  The `C-d` is understood as an end-of-file marker not only by Python, but by all UNIX programs.  When you are talking to `python` it sees its input channel as something equivalent to an ever growing file: when you type a line and press Enter it is sent to `python` as another line in the never ending file, and executed.  When you press `C-d` it understands that the file-like object is is reading for input has finished, and exits.

{#L74EEE44B-F94A-4A0A-A66F-EACDDBB14F77}
## Writing a Python program


We can talk to Python one sentence at a time, as we have done until now, or we can write in a file all that we want Python to do and then ask it to do whatever the file says, as if we were writing a note with a list of instructions.  Let's open a file `circle.py`,

{lang="sh"}
~~~~~~~~
vi circle.py
~~~~~~~~

The `.py` is the traditional extension of Python programs.  Write your program in it, just as if you were writing directly to Python:

{lang="python"}
~~~~~~~~
import math

def longitude_circle(diameter):
    return math.pi * diameter

def time_to_circle(diameter, speed):
    return longitude(diameter) / speed

time_to_circle(1234, 23)
~~~~~~~~

Save and quit when you are done (remember, escape, then `:wq`).  Can you think how you'd actually run it?  Just as with the shell, you'd ask Python to do it:

{lang="sh"}
~~~~~~~~
python circle.py
~~~~~~~~

Nothing.  Python did indeed return the result of the `time_to_circle` function, but it stayed within Python.  And now you are not there, you are on the shell.  In order to ask Python to send the results to the outside world you need to `print` them.  Change the last line so that it says

{lang="python"}
~~~~~~~~
print time_to_circle(1234, 23)
~~~~~~~~

and now run again,

{lang="sh"}
~~~~~~~~
python circle.py
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 168.553275414
A> ~~~~~~~~

Much better.

{#L7B2F31F6-15BC-48D5-9218-B4AD1B311DC8}
## Command line arguments for your Python program


It is rather sad that the diameter and the speed are hard-coded.  If you want to run it with a different diameter you'll have to open the file, modify it, and save it before you are ready to run the program again.  There is, of course, a solution: you can send command line arguments to your Python program.

It's actually quite simple.  You need to `import sys`, and then you'll have access to the `sys.argv` variable.  This is a special kind of variable named *list*.  It can contain many elements that you access with an index enclosed in brackets: you find the first command-line argument in `sys.argv[1]`, the second in `sys.argv[2]`, and so forth.  Edit the program, and make it look like this:

{lang="python"}
~~~~~~~~
import math

def longitude_circle(diameter):
    return math.pi * diameter

def time_to_circle(diameter, speed):
    return longitude_circle(diameter) / speed

import sys
diameter = float(sys.argv[1])
speed = float(sys.argv[2])
print time_to_circle(diameter, speed)
~~~~~~~~

There is a catch, so let's follow it closely.  First we import `math`, because we know we'll need `math.pi`.  Next we define the functions.  So far it tracks exactly what we were doing when we were talking to Python real-time.  Then we import `sys`, because we want access to its `argv` variable.  But when we assign the values of the arguments, in `sys.argv[1]` and `sys.argv[2]`, to the `diameter` and `speed` variables, we are calling a previously unknown `float` function.

It turns out that Python makes a distinction between strings, which are pieces of text, and numbers.  The command-line arguments coming in `sys.argv` are strings, and we want to convert them to floating-point numbers.  This is what the `float` function does.

We are ready now to call the program with arguments:

{lang="sh"}
~~~~~~~~
python circle.py 1000 10
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 314.159265359
A> ~~~~~~~~

{#L79853D24-3545-43D3-AE2E-65202F601A6D}
## The shebang


So we've written a Python program, but we have to run it with an explicit call to `python`.  Shouldn't it be aware of who is the one who has to run it?  There is a trick to do just that.  Of course, the first thing to do is to make it [executable](#L75DC1ED6-8BD2-49C7-9BC9-C79E44F0C0C8), just as we did when the shell script when we wanted to run it by itself:

{lang="sh"}
~~~~~~~~
chmod +x circle.py
~~~~~~~~

Now when we try to run it the shell will open it.  If the first line it finds looks like this:

{lang="python"}
~~~~~~~~
#!/usr/bin/python
~~~~~~~~

it will strip the `#!` from the beginning, and it will understand that the rest, the `/usr/bin/python`, is the interpreter that will be able to run what's coming next.  If the `python` program in your system is actually residing in the `/usr/bin` directory everything will work fine.

How can you know where the `python` program is?  Use `which`,

{lang="sh"}
~~~~~~~~
which python
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> /usr/bin/python
A> ~~~~~~~~

Indeed; in my system, `python` lives in `/usr/bin`.  Which means that before, when I was running `python` in the command line, I could have typed `/usr/bin/python` just as well.  It also means that, if I add the `#!/usr/bin/python` ---called the *shebang* --- as the first line in the `circle.py` file, the shell will send all the other lines to `python`, who will be able to execute it.  Thus we can run, in the command line,

{lang=":results"}
~~~~~~~~
./circle.py 1 1
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 3.14159265359
A> ~~~~~~~~

{#LBC964101-741C-4982-B572-7D22F2669560}
## Programming Python


By now you have learned a great deal about the shell, and about the way it organizes and connects the many players in your computer.  But we have only scratched the surface of Python.  My goal was not to teach you the language, but to help you understand what a Python program is, and how it plays along with the rest of the world.

Python the language is beyond the scope of this book, but I do encourage you to go and learn more about it.  Knowing Python will greatly increase the types of problems that you can solve.  The other day, for example, one of my sons wanted to make a statistical analysis of the evolution of the length of songs over the last 100 years.  He found and downloaded a database that contained more than half a million songs, and he wrote a Python program that would read it, analyze it, and plot pretty graphs.  (In case you are wondering, he found that at the beginning of the seventies song length increased quite clearly, but was pretty much constant before and after.)

There's just no way you can tackle problems of this caliber without some knowledge of a programming environment (although, for this particular problem, [R](http://www.r-project.org) would have been a better choice; but he had to run with what he knew, which was good enough).

There are plenty of excellent resources online to learn Python.  One that we've used and found great is Udacity's [Intro to Computer Science](https://www.udacity.com/course/cs101).

{#L2F600A00-D1BF-407F-8E9C-FB7122B22027}
## Compiled languages and interpreted languages


When you were talking to Python, the `python` program was always an intermediary between you and the computer.  You ask for something in a language that you and Python understand, then `python` makes sure that it is translated into machine code ---the language that your computer actually understands--- and then run.  There translation to machine code is not free: you have to have `python` doing it, and it takes time and machine resources that you could be using to actually run your program.

Languages that do that ---stand between you and the computer, translating as you go--- are called interpreted languages.  This is usually not a problem.  For most programming tasks the performance that you get from Python is plenty enough, and the ease of use and convenience of being able to talk a directly to the interpreter more than makes up for the loss of speed.

In some cases, though, you need more performance than what an interpreted language like Python can give you.  The solution, then, is to write all or part of the program in a language that can be translated directly to machine code, thereby removing the need of an interpreter during the execution.  This translation to machine code is called *compilation*, and the king among compiled languages is C.

{#L8ECB802D-509B-4047-A4CC-512AF938CE0D}
### A little C program


Developed by [Dennis Ritchie](http://en.wikipedia.org/wiki/Dennis_Ritchie) in 1972 in order to write UNIX (which he also invented), C is a rather small language with which most of UNIX is written.  All the tools we've been talking about (including Python) are written in C.  The book [The C Programming Language](http://www.amazon.com/gp/product/0131103628/ref=as_li_ss_tl?ie=UTF8&camp=1789&creative=390957&creativeASIN=0131103628&linkCode=as2&tag=juanreyero-20)[^fn_disc] that Dennis Ritchie and Brian Kernighan wrote is one of the best computer science books ever, and one you should certainly read.

I will not try to teach you C in this book, but I want to give you a glimpse of how it looks like, and what the compilation process entails.

Make yourself a directory, and move into it.

{lang="sh"}
~~~~~~~~
mkdir ctest
cd ctest
~~~~~~~~

Open a file called `greeting.c`, and write the following in it:

{lang="C"}
~~~~~~~~
#include <stdio.h>
int main(void)
{
    int first = 10;
    int second = 20;
    printf("Hi there.  Looks like %d times %d is %d\n",
           first, second, first*second);
    return 0;
}
~~~~~~~~

There are several interesting things to note.  First, the need to include things, just as you did in Python.  The `stdio.h` header has the definition of many functions, including the `printf` that we'll use in the program.

Second, the use of curly brackets to mark blocks (while in Python it was indentation).  Even though it is not needed, we still indent blocks because it makes the code much more readable.

Third, the need to define your variables.  You have to be explicit about what variables you want, and what type they are.  The two we've defined here, `first` and `second`, are integers.

Third, the syntax in the `printf` is something we haven't seen before.  First a string with control codes that look like `%d`, then a list of values (in this case, `first`, `second`, and `first*second`.  The values in the list will replace the control codes, so we need the same number of both.

And fourth, and most important: you cannot run this program.  At least, not yet.  First we need to compile it.  Run this:

{lang="sh"}
~~~~~~~~
cc greeting.c
~~~~~~~~

Now this is where you might have a problem if you are on a Mac.  By default, OSX does not install the command-line developer tools, and the C compiler comes with them.  Depending on the OSX version you are running it will ask you directly to install them (say yes), or you will need to figure out [how to do it](http://stackoverflow.com/questions/9329243/xcode-4-4-and-later-install-command-line-tools).  Do install them, you'll be using them all the time.

Once `cc` (the C compiler) has finished with your file you'll find an `a.out` file in your directory.  This is the compiled program, already made executable.  You can run it directly,

{lang="sh"}
~~~~~~~~
./a.out
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> Hi there.  Looks like 10 times 20 is 200
A> ~~~~~~~~


[^fn_disc]: Disclaimer: I do get a cut from your Amazon purchase. Thank you very much for your support.

