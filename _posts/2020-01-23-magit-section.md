---
layout: default
title: "Magit-Section as a stand-alone package"
date: 2020-01-23 21:00:00 +0100
categories: emacs
excerpt: Magit-Section as now available as a stand-alone package.
---

## Magit-Section as a stand-alone package

Magit-Section implements the main user interface of Magit — the
collapsible sections that make up its buffers.  How to use these
sections — from an end-user perspective — is documented in the [Magit
manual](https://magit.vc/manual/magit/Sections.html#Sections).

I am now making Magit-Section available as a stand-alone package.  The
`magit-section.el` library used to be distributed as part of the Magit
package and it still is maintained in the same repository, but now it
can be used by other packages that have nothing to do with Magit,
*without* having to depend on Magit.

The new [Magit-Section](https://magit.vc/manual/magit-section) manual
is intended for package developers.  A [Magit Section
Tutorial](https://github.com/magit/magit/wiki/Magit-Section-Tutorial)
is also available.  Unfortunately both documents are still far from
finished.  I decided to make this package available now anyway because
Magit comes with many examples that you can learn from.

## What's next?

Well... gradual improvments to the documentation for one thing.  ;-)

I hope that over time authors start using Magit-Section similar to how
they did that for Magit-Popup, which also used to be part of Magit and
then was released separately so that other packages could use it.

That package however came with scary warnings about it going to be
deprecated eventually and in fact that has happened a year ago when I
released [Transient](/2019/02/14/transient-0.1) but I still maintain
Magit-Popup and would fix bugs if any were reported.  I intend to do
the same for Magit-Section, so I skip the warning this time and you
can use it in confidence.

By the way Transient 0.2.0 is due soon too.

And finally I plan to release Magit 3.0.0 in February.  The first
Magit-Section release will happen at the same time and it will be
named 3.0.0 too.

{% include donate-tiny.md %}
