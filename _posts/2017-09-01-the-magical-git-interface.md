---
layout: default
title: "Magit, the magical Git interface"
date: 2017-09-01 16:31:00 +0200
categories: [magit, magit-campaign]
---

[a-visual]:     /2017/09/01/magit-walk-through#start

[about]:      https://magit.vc/about
[annou]:      https://emacsair.me
[atomatigit]: https://github.com/diiq/atomatigit
[emacs]:      https://www.gnu.org/software/emacs
[git]:        https://git-scm.com
[gitsavvy]:   https://github.com/divmain/GitSavvy
[hn]:         https://example.com
[home]:       https://magit.vc
[kick]:       https://kickstarter.com/
[manual]:     https://docs.magit.vc/magit/#Top
[ncurses]:    https://en.wikipedia.org/wiki/Ncurses
[quotes]:     https://magit.vc/quotes
[sublimegit]: https://sublimegit.readthedocs.io/en/latest/index.html
[vimagit]:    https://github.com/jreybert/vimagit
[walk]:       https://magit.vc/screenshots

# Magit, the magical Git interface

### Basic similarities and differences to other interfaces

Magit is a text-based user interface to Git.  It looks similar to the
output of `git` itself.  Unlike when using `git` directly, a Magit
user does not execute commands by typing them into a shell.  The main
entry point to Magit isn't the command-line but its status buffer,
which looks like this:

![](https://magit.vc/screenshots/status.png)

Unlike the read-only output of `git`, everything that you can see in
the status buffer, or any other Magit buffer, is actionable.  Commands
are invoked, not by typing them out, but by pressing short mnemonic
key sequences.  Many commands act on the thing the cursor is on,
either by showing more detailed or alternative information about it in
a separate buffer or by performing an action with side-effects on it.

Git GUIs are similar to Magit in that many things you can see in a GUI
can also be acted on directly.  Of course in a GUI you would normally
click on something to act on it, while Magit is primarily[^1] driven
using the keyboard.  But the differences between Magit and Git GUIs go
much further than just looks and input methods.

[^1]: Better mouse support, including drop-down menus, is one of the
      planned features.

Current GUIs only expose a limited subset of Git's features, while
Magit is an essentially complete interface.  And many of the actions
that GUIs do expose tend to only by available in some view or dialog
but not another, even though the object that the feature would act on
is visible in both.  In Magit, on the other hand, you can do virtually
everything with some object that can be done with objects of that type
in any other contexts.

So one could say that Magit combines the completeness of Git with the
interactive nature of a GUI, while not limiting the availability of
features to certain specialized views.  The result is an interface
that, with a little practice, is both faster and more intuitive than
either the command line or a GUI.

### What separates Magit from other Git interfaces?

Magit heavily relies on a few simple, yet powerful interface concepts.
What makes their application in Magit powerful isn't necessarily (or
only) some innovative approach, but the fact that these concepts are
applied very consistently across all features.  Let's look at the most
important of these concepts in more detail.

#### In Magit all output is actionable

Magit looks quite similar to the Git command line, prettier maybe, but
Magit remains a text based interface.  It is worth repeating that the
crucial difference between Git and Magit is that Magit's output is not
"read-only".

Instead all status information is automatically kept up-to-date and
relevant to the task at hand.  And most importantly everything that
can be seen is actionable.  Furthermore, unlike in GUI interfaces,
every action you might reasonably (based on your knowledge of what Git
itself can do) want to perform on some visible (or invisible) thing
actually is available, using only a single or very few mnemonic key
presses in most cases.

#### Magit is essentially complete

By now, Magit is an essentially complete Git interface.  That does not
only mean that it supports most Git features — most features
that are supported are also improved upon.

The reason that there still exist some gaps is that fully integrating
supported features into the interface, by taking advantage of Magit's
interface concepts whenever possible, is more important than trying to
achieve completeness for its own sake.

If I had to put a number on it, I would say that Magit supports about
90% of what can be done using `git`, while other third-party
interfaces are stuck somewhere around 60%.  But what is more important
than the relative completeness at any given time is that support for
all of Git features could be added to Magit without any changes to its
user interface concepts.

Magit enables even advanced Git users to perform nearly all of their
daily version control tasks with a fraction of the effort that would
be required on the command line, without having to drop to that
command line for "edge cases" as would be necessary with many other
interfaces.

#### Magit will grow with you

Magit does more than make it possible to use the commands that you
already know more quickly than on the command line.  By offering
specialized variants of common commands, optimized for certain common
work-flow variations, it also gently encourages its users to learn
more advanced concepts.

Like Git and unlike many graphical interfaces to it, Magit grows with
you as you move beyond the basics and start performing more involved
version control tasks.  Until you do, the more advanced features do
not get in the way.

Magit encourages (but never forces) its users to use Git features that
many users of the command line would deem too advanced and/or too
cumbersome to be used except in special circumstances.  Many of these
features simply are not available when using other GUI and TUI
interfaces.  Magit makes advanced features just as accessible as the
basic features, which even the less than enthusiastic Git user cannot
get around learning eventually.

With GUI interfaces many users at some point reach a level of Git
proficiency that forces them to drop back to the command line on a
regular basis even for things they do every day.  With Magit this will
only happen very rarely and only for things that even advanced users
only do irregularly.

More advanced actions are not harder to perform than the trivial ones.
With Git's porcelain the user not only has to learn a new concept, but
often s/he also has to deal with a more complex interface that comes
with the advanced task.  With Magit the user of course also has to
understand the concept and learn to deal with the more complicated
cases, but the interface for an advanced task is seldom more complex
than that of a trivial one.

#### Magit has co-evolved with its users

Initially, users new to Magit will likely only use a few basic
features and work-flows that they are familiar to them based on prior
exposure to `git` on the command line and to other GUIs and TUIs.

However, for reasons given before, most users will eventually start
using features that previously seemed too daunting or cumbersome to
use.  Another reason why doing so comes naturally is that Magit has
co-evolved with its users.

Magit has been around for many years, and historically many features
that are now being taken for granted did not exist.  Many features,
especially those concerning streamlined work-flows, were originally
proposed by users who enjoyed and had grown accustomed to some
existing feature, only to find themselves wondering why some other
feature was not as convenient to use.

This has been going on for many years now, so if you start using Magit
now, then chances are good that most work-flow improvements you might
come to desire have already been implemented.  And because those
features had seemed like obvious intentions at the time they were
first implemented, it might even be the case that they work exactly as
you would have expected.

This process has progressed very far, but it is not over.  If you are
missing some feature, then just ask.  If it is a simple feature, then
chances are good that that in a few days it won't be missing anymore.
I hope that by encouraging non-Emacs users to use Magit, we will also
get some fresh ideas.

Despite all this, it would be wrong to assume that Magit started out
with a predefined set of interface concepts and abstractions, and all
that was left to be done was incrementally filling in the gaps.

#### Magit streamlines work-flows

Magit does not — and maybe this is what ultimately separates it from
the competition — restrict users to a certain set of simple features
and tasks.  Magit supports and streamlines the use of Git features
that many users and developers of other Git clients apparently thought
could not be reasonably mapped to a non-command-line interface.

While Git offers many commands and arguments that perform a wide
variety of tasks, Magit goes one step further by not only preserving
that flexibility but by also providing higher-level commands that are
not so much bound by the (wonderful) underlying data-model and whose
design is instead primarily oriented on the actual tasks that users
often have to perform.

The output of Git commands can guide the user in their work, but on
the command-line users have to extract the relevant information
themselves, mentally and by manually feeding it to the next command.
Magit commands automates that manual step by taking advantage of the
interface context and the state of the repository to guide their
operation, which not only speeds up the process but also frees mental
capacities.

Additionally Magit provides many "variants" of often used commands
that are optimized for particular use-cases, as well as dwim (do what
I mean) variants that very reliably guess the user's intention based
on the cursor's position.  (In cases when the user wishes to act on
something other than the thing under the cursor or if s/he wants to
fine-tune the behavior using certain `git` arguments explicitly, then
that is of course also possible.)

{% include donate-main.md %}

<br><br>
