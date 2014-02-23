

# §3 --- Basic UNIX tools

Most of the tools you'll be using in the terminal, including those presented in the previous chapter, were designed by the people who created UNIX back in the late sixties and early seventies.  They did an amazing job.  People like [Ken Thompson](http://en.wikipedia.org/wiki/Ken_Thompson) and [Dennis Ritchie](http://en.wikipedia.org/wiki/Dennis_Ritchie) are heroes in the computing world: the system they created is at the heart of most servers running the internet, and at the core of all OSX and Linux computers.  Dennis also invented the C programming language, with which most of the rest has been written.

The tools you'll be running are not the ones they wrote; there have been plenty of rewrites over the years.  Yours most likely come from the [GNU](http://www.gnu.org/gnu/gnu.html) project, the brainchild of [Richard Stallman](http://stallman.org) ---another legendary programmer--- or from the BSD UNIX from Berkeley.  When looking at the [man](#LA6586ED3-AC24-4480-8B15-DAB7FD956ADF) page of any program type `G` to go to the end, and you'll usually see something about the history of the program and its authors there.

Let's get started.  Open the terminal and go to the `changek` directory that you [built](#L459BED4D-E7E9-49F9-946A-0A5DE7B64F81) in the previous chapter.  And check out what's in there, just in case.

{lang="sh"}
~~~~~~~~
cd ~/changek ; ls
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> index.html
A> ~~~~~~~~

(Note how we can have more than one command per line if we use a `;` to separate them.)

Just as we left it in the previous chapter.  We can also see what's in index.html,

{lang="sh"}
~~~~~~~~
cat index.html
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> Hi there
A> How's that going?
A> ~~~~~~~~

{#LEC6C0221-E3A6-4A7C-87F6-334EB3288A1E}
## Bring in some content


We'll be using [Bootstrap](http://getbootstrap.com) to help us style our page.  Bootstrap is a library; a bunch of files intended to work together in order to provide some functionality to programmers.  In this case, the functionality we'll get from it is an easy way to give a professional look to your pages and to make them adapt to different screen sizes.

You may download the library from your browser, but as we are learning to work with the terminal we might as well download from there.  The two main command-line programs to download from the web are `curl` and `wget`.  Most likely you'll have `curl` installed if you are on OSX, and `wget` if you are on Linux.

We don't want to litter our working directory with downloads, so let's first build a temporary directory

{lang="sh"}
~~~~~~~~
mkdir ~/tmp
~~~~~~~~

and move to it,

{lang="sh"}
~~~~~~~~
cd ~/tmp
~~~~~~~~

And we are ready to download.  Now let me take a small detour.  What you would typically do is go to the [Bootstrap](http://getbootstrap.com) page, right-click in the download link, copy the address, and paste it in the command line to download.  But it is distributed as a zip file, and I want to show you UNIX way, which is `tar`.  So I have re-packed it, and made it available in my own server.  Here's the command line to download it:

{lang="sh"}
~~~~~~~~
curl -Os http://juanreyero.com/bootstrap-3.0.3-dist.tgz
~~~~~~~~

And make sure it came,

{lang="sh"}
~~~~~~~~
ls
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> bootstrap-3.0.3-dist.tgz
A> ~~~~~~~~

{#LFE07EC99-5CCE-49B9-B9BA-D7A3AB674A47}
## Bundling files with `tar`


The `tar` program bundles many files into one, usually named with the prefix `tar`, and extracts files from a `tar` bundle.

The `tgz` extension in the example is a very common contraction of the extensions `tar` and `gz`.  So the file we've just downloaded could have been named

A> {linenos=off}
A> ~~~~~~~~
A> bootstrap-3.0.3-dist.tar.gz
A> ~~~~~~~~

and it would mean the same: that it has been compressed with `gzip` (hence the `.gz`) after being packaged with `tar`.  You can uncompress it to get the tar,

{lang="sh"}
~~~~~~~~
gunzip bootstrap-3.0.3-dist.tgz ; ls
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> bootstrap-3.0.3-dist.tar
A> ~~~~~~~~

You should always check the contents of a `tar` file before unpacking it.  You do it with the `tvf` options, as in

{lang="sh"}
~~~~~~~~
tar tvf bootstrap-3.0.3-dist.tar | head -n 4
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> drwxr-xr-x  0 juanre staff       0 Dec  5 17:40 dist/
A> drwxr-xr-x  0 juanre staff       0 Dec  5 17:40 dist/css/
A> drwxr-xr-x  0 juanre staff       0 Dec  5 17:40 dist/fonts/
A> drwxr-xr-x  0 juanre staff       0 Dec  5 17:40 dist/js/
A> ~~~~~~~~

(Note how I [piped](#L477EE735-E4B8-46EF-8829-FE3DF0B69AE0) the output of `tar` to `head`, a program that shows the first lines of the input and ignores the rest, so I didn't have to clutter the page too much.)

The content of the `tar` file sounds reasonable, so let's unpack for good.  Replacing the `t` in the options with an `x`,

{lang="sh"}
~~~~~~~~
tar xvf bootstrap-3.0.3-dist.tar
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> x dist/
A> x dist/css/
A> x dist/fonts/
A> x dist/js/
A> x dist/js/bootstrap.js
A> x dist/js/bootstrap.min.js
A> x dist/fonts/glyphicons-halflings-regular.eot
A> x dist/fonts/glyphicons-halflings-regular.svg
A> x dist/fonts/glyphicons-halflings-regular.ttf
A> x dist/fonts/glyphicons-halflings-regular.woff
A> x dist/css/bootstrap-theme.css
A> x dist/css/bootstrap-theme.min.css
A> x dist/css/bootstrap.css
A> x dist/css/bootstrap.min.css
A> ~~~~~~~~

The unpacking of the `tar` file has created a `dist` directory,

{lang="sh"}
~~~~~~~~
ls
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> bootstrap-3.0.3-dist.tar        dist/
A> ~~~~~~~~

The `tar` program is able to deal with compressed files as well when you add the `z` option, so you didn't have to uncompress before unpacking.  Let's try it out.  First compress it back,

{lang="sh"}
~~~~~~~~
gzip bootstrap-3.0.3-dist.tar ; ls
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> bootstrap-3.0.3-dist.tar.gz     dist/
A> ~~~~~~~~

then check the contents again, but now adding the `z` option

{lang="sh"}
~~~~~~~~
tar ztvf bootstrap-3.0.3-dist.tar.gz | head -n 4
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> drwxr-xr-x  0 juanre staff       0 Dec  5 17:40 dist/
A> drwxr-xr-x  0 juanre staff       0 Dec  5 17:40 dist/css/
A> drwxr-xr-x  0 juanre staff       0 Dec  5 17:40 dist/fonts/
A> drwxr-xr-x  0 juanre staff       0 Dec  5 17:40 dist/js/
A> ~~~~~~~~

### Creating `tar` files

You'll certainly want to build `tar` files.  You do it by replacing the `x` in the options by a `c`, and by specifying a file name for the bundle.  We could, for example, pack the content of our working directory with:

{lang="sh"}
~~~~~~~~
cd ~ ; tar zcvf changek.tgz changek
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> a changek
A> a changek/index.html
A> ~~~~~~~~

### Summary of `tar`

The `tar` program has many more options and interesting use cases, but basic usage is not so bad.  You can certainly remember the three main incantations:

-   Create a file bundle with `zcvf`,

{lang="sh"}
~~~~~~~~
tar zcvf changek.tgz changek
~~~~~~~~

-   Check the contents of a bundle with `ztvf`

{lang="sh"}
~~~~~~~~
tar ztvf changek.tgz
~~~~~~~~

-   And unpack a bundle with `zxvf`,

{lang="sh"}
~~~~~~~~
tar zxvf changek.tgz
~~~~~~~~

### Move things in place

After unpacking we have a `dist` directory with the files that came along when we downloaded bootstrap.  Let's [move](#L992E78A5-2C6B-4994-8799-0C40B21F28EA) it to its final location,

{lang="sh"}
~~~~~~~~
mv ~/tmp/dist ~/changek/bootstrap ; cd ~/changek ; ls
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> bootstrap/      index.html
A> ~~~~~~~~

{#L959FBF99-8C5C-4470-9B85-7C11C31A0E45}
## Finding files with `find`


This is another tool that you'll probably find yourself using all the time.  The basic invocation is:

{lang="sh"}
~~~~~~~~
find . -name bootstrap.css
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> ./bootstrap/css/bootstrap.css
A> ~~~~~~~~

The first argument is the directory where you want to search.  The `-name` is the search condition.  You can use [wildcards](#L98AE7722-8FD0-4AC5-84B3-16E21CEF1B75) in your searches.  For example, to find the names that start with bootstrap do:

{lang="sh"}
~~~~~~~~
find . -name bootstrap\*
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> ./bootstrap
A> ./bootstrap/css/bootstrap-theme.css
A> ./bootstrap/css/bootstrap-theme.min.css
A> ./bootstrap/css/bootstrap.css
A> ./bootstrap/css/bootstrap.min.css
A> ./bootstrap/js/bootstrap.js
A> ./bootstrap/js/bootstrap.min.js
A> ~~~~~~~~

Note the `\` before the `*`: it is meant to tell the shell to leave the following `*` go, not to treat it as a wildcard, and pass it untouched to the program being invoked ---the `find` program, in this case---.  It is called an *escape*, and it is a trick used thorough.  If we had written the `*` without the escape this is what would have happened:

{lang="sh"}
~~~~~~~~
find . -name bootstrap*
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> ./bootstrap
A> ~~~~~~~~

The shell has expanded the `bootstrap*` to the existing `bootstrap` directory, and thus has called `find` as

{lang="sh"}
~~~~~~~~
find . -name bootstrap
~~~~~~~~

which is not what we wanted.

We can call `find` with all sorts of interesting arguments.  For example, if we want to limit the search to files we can say

{lang="sh"}
~~~~~~~~
find . -name bootstrap\* -type f
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> ./bootstrap/css/bootstrap-theme.css
A> ./bootstrap/css/bootstrap-theme.min.css
A> ./bootstrap/css/bootstrap.css
A> ./bootstrap/css/bootstrap.min.css
A> ./bootstrap/js/bootstrap.js
A> ./bootstrap/js/bootstrap.min.js
A> ~~~~~~~~

Or we can find the files that have been modified in the last minute,

{lang="sh"}
~~~~~~~~
find . -name bootstrap\* -type f -mtime -1m
~~~~~~~~

We get nothing, because none of the files has been modified in the last minute.  Let's force it by using `touch` on one of the files.  With `touch` you set the file's access time to now (and you create the file if it didn't exist):

{lang="sh"}
~~~~~~~~
touch ./bootstrap/js/bootstrap.js
~~~~~~~~

And now search again,

{lang="sh"}
~~~~~~~~
find . -name bootstrap\* -type f -mtime -1m
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> ./bootstrap/js/bootstrap.js
A> ~~~~~~~~

{#L3E414D1D-B639-4DFA-98FD-42FBD5C5E9D9}
## Looking for differences between files


The `diff` program returns the difference between two files, using a clever but easy to understand [syntax](http://en.wikipedia.org/wiki/Diff#Unified_format).  Let's take two identical files: the `index.html` file, and an exact copy:

{lang="sh"}
~~~~~~~~
cp index.html another.html ; ls
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> another.html    bootstrap/      index.html
A> ~~~~~~~~

Let's run `diff` on them:

{lang="sh"}
~~~~~~~~
diff index.html another.html
~~~~~~~~

Nothing.  Good.  When two files are identical there is no difference.  Remember what was on `index.html`,

{lang="sh"}
~~~~~~~~
cat index.html
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> Hi there
A> How's that going?
A> ~~~~~~~~

Let's [append](#L477EE735-E4B8-46EF-8829-FE3DF0B69AE0) another line in `another.html`,

{lang="sh"}
~~~~~~~~
echo "Yet another line" >> another.html
~~~~~~~~

and another one, just for fun,

{lang="sh"}
~~~~~~~~
echo "This is the last line" >> another.html
~~~~~~~~

Now check the contents,

{lang="sh"}
~~~~~~~~
cat another.html
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> Hi there
A> How's that going?
A> Yet another line
A> This is the last line
A> ~~~~~~~~

Nice.  Let's check again the output of diff,

{lang="sh"}
~~~~~~~~
diff index.html another.html
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> 2a3,4
A> Yet another line
A> This is the last line
A> ~~~~~~~~

Here it is.  It tells you that, after line 2, lines 3 to 4 have been added, and it lists the new lines.  This is something that you'll use all the time to answer questions like did I change this file?  Is it the same as that other file?

{#L3A076896-07A4-4750-9961-B3C0F7FC5894}
## Find text in files


The `grep` program can find text in files.  For example, to extract from `index.html` the line that contains the word `that` you can do

{lang="sh"}
~~~~~~~~
grep that index.html
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> How's that going?
A> ~~~~~~~~

You can call it with several files, and it will tell you to which file the line or lines it found belong:

{lang="sh"}
~~~~~~~~
grep there *.html
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> another.html:Hi there
A> index.html:Hi there
A> ~~~~~~~~

If you want to match words ignoring differences between capital and non-capital letters you can use the `-i` option,

{lang="sh"}
~~~~~~~~
grep -i yet *.html
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> another.html:Yet another line
A> ~~~~~~~~

{#LB0CF8902-D731-4D01-B881-D14A42D0243F}
## Finding words in files of a particular type


This is another problem that pops out very often.  Say you want to find which among your Python files (ending in `.py`) include a particular word, and that your files are spread in several subdirectories.  Or, as we are going to do, which among your `.html` files contains the word `there`.  Let's first move one of the files to a directory,

{lang="sh"}
~~~~~~~~
mv another.html bootstrap ; ls
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> bootstrap/      index.html
A> ~~~~~~~~

The first thing we need to do is to find all the `.html` files, and we [know](#L959FBF99-8C5C-4470-9B85-7C11C31A0E45) how to do that:

{lang="sh"}
~~~~~~~~
find . -name \*.html
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> ./bootstrap/another.html
A> ./index.html
A> ~~~~~~~~

Now we would like to pipe this results to `grep`, but we have a problem: the output of `find` is just text; it happens to represent file names, but if we send it go `grep` as is `grep` will never know.  It will think it is plain old text, and it will search for whatever we want to find within it.  For example,

{lang="sh"}
~~~~~~~~
find . -name \*.html | grep another
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> ./bootstrap/another.html
A> ~~~~~~~~

We've found the line that contains another, but we've done nothing to the *contents* of the files.  This is useful when you want to find a file whose name contains a word, but now we want something else: we want to peek inside the files.

In order to do that we need another program: `xargs`, which is kind of tricky: it takes standard input and a program, and arranges things so that the standard input is sent as the files of that program.  For example, lets send the name of a file to standard output, to be piped:

{lang="sh"}
~~~~~~~~
ls *.html
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> index.html
A> ~~~~~~~~

Now we pipe it to `xargs`, so that it goes to its standard input:

{lang="sh"}
~~~~~~~~
ls *.html | xargs grep -i hi
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> Hi there
A> ~~~~~~~~

Whatever `xargs` received in standard input (in this case, the output of `ls`) it sent as a parameter to the program `grep -i hi`.

Knowing this, we can refine our incantation so that it does search inside files, as

{lang="sh"}
~~~~~~~~
find . -name \*.html | xargs grep -i hi
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> ./bootstrap/another.html:Hi there
A> ./bootstrap/another.html:This is the last line
A> ./index.html:Hi there
A> ~~~~~~~~

Do you see why it found two lines in `./bootstrap/another.html`?  Remember that `-i` stands for ignore case.

It turns out there is another way of running a program on all the files found by `find`.  I think it is messier, so I only use it in the one ocasion in which the above command is messed up: when your file names include spaces.  You do it with the `-exec` argument to `find`, followed by the command, ended in `\;`.  In the place where you want the file names you put `{}`:

{lang="sh"}
~~~~~~~~
find . -name \*.html -exec grep -i hi {} \;
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> Hi there
A> This is the last line
A> Hi there
A> ~~~~~~~~

This sort of works, but it does not print the file name where the line was found.  This is because `grep` has been called once per file, every time a file was found, instead of one time with all the files as before.  And when you call `grep` with only one file it assumes you know what file you sent, and it does not write it back.  In this case we don't know it, because it was `find` doing the calling, so we ask `grep` to output the file name as well with the `-H` option:

{lang="sh"}
~~~~~~~~
find . -name \*.html -exec grep -i -H hi {} \;
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> ./bootstrap/another.html:Hi there
A> ./bootstrap/another.html:This is the last line
A> ./index.html:Hi there
A> ~~~~~~~~

Much better.  Another thing to know is that you can usually group arguments.  In this case, the `-i -H` can become `-iH`, and it should still work:

{lang="sh"}
~~~~~~~~
find . -name \*.html -exec grep -iH hi {} \;
~~~~~~~~

A> {linenos=off}
A> ~~~~~~~~
A> ./bootstrap/another.html:Hi there
A> ./bootstrap/another.html:This is the last line
A> ./index.html:Hi there
A> ~~~~~~~~

In fact, this is what we were doing when calling [`tar`](#LFE07EC99-5CCE-49B9-B9BA-D7A3AB674A47) (remember the `zcvf` and `zxvf`?).  But `tar` is special in that it lets you not put the `-` in its optional arguments.

{#L3382CF10-CE7F-4A70-BE19-27435A62353B}
## Looking for help


This section might be a bit overwhelming.  Don't worry: you don't have to remember it all.  You know how to look for [help](#LA6586ED3-AC24-4480-8B15-DAB7FD956ADF), and you will develop an intuition that tells you "I am sure there's a way to tell this program to behave like this".  For example, I didn't remember about the `-H` argument to `grep`, but I knew it had to be there.  So I checked in the man page, and there it is.  The things that you use all the time ---and this will include the `find` piped to `xargs` with `grep`--- you will remember without problems.


