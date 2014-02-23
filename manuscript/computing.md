

# §7 --- Making the computer work for you

In the previous chapter we saw how to interact with Python.  In this chapter we want to start using it to do interesting stuff, but before we'll spend some time improving our work environment.

First we'll introduce `screen`, a wonderful piece of software that will allow you to do many things at once within the terminal, without losing track of any; get used to `screen`, and you won't be able to be without it.

Once we understand `screen` we'll learn how to install Python packages.

By the end of the chapter you will know how to use `screen` to work in parallel workspaces within the terminal.  You will have also learned how to find and install Python packages, and you'll know a bit more about system administration.  You will have a rather nice Python environment set up, and we'll use it to take a mathematical detour that will give you a feeling of the many cool things you can do easily with Python once you know your way around.  You may, of course, skip the last part if you don't care about math: read the first parts, were we talk about `screen` and Python packages, and move on.

{#L8DF24CAD-4CFD-4A6C-8C6F-0D56FBDB45C9}
## The case for improving your work environment


It is good that you experiment with your work environment, and figure out how to tailor it to your needs.  And not only for the obvious fact that you might spend many hours a day in front of your computer, and you'd rather be comfortable.  The best work happens when the computer does not interfere between you and your task.  The interface to the computer should be as transparent to your thought processes as possible, the interaction effortless and automatic.  Only then your attention will be focused, and your work your best[^fn_flow].

It might be that one of the reasons that makes the UNIX work environment so compelling is that it lends itself so well to tuning and automating, leaving plenty of room for you to find your perfect setup.  Most things can be done with keyboard shortcuts that can be learned until they become almost autonomous.  When in Emacs, my fingers reach out for `C-x C-s` every now and then without me being fully aware of it; movement between applications happens with `Command-TAB`; the mouse is hardly every touched.

Because I think (and this is a strongly felt guess, but a guess nevertheless) that reaching for the mouse, and aiming at a place to click, imposes a much higher cognitive load on your brain than just letting your fingers press a fully automated chord in the keyboard.  And I'd much rather have my brain working out the problem at hand than thinking about what it's doing with the mouse.

{#L5AB1ECA3-AC90-4B1F-B941-A11359B0C428}
## Running things in parallel with `screen`


When you have been working at the terminal for a while there may be quite a bit of information in it.  Its value is usually in the short term ---whatever you want to store for the future you'll stash away in a file and save it--- but it is important anyway.  It is your command line history, environment variables you might have declared, a Python session in which you have defined a couple of helper functions, and have stored some values in variables that you are using to perform repetitive computations.

The time will come in which your work-flow will make you close valuable sessions.  For example, you are working with the Python interpreter when you realize that you need to install a new package, and while you are at it you need to check if a library is installed.   You'd rather not interrupt the interpreter, and you'd rather not leave your package installation to check the library out.

There's a simple solution: start a new terminal or, if in OS-X, open another window with `Command-n` (or another tab with `Command-t`).  But it quickly becomes cumbersome, you end up with lots of terminal windows in your screen, and it's not the best way.  The best solution is to have multiple workspaces within your terminal, which is what `screen` does for you.  And it is the best because it works, it is based on easy-to-automate keyboard commands, you find it everywhere, and it affords you some measure of permanence between sessions.

### Starting `screen`

Enter

A> {linenos=off}
A> ~~~~~~~~
A> clear
A> ~~~~~~~~

in your terminal to clean up.  We'll be showing how `screen` works with a little experiment, and keeping things tidy will help.  We are just about to start creating parallel workspaces and moving among them, and it might get confusing.  So we are going to leave tracks, writing something recognizable; type something like this:

A> {linenos=off}
A> ~~~~~~~~
A> echo "This is the starting bash"
A> ~~~~~~~~

And now prepare to run `screen`.  This is what you should see just before you press enter, after typing `screen`:

![](images/screen-1-screen.png)

Once you press enter you will see a page-long description (check it out, you might see an invitation to send pizza to the authors).  Pressing space or enter will clear this page and start `screen` proper.  You should see a new, clean shell.  Let's leave a track,

A> {linenos=off}
A> ~~~~~~~~
A> echo "This is the first screen"
A> ~~~~~~~~

Your terminal should now look more or less like this:

![](images/screen-2-screen.png)

### Creating a new `screen` workspace

Type `C-a c`, and you'll find your terminal looking like a new shell again.  The `screen` man page calls it a window, but I'll use workspace because it does not look like a window at all.  Leave a track for later,

![](images/screen-3-screen.png)

And, just for fun, build another one, `C-a c` again, and `echo` to know where you are:

![](images/screen-4-screen.png)

### Moving between `screen` workspaces

If you type `C-a p` you will go back to the previous workspace.  Try it out, and your terminal should be back at

![](images/screen-3-screen.png)

With `C-a n` you will go forward to the next workspace.  Experiment circling between workspaces back and forth, making sure you recognize them.

### Leaving `screen`

When you are done with screen, or when you want to do something else with your terminal, type `C-a d`.  This will *detach* your screen, and it will leave you at your initial bash,

![](images/screen-5-screen.png)

where you can work as usual.  Now what's really nice is that, if you want to go back to your `screen` workspaces, you just run `screen` again, this time with the `-r` switch for *reattach*,

A> {linenos=off}
A> ~~~~~~~~
A> screen -r
A> ~~~~~~~~

and you'll be back, moving with `C-a n` and `C-a p` among workspaces that remember your previous work and the state your programs were in, as if you had never left.

### Actually closing `screen`

When you are done with it, you close `screen` by leaving all the shells it is running.  You close a shell by typing `C-d` (remember that `C-d` means [end of file](#L680363FB-3440-43EA-BA7A-83C38D26E2F6), and is also how you leave the Python interpreter).  When you have closed all the shells within `screen` it will not have further reason to stay alive, and it will exit.

### Pre-packaged screen

Like most UNIX programs, `screen` is easily configurable with a text file.  Its configuration file, `~/.screenrc`, allows you to pre-load several workspaces.  And, while you are at it, you can also give them names, and make them start in different directories.  This is how my `.screenrc` looks like,

{lang="sh"}
~~~~~~~~
startup_message off
defutf8 on
nonblock on

# hardstatusline
hardstatus on
hardstatus lastline
hardstatus string '%{= b}%-Lw%{= g}%50> %n%f %t%{= b}%+w%<'

# Startup settings
screen -t home 0
chdir /Users/juanre/hp
screen -t hp 1
chdir /Users/juanre/prj
screen -t prj 2

# Fix screen overwriting
altscreen on
~~~~~~~~

So when I start screen I have three workspaces, labeled `home`, `hp` and `prj`, and a nice text at the bottom of the terminal showing me where I am:

![](images/screen-6-screen.png)

{#L4A846D06-E727-4918-AD65-0A15FD213ADA}
## A remote server running `screen`


In a remote server `screen` becomes much more than a convenience.  A remote server is, for example, the computer hosting your web pages.  We'll talk about how to connect to another computer in a later chapter.

When you are working in a remote server it feels just like when you are working at the terminal in your computer, but slower.  The main difference is that the computer who's answering your commands is your server, not yours.

The first thing you do after login in your server, before starting to work, is to run `screen`.  This allows you to keep several tracks in parallel, creating workspaces as you need them.  But then you have to disconnect from the server, and you don't want to stop what you are doing, because maybe one of the workspaces contains a long running program that has not finished, and in another you are editing a file.

So you just detach from your screen, `C-a d`, and exit the server.  The next time you log in you'll reattach with `screen -r`, and it will be as if nothing had happened.  You'll be back to your long running program, maybe finished by now, and to the file you are editing, and to whatever workspaces you left when you disconnected.

You can try something similar now: just exit your screen-running terminal.  Open a terminal again, then do `screen -r`.  If all has gone well you should be looking at the workspace where you were before you closed the terminal.

{#LA3D54299-F846-42EC-9810-F1AC7CE1EAD5}
## Python packages


Another way in which you improve your work environment is by adding functionality to it.  Python gives you an easy way to do it.

Say you are a programmer.  You've been working on a cool problem, you've come up with a piece of software to solve it, and you decide to give it to the community.

You want to make it available to other programmers, who may want to contribute to your code.  Luckily, you have been using `git` to keep track of your versions (more on `git` on a coming chapter), so you decide to store your software as a repository in [Github](http://github.com).  Once your software is there it is easy for other programmers to get copies, make improvements, and share them with you.

The chances are not low that there will be other programmers around who want to help, or who can take advantage of your software to help them solve other problems: there were [3.5 million users](http://en.wikipedia.org/wiki/GitHub#Statistics) on Github on April 2013, and on December 2013 Github was hosting 10 million repositories.

You also want to make your software available to users, so you package it up in a way that makes it is easy for other people to install.  In this section we'll be talking about these packages, and how to install them.

### The Python package index

Say your hypothetical piece of software is a Python package.  If you want to make it as easy as possible for your users to find it you'll go and register it at the [Python Package Index](https://pypi.python.org/pypi), PyPI for short[^fn_pypi].  Once your package is listed there your users will be able to find it and install it using a program called `pip`.

{#L985C7A2A-FED9-41F4-A017-1B55E6E4C377}
## Installing Python packages with `pip`



### Installing `pip`

It might be that your system already has `pip` installed.  [Remember](#L79853D24-3545-43D3-AE2E-65202F601A6D) `which`?  Try it out:

{lang="sh"}
~~~~~~~~
which pip
~~~~~~~~

If `pip` is installed `which` will tell you where it is.  If it is not installed `which` will stay quiet.

Most likely `pip` will not be installed, so you'll need to install it.  The installation [procedure](http://www.pip-installer.org/en/latest/installing.html) is a rather unusual one: you need to download the installer,

{lang="sh"}
~~~~~~~~
wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
~~~~~~~~

and then run it with Python,

{lang="sh"}
~~~~~~~~
sudo python get-pip.py
~~~~~~~~

### Administrative privileges with `sudo`

Note that we are not running Python as we usually do: there is a `sudo` before the call to `python`.  It is required because the installation procedure will need to write in locations of your computer that are protected.

On your day-to-day interaction with the computer you are a normal user: you can modify and delete files in your home directory (either `/Users/your-login-name/` if you are in a Mac, or `/home/your-login-name/` if you are in Linux), which is plenty enough for normal work and it does not put the integrity of the computer at risk.

But software is usually installed in places of the computer where all users will be able to run it, like `/usr/local/bin/`, and is usually protected so that normal users cannot remove it.

If you want to install something you will need to temporarily acquire the power to do so: you will need administrative privileges.  This is what a `sudo` before a command does.  It will ask for your password, and if you enter it correctly it will grant administrative privileges to the command that you are running.  It will work if you are on the `sudoers` group; if you are not, you will be informed, and you will have to find somebody with administrative rights to your computer to do the installation for you.

To recap, when you do this:

{lang="sh"}
~~~~~~~~
sudo python get-pip.py
~~~~~~~~

you'll be asked for your password and, if you enter it correctly, you'll be giving administrative rights to `python get-pip.py`.  If the person who wrote `get-pip.py` wanted to wipe out your computer, he could.  If somebody intercepts it when you download it, on its way from the Github server where it resides to your computer, she could make it do anything she wanted.  Which is kind of scary.

But you'll be all-right.  There are many people making sure that `get-pip.py` does what it's supposed to do; and the address you'll be downloading `get-pip.py` from begins with `https`, which means that it will travel encrypted.

Python offers a mechanism that helps you avoid installing things in your machine for everybody.  It is called [virtualenv](https://www.google.com/search?client=safari&rls=en&q=python+virtualenv+tutorial&ie=UTF-8&oe=UTF-8), and it makes a local installation of everything Python wherever you want.  It is very convenient when you are developing Python packages, but unless you don't have administrative rights to your computer you don't need to worry about it now.

### Checking the `pip` installation

Make sure that you've installed `pip`, and it's available:

{lang="sh"}
~~~~~~~~
which pip
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 
A> /usr/local/bin/pip
A> ~~~~~~~~

You should now be ready to run it, if the shell is able to find it.  If it doesn't ---if `which` does not return a proper location--- it might be because you didn't follow [my suggestion](#L267DFFB4-3BF1-41DB-A156-DBCF2F156C8F) to add `/usr/local/bin` to the `PATH` environment variable, in which case you should do it now,

{lang="sh"}
~~~~~~~~
export PATH=/usr/local/bin:$PATH
~~~~~~~~

{#LD2E58F89-FE38-4003-A7A4-3DBEFB471016}
## Improve your Python environment with IPython


[IPython](http://ipython.org) is a great addition to your Python toolset.  We are going to install and use it for the Python shell it provides, much nicer than the standard `python` you've been interacting with so far.  But IPython does many more things: you might want to spend some time [exploring it](http://ipython.org/documentation.html).

{#L9B94812A-C5F1-4599-BF58-C5539A57DA68}
### Command line completion


Command line completion is a big deal.  It is much easier and quicker to interact with a program that's helping you write ---as `bash` and Emacs do.  Let's install IPython, and then we'll take a closer look at completion.

### Install Readline and IPython

Installing IPython is easy, thanks to `pip`.  But it turns out that it has a dependency ---a package it depends on--- that you may need to install first: [Readline](http://docs.python.org/2/library/readline.html), which "defines a number of functions to facilitate completion and reading/writing of history files from the Python interpreter".  It should be straight-forward to install:

A> {linenos=off}
A> ~~~~~~~~
A> sudo pip install readline
A> ~~~~~~~~

Once it's finished you can download and install IPython with

A> {linenos=off}
A> ~~~~~~~~
A> sudo pip install ipython
A> ~~~~~~~~

If everything went well you should have now a working IPython installation.  Try it out typing

A> {linenos=off}
A> ~~~~~~~~
A> ipython
A> ~~~~~~~~

This should open the `ipython` shell.

### Testing command line completion

Import `math`,

{lang="python"}
~~~~~~~~
import math
~~~~~~~~

Then type

{lang="python"}
~~~~~~~~
math.
~~~~~~~~

and a TAB.  IPython will show you all the possible command completions, which are all the functions and variables available in the `math` module,

A> {linenos=off}
A> ~~~~~~~~
A> math.acos       math.degrees    math.fsum       math.pi
A> math.acosh      math.e          math.gamma      math.pow
A> math.asin       math.erf        math.hypot      math.radians
A> math.asinh      math.erfc       math.isinf      math.sin
A> math.atan       math.exp        math.isnan      math.sinh
A> math.atan2      math.expm1      math.ldexp      math.sqrt
A> math.atanh      math.fabs       math.lgamma     math.tan
A> math.ceil       math.factorial  math.log        math.tanh
A> math.copysign   math.floor      math.log10      math.trunc
A> math.cos        math.fmod       math.log1p
A> math.cosh       math.frexp      math.modf
A> ~~~~~~~~

This is an extremely convenient thing to have.  If you want a quick glance of a module you just import it, then use command line completion to see its contents.

Keep typing: a `f`, and TAB again:

{lang="python"}
~~~~~~~~
math.f
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> math.fabs       math.floor      math.frexp
A> math.factorial  math.fmod       math.fsum
A> ~~~~~~~~

You see where this is going.  If you now type `ac`, then TAB, it will finish the command for you:

{lang="python"}
~~~~~~~~
math.factorial
~~~~~~~~

{#L491B6BE8-03AB-4D2C-9730-2A0D452A78B4}
## Asking for help in Python


When you are in the terminal, interacting with the shell, you [ask for help](#LA6586ED3-AC24-4480-8B15-DAB7FD956ADF) with `man`.   When in Emacs [you do](#L1FBA41B9-A257-455C-9311-DCF46565AE90) `M-x describe-function`.  When you are interacting with Python you ask for help with the function `help`,

{lang="python"}
~~~~~~~~
help(math.cos)
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> help(math.cos)
A> Help on built-in function cos in module math:
A> 
A> cos(...)
A>     cos(x)
A> 
A>     Return the cosine of x (measured in radians).
A> ~~~~~~~~

When you are in IPython asking for help is even simpler: you only need to do

{lang="python"}
~~~~~~~~
?math.cos
~~~~~~~~

{#LCAA88779-22E0-4079-B589-C0C98CAF2C8D}
## Playing with Python and math


In the previous chapter we asked the computer to manipulate numbers.  It is reasonably easy to convince Python to do simple operations, such as the ones we did, or even combinations of them, such as the average of a list of numbers.

It is a bit more difficult ---but very rewarding--- to convince your computer to do *symbolic* math for you.  By symbolic we mean that we expect symbols to be manipulated, symbols like the {$$}x{/$$} in the following equation

{$$}
  x^5 + 3x^4 - 11x^3 - 27x^2 + 10x + 24 = 0.
{/$$}

How about a way to write a program that would perform algebraic manipulations in symbols such as the above, and maybe find the exact values of {$$}x{/$$} for which the equation is true?  It is actually quite straight forward if you have the right package installed.

With `pip` we can search for an algebra package,

{lang="sh"}
~~~~~~~~
pip search algebra
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> sympy                     - Computer algebra system (CAS) in
A>                             Python
A> VectorDict                - dict with recursive operations
A>                             (algebraic, set, logicial)
A> Assimulo                  - A package for solving ordinary
A>                             differential equations and
A>                             differential algebraic equations.
A> features                  - Feature set algebra for linguistics
A> qmath                     - qmath provides a class for deal with
A>                             quaternion algebra and 3D rotations.
A>                             Root evaluations and Moebius
A>                             transformations are implemented.
A> scikits.odes              - A python module for ordinary
A>                             differential equation anddifferential
A>                             algebraic equation solvers
A> colorname                 - colorname tries to assign a name to a
A>                             color, using predefined color
A>                             definitions and linear algebra.
A> Ceygen                    - Cython helper for linear algebra with
A>                             typed memoryviews built atop the Eigen
A>                             C++ library
A> relalg                    - Relational algebra for python
A> ...
A> ~~~~~~~~

The first one is [sympy](http://sympy.org/en/index.html), an awesome package for symbolic mathematics.  Let's install it:

{lang="sh"}
~~~~~~~~
sudo pip install sympy
~~~~~~~~

And you are ready to start playing.

{#L24C6BA31-F99E-48A6-9887-330CD480A541}
## Solve equations and plot graphs


Open `ipython`.  First we need the functionality that `sympy` available.  [Remember](#LEFB46343-E073-4740-8012-15076EC87192) that in order to make the functionality in a package available to the current session we need to `import` it,

{lang="python"}
~~~~~~~~
import sympy as sp
~~~~~~~~

but here we are playing a trick.  We'll be using `sympy` later on, and we don't want to use the full name every time we call one of its functions.  By adding the `as sp` to the import we define `sp` as a synonym, so we can type `sp` wherever `sympy` was called for.

Once `sympy` is loaded we define `x` as a variable,

{lang="python"}
~~~~~~~~
x = sp.var('x')
~~~~~~~~

After this we can use `x` in equations.  We may, for example, want to solve the previous one.  We start by storing it into a variable `p`, for polynomial,

{lang="python"}
~~~~~~~~
p = x**5 + 3*x**4 - 11*x**3 - 27*x**2 + 10*x + 24
~~~~~~~~

where `x**5` means {$$}x^5{/$$}.

Now we can evaluate the polynomial at any value of `x` simply by running its `subs` function (for substitute),

{lang="python"}
~~~~~~~~
p.subs(x, 10)
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 116424
A> ~~~~~~~~

Note that you can explore it further simply by typing `p.`, then tab: IPython will show you all the possible completions, which include `subs` and all the other functions defined in `p`.

Can we solve the equation?  Sure,

{lang="python"}
~~~~~~~~
sp.solve(p, x)
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 
A> [-4, -2, -1, 1, 3]
A> ~~~~~~~~

Now you may ask, how come I came up with such a nice polynomial as an example, one that has neat roots?  I cheated, of course.  I defined it as

{lang="python"}
~~~~~~~~
p = (x+4) * (x+2) * (x+1) * (x-1) * (x-3)
~~~~~~~~

which was easy to see when it would be zero, and then asked `sympy` to expand it for me,

{lang="python"}
~~~~~~~~
sp.expand(p)
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> x**5 + 3*x**4 - 11*x**3 - 27*x**2 + 10*x + 24
A> ~~~~~~~~

I didn't even have to write it up in LaTeX for nice formatting, `sympy` did that for me as well:

{lang="python"}
~~~~~~~~
sp.latex(sp.expand(p))
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> x^{5} + 3 x^{4} - 11 x^{3} - 27 x^{2} + 10 x + 24
A> ~~~~~~~~

Can we plot it?  We can, with `sp.plot`.  We need to give it the coordinate with which we want to plot, `x`, and its range:

{lang="python"}
~~~~~~~~
sp.plot(p, (x, -4.5, 3.5))
~~~~~~~~

![](images/sympy-example.png)

Some familiarity with Python and `sympy` can do a lot for your appreciation of mathematics, and your ability to explore them.


[^fn_flow]: Only then can you hope to enter what top athletes and many computer programmers call *the flow*, a state of mind in which  you let your mind focus by itself, and in which you can spend many joyful hours feeling as if your work just happens.



[^fn_pypi]: There are 39361 packages available at PyPI as of 2014-01-14.

