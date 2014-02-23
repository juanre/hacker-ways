

# §5 --- From the shell to a program

Programming is a natural extension of the types of conversation that we've been having with the computer.  If, instead of writing directly to the shell, you write the commands in a file, you can then ask the shell to run whatever it finds in it.  Writing directly in the shell is like interactively asking somebody to do something, wait for the result, then ask something else, and so forth; writing the commands in a file is like leaving a note with instructions for somebody.

This file with the instructions for the shell is a program.  Some would rather call it a script, because the computer will go over it one step at a time without taking first the time to think about what's to be done and try to optimize it (yes, we can do that too, and you'll get a glance in the next chapter).  Don't be concerned with the difference between program and script.  It was always fuzzy anyway, and it is now at the point where it is completely irrelevant.

{#L149ED997-4CDC-4026-B5D6-A5DAD843E3EB}
## Our first program


Open a file named `shelltest.sh`, for example with Vi,

{lang="sh"}
~~~~~~~~
vi shelltest.sh
~~~~~~~~

and write this:

{lang="sh"}
~~~~~~~~
mkdir testdir
cd testdir
echo "My first file made by a program" > first.txt
wc -w first.txt
cd ..
~~~~~~~~

Remember that you have to type `i` to move into input mode before you start writing; escape to move back to normal mode when you are done; then `:wq` to save to disk and quit.

All programs are written in a programming language.  This one contains just the type of commands that the shell understands: it is written for the shell.  This is why we have used a `.sh` extension in the name: it is convenient to know, by looking are your files' names, the type of content you can expect to find in them.

So your file contains a bunch of commands for the shell.  You would expect the shell to be able to understand it, and you should be able to ask the shell to run it.

{#L1750CE93-B64F-4249-A407-51826FA86053}
## Running the program


There are a three ways to do it, and it is very important that you understand them well.

The clearest way to run a program is explicitly: ask a shell to run it.  Try this on your terminal:

{lang="sh"}
~~~~~~~~
bash shelltest.sh
~~~~~~~~

By typing `bash` in the command line you are executing another `bash` within the terminal's `bash`.  It may sound like a puzzle, but remember that the program that you are talking to when in the terminal is the shell `bash`.  And that `bash` is a program, like any other, so you can call it whenever you wish, running it like any other program.

Take some time now and do a quick experiment  to convince yourself.  First take a look at where you are in your terminal:

{lang="sh"}
~~~~~~~~
pwd
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> /Users/inesuka
A> ~~~~~~~~

Now run another instance of `bash`,

{lang="sh"}
~~~~~~~~
bash
~~~~~~~~

You are now in an instance of the shell that runs under your initial shell.  Try, for example, to move to another directory,

{lang="sh"}
~~~~~~~~
cd /
pwd
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 
A> /
A> ~~~~~~~~

This instance of bash is now at the root directory.  Exit it,

{lang="sh"}
~~~~~~~~
exit
~~~~~~~~

and now check again where you are,

{lang="sh"}
~~~~~~~~
pwd
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> /Users/inesuka
A> ~~~~~~~~

Indeed.  The parent shell, the one you were running before your call to `bash`, does not know that in the other shell you have moved to another directory.

When you execute `bash` passing it a text file as an argument --- *your* program ---, as you did just a moment ago, it will execute one by one the commands in the text file, then exit.  When it exits you will be standing in the original shell.

You have seen the output of the `wc` command.  To further convince yourself that the program did what it was supposed to, take a look at the file it created:

{lang="sh"}
~~~~~~~~
cat testdir/first.txt
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> My first file made by a program
A> ~~~~~~~~

Bingo!  It did create the file with the expected content.

You can usually call the shell with the shorter name `sh`,

{lang="sh"}
~~~~~~~~
sh shelltest.sh
~~~~~~~~

{#L75DC1ED6-8BD2-49C7-9BC9-C79E44F0C0C8}
## Program permissions


The second way to run a program is to mark it as executable.  Files have [permissions](http://en.wikipedia.org/wiki/File_system_permissions#Traditional_UNIX_permissions); with the program `chmod` you can mark them as readable, writable and executable.  You can do it separately for the owner of the file, for the members of the user group to which the file belongs, and for the users of your computer in general.  I haven't given you enough detail to understand file permissions: for now, we just care about the fact that files can be marked as executable.  Let's mark ours:

{lang="sh"}
~~~~~~~~
chmod +x shelltest.sh
~~~~~~~~

And now try to run it.  Just type the name, then enter.

Did it work?  Most likely not.  You probably got an error, the shell complaining about not being able to find your program.  The reason is that the shell has a set of directories in which it looks for programs, and the directory where you currently are does not belong to this set.  So it is not looking for your program where it would find it, and loudly complaining.

We'll go over this later on in this chapter, and you'll understand how to change the directories in which your shell looks for programs; for now, let's just be very explicit to the shell about where to find it.  Remember that the current directory ---whichever it might be--- was always called a dot `.`?  By adding a dot and a slash to the beginning of the file name we'll be being explicit about where the file is: here, in the current directory.

{lang="sh"}
~~~~~~~~
./shelltest.sh
~~~~~~~~

When the shell sees the `/` it understands that you are giving it a path to the file with your program, and it doesn't bother to further look for it.

{#LB0BAEBB5-C424-41A2-A0DD-EFE55B826B8C}
## Variables in the shell


Before we look into the third way to run a shell program let me tell you about variables.  They are one of the tricks that simplify programming.  Look at the program we just wrote:

{lang="sh"}
~~~~~~~~
mkdir testdir
cd testdir
echo "My first file made by a program" > first.txt
wc -w first.txt
cd ..
~~~~~~~~

We are using `first.txt` twice: first when we create it, second when we count how many words it contains.  Imagine that we wanted to change it to another file name: we would have to change it in two places.  Which doesn't sound like a big deal, but if the program was large it would quickly become a burden and a source of errors.

Defining a variable is choosing a name for a value, a name that we'll be able to use to refer to the value.  Let's pick `FILE`, which will remind us of what the variable is a name for.  We define the variable by *assigning* to it, and we assign using the `=` sign.  When we write

A> {linenos=off}
A> ~~~~~~~~
A> FILE=first.txt
A> ~~~~~~~~

we are saying that, from now on, the name for `first.txt` will be `FILE`.  Or, in more conventional words, we have assigned the value `first.txt` to the variable `FILE`.  In order to access the variable's value we prepend it with `$`, as in `$FILE`.  Variables are a common feature to most programming languages, but the `$` prepended at the beginning is a quirk of the shell.

Try it out first directly in the shell.  Store something in a variable,

{lang="sh"}
~~~~~~~~
days=365
~~~~~~~~

then access it,

{lang="sh"}
~~~~~~~~
echo $days
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 365
A> ~~~~~~~~

Now let's modify our program so that it uses a `FILE` variable,

{lang="sh"}
~~~~~~~~
FILE=first.txt
echo "Using $FILE for test"
mkdir testdir
cd testdir
echo "My first file made by a program" > $FILE
wc -w $FILE
cd ..
~~~~~~~~

We have added a line that echoes the current value of `FILE`, just for fun.  Note that now, if we want to modify the file name, we just have to change in one place: where we assign it to the `FILE` variable.

The next thing we would naturally want to do is to set the file name as a command line argument.  All languages have a method to do that; in the shell, this is such a common thing to do that it is very easy.  You just use `$1` for the first argument, `$2` for the second, etc.  This is how it looks like:

{lang="sh"}
~~~~~~~~
FILE=$1
echo "Using $FILE for test"
mkdir testdir
cd testdir
echo "My first file made by a program" > $FILE
wc -w $FILE
cd ..
~~~~~~~~

Now you can call your program with

A> {linenos=off}
A> ~~~~~~~~
A> ./shelltest.sh filename
A> ~~~~~~~~

{#LAFBBEE01-187D-473E-AF07-1AE76B26C73E}
## Sourcing scripts


I've mentioned [before](#L1750CE93-B64F-4249-A407-51826FA86053) that there are three ways to run a shell program, but we've only talked about two: running explicitly on a shell, as in

A> {linenos=off}
A> ~~~~~~~~
A> sh yourprogram.sh
A> ~~~~~~~~

and making it executable.  They are quite equivalent: when you make the program executable the shell will also run it inside another shell.

The third way to run a shell program is to ask the *current* shell to run it herself.  You do it by sourcing it, which can be done either with the `source` command, or with a single dot, followed by a space, followed by your program.

But, before trying it, do a quick test.  Make sure that your experiments so far have not created a variable named `FILE` in your current shell:

{lang="sh"}
~~~~~~~~
echo $FILE
~~~~~~~~

This should not return anything, because every time you have created the variable `FILE` ---every time you've run your program--- you've done so inside another shell, which had been run by the current one.

Try now to source your program:

A> {linenos=off}
A> ~~~~~~~~
A> . yourprogram.sh
A> ~~~~~~~~

This should work just as before, but it is your shell, the one running in your terminal, that did the work.  So when you created the FILE variable you did it in the current shell.  Check it out:

{lang="sh"}
~~~~~~~~
echo $FILE
~~~~~~~~

You should always run your scripts in separate shells, except when you want them to affect the state of your shell by, for example, setting up variables for you.

{#L8041E89C-AA38-447F-B4D5-2F25449E9197}
## Environment variables


What if you want your shell's variables to be available to the shells you spawn?  That is, imagine that you want to define a variable that the programs you call will be able to see and use.  You do that by exporting it, as in:

{lang="sh"}
~~~~~~~~
export ME=yourname
~~~~~~~~

Now you can write a program that uses the `ME` variable.  For example, in a file `greet.sh` write

{lang="sh"}
~~~~~~~~
echo "Good morning, $ME"
~~~~~~~~

and run it with

{lang="sh"}
~~~~~~~~
sh greet.sh
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> Good morning, yourname
A> ~~~~~~~~

The variables that have been exported from your shell are called environment variables.  A particularly important one is `PATH`, a variable containing all the directories in which to look for executable programs, separated by colons.

{#L267DFFB4-3BF1-41DB-A156-DBCF2F156C8F}
## Initializing environment variables


A good place to define your environment variables is the `.bashrc` file in your home directory.  Remember that `ls` will keep it hidden unless you specify the `-a` option, as it does with all files whose name starts with a dot.

From the `bash` man page,

> When an interactive shell that is not a login shell is started, bash reads and executes commands from ~/.bashrc, if that file exists.

Whenever you start a terminal you'll be starting a new shell, and you'll want it to have your environment variables.  Open the `.bashrc` file,

A> {linenos=off}
A> ~~~~~~~~
A> vi ~/.bashrc
A> ~~~~~~~~

and add to it the following lines:

{lang="sh"}
~~~~~~~~
export PATH=/usr/local/bin:$PATH
export PS1='\w\$ '
~~~~~~~~

The first line adds `/usr/local/bin` to your path.  This is usually a good idea, because most of the programs that you'll be installing to run from the command line are installed there.

The second line is less important.  The `PS1` environment variable defined the prompt in your shell.  I've given you my choice (the current path, `\w`, followed by a dollar sign) but you can set it up to anything you want, and there are plenty of fun things you can do with it.

Source the `.bashrc` file to get your shell to apply the new `PS1`, and to export the new `PATH`:

{lang="sh"}
~~~~~~~~
. ~/.bashrc
~~~~~~~~

Now you want to make sure that every time you start a shell it will load your defaults.  There are two ways to start `bash`: as a non-login shell (ie, you are already logged-in), and as a login shell (that will start by asking your id and pasword).  A new non-login bash loads `.bashrc`; a login bash loads another file, `.bash_profile`.

So if you want to forget about it, and make sure your terminals look good, open `.bash_profile`,

A> {linenos=off}
A> ~~~~~~~~
A> vi ~/.bash_profile
A> ~~~~~~~~

and add a line to it that ensures that `.bashrc` is sourced:

{lang="sh"}
~~~~~~~~
. ~/.bashrc
~~~~~~~~

{#L15F3F11D-06F9-46F5-9F7E-DF8E97426121}
## Conditionals in the shell


Say you want to be able to specify the file name as a command line argument, as we just did, but you want your program to use some default value if you don't specify it.  That is, you want to be able to write

{lang="sh"}
~~~~~~~~
./shelltest.sh somename
~~~~~~~~

to use `somename` as file, or

{lang="sh"}
~~~~~~~~
./shelltest.sh
~~~~~~~~

to use a default value, for example the original `first.txt`.  In order to do this we need to check whether the user of the program specified the argument or not.  You do it with the conditional, `if`, which is something you'll find in all programming languages.  The shell has what's probably the least intuitive way to write it, but it's still worth while to know it.  Check it out:

{lang="sh"}
~~~~~~~~
if [ "$1" != "" ]; then
    FILE=$1
else
    FILE=first.txt
fi

echo "Using $FILE for test"
mkdir testdir
cd testdir
echo "My first file made by a program" > $FILE
wc -w $FILE
cd ..
~~~~~~~~

The `!` = in the condition,

{lang="sh"}
~~~~~~~~
[ "$1" != "" ];
~~~~~~~~

means "non equal to".  It will be true when what comes in the `$1` variable is not equal to an empty string, which is when we want to use its value for the `FILE`.

{#L520442DF-CFF3-4451-BB58-728511454285}
## Looping the shell


Loops ---the ability to repeat something many times--- are another feature found in most programming languages.  Try this out, directly on the shell:

{lang="sh"}
~~~~~~~~
for i in 1 2 3 4 5
do
   echo "Now i is $i"
done
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> Now i is 1
A> Now i is 2
A> Now i is 3
A> Now i is 4
A> Now i is 5
A> ~~~~~~~~

You can specify a range with

{lang="sh"}
~~~~~~~~
for i in {1..10}
do
   echo "Now i is $i"
done
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> Now i is 1
A> Now i is 2
A> Now i is 3
A> Now i is 4
A> Now i is 5
A> Now i is 6
A> Now i is 7
A> Now i is 8
A> Now i is 9
A> Now i is 10
A> ~~~~~~~~

Now look at this version of your program, and see if you can figure out what it will do before trying it out:

{lang="sh"}
~~~~~~~~
if [ "$1" != "" ]; then
    FILE=$1
else
    FILE=first.txt
fi

echo "Using $FILE for test"
mkdir testdir
cd testdir

# This will have the effect of starting the file afresh,
# so that later we can append to it without worrying about
# previous runs of the program having already started the
# file.
echo "" > $FILE

for i in {1..20}
do
    echo "The line $i" >> $FILE
done
wc -w $FILE
cd ..
~~~~~~~~

{#L804502AB-F2FA-4A8E-A48F-8C1341D191C7}
## Programming and the shell


About twenty years ago I used to write rather complex shell scripts, programs with hundreds or thousands of lines.  But then I discovered Perl, a very powerful and much more forgiving language, and the shell was relegated to simple automation tasks, usually in combination with a Makefile (we'll talk about `make` and Makefiles in a later chapter).

Perl was itself set aside for Python about fifteen years ago.  Nowadays I still write small shell scripts all the time, but whenever a significant amount of logic is required I will quickly switch to Python.  It is much easier, more clear, and a more powerful language.


