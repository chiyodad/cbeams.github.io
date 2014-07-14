---
layout: post
title: Epoch Shortlinks
timestamp: 18947431
---

_I spent a truly stupid amount of time thinking about how to do shortlinks for this site. This is what I finally decided on. Hopefully it saves somebody else the trouble._

Here are a couple of facts:

 1. I was born in Great Falls, Montana on July 2nd, 1978 at 7:02 AM.
 2. I began writing this post in Vienna, Austria on July 11th, 2014 at 1:32 PM.

The second event occurred 18,947,431 minutes after the first. For reasons detailed below, that's why you can also get to this post via [cbea.ms/{{ page.timestamp }}]({{ site.shorturl }}/{{ page.timestamp }}). Go ahead, click it—you'll end up back here.

Back? Good. I'll explain why I'm counting the millions(!) of minutes since my birth—and why you might want to too. But let me share how I got there in the first place.

## The simplest possible (indie) shortlink
It started with a simple goal. I wanted to assign an ID to each page on this site. Mainly so I could share short, Twitter-friendly URLs to stuff I write. You know, like this:

    $ curl -I http://cbea.ms/1234
    HTTP/1.1 301 Moved Permanently
    Location: http://chris.beams.io/notes/some-longer-url

Of course URL shortening is nothing new. There are plenty of services out there like [TinyURL](http://tinyurl.com) and [bit.ly](http://bit.ly) that will do it for you.

But I don't want to use them anymore.

I don't want to use URL shortening services for the same reasons I serve this site and my mail from a Mac Mini in my living room. Like  [many](indieweb) [others](tk), I want to [own my data](tk). Like [TimBL](tk), I want to [re-decentralize the web](http://arstechnica.com/tech-policy/2014/02/tim-berners-lee-we-need-to-re-decentralize-the-web/).

<!--
The last decade showed us how convenient free cloud services can be. And we've also seen them unilaterally [put out of commission](reader, wave, posterous), aggressively [monetize our data](tk) and get used (with or without their consent) by governments to [spy on us](tk) at massive scale.

The only [terms and conditions](http://www.imdb.com/title/tt2084953/) I want to agree to are my own. While URL-shortening services aren't the the first or biggest concern, owning one's data and keeping things decentralized means getting rid of them too.

In fact, it's because of their simplicity that URL-shortening services provide an excellent object lesson in the challenges of providing decentralized alternatives to cloud services. URL shortening and redirection is one of the most basic services imaginable, but try to do it on your own and you may soon find yourself writing a 5,000 word article about the technological adventure that is sure to ensue.

It goes to show that as technologists committed to digital independence, our biggest challenge is how to make it easy, fun, even cool for everyday users to take this path with us. We're a long way today from an average user running her own web or mail server—but while we can all agree that getting this to happen is a hard problem, let's also acknowledge that most of us haven't even been trying to solve it.

There are [good arguments](tk) that the way to solve these problems is through building design-led organizations that focus first on world-class user experiences—and only in that context do they develop the free and decentralized software that can deliver them. I agree completely. But in the meantime, there's also utility in starting small, weaning ourselves off centralized services one by one, and sharing how we did it as we go.

So today, I present my attempt to build the simplest possible independent URL shortener; next, we take Manhattan.
-->

## Teaching Jekyll to redirect
This site is statically generated using [Jekyll](http://jekyllrb.com). That means it doesn't have the benefit (or burden) of a database that can keep track of IDs for each page. Pages like [this one](tk) are just text files with a bit of metadata at the top. It's pretty simple. Here's what one looks like:

`2014-07-11-a-quick-example.md`

    ---
    title: A Quick Example
    date: 2014-07-11 20:41:00 +0200     <-- metadata
    permalink: /notes/a-quick-example
    ---
    Blah blah blah blah blah blah blah
    blah blah blah blah blah blah blah  <-- content
    blah blah blah blah blah blah blah.

This means that assigning an ID to each page is easy: just add a new entry to the metadata at the top of each file. Something like this:

    ---
    title: A Quick Example
    date: 2014-07-11 20:41:00 +0200
    permalink: /notes/a-quick-example
    id: 1234                            <-- boom.
    ---
    ... content ...

Of course something needs to handle the new `id` metadata. And that something needs to cause a redirect to the `permalink` URL when a user requests the `id` URL. Here again is a simplified version of what we're trying to do (the cbea.ms domain will be re-introduced later):

    $ curl -I http://chris.beams.io/1234
    HTTP/1.1 301 Moved Permanently
    Location: http://chris.beams.io/notes/some-longer-url

This seems simple, but it's actually not easy to do with Jekyll. Jekyll generates a site once at startup and dumps out a bunch of HTML files. Afterward, the web server (Ruby's WEBrick) is just a black box for serving those files. There is no mechanism for telling the server how it should issue redirects for specific paths<sup><a name="ref-redirects" href="#fn-redirects">1</a></sup>.


### Let's get meta
We can still make the desired redirection happen, but we have to take a different approach. We can't tell the server to issue a 30x HTTP redirect, but we can create another simple page that tells the browser how to redirect using HTML:

`1234/index.html`

```html
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="refresh" 
          content="0;url=/notes/some-longer-url" />
  </head>
</html>
```

[Meta refresh](https://en.wikipedia.org/wiki/Meta_refresh) FTW. This method isn't as clean or efficient as straight HTTP redirects, but it gets the job done. The user still requests the shortlink

    http://chris.beams.io/1234

and is ultimately still redirected to the original url.

    http://chris.beams.io/notes/some-longer-url

The important thing is that this approach doesn't compromise the desired URL scheme. This means the site could later be moved to a platform that supports HTTP redirects and nothing else would need to change.

### Automating redirect page creation
The meta refresh approach works, but the creation of these pages needs to be automated. Fortunately the Jekyll [alias generator](https://githubplugin that can be repurposed for this use: .com/tsmango/jekyll_alias_generator) plugin can help.

Using it means switching from our custom `id:` property to the plugin's generic `alias:` property. It looks like this:

    ---
    title: A Quick Example
    date: 2014-07-11 20:41:00 +0200
    permalink: /notes/a-quick-example
    alias: /1234                        <-- goodbye 'id', hello 'alias'
    ---
    ... content ...

Note the leading `/`. The alias generator plugin needs this to function properly.

Now when Jekyll generates the site, it creates meta refresh pages for any `alias:` entries. This means we end up with the same `1234/index.html` page without having to write it by hand. Here's what the generated pages look like:

    $ curl -i http://chris.beams.io/1234/
    HTTP/1.1 200 OK

        <!DOCTYPE html>
        <html>
        <head>
        <link rel="canonical" href="/notes/some-longer-url" />
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta http-equiv="refresh" content="0;url=/notes/some-longer-url" />
        </head>
        </html>

Note the `<link rel="canonical" ... />` element. This is a nice addition by the alias generator plugin. Its purpose is to help search engines [avoid duplicate content](https://en.wikipedia.org/wiki/Canonical_link_element).

## Choosing an ID scheme
So that's how I got redirects worked out. Thus far I've been using `1234` as an example page ID. Now it's time to choose an actual scheme to use in practice.

### The criteria

#### 1. Reasonably short URLs
This sounds redundant given that the task at hand is creating <em>short</em>links. But how short is short enough? How long is too long?

Currently Twitter truncates any URL longer than 23 characters with an ellipsis. When this happens, readers can no longer memorize, copy and paste, or create a screenshot of the URL. They are forced to click on it and go through Twitter's [t.co](http://t.co) shortening service, which defeats the purpose of having an independent one. Given that my personal shortlink domain (cbea.ms) is itself 7 characters long (8 with a trailing slash), I have 15 characters of ID runway before Twitter truncation.

An even better guide is [Miller's Law](https://en.wikipedia.org/wiki/The_Magical_Number_Seven%2C_Plus_or_Minus_Two). Roughly stated, it says that the maximum number of objects a human can hold in working memory is 7 ± 2. I've found this to hold true in my own experience, so it seems like a good rule of thumb.

Conclusion: while the ideal shortlink ID would consist of as few characters as possible, it shouldn't be much longer than 7, and certainly not longer than 15.

#### 2. No database required
As mentioned earlier, it's not an option when using Jekyll or any other static site solution. Everything is just textfiles and directories, and that's a good thing.

#### 3. No thinking required
If I'm writing a quick 140-character post, I don't want to have to think about crafting a shortlink ID. ID creation should be brain-dead, fully automated, foolproof.

#### 4. Algorithmically simple to create
It's fine if it takes a little bit of code to create a shortlink ID, but that code should be as simple as possible. It shouldn't assume a particular language, execution environment, complex libraries or any other elaborate context. Simple, simple, simple.

#### 5. Future-proof
This one is hard to define, but roughly it means I don't want make a short-sighted decision about my shortlink ID scheme now only to regret it later. I'll put a pin in this for now and come back to it by example below.

### The options

Here are the ID scheme options that I thought through. I'm sure it's an incomplete list.

#### 1. Simple counter
The seemingly simplest approach for an ID scheme would be to start from 1 and increment the ID for each new page we create. This approach is attractive for a few reasons, but there are serious enough issues as to disqualify it for my purposes.

 - **It basically requires a database**. To implement this, a script would have to be written to search all files for `alias:` entries, sort to find the highest ID value, and then return that value incremented by one. If you think about it, this approach is really just creating a poor man's database from textfiles on a filesystem. Among other problems, this means you have to have access to all those files along with the correct tools in order to create an ID. That might be a constraint too far at some point in the future.

 - **Gaps will creep in over time**. An ID scheme that starts from 1 and increments for each new page carries with it some implied semantics. It suggests that the ID of the newest page is also equal to the total number of posts. But what if one or more posts are deleted after publication? The highest ID value is no longer equal to the number of posts. This isn't a huge problem but does violate an expectation. Similarly, readers may notice this scheme and think they can "url hack" their way through newer and older entries simply by incrementing and decrementing the ID in the URL. If there are gaps, they won't be able to do this in practice.

 - **No ability to "backdate" entries.** Another among the implied semantics of an incrementing ID scheme is that pages with higher ID values represent events chronologically newer events than pages with lower values. This is a reasonable assumption in the context of a typical blog. But having the flexibility to insert older pages could be useful in other contexts (some of which I'll explore below).

 - **Not necessarily portable.** Imagine I have two blogs that use this incrementing ID scheme and at some point in the future I want to merge them them. The IDs would collide. A reindexing would be required. A mapping of redirects from each old blog entry ID to each new one would need to be maintained. A scheme that creates IDs globally unique in the context of "me" would be better.

#### 2. Algorithmically reversible shortlinks
Tantek's [algorithmically reversible shortlinks](http://tantek.pbworks.com/w/page/21743973/Whistle) deserve a mention here. I like this design and Tantek's thinking behind it.

It's also relatively complex, requiring less-than-trivial code to implement and requires some up-front thinking about categories and prefixes that I wasn't quite comfortable with. It requires at least some thinking every time you post because one must at least decide which category/prefix a post will fall into before a shortlink ID (path) can be created.

In short, while I think there's a lot to like in Tantek's approach, it's basically overengineered for my purposes. It might be perfect for others though. I recommend giving his docs a read in any case.

#### 3. Random numbers, random strings, hash values, etc
It's probably not fair to group all of these together. But in short, I mean to capture here more or less what most URL-shortening services do today. They typically create a short string of letters and/or numbers, that if not random, appear to be.

For example, if you feed [http://example.com](http://example.com) into TinyURL, the shortlink ID it returns is [`yvdle`](http://tinyurl.com/yvdle). I do not know how this value is determined, and as far as I know, they don't advertise it. I'm sure most people don't care so long as it works.

These opaque shortlink IDs may be a reasonable design decision for a large-scale URL shortening service. However, when designing a personal shortening scheme, I'd prefer values that the user can reason about; ideally something that communicates order, chronology, or something about the content itelf.

A 3rd party URL shortening service

 - seems like a missed opportunity.
 - opaque semantics
 - requires a specific algorithm / custom code.
 - not memorable

#### 4. Intentionally short human-readable names
...

e.g.: 
chris.beams.io/long -> chris.beams.io/notes/some-longer-url

 - requires checking for duplicates.
 - 'pollutes' the top-level namespace. what if create a shortcut called 'notes' today, but want a 'notes' section of the site tomorrow.

#### 5. Numeric date representation

e.g.: /201407022459

 - too long. with seconds it's 14 digits, with minutes it's 12. too long in either case.
 - it's not really a simple number. it's a 'number string' encoded with meaning.

But numeric representation might have legs yet.

Let's use epoch seconds.

 - 1405249572
   0123456789

Already shorter at 9 digits than the shortest date alternative above.

But I probably don't actually need second resolution. let's go with minutes.

 - 23420827

Not bad... but while epoch time is something that all the geeks understand, it is nevertheless a pretty arbitrary date. What if we counted not from the unix epoch, but from our own personal epoch—the date of our own birth?

## Epoch win

Like I wrote at the top, the date of my birth was 7:02 AM on July 2nd, 1978. I was born in Montana, so that makes the time zone Mountain Time.

Let's ask `date` what time that was in epoch seconds:

    $ export TZ=MST7MDT
    $ date -j -f "%m-%d-%Y %T" "07-02-1978 07:02:00" +%s
    268232520

There it is. I was born 268,232,520 seconds after the unix epoch. Let's call this number `$EPOCH_CBEAMS`.

    $ export EPOCH_CBEAMS=268232520

And just to confirm, let's ask `date` the same question in reverse: what was the human-readable time at epoch second 268232520?

    $ date -r $EPOCH_CBEAMS
    $ Sun Jul  2 07:02:00 MDT 1978    

Voilá. Now we can easily calculate the number of seconds from my birthdate by treating it as an offset from the unix epoch. Let's call the current unix time $UNIX_NOW:

    $ export $UNIX_NOW=$(date +%s)
    $ echo $UNIX_NOW
    1405253929

Which means that the number of seconds that has elapsed since `$EPOCH_CBEAMS` is a matter of simple subtraction. Let's call the result `$CBEAMS_NOW`:

    $ let CBEAMS_NOW=$UNIX_NOW-$EPOCH_CBEAMS
    $ echo $CBEAMS_NOW
    1137021658

And of course we can convert that to a shortlink-ready timestamp in minutes by dividing by 60:

    $ let TIMESTAMP=$CBEAMS_NOW/60
    $ echo $TIMESTAMP
    18950360

[`etime`](tk) is a script I wrote to automate this simple process.

[`post`](tk) is a script I wrote that uses `etime` to create a new text file in my Jekyll `_drafts` folder complete with metadata. It uses `etime` to populate the timestamp information.

---

What if we thought of our birthdate not in terms of a calendar date, but as our "zero-moment", our own personal _epoch_? If our birthdate represents 0 on on our personal timeline, then we can then timestamp any later event in our lives in terms of the amount of time that has elapsed since that moment.

Combine that simple number with a personal domain name, and you have a URL scheme that can theoretically accommodate recording anything and everything you've ever done or experienced.

 - **Doesn't need a database.** It just needs something that can calculate the number of minutes since your birth.

 - **It's portable**. As long as we're talking about ...

 - **Future proof**.

 - **It's short (enough)**. Twitter truncation lengths, etc.

 - other stuff

## Basic tools.

First, calculate your offset.

### etime


 - post



---

<a href="#ref-redirects" name="fn-redirects">1</a>: ...
