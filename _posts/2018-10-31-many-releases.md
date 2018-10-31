---
layout: default
title: "Many new releases"
date: 2018-10-31 23:00:00 +0100
categories: magit
excerpt: I am excited to announce new releases of many of my lesser packages.
---

I am excited to announce new releases of many of my lesser packages,
i.e. many of my packages that are not [Magit](https://github.com/magit/magit).

While working on these releases it turned out that I would have to ask
for a new release of one of the third-party packages some of them
depend on.  *While waiting for that to happen, I passed the time by
sprinkling some general remarks about releases of Emacs packages
across this set of release announcement.  It was the topic on my
mind.*

Some of the below releases should probably have been announced
separately but I don't have the time for that right now.

## [Ghub](https://github.com/magit/ghub) v3.0.0

This prepares for the initial release of the
[`forge`](https://github.com/magit/forge) package, an important
extension to `magit`.

- Add support for Gitea, Gogs and Bitbucket.  `ghub.el` supports these
  forges directly, but also add new libraries `gtea.el`, `gogs.el` and
  `buck.el`, which provide convenience wrappers just like the existing
  `glab.el`.  [#67](https://github.com/tarsius/ghub/issues/67)

- No longer split the repository into multiple Melpa packages.
  I.e. the `glab.el` library is now part of the `ghub` package.

- Add support for automatic GraphQL unpagination.
  [#68](https://github.com/tarsius/ghub/issues/68)

  GraphQL was designed around the idea that you should be able to "ask
  for what you need and get exactly that".  Unfortunately this does not
  cover the "look, if I persist, then you are going to hand me over all
  the data anyway, so just caught it up already", which is what Forge
  needs.

  `ghub--graphql-vacuum` provides a way to unpaginate all cursors in the
  returned data without having to write a lot of boilerplate.  Callers
  have to provide the query as an s-expression that corresponds to the
  root request.  The queries needed to follow cursors in arbitrary
  locations within the returned data, are automatically derived from
  that query.

  `ghub-fetch-repository` fetches information about a repository.
  If also serves as an example for how to use `ghub--graphql-vacuum`.

  The initial queries used by `ghub-fetch-issue` and
  `ghub-fetch-pullreq` are pre-narrowed variants of the initial query of
  `ghub-fetch-repository`.  Pre-narrowing is somewhat similar to the use
  of fragments, but unlike that, it doesn't result in lots of duplicated
  boilerplate and/or lots of variables.

  There is very little documentation and everything is still very much
  subject to change.

- Bind `url-show-message` to `nil` so that the more useful messages
  displayed by the callers of this package are visible to the user
  instead of the less useful "Contacting host: api.github.com:443".

- Sometimes Github returns an HTML document instead of the promised
  JSON when an error occurs.  Try harder to extract some meaningful
  information from that document.

- Work around a bug in older Emacsen that prevented `auth-source` from
  retrieving saved secrets.  [#64](https://github.com/tarsius/ghub/issues/64)

- Deal with a chicken and egg problem concerning 2fa.  [#65](https://github.com/tarsius/ghub/issues/65)

- Add new `ghub-clear-caches` command because if things go wonky it is
  nice to know it isn't the cache.

- Add new `ghub-repository-id` function.  This function works for all
  supported forges and always returns a string, even for less
  successful forges that can still get way with using integers as ids.

- Add new `ghub-graphql-rate-limit` function.

## [Closql](https://github.com/emacscollective/closql) v1.0.0

This library was written for `epkg`.  The upcoming `forge` package, an
important extension to `magit`, also uses it.  This release, `v1.0.0`
none the less, removes the scary "don't you dare use this yourself"
comment but I continue to consider it an internal library and there
still is no documentation.

- Added optional `replace` argument to `closql-insert`.  It non-nil,
  then this function uses `INSERT OR REPLACE INTO` instead of just
  `INSERT INTO`, allowing the caller to replace an existing row.

- Added function `closql-reload`, which, given a potentially outdated
  object, returns an up-to-date object.

- Replaced the slot property `:closql-columns` with `:closql-table`.  The
  value has to be a table instead of a vector of columns and its name
  can be different from that of the slot, which previously was not
  possible.  The slots are now determined by quering the database.

- Added new experimental function `closql--iref`.

## [Epkg](https://github.com/emacscollective/epkg) v3.1.1

Nothing interesting here.  In the process of making `closql` useful
for `forge`, I made an incompatible change that makes it necessary to
adjust `epkg`.

- Use the `:closql-table` slot property of `closql-1.0.0` instead of
  the `:closql-columns` property provided by older releases.

## [Borg](https://github.com/emacscollective/borg) v3.0.0

- Borg can now be used as a secondary package manager alongside
  `package.el`.  When used like this, then Borg itself should be
  installed from Melpa.  This is still experimental.  For instructions
  and help see [#46](https://github.com/emacscollective/borg/issues/46).
  The manual does not yet cover this topic.

- The commands `borg-assimilate` and `borg-clone` now require the user to
  confirm before acting on a package that is known to be (potentially)
  unsafe.  Note that this does not imply that other packages are safe,
  and also that the `epkg` package has to be available for this to kick
  in for the most dangerous packages — those from the Emacswiki, into
  which anyone could trivially inject malicious code.

- The new files `borg.mk` and `borg.sh` were added, replacing files that
  were previously located directly in the super-repository.

  The super-repository still contains a `Makefile`, which users who do
  not use the Emacs.g collective have to update manually, but failure
  to do so should be less problematic now, because this file only
  defines a single target needed to make `borg.mk` and `borg.sh`
  accessible during bootstrap, while using these files for everything
  it previously did itself.

  This makes it easier and safer to improve the respective
  functionality iteratively and to create configurations that are not
  based on the Emacs.d collective.

- The new user configuration files ``/.emacs.d/etc/borg/config.el` and
  ``/.emacs.d/etc/borg/config.mk` are loaded by `borg-build` and `make` if
  they exist.  These files are primarily intended to set the variables
  `borg-emacs-argument` (which see) and `EMACS_ARGUMENTS`.  The latter can
  also be used to set `EMACS` and/or to define new make targets.

- The new command `borg-insert-update-message` inserts information
  about drones that are updated in the index.  The inserted text is
  formatted according to the commit message conventions documented
  in the manual.  In `git-commit-mode-map` `C-c C-b` is bound to this
  command.

- A new make target `tangle-init` was added which recreates `init.el` from
  `init.org`.

- Added new variables `submodule.DRONE.recursive-byte-compile` and
  `borg-byte-compile-recursively`.

- The user is asked to save relevant buffers before compiling.

- The values of `submodule.DRONE.no-byte-compile` are now treated as
  relative to the top-level.  The documentation already claimed that
  was the case before.

- All build output is appended to the same buffer now.  Previously each
  build created a new, unspecialized buffer that never got cleaned up.
  The buffer is automatically shown on every build but can easily be
  buried using `C-q`.

- The command `borg-insert-update-message` now also handles assimilations
  and removals.

## [Emir](https://github.com/emacscollective/emir) v2.1.0

- Add new `emir-update-github-packages` command, which takes about
  fifteen minutes compared to the five hours `emir-update-packages`
  takes.  This uses the new `emir-gh-foreach-query` function, which
  uses Github's Graphql API instead of fetching every repository
  including the ones that have not seen a commit in years.

## [With-Editor](https://github.com/magit/with-editor) v2.8.0

- When using the sleeping editor, ensure we edit the correct file even
  if the calling process changes the working directory and provides a
  relative file-name. [#55](https://github.com/magit/with-editor/issues/55)
- Ensure `with-editor-post-{finish,cancel}-hook` are run in the
  correct directory.
- Add new macro `with-editor*`, which is like `with-editor` except
  that it evaluates the `envvar` argument at run-time.

## [Hl-Todo](https://github.com/tarsius/hl-todo) v2.0.0

- Use a dedicated syntax-table when searching for keywords instead of
  the major-mode's syntax-table.  Before doing that I experimented
  with improving the used regexp to account for differences in
  major-mode tables, but that was not feasible; fixing it for one mode
  (`python-mode`) meant breaking it for another
  (`clojure-mode`). [#27](https://github.com/tarsius/hl-todo/issues/27)
  [#28](https://github.com/tarsius/hl-todo/issues/28)
  [#30](https://github.com/tarsius/hl-todo/issues/30)
- During initial fonification, when a regexp match is found outside of
  a string or doc-string, then continue the search.  Previously we
  failed to continue because the "partial match" was considered as
  "past last
  match". [#26](https://github.com/tarsius/hl-todo/issues/26)
- Speedup initial fontification.
- Match a variable amount of punctuation after a keyword.
- Add "TEMP" to `hl-todo-keyword-faces`.

## Hl-Todo v2.1.0

Yes, on the same day as `v2.0.0`.  While working on this blog post I
realized that I want TODO keywords to be highlighted in
`markdown-mode` buffers too, so:

- Also turn on `hl-todo-mode` in buffers whose major-mode derives from
  `text-mode`.  This is done by adding `text-mode` to the value of the
  option `hl-todo-activate-in-modes`, i.e. you can revert this if you
  want to.  In `org-mode` buffers `hl-todo-mode` isn't turned on even
  though that indirectly derives from `text-mode` because that mode
  provides its own keyword handling.
  
- In buffers whose major-mode derives from a text-mode, as defined by
  the new option `hl-todo-text-modes`, highlight keywords even when the
  appear outside of strings.
  
*As a side-note; please consider releasing your own packages more
frequently.*

*Sure, there is always one last feature that you want to implement
before creating a new release and every time you create a release
someone shows up with a pull-request the next day.  But those are
not good reasons not to release.*

*You might even want to create a new release if all commits since the
last release are rather insignificant.  You certainly don't want to
create a release for every typo fix, but if half a dozen commits have
been sitting on `master` for a year, why not bump the subminor part of
the version number?*

*For example:*

## [No-Littering](https://github.com/emacscollective/no-littering) v0.5.15

- Theme file-names of a few more packages.

*On the other hand you also want to release `v1.0.0` at some point.
There is never a perfect time unless you do a sprint to implement all
those features you wanted to implement before doing so.*

*Apparently too few maintainers ever find the time for that.  While
24% of all packages on the Emacsmirror are stuck on `v0.*` only 12%
are at `v1.*` and only 8% at >= `v2.*`.  (The 55% that didn't bother
to ever tag any release at all are arguably a much bigger problem
though, but that will be the subject of another post.)*

*So if the perfect time for `v1` never comes, then you might as well
do it when the opportunity presents itself.*

*For example:*

## No-Littering v1.0.0

- This package has proven its worth.  It serves the intended purpose
  well and I have no intention of making any significant changes
  anytime soon.
  
- Nothing else changed compare to `v0.5.15`.

*Sure, one day I will go back and make it much better and everything.
But the thing is this package does what it is supposed to do right
now.  It is "done".  So lets call it `v1.0.0`.*

## [Elx](https://github.com/emacscollective/elx) v1.2.5

- Adapt `elx-licensee` to work with `licensee v9.9.4`.
- Fix a regression in license detection.

<br><br>
*The following packages were created this year.  It is too early to
tell whether I will act on my ideas on how they could be further
improved any time soon or whether it turns out that they are good
enough and that those additional features I was thinking about don't
actually sound all that useful anymore to make it necessary to
implement them before `v1`.*

*It might happen that after a year I still intend to implement those
additional features but still haven't gotten around to actually do so.
By that time those packages, while not be "done", but they will have
proven themselves anyway, so I will tag `v1.0.0`.  But for now I give
them some time to mature before that big step.  While I think `v1`
should come earlier than it usually does, I also don't think it should
happen as soon as things work properly for the first time.*

## [Moody](https://github.com/tarsius/moody) v0.4.0

- Force a mode-line update when a new window becomes active.
- Improve documentation and code-comments.

## [Minions](https://github.com/tarsius/minions) v0.3.1

- Add new option `minions-mode-line-delimiters`.

<br><br>
**Oh, and I almost forgot. Yesterday I released two completely new
packages:**

## [Outline-Minor-Faces](https://github.com/tarsius/outline-minor-faces) v0.1.0

Unlike `outline-mode`, `outline-minor-mode` does not change
the appearance of headings to look different from comments.

This package defines the faces `outline-minor-N`, which inherit from
the respective `outline-N` faces used in `outline-mode` and arranges
for them to be used in `outline-minor-mode`.

## [Backline](https://github.com/tarsius/backline) v0.1.0

An outline heading does not extend to the right edge of the window
when its body is collapsed.  This is unfortuante when the used face
sets the background color or another property that is "visible on
whitespace".  This package adds an overlay to extend the heading's
appearance all the way to the right window edge.
