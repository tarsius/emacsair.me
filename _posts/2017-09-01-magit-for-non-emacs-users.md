---
layout: default
title: "Magit for users of other editors"
date: 2017-09-01 16:32:00 +0200
categories: [magit, magit-campaign]
---

[a-visual]:     /2017/09/01/magit-walk-through#start
[articles]:     /2017/09/01/campaign-articles#start
[campaign]:     https://www.kickstarter.com/projects/1681258897/its-magit-the-magical-git-client
[ncurses]:      https://en.wikipedia.org/wiki/Ncurses

[Atomatigit]:   https://github.com/diiq/atomatigit#atomatigit
[GitSavvy]:     https://github.com/divmain/GitSavvy#gitsavvy
[SublimeGit]:   https://sublimegit.readthedocs.io
[Vimagit]:      https://github.com/jreybert/vimagit#vimagit

<div id="prelude" markdown="1">
{% markdown campaign-prelude-part1.md %}
{% markdown campaign-prelude-part2.md %}
{% markdown campaign-prelude-part3.md %}
</div>
{% markdown campaign-prelude-part4.md %}

# Magit for non-Emacs users

Unfortunately most potential users are not aware of Magit.  Others
might be aware of its existence, but would not consider giving it
a try because it is implemented as an extension to the Emacs text
editor, and that's not what they are using.

That's something I intend to change over the next year, beginning with
this article, because I think that Magit can be an excellent Git
interface even for users of other editors and IDEs.  I am under the
impression that many Git users want, or would at least appreciate,
something like Magit.  It seems worthwhile to invest some time to help
some of those potential users get over the initial hurdles.  And yes,
I do hope that some of those people will support the
[fundraising campaign][campaign].

Magit itself has a relatively flat learning curve, provided one
already knows a bit about both Emacs and Git.  Without prior exposure
to Emacs, it is somewhat steeper.  However I believe that, aside from
Magit possibly not looking very impressive at [first sight][a-visual],
the largest factor that prevents potential users from taking it for a
spin is the (real or perceived) learning curve (and unfortunately also
reputation) of Emacs.  Emacs users of course think that it is well
worth getting over that barrier, but that won't help or convince
anyone who intends to stick with their current editor or IDE and just
wants to give Magit a try.

I won't try to change anyone's opinion about Emacs itself.  I consider
it to be a wonderful text editor, and, more importantly in this
context, an excellent environment for implementing a text based
interface to, say, a version control system.  You can think of Emacs
as a vastly more capable alternative to [ncurses], i.e. as an
open-ended environment that facilities the implementation of all kinds
of applications.  Parallels to web browsers can also be drawn.

For people who use something different than Emacs for editing
purposes, using Magit isn't any different from using that editor/IDE
and a separate Git GUI interface and/or `git` on the command line.  In
such a scenario some benefits that result from the tight integration
of the version control interface into the editing environment are
lost, but even without that, Magit still provides many benefits over
using an equally separated but either much more limited (GUI) or
inefficient (command-line) interface.

## Making Magit more accessible

Making Magit accessible to non-Emacs users has not been much of a
concern until now.  But that is about to change.  Magit itself has to
be made more beginner friendly, to begin with.

### Mouse support

Emacs, and by extension Magit, is largely driven using the keyboard.
If your primary interface to Git currently is a GUI, then that might
amount to an additional hurdle.  Most Magit key bindings do not
involve any modifiers and are mnemonic, so it shouldn't be hard to
learn the essential ones.  It is also possible to use the mouse for
navigation, but it is not yet possible to use it to invoke commands.
But I will soon implement better mouse support, starting with simple,
context-aware drop-down menus.  That would greatly increase
discoverability, which would also benefit existing users.

### Documentation and configuration

Maybe even more importantly though, the barrier that comes before one
can start learning to use Magit has to be reduced.  This involves
mainly two improvements: tailored documentation and ready-to-use
configuration sets that target specific user groups (e.g. Vim users),
and that limit Emacs to Magit and not much else.  These configurations
will be fairly simple and well documented, allowing users to
selectively remove certain restrictions once they have grown more
accustomed to Emacs, when and if they are ready and motivated to use
more of Emacs.  The documentation will cover simple, fully tested, and
(where necessary) OS-/distribution-specific installation instructions
for both Emacs and Magit.

### Command-line interface

Finally, I intend to expose a limited subset of Magit's features as
commands that can be used in a regular shell.  For example `magit
diff` will be an interactive alternative to `git diff` and take the
same arguments.  Among other things, this command will allow quick
access directly from the command line to the superior staging
interface.  The staging interface is only a small part of Magit, but
it is an essential one and exposing it as a separate command would
allow newcomers to get started with Magit without having to go all in.

## Magit as a source of inspiration

Magit has inspired some Git extensions for other editors, including
[Vimagit], [Atomatigit], [GitSavvy], and [SublimeGit].  But
unfortunately these extensions only implement a small subset of the
functionality provided by Magit.  There appears to be a focus on
implementing the status buffer along with the staging interface, which
is a good place to start, but Magit is much more than this.

Magit has demonstrated that it is possible to implement an interface
to Git that is just as capable as using `git` on the command line,
while being faster and more consistent.  While these other extensions
have at least demonstrated that, given enough resources and while
making some compromises, something similar could be implemented for
other editors.

After reading some of the [articles] about Magit, you might be
interested in Magit but never-the-less not be willing to learn enough
Emacs to take it for a spin.  Even if that is so, I would like to
kindly encourage you to contribute to the campaign with a small amount
anyway and/or to let other people know about this project and the
[campaign].  Its success would not only allow me to make Magit even
better for existing users, but also make it more accessible to new
users.  If the effort required to get started with Magit seems to
large at this point, then please help me to change that.

Even if you don't intend to ever us Magit, you might still benefit
from the success of the campaign because I intend to create video
tutorials and other resources that would allow non-Emacs users to see
what version control could be like. That in turn would make it much
more likely that someone creates another magical interface, but this
time for your editor or IDE of choice.
