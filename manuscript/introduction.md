

# §1 --- Introduction

There is a better way to deal with computers.  Hackers have been developing and using it for at least 40 years: it is the way of the command line, of the conversation with the computer in languages that are neither human nor machine, but a carefully crafted middle ground.  Hackers, by the way, is how we call people who know well their tools, who dare to explore, and who need to build things.  In the words of master hacker [Paul Graham](http://paulgraham.com/gba.html), "To programmers, 'hacker' connotes mastery in the most literal sense: someone who can make a computer do what he wants".

You'll find the tools of the hackers in Linux, in OSX, in a [Raspberry Pi](http://www.raspberrypi.org), and running most of the web.  By learning them you'll become much more productive, and a realm of things that were previously unthinkable will become possible.  You will became able to talk your computer into doing what you want.  And you will be mastering the tools that scientists, programmers, engineers, statisticians, mathematicians and analysts all over the world are using.

{#LA4157432-5137-4A7B-A8DA-97F07B3BD234}
## Why this book


Some months ago my 15 year old son came up with what he thought was a great business idea.  He would build a website about his favorite music band.  Then he would have lots of visitors, and he would sell them something or other and thereby make tons of money.  I of course dismissed it as one of his bold late-night, think-big plans, and secretly worried that he would end up going to business school and into marketing.  But then he started actually working, and he did so along a line I had not foreseen: he opened an [Instagram account](http://instagram.com/rageandloveidiot), and started working on building a following.

And he asked me for help in learning the basics of building a professional-looking website.  I could have pointed him to a web-site building site, but I thought I might as well try to use the opportunity to help him learn some actually useful skills.  Luckily he was game for the experiment, and over the following months he learned quite a bit about how people in the real world actually go about building stuff.

From editing files to the tools for keeping his project organized, from HTML to how to send his files to the server:  he had to learn about problems he didn't yet know he had, and the software we use to solve them, and how it all fits together.  Most importantly, he had to learn to explore, not to be afraid to try things out, to prototype.

At about the same time, his 13 year old brother started getting serious about the Raspberry Pi.  They had built a non-crashing car with an Arduino, a distance sensor and a couple of motors, and he wanted to make it location-aware.  His first idea was that he wanted to be able to tell it where to go, and the thing would find its way.  Their ambition matches their naivete, my boys.  It took me some cajoling, but he ended up accepting that a first version of his car could be something with a video camera that he could guide from a computer.

I decided that I'd do the same I did with his brother: use the project to help him learn some useful stuff.  By adding a Pi to his car he could connect to it via wifi.  He could write Python programs in the Pi, and get them to talk to the Arduino using the serial port.  It turns out that the tools he needed were pretty much the same ones his brother was learning: those that let you navigate the UNIX-based world.

The process of teaching them is both rewarding and frustrating.  It is easy to overlook things you take for granted, but that are absolutely essential for understanding; this oversight results in frustration.  The reward is the look of happiness and comprehension when they finally understand what they are doing, and their elation when they realize that they can actually build good looking stuff that works great.

We are working on it.  The elder has already put his website online, [the best Green Day site](http://rageandloveidiot.com) ever on the internets, and the younger is figuring out how to make the Pi camera work and send him video to the Mac.  But they still don't know about git, and I catch them from time to time reaching for the mouse when editing in Emacs.  So there's some way to go.

{#LC9D1ED72-BBBE-4F9C-8201-19B31F703E0C}
## The UNIX tools and environment


Over the last couple of decades the UNIX environment and toolset has become increasingly prevalent in research institutions and development labs.  Programmers find it powerful and efficient, and they often go for it when given the choice; scientists find its tools the best suited for most computing tasks.

It used to be that programmers had to develop in whatever operating system their users had (Windows, in most cases).  But the web runs mostly in web servers and web browsers; most servers are UNIX-like, and the browsers need to work everywhere.   That has given the people programming for the web the freedom to chose their environment, and many have chosen Linux and Mac OSX, both flavors of UNIX.  When people learn how to use them, as you will have by the end of this book, they find themselves much more productive ---and much more powerful--- than they used to be.  There's no going back.

Scientists have also gravitated towards UNIX-like environments.  They are rock solid, can be made very fast, and the readily available set of tools allow them to get the job done.  If your job requires data analysis and exploration, or building models, it will pay you to be at home in a UNIX-like environment.  If you want to work in a world-class development or research organization you'll most likely be expected to be proficient using it.

### The rise of open source

When I started to work at an HP research and development lab in 1996 I didn't know much about UNIX.  But it soon became clear that it was what one used to do real work. As an R&D engineer I had a [HP 735](http://en.wikipedia.org/wiki/HP_9000#Series_700) sitting on my desk, which was a Real Computer, running HP-UX, HP's version of UNIX.  It had a huge screen, a big, noisy keyboard, and a clumsy mouse.  I loved it.  Task automation, data gathering, analysis, models, everything that sounded like engineering proper ---plus email--- was done on it.  The Windows PC was only used for documents (Amipro, now unreadable) and spreadsheets (Lotus 123).

At about the same time I found out that I could have Linux on my PC at home.  It was not easy: I would install it from a set of around 15 diskettes from a Slackware distribution that my brother would download at the University; later on, I would buy RedHat Linux, and it would arrive home in a nice blue box with a CD on it.

I used Linux to do my PhD work, because I quickly found out that I was much more efficient with it.  And I was in control, much more than I had ever been with my previous work environments (which go all the way back to CP/M on an [Osborne](http://en.wikipedia.org/wiki/Osborne_1).  My father still owns it.)  Most significant, they were the same tools that we were using at HP, on a first-line research lab using very expensive computers.

And the tools I learned about back then are, with few exceptions, the same that I am using today.  It used to be that only hard-core CS majors and mathematicians would be familiar with them; nowadays, many of the people we hire from most science disciplines are at home in Linux, and expect to be able to work with the UNIX toolset.

### What you will learn

By the end of this book you'll be familiar with the command line interface to your computer ---and to your server--- and the classic UNIX tools you can run on them.  You'll know how to edit files using Emacs and Vi, the two classic UNIX editors.  You'll be organizing your files in an efficient manner and managing them using git and github.  You'll have learnt how to go about writing programs in Python, how to write and publish a professional-looking web-site, and how to connect a computer to a Raspberry Pi and make it do cool stuff.

The scope is large and the coverage will be shallow.  I shall not attempt to write a full reference to these tools: only to give you enough of a push to get you going.

There are many things to learn, but none is of great complexity.  Some, like the commands your editor understands and a bunch of UNIX utilities, you need to interiorize in muscle memory until they become automatic.  Others you'll just have to know they exist, and where to look them up.

I will pick for you, and my choices will reflect my own personal preferences.  They are not particularly controversial: many professional developers nowadays are using similar setups to the ones I'll be showing here.  Some of them I feel very strongly are the the right ones: you should use a UNIX-style environment like Linux or Mac OS-X.  Others are a matter of personal taste: I'd rather use Emacs than Vi for editing, but the alternative is a very good one as well.  Some probably reflect fashion: the fact that most people are using git instead of mercurial for version control is probably due to the success of [github](http://github.com), for example.  You'll probably want to learn git first, but don't rule out learning other version control systems down the road.  The important thing is that you know what version control is, and that you make it part of your work-flow.

Some parts of the tool set are more stable than others. I have been using Emacs, Vi, and the classic UNIX tools since 1996, but over this time I have controlled my sources with tar, RCS, CVS, subversion, and git.  Each one of them has been a large improvement over its predecessor.  But today git is here to stay, as are the classic editors and tools, and it's well worth your time to learn them well.

You should learn by doing, and you should explore.  Do not be afraid of trying things out.  Do not concern yourself too much with breaking things.  Thanks to git ---and to the good working practices you will be acquiring--- you'll always be able to go back in time and recover an earlier working version.  The first law of software development is that you don't understand your problem until you have implemented a solution, so don't be shy about it.

### The environment

My first intention was to focus in OSX, which is what I use.  But then I realized that this would leave out the many people who cannot afford a Mac, and that there is a very cheap but still viable alternative: the kind of tools we'll be using are perfectly happy to run on a \$30 Raspberry Pi as well.  And my son happens to have one, courtesy of his grandfather.  So I'll show you how to use both OSX and a Pi.  Pretty much everything we do applies to a Linux machine as well, if that's your choice.

{#LEA23F701-E436-4E1F-816D-A5289DD2BD20}
## The development process



### Prototype and adapt

It is in the nature of the design of complex things that you never know in advance what you'll really want it to look like when you are done.  Surely you have an idea of what problem you want to solve, and how you are going to do it; but as you build it you'll become aware of all sorts of complexities and crevices hiding beneath the surface, and you'll adapt, and you'll learn about the problem you are trying to solve.  In most cases you'll end up with something that is not what you first envisioned.  And that is a good thing.  You'd otherwise have missed an excellent opportunity to learn.

This fluidity of the design and construction process is most apparent in building software, but it was ever thus.  In more traditional engineering disciplines it happened during the design part of the development cycle, in the form of changing specs and design drawings, long before the concrete was cast.  What makes software special is that the drawings are also the product.

### Start small, be nimble

Don't set up to build a new facebook.  Don't be concerned about scalability, or millions of users.  Focus instead of testing your ideas, on having online something you can learn from as soon as possible, and on building it in such a way that you can change it fast.

The tools you'll be learning about in this book will enable you to go back in time to an earlier version of your projects; explore different options by keeping different versions of your work and moving between them; put them online fast and easy, and setup and manage your servers; edit your work efficiently, and manage it properly.  The goal is to help you do the things that need doing and move along.

{#L029EE8C0-9F04-49A3-8DB2-B67B981E55FE}
## The Way of the Future


The importance of the UNIX tools and environment as the platform in which computing is done will continue growing.  Some programs will change, new utilities and programming languages will appear, but they will live and prosper in UNIX soil.  I am encouraging my kids to learn the tools of the trade ---in a way, I am writing this book for them--- because I am convinced that they will find them useful in almost any endeavor they are likely to chose.


