---
layout: default
title: "A walk through the Magit interface"
date: 2017-09-01 16:30:00 +0200
categories: [magit, magit-campaign]
---

[a-magical]:    /2017/09/01/the-magical-git-interface#start

[Magit]:        https://magit.vc

[solarized]:    https://github.com/bbatsov/solarized-emacs
[zenburn]:      https://github.com/bbatsov/zenburn-emacs

<div id="prelude" markdown="1">
{% markdown campaign-prelude-part1.md %}
{% markdown campaign-prelude-part2.md %}
{% markdown campaign-prelude-part3.md %}
</div>
{% markdown campaign-prelude-part4.md %}

# A walk through the Magit interface

This article demonstrates some of Magit's most essential features in
order to give you an impression of how the interface works.  It also
hints at some of the design principals behind that interface.

But this is only the tip of the iceberg.  Magit is a complete
interface to Git, which does not limit itself to the "most essential
features everyone needs".  I hope that this article succeeds in
demonstrating how Magit's focus on work-flows allows its users to
become more effective Git users.  Here we concentrate on some
essential work-flows, but note that more advanced features and
work-flows have been optimized with the same attention to detail.

If you would rather concentrate on the big picture, then read the
article [Magit the magical Git interface][a-magical] instead (or
afterwards).

## In Magit everything is actionable

Almost everything you see in a Magit buffer can be acted on by
pressing some key, but that's not obvious from just seeing how Magit
looks.  The screenshots below are accompanied by text explaining how
what you see can be used to perform a variety of actions.

Regardless of where in a Magit buffer you are, you can always show
more details about (or an alternative view of) the thing at point
*without* having to type or copy-paste any information, as you often
would have to do on the command line.

## The status buffer

The status buffer, which can be shown while inside a Git repository by
typing <i>C-x g</i> (<i>Control+x</i> followed by <i>g</i> [^1]), is
Magit's equivalent of typing `git status` in a shell.  It shows a
quick overview of the current repository.

[^1]: <i>C-x g</i> is actually only the *recommended* binding for the
    command `magit-status`.  To use this binding add `(global-set-key
    (kbd "C-x g") 'magit-status)` to the init file `~/.emacs.d/init.el`.

![](https://magit.vc/screenshots/status.png)

As you can see, Magit shows more information than Git.  On the command
line, you would have to also use `git diff`, `git diff --cached`, `git
log --oneline origin/master..`, `git log --oneline ..origin/master`,
and a few other commands to get the same information.

### Other Emacs themes

Many themes exist for Emacs.  Throughout this guide we use
the [Solarized light][solarized] theme, but here is how the status
buffer looks when using some other popular themes:

#### Solarized dark
![](https://magit.vc/screenshots/status-solarized-dark.png)
[Homepage][solarized]

#### Zenburn
![](https://magit.vc/screenshots/status-zenburn.png)
[Homepage][zenburn]

#### Light Emacs default
![](https://magit.vc/screenshots/status-light-default.png)

#### Dark Emacs default
![](https://magit.vc/screenshots/status-dark-default.png)

## Hiding details

You might have noticed that some diff hunks, those for `README.md`,
are not shown.  That's because the respective sections have been
collapsed.  You can collapse diff sections and any other section
(which are larger than a single line) by moving the cursor into it and
then pressing <I>TAB</I>.

Note that the current section is highlighted with a different
background color so that you always know the extent of the current
section.  If you moved up one line, "Unpulled from origin/master"
would become the current section.  The current line as well as all the
commits that follow would be highlighted

If you don't currently need to know any details about the unpulled
commits, then you could now type <I>TAB</I>.  After doing so you still
see the name of the upstream branch and how many commits it is ahead
of `master`, but the details (the individual commits in this case) are
hidden.

If you want to see them, just type <I>TAB</I> again.  On the command
line you would have to type something like `git log --oneline
..@{upstream}`.

In Magit's status buffer you can always show as much or little as
currently appropriate without having to remember both the command that
shows little or much information.  Instead you can temporally hide or
show details as needed by pressing a single key.

After hiding as much as possible, a status buffer looks like this:

![](https://magit.vc/screenshots/status-hidden.png)

Here is the same buffer, showing a little more than that:

![](https://magit.vc/screenshots/status-more.png)

## The status buffer is automatically updated

*If you use Emacs to edit and save a file which is located inside the
repository or if you use Magit to perform some action such as staging
a change, then the status buffer is automatically updated.*

And if you change something outside of Emacs, then you can press
<i>g</i> to refresh the current status buffer or <i>G</i> to refresh
all Magit buffers.

## Acting on what you see

*A major advantage Magit has over Git on the command line is that
nearly everything you see in a Magit buffer can be acted on.  Hiding
and showing a section is just one example of that.*

Besides <I>TAB</I>, another key that works nearly everywhere is
<I>RET</I> (<i>return</i>).  It shows a more detailed view of the
thing at point, be that a commit, branch, diff, hunk, stash, ...

## Commit details

For example, if you type <I>RET</I> while the cursor is on a commit,
then the message and diff for that commit are shown.

![](https://magit.vc/screenshots/commit-top.png)

In this case the diff does not completely fit into the window.  You
could hide some sections — the metadata, commit, and diffstat at
the top — to bring the complete diff into view, or you could
move down a few sections to view the rest of the diff.

![](https://magit.vc/screenshots/commit-bottom.png)

The basic keys movement keys are <i>C-p</i> to move up one section,
and <i>C-n</i> to move down one section.  <i>M-p</i>
(i.e. <i>Meta+p</i>, also commonly known as <i>Alt+p</i>) and
<i>M-n</i> would move to the previous or next section on the same
level as the current section.  The latter two commands can be used to
navigate Magit buffers more quickly by skipping child sections.  For
example, you could jump from one file to another without having to
step through the hunks of the first.

## Beyond the default action

If you were only interested in the diff but not the commit message in
the first place, you could have typed <i>d d</i> (<i>d</i> by itself
and then <i>d</i> again) in the status buffer instead of <I>RET</I>.

But you already pressed <I>RET</I>, now what?  Type <i>q</i> to quit
(i.e. hide) the current Magit buffer, in this case the commit buffer,
to go back to the previous buffer (more precisely the previous window
configuration).  In this case that would take you back to the status
buffer.

So while <I>RET</I> performs the most likely action for the thing at
point, there are many other keys which perform other, equally useful
actions.  There is <i>d</i> to show a diff, <i>l</i> to show a log,
and dozens more, some of which will be mentioned below.

## Invoking Git commands using popups

If the cursor is on the thing you want to act on, then it is very
convenient that many commands default to acting on that thing.  But
sometimes you *do* want to act on some other thing. It might be
inconvenient to first move to its representation in the current
buffer, or the thing you want to act on might not even be present in
the current buffer.  Many commands therefore also allow you to act on
some other thing.

Above we pressed <i>d</i> twice to show the diff for the commit at
point.  Pressing <i>d</i> just once actually does something by itself:
it shows the "diff popup", which you can see below.

![](https://magit.vc/screenshots/popup-diff.png)

The window is split into two panes.  (Note that in Emacs, which
predates window systems, one would say the *frame* is split into two
*windows*.) The pane at the top still shows the status buffer, while
the pane at the bottom shows the diff popup.

The diff popup shows some actions at the bottom and some arguments,
which you know from your command line use of Git, at the top.

Previously we pressed <i>d</i> again.  That causes the popup
buffer/window to disappear and the "dwim" (do what I mean) diff
variant to be invoked.  As with most dwim variants, this particular
one acts on the thing at point.  Alternatively, you could press any
letter show under "Actions" (such as <i>s</i> to show the index).

Or you might want to show the diff for an arbitrary range, in which
case you would press <i>r</i>.  After doing so, you can type the range
with completion:

![](https://magit.vc/screenshots/diff-range.png)

## Popup arguments

Most popups also allow users to set arguments which will then be used
when the invoked action calls Git.  In the diff popup, for example,
one can enable the use of the `--function-context` argument by typing
<i>- f</i> before invoking an action.  When an argument takes a value,
then that is read from the user, using completion when appropriate.

Usually arguments are just used once.  When you later enter the same
popup again, then it is not enabled anymore.  However, you can save
the arguments you want to be used by default.  To do so, enter the
popup, set the arguments as desired, and then instead of invoking an
action, type <i>C-c C-c</i> to save them as the default for the
current popup.  These settings persist between Emacs sessions.

<i>C-c C-c</i> is only one of the commands that is available in all
popups.  To show them all, type <i>C-t</i>.

![](https://magit.vc/screenshots/popup-common.png)

## The popup of popups

There are many popups.  For the most commonly used ones, you will
quickly learn the keys you have to press because they are mnemonic.
Until then, or when you need to do something you rarely do, then the
"popup of popups" comes to the rescue.  Show it by typing <i>?</i>.

![](https://magit.vc/screenshots/popup-popup.png)

## Popups vs. direct commands

Many Magit commands are invoked by first showing the available
variants and then picking one of those variants.  (For many popups, it
is possible to press the same key twice to invoke the most common
variant, often a dwim variant.)  But there are also many commands
which are not implemented using such a popup.  We have seen the
hide/show command (<I>TAB</I>) and the visit command (<I>RET</I>) so
far.  Other such commands are staging (<i>s</i>) and unstaging
(<i>u</i>), which always act on the file or hunk at point.  These and
similar commands will be discussed below.

## Staging changes

Magit makes it very simple to stage and later commit only some
changes, while leaving other changes in the working tree to be
committed separately.

On the command line you have to invoke special staging and unstaging
sessions using `git add --patch` or `git reset --patch`, which is
quite cumbersome as you have to go through all the available hunks one
by one and in order.

In Magit, just act on what you see.  To stage only the `-59,7 +60,7`
hunk you would move there and simply press <i>s</i>, without having to
first tell Git that you don't want to stage `-45,13 +45,14` and then
also that you don't want to stage `-69,7 +70,7`.

![](https://magit.vc/screenshots/stage-before.png)

After you have done so, the buffer automatically updates and the
cursor is moved to the next hunk. Therefore you can stage multiple
hunks by pressing <i>s</i> multiple times, if that's what you want.
If not, then Magit won't bother you with the other hunks like Git
does.  The staged hunk now appears inside the "Staged changes"
section.

![](https://magit.vc/screenshots/stage-after.png)

Unstaging of course works the same way.  Move to a staged change and
press <i>u</i>.  You can also stage or unstage everything at once by
pressing <i>S</i> or <i>U</i>.

## Acting on the selection

You can also stage multiple files or hunks at once. To do so, mark
these sibling sections using the region. (The region is an Emacs term
for "the selected text".)

First press <I>C-SPC</I> to mark one end of the region, and then move
the cursor until you reach what should be the other end of it.
Alternatively you could use the mouse.  If the region constitutes a
valid "Magit selection" which can be acted on as a unit, then it looks
like the example below, where both `CONTRIBUTING.md` and `README.md`
are selected but `lisp/magit.el` is not.

![](https://magit.vc/screenshots/sibling-selection.png)

When such a selection is active, many commands which would normally
act on the current section instead act on the selection (i.e. all the
marked sections).  Staging (<i>s</i>) is such a command.

If a region is active, but it does not constitute a valid selection
because the sections that fall into it are not siblings of one
another, then the region looks as it usually does in Emacs.  That
makes it trivial to see if you are about to act on the current section
only or on the selection.

![](https://magit.vc/screenshots/no-selection.png)

## Staging parts of a hunk

Besides sibling selections, Magit supports a second selection, the
"hunk internal region".  You can mark just part of a hunk using the
region and then only stage (or unstage or otherwise apply) just that
part of the hunk.

Here you can see what it looks like when only the part of the hunk
which removes the word "older" is selected using the region:

![](https://magit.vc/screenshots/stage-region-before.png)

If you pressed <i>s</i> now, then only that part would be staged,
resulting in:

![](https://magit.vc/screenshots/stage-region-after.png)

(Note how conveniently the cursor is placed.  We take pride in such
details.  This particular detail might not be all that important when
looked at in isolation, but we go that little extra step in many
places, and that does make a difference.)

## Changing diff arguments

Instead of using a hunk internal region to just stage parts of the
hunk, you could also have told Git to make the hunks smaller using
the `-U` argument.  To do so, press <i>-</i> until the hunk in question
breaks up into two.  Use <i>+</i> to do the opposite.

This works in the status buffer as well as all other buffers that may
contain diffs.  So far we have seen plain diff buffers and commit
buffers.

As we have seen above, you can specify several arguments when using the
diff popup to create the diff buffer.  But when showing the status
buffer by pressing <i>C-x g</i> or when showing the commit buffer by
pressing <I>RET</I>, then that is not possible.  You can however change
the diff arguments used in the current buffer.  Press <i>D</i> to bring
the diff arguments popup.  It is very similar to the diff popup in
that it offers the same arguments, but instead of actions which show
some diff in another buffer, it offers actions which affect the
current buffer.

![](https://magit.vc/screenshots/popup-diff-arguments.png)

Press <i>g</i> to use the arguments that are currently selected in the
popup in the current buffer.  <i>s</i> sets these arguments as the
default for buffers of the same type, so if you did that in the status
buffer of some repository, then the same arguments would be used for
status buffers of other repositories that you subsequently create.
But this only lasts until you restart Emacs; to permanently save new
defaults use <i>w</i>.

A similar "log arguments" popup exists on <i>L</i>.

## Applying changes

Some other graphical tools approach Magit when it comes to the staging
features described above, but I don't think any one of them quite
makes it.  One more thing that sets Magit apart from these tools,
however, is that these features are not only available for staging and
unstaging, but also when "otherwise applying changes".

With Magit you can also discard, reverse, or apply, the file, files,
hunk, hunks, or region at point using the exact same interface as
described above.  For more information about these apply variants
[consult](/manual/magit/Applying.html) the manual.

## Arguments missing from popups

If you noticed that the diff popup lacked your favorite argument, then
fear not.  It is easy to add arguments to an existing popup,
as [described](/manual/magit-popup/Customizing-existing-popups.html) in
the manual.

Some arguments are missing because they are not actually required.
`--cached` falls into that category; it's not needed because you
simply use the "staged changes" diff variant (<i>s</i>) to show the
cached changes (those in the index) .

Other arguments, e.g. `--irreversible-delete`, are missing because we
have to strike a balance between making every argument available that
anyone might ever need and not overwhelming beginners with arguments
that "nobody will ever need".

(While it is fairly easy for a user to add additional arguments to a
popup, I intend to make it trivial.  It will be possible to temporally
show all supported arguments and then select which ones should be
shown by default, using a checkbox or similar.  In other words, users
will no longer have to "add additional arguments".  Instead they can
choose the ones they need.)

## Log buffers

Like it is possible to show a diff in a separate buffer, that is of
course also possible for logs.  To do so press <i>l</i> to show the
log popup, which looks like this:

![](https://magit.vc/screenshots/popup-log.png)

After choosing what log you want to see, that log is shown in the
actual log buffer, which looks quite similar to what you would get on
the command line.  Here is an example of the "show all branches"
variant (notice the arguments displayed at the top):

![](https://magit.vc/screenshots/log.png)

## Moving through logs

Things get more interesting once you press <I>RET</I> to show the
commit at point in a separate buffer.  Actually in this case it is
better to press <I>SPC</I>, which displays the same buffer but the
current log buffer remains the current buffer.  If you now move
through the log buffer using <i>C-p</i> and <i>C-n</i>, the commit
buffer is automatically updated to show the commit which the cursor is
on in the log buffer.

![](https://magit.vc/screenshots/log-and-commit.png)

## Innovative variants of many commands

As we have seen, Magit provides commands that allow invoking certain
variant of Git commands without having to remember and type many
arguments.  The "show diff for staged" changes, for example, is such
command that saves you from having to remember and type `--cached`.
That, while useful, isn't all that innovative by itself.  Also many
experienced users of the Git command line have probably created
aliases for that sort of thing by now.

But Magit also provides many truly innovative commands which go beyond
what you could do with aliases.  These include, among others, commands
for committing, rebasing, stashing, and branching.

## Committing

Press <i>c</i> to show the committing popup and then <i>c</i> to
create a regular new commit.  This calls `git commit` and arranges for
the current Emacs session to be used as the `$GIT_EDITOR`.  The commit
message buffer is opened in one buffer, and another buffer shows the
changes about to be committed.  When done, press <i>C-c C-c</i>.

![](https://magit.vc/screenshots/committing.png)

You can also amend to `HEAD` by pressing <i>a</i>.  This is just like
`git commit --amend`.  While editing the message while amending, press
<i>C-c C-d</i> to toggle between showing only the changes that are
being added to HEAD and all changes that will make it into the amended
commit.

There are also fixup and squash variants.  And then there are some
variants that don't exist in Git.  Because the terms used here do not
correspond to terms you might be familiar with from Git, this might be
a good time to show you how to get more information about a popup
action or argument.  To show information about the "reword" variant,
type <i>?</i> and then <i>w</i>, which gives you this:

![](https://magit.vc/screenshots/popup-help.png)

So "reword" lets you change `HEAD`'s message without adding any
changes to it.  Similarly "extend" adds the staged changes without
forcing you to review the message, which is quite useful for simple
typo fixes.

"Instant fixup and squash" let you pick a commit to be modified with
the staged changes, but then they immediately initiate a rebase.
"Instand fixup" is mostly like "extend" but on commits other than
`HEAD`.

The commit to be modified is picked using a specialized log buffer.

![](https://magit.vc/screenshots/log-squash.png)

## Rebasing

The rebasing popup also provides a variety of commands that are unique
to Magit.

![](https://magit.vc/screenshots/popup-rebase.png)

There is one variant which lets you edit a single commit, without
having to go through a list of commits to be rebased.  Simply go
to the commit you want to rebase in any log (of course including the
log of unpushed commits in the status buffer), press <i>r</i> to enter
the rebase popup, and then <i>m</i> to modify that commit.  Likewise
there is a variant which allows only editing the message of a single
commit.

When performing an interactive rebase (which is supposed to affect more
than a single commit), then this is done as usual by editing the file
`git-rebase-todo`, but Magit makes a few additional key bindings and
other convenience features available:

![](https://magit.vc/screenshots/rebase-edit.png)

When a rebase sequence is in progress, then a log-like section with
information about the rebase is shown in the status buffer.  Like in a
regular log, you can of course perform various actions on the listed
commits, like viewing them.  And of course conflicts are shown too.

![](https://magit.vc/screenshots/rebase-status.png)

You can resolve the conflict by visiting the file.  After
pressing <I>RET</I> on a conflict hunk you would see something like
this:

![](https://magit.vc/screenshots/smerge.png)

There you can use the Smerge package to do so in style, or you can
just edit the file.  You can also use the Ediff package, which shows
the two sides and optionally the common ancestor in separate windows.
Magit wraps the features provided by these packages, but since they
are not actually part of Magit, we skip looking at them in detail.

Of course you could also abort the rebase by pressing <i>r</i> again and
then <i>a</i>:

![](https://magit.vc/screenshots/popup-rebase-abort.png)

## Merging

The merging popup is quite simple.

![](https://magit.vc/screenshots/popup-merge.png)

When a merge is in progress, then the status buffer shows information
about that:

![](https://magit.vc/screenshots/merge-status.png)

## Fetching, pulling and pushing

Without going into any details, here are the popups for fetching,
pulling and pushing.

![](https://magit.vc/screenshots/popup-fetch.png)

![](https://magit.vc/screenshots/popup-pull.png)

![](https://magit.vc/screenshots/popup-push.png)

One thing worth noting though is that all of these popups feature a
"<i>p</i>ush-remote", an "<i>u</i>pstream", and an "<i>e</i>lsewhere"
variant.  A branch's "push-remote" is somewhat similar to the
"upstream", but it usually is a different branch.  The "push-remote"
is actually a Git feature, but not many Git users know about it because
it is hardly documented.  To learn more about the "push-remote" and
how it is different from the "upstream",
see [this](https://magit.vc/manual/magit/The-two-remotes.html)

## Branching

The branching popup is used to edit, create, and/or checkout a branch.

![](https://magit.vc/screenshots/popup-branch.png)

The "create new spin-off" variant is particularly interesting.  It
creates and checks out a new branch whose upstream is the previously
checked out branch.  Then it rewinds that branch to its upstream.
This is useful when you began working on some new feature directly on
`master` and then realize that you should be using a feature branch.

The branching popup is also one of the few popups that have a
sub-popup.  Press <i>C</i> to show the branch configuration popup.

![](https://magit.vc/screenshots/popup-branch-config.png)

In that popup you can see the values of some important Git variables
concerning the current branch.  The values obviously can be changed
using the shown keys.

<br><br>Footnotes:
