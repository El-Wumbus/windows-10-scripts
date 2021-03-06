On Thu, 6 Dec 2007, Daniel Berlin wrote:
>
> Actually, it turns out that git-gc --aggressive does this dumb thing
> to pack files sometimes regardless of whether you converted from an
> SVN repo or not.

Absolutely. git --aggressive is mostly dumb. It's really only useful for
the case of "I know I have a *really* bad pack, and I want to throw away
all the bad packing decisions I have done".

To explain this, it's worth explaining (you are probably aware of it, but
let me go through the basics anyway) how git delta-chains work, and how
they are so different from most other systems.

In other SCM's, a delta-chain is generally fixed. It might be "forwards"
or "backwards", and it might evolve a bit as you work with the repository,
but generally it's a chain of changes to a single file represented as some
kind of single SCM entity. In CVS, it's obviously the *,v file, and a lot
of other systems do rather similar things.

Git also does delta-chains, but it does them a lot more "loosely". There
is no fixed entity. Delta's are generated against any random other version
that git deems to be a good delta candidate (with various fairly
successful heursitics), and there are absolutely no hard grouping rules.

This is generally a very good thing. It's good for various conceptual
reasons (ie git internally never really even needs to care about the whole
revision chain - it doesn't really think in terms of deltas at all), but
it's also great because getting rid of the inflexible delta rules means
that git doesn't have any problems at all with merging two files together,
for example - there simply are no arbitrary *,v "revision files" that have
some hidden meaning.

It also means that the choice of deltas is a much more open-ended
question. If you limit the delta chain to just one file, you really don't
have a lot of choices on what to do about deltas, but in git, it really
can be a totally different issue.

And this is where the really badly named "--aggressive" comes in. While
git generally tries to re-use delta information (because it's a good idea,
and it doesn't waste CPU time re-finding all the good deltas we found
earlier), sometimes you want to say "let's start all over, with a blank
slate, and ignore all the previous delta information, and try to generate
a new set of deltas".

So "--aggressive" is not really about being aggressive, but about wasting
CPU time re-doing a decision we already did earlier!

*Sometimes* that is a good thing. Some import tools in particular could
generate really horribly bad deltas. Anything that uses "git fast-import",
for example, likely doesn't have much of a great delta layout, so it might
be worth saying "I want to start from a clean slate".

But almost always, in other cases, it's actually a really bad thing to do.
It's going to waste CPU time, and especially if you had actually done a
good job at deltaing earlier, the end result isn't going to re-use all
those *good* deltas you already found, so you'll actually end up with a
much worse end result too!

I'll send a patch to Junio to just remove the "git gc --aggressive"
documentation. It can be useful, but it generally is useful only when you
really understand at a very deep level what it's doing, and that
documentation doesn't help you do that.

Generally, doing incremental "git gc" is the right approach, and better
than doing "git gc --aggressive". It's going to re-use old deltas, and
when those old deltas can't be found (the reason for doing incremental GC
in the first place!) it's going to create new ones.

On the other hand, it's definitely true that an "initial import of a long
and involved history" is a point where it can be worth spending a lot of
time finding the *really good* deltas. Then, every user ever after (as
long as they don't use "git gc --aggressive" to undo it!) will get the
advantage of that one-time event. So especially for big projects with a
long history, it's probably worth doing some extra work, telling the delta
finding code to go wild.

So the equivalent of "git gc --aggressive" - but done *properly* - is to
do (overnight) something like

    git repack -a -d --depth=250 --window=250

where that depth thing is just about how deep the delta chains can be
(make them longer for old history - it's worth the space overhead), and
the window thing is about how big an object window we want each delta
candidate to scan.

And here, you might well want to add the "-f" flag (which is the "drop all
old deltas", since you now are actually trying to make sure that this one
actually finds good candidates.

And then it's going to take forever and a day (ie a "do it overnight"
thing). But the end result is that everybody downstream from that
repository will get much better packs, without having to spend any effort
on it themselves.

Linus
