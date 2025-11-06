---
layout: default
title: "Many new releases"
date: 2019-12-06 17:00:00 +0100
categories: emacs
excerpt: I am excited to announce new releases of many of my packages.
---

I have releases new versions of many of my packages:
[auto-compile](https://github.com/emacscollective/auto-compile) 1.5.2,
[borg](https://github.com/emacscollective/borg) 3.1.2,
[closql](https://github.com/emacscollective/closql) 1.0.1,
[elx](https://github.com/emacscollective/elx) 1.2.9,
[emir](https://github.com/emacscollective/emir) 2.4.0,
[epkg](https://github.com/emacscollective/epkg) 3.2.2,
[hl-todo](https://github.com/tarsius/hl-todo) 3.1.0,
[keycast](https://github.com/tarsius/keycast) 1.0.0,
[minions](https://github.com/tarsius/minions) 0.3.2,
[moody](https://github.com/tarsius/moody) 0.5.0,
[no-littering](https://github.com/emacscollective/no-littering) 1.0.3,
[orgit](https://github.com/magit/orgit) 1.6.0,
[orglink](https://github.com/tarsius/orglink) 1.1.4 and
[outline-minor-faces](https://github.com/tarsius/outline-minor-faces) 0.1.2.

Some of these packages (`orgit` and `orglink`) had to be adjusted to
adapt to changes in `org`, which was released very recently.  Others
(`auto-compile`, `closql`, `moody` and `outline-minor-faces`) had to
be adjusted for Emacs 27, which will soon enter the pre-test phase.

Some other changes include:

### borg

- The new option `borg-rewrite-urls-alist` allows rewriting certain urls
  when a package repository is cloned.  This is mostly intended to
  replace Github and Gitlab ssh URLs with https urls.

### epkg

- Fix and properly document `epkg-list-matching-packages`.

### hl-todo

- Added new option `hl-todo-exclude-modes` and for consistency also
  renamed the existing option `hl-todo-enable-in-modes` to
  `hl-todo-include-modes`.

- Added new option `hl-todo-color-background` allowing users to
  highlight keywords using distinct background colors instead of using
  distinct foreground colors.

- The command `hl-todo-insert` handles some edge-cases better.

- Give up on highlighting `???`.  Supporting this is just not worth the
  effort and risk of breaking other features.

### keycast

This package has marinated long enough for an initial *stable*
release: 1.0.0.

- While reading a password (using `read-passwd`) the typed keys are no
  longer broadcast.

- Merely loading the library no longer results in
  `keycast-mode-line-update` being added to `pre-command-hook`.

### minions

- Added new option `minions-mode-line-face`.

### moody

The maintainers of other mode-line packages should take notice of
these changes.

- Advice `fit-window-to-buffer` to explicitly call `redisplay`.  This
  causes the actual height of the mode-line to be taken into account.
  Without this parts of the buffer can end up being cut of if the
  mode-line is higher than a regular buffer line.

- Detecting whether the window whose mode-line is currently being
  formatted is the actual selected window was believed to be difficult
  because that window was always temporarily selected while doing so.

  I brought this up on emacs-devel and two approaches were suggested
  that are much better than what any of the third-party mode-line
  packages are doing.

  Starting with Emacs 27 we use `old-selected-window`, whose value as
  far as I can tell is always what such packages need.  For older
  Emacs versions use `pre-display-functions` to record the selected
  window, an approach that is much simpler than all the hacks we have
  been using in the past.

### no-littering

- Many packages got themed.

### orgit

- Added new option `orgit-abbreviate-hashes`.

- Added new options `orgit-store-reference` and
  `orgit-store-repository-id`.

- `orgit-rev-store` now stores all marked commits, if any.

- Adapt to changes in Org and Magit.

## In Other News

I also performed some other maintenance tasks.

- Most importantly this blog, as well as [magit.vc](https://magit.vc)
  and [emacsmirror.net](https://emacsmirror.net) no longer fetch fonts
  from Google Fonts.  Sorry it took so long.  What finally got me to
  do it is that I just accepted a $250 donation from Google, which
  brings me to the next topic.

- I have been accepted to the [Github
  Sponsors](https://help.github.com/en/github/supporting-the-open-source-community-with-github-sponsors/about-github-sponsors)
  program about two months ago.  After a quick start new sponsors have
  become much rarer lately, so I decided to do some marketing.  In my
  experience many users are happy to donate, but need a few friendly
  nudges until they actually do, so:

{% include donate-main.md %}
