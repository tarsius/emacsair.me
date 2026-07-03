---
layout: default
categories: melpa
date: 2026-07-03 20:15:00 +0200
title: "Announcing two new experimental MELPA channels"
excerpt: >
  I am excited to announce that we have finally added two new
  experimental MELPA channels.
---
[rel-reddit]: https://old.reddit.com/r/emacs/comments/1umm2zp
[MELPA]: https://melpa.org
[Emacs]: https://www.gnu.org/software/emacs

## {{page.title}}

<small>[MELPA] is the original and independent [Emacs] Lisp package
archive.</small>

A few days ago we have published two new MELPA channels, **MELPA
Snapshots** and **MELPA Releases**.  For now these channels are
considered experimental and coexist with the traditional channels
*MELPA* ("regular" a.k.a. "unstable") and *MELPA Stable*.  Eventually
the *snapshots* channel is going to replace *unstable*, and *releases*
is going to replace *stable*.  But don't worry, if you are not ready
to update just yet; the new channels are still considered experimental
and the current thinking is that they won't replace the traditional
channels for around another year.

## Better version strings

After years in the making, MELPA is finally moving away from using
raw timestamps as version strings for development versions.  While
the traditional *unstable* channel uses the version string format
`YYYYMMDD.HHMM`, the new *snapshots* channel uses
`RELEASE.0.YYYYMMDD.COUNT`.

`RELEASE` is the latest release, i.e., the version distributed on the
*releases* channel.  `YYYYMMDD` is the committer date.  Instead of
appending the time to the date, `COUNT` is used; the number of commits
since the latest release (i.e., `RELEASE`).

If no release information can be determined, then `0.0` is used as
`RELEASE` and `COUNT` is the number of commits since the initial
commit.

If no new commits since that release touch any files, that are
included in the package tarball, then the same release is distributed
on the *snapshots* channel as well; build from the same commit and
using the same `RELEASE` version string as on the *releases* channel.

<small>That's all wonderful, but [just take me to the setup
instructions](#instructions).</small>

### Versions going up

The main advantage of not using raw timestamps as version strings for
snapshots is, that a snapshot version will no longer be greater than
*every* release.  That was a problem because it meant that *any*
snapshot seemingly satisfied the minimal dependency on even the very
latest release of a dependency.  E.g., `org-20040101.1234` is
considered greater than `org-9.8.6`, by `version<`.  The new snapshot
version strings do not have this issue:

```
1.2.3  <  1.2.3.0.20260701.4  <  1.2.4
```

### What about the zero?

Instead of just `.`, we inject `.0.` in between the `RELEASE` and
`DATE`.  We do that to allow package maintainers to add one version
string component when creating a new release, without throwing the
just mentioned improvement out of the window again.  I.e., `2.0 <
2.0.0.20260701.4 < 2.0.1`.

### Why DATE *and* COUNT?

Well, when that was first proposed, I mentioned that it has a definite
"designed by committee" feel to it, but I considered it a good
compromise and have come to actually like it.

I would have liked to use just `COUNT` because it is shorter and IMO
encodes more useful information than `DATE.TIME`.  That being said,
both `DATE` and `COUNT` are useful information, and so it makes sense
to encode both in the version string.

### Compatibility with other ELPA

A few weeks ago GNU-devel ELPA and NonGNU-devel ELPA also switched
to the `RELEASE.0.DATE.COUNT` format.  Version string compatibility
between different ELPA is important, so I finally gave up on the
`RELEASE.0.COUNT` idea, and returned my focus to getting *some* sane
format across the finish line.

## Sources of versioning truth

Until now, MELPA exclusively used git/mercurial tags to determine the
latest release and the commit corresponding to it, while (Non)GNU ELPA
exclusively use the `Version` or `Package-Version` library header.

Neither of these approaches is compatible with reality.  Many
maintainers use only tags, while many other maintainers use only the
library header.  To detect the latest release for most packages (that
actually do releases), a package archive has to consult both potential
sources of versioning truth.

For the new *releases* and *snapshots* channels we first consult the
tags, and iff there are no release tags, then we fall back to the
library header.

Because it considers both version information sources and also falls
back to using the `0.0` stand-in, if both version sources are void,
the *releases* channel features 6207 packages, compared to
*stable's* 3400.  (The reason why it doesn't feature all 6240
packages, available from the *unstable* and *snapshots* channels,
is that the latest releases of these 33 packages are defective.)

### Interlude I: How to create a release

I should expand on this in a separate post, but the gist is this:

Make sure you tag **exactly** the commit that bumps the `Version`
library header with the corresponding release tag.  This way, and
only this way, the same commit will be considered to be release `N`,
regardless of whether some tool looks at the header or the tag, and
regardless of how it deals with conflicting information, if it
supports both sources.

If you forget to create (or push) a tag, that is not a huge issues;
once you notice, just tag the commit that bumped the header.  If you
create a tag but forgot to bump the header, then that release is
broken and cannot be fixes, and you must create a *new*, greater
release.

<details>

<p>You do not want to end up in this situation:</p>

<pre>
ddddddd Ups, also bump version header      # 1.2.0 on GNU ELPA
- ;; Version: 1.1.0
+ ;; Version: 1.2.0
ccccccc Massive refactoring
bbbbbbb Totally harmless change
aaaaaaa (tag: v1.2.0) Release 1.2.0        # 1.2.0 on MELPA
</pre>

<p>If you did that, and a user reports an issue and mentions that they
are using "1.2.0", you won't immediately know which "1.2.0" and thus
whether this is a regression in "totally harmless change" or "massive
refactoring", or a long-standing issue that has so far gone unnoticed.
</p>

<p>Also don't do this:</p>

<pre>
zzzzzzz (tag: v2.0.0) Release 2.0.0        # 2.0.0 on MELPA
  ...
  many commits
  ...
bbbbbbb Begin work toward 2.0.0            # 2.0.0 on GNU ELPA
- ;; Version: 1.2.0
+ ;; Version: 2.0.0
aaaaaaa (tag: v1.2.0) Release 1.2.0
</pre>

<p>You might think this is obvious, but unfortunately there is a large
number of packages, for which the two sources of versioning truth do
not agree.</p>

</details>

<a name="instructions"></a>
## How to switch to one of the new MELPA channel

Make sure you don't stop after the first step!

### Update the configuration

To switch from "regular" MELPA to the new *snapshots* channel, locate
a setting like this in your configuration

```elisp
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
```

and replace it with

```elisp
(add-to-list 'package-archives
             '("melpa" . "https://snapshots.melpa.org/packages/") t)
```

Or to switch from MELPA *stable* to the new *releases* channel, replace


```elisp
(add-to-list 'package-archives
             '("melpa" . "https://stable.melpa.org/packages/") t)
```

with

```elisp
(add-to-list 'package-archives
             '("melpa" . "https://releases.melpa.org/packages/") t)
```

Note that in these examples the name "melpa" is used, regardless of
what channel is used.  Since this is just a local name, and you should
never enable more than one MELPA channel anyway, this is a reasonable
name.  If you want to use a more precise name, like "melpa-snapshots",
that makes sense too.

### Force reinstallation of all packages

At lease when switching from the old "regular" MELPA channel to the
new *snapshots* channel, you have to first remove all installed
packages and then reinstall them.  Remember, we are switching from
timestamps such as `20260701.1234` to "smaller" version strings such
as `1.2.3.0.20260701.4`.  Because the former is greater (according to
`version<`), `package.el` won't automatically update to the latter.
Considering the version strings at face value, doing so would be a
*downgrade*.

So start by modifying `package-archives` (as shown above) and *copying*
`~/.config/emacs/elpa/` to some other location, before exiting Emacs.
Then restart Emacs and run `M-x package-refresh-contents`, followed by
`M-x package-install-selected-packages`

Nowadays, when you explicitly install a package, `package-install`
records that fact in the variable `package-selected-packages`, and if
some packages are listed in that variable without actually being
installed, then `M-x package-install-selected-packages` offers to to
reinstall them.

However, that was not always the case, or maybe some packages are
missing from that variable for some other reason.  To really make sure
that all packages will be reinstalled, you should compare the contents
of the new `~/.config/emacs/elpa/` with that of the directory you
previously moved out of the way.  If any packages are missing, then
the most likely cause is, that some other packages, which you have
explicitly installed, used to depend on them, but no longer do.  If,
on the other hand, you notice, that some package which you still want
are missing, then just reinstall them explicitly.

### Interlude II: Which channel should I use?

Personally, I recommend you soon switch from the "legacy" channel,
which you are currently using, to the respective "experimental"
channel.  If you want to play it safe, maybe wait a few weeks, in case
something unexpectedly explodes.

The more interesting question is whether to use snapshots/unstable or
releases/stable, i.e., which *type* of channel you should use, as
opposed to which "generation" of a given type you should use.  You
have already made that decision, so the short answer is "stick to your
decision".

<details>

<p>However, the new generation moves the needle somewhat, so you might
wonder whether the time has come to switch from using snapshots to
using just releases.  (The main reason being that for packages that
have not been released even once, the releases channel now features
the same <b>snapshots</b> as the snapshots channel, instead of
dropping those packages entirely.)</p>

<p>IMO that unfortunately isn't enough just yet.  The new channels
may, over time, encourage maintainers to release more often,
resp. start releasing in the first place.  I very much hope that will
happen, and once it does, I will happily recommend installing
releases.  But for now the rational for why snapshots should be
preferred remains unchanged:</p>

<p>By using the releases channel you can avoid regressions in actively
maintained packages, but at the same time you opt-in to using severely
outdated releases of other packages.  A regression is unfortunate, but
since those happen in packages being actively worked on, the fix will
likely follow suit soon.  The same cannot be said if a critical bug
was fixed three years ago and no release has been created since then.
While not impossible, it is unlikely that the maintainer of such a
package will decide next week, that the time for a new release has
finally come.</p>

</details>

## Package-Build v5.0.0 released

Package-Build is the tool used to build the package tarballs
distributed on MELPA.  Alongside the creation of the new MELPA
channels, I have also created a new release of this package.

This has been in the making for a few years, so v5.0.0 is a big
release consisting of 270 commits.  The release notes can be found
[here](https://github.com/melpa/package-build/blob/main/CHANGELOG#v500-----2026-07-01).
If you are a downstream of this package, then please have a look soon,
and make the necessary adjustments.  This release comes with breaking
changes, but where possible I have kept many obsolete functions and
variables.  For now at least.  I plan to remove these fairly soon,
because (potentially accidentally) using them, means missing out on
many of the improvements in this release.

## Coming soon, your very own ELPA!

While it was always *possible* to take MELPA, make some adjustments,
and then publish your own ELPA, that was rather unwieldy.  The MELPA
repository contains many files (and I don't mean the recipes), which
look relevant enough for you to want to study them first, and their
number made that a daunting task.

I have now created the MyELPA project, which is much simpler and
allows anyone to easily publish their own ELPA.  Like MELPA it uses
Package-Build, but is much less complex.  While it removes many bits
that are unnecessary when just publishing a small ELPA, it also *adds*
Forgejo (used on Codeberg) and Github action workflows, which greatly
simplifies publishing your ELPA.  By default your ELPA is published
using Forgejo or Github pages and the published webpage is rather
blant, but you are free to change the hosting, domain and/or the
amount of fluff you add to your landing page.

To learn how to create your own ELPA, visit the
[MyELPA wiki](https://codeberg.org/tarsius/myelpa/wiki).

<details>

<p>Not every package has to be added to MELPA.  Sometimes I get the
impression that some authors add their packages to MELPA, even if they
realize that they probably won't be used by anyone but themselves,
just because it is more convenient for them to be able to easily
install their own packages the same way as any other package.</p>

<p>For example, I think that very incomplete color themes and packages
that have been vibe-coded in a single day, are best left out of
MELPA.</p>

<p>I hope that by making it easier to publish one's own ELPA, Chris'
workload can be reduced.  For years now, and week after week, he
reviews all recipe submissions MELPA receives, almost entirely by
himself.</p>

</details>

## A final note

I make a living working on Magit, Transient and many other packages,
and on MELPA and the Emacsmirror, and then some.  Donations by users
of these packages and projects are my only income, so if you benefit
from my work and can afford it, please consider making a
contribution. — Thanks!

{%include donate-main.md %}

<br/><br/>***Comments on [Reddit][rel-reddit].***
