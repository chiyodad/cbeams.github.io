---
layout: post
title: Epoch Shortlinks
timestamp: 18947431
---

_I spent a truly stupid amount of time thinking about how to do shortlinks for this site. This is what I finally decided on. Hopefully it saves somebody else the trouble._

Here are a couple facts:

 1. I was born in Great Falls, Montana on July 2nd, 1978 at 7:02 AM.
 2. I began tk writing this post in Vienna, Austria on July 11th, 2014 at 1:32 PM.

The second event occurred 18,947,431 tk minutes after the first. For reasons detailed below, that's why you can also get to this post via [cbea.ms/{{ page.timestamp }}]({{ site.shorturl }}/{{ page.timestamp }}). Go ahead, click it—you'll end up back here.

Back? Good. I'll explain why I'm counting the millions(!) of minutes since my birth—and why you might want to too. But let me share how I got there in the first place.

## The simplest possible (indie) shortlink
It started with a simple goal. I wanted to assign an ID to each page on this site. Mainly so I could share short, Twitter-friendly URLs to stuff I write. You know, like this:

    $ curl -I http://cbea.ms/1234
    HTTP/1.1 301 Moved Permanently
    Location: http://chris.beams.io/posts/some-longer-url

Of course URL shortening is nothing new. There are plenty of services out there like [TinyURL](http://tinyurl.com) and [bit.ly](http://bit.ly) that will do it for you.

But I don't want to use them anymore.

I don't want to use URL shortening services for the same reasons I serve this site and my mail from a Mac Mini in my living room. Like  [many](indieweb) [others](tk), I want to [own my data](tk). Like [TimBL](tk), I want to [re-decentralize the web](http://arstechnica.com/tech-policy/2014/02/tim-berners-lee-we-need-to-re-decentralize-the-web/).

tk

<!-- tk
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
    permalink: /posts/a-quick-example
    ---
    Blah blah blah blah blah blah blah
    blah blah blah blah blah blah blah  <-- content
    blah blah blah blah blah blah blah.

This means that assigning an ID to each page is easy. Just add a new entry to the metadata at the top of each file. Something like this:

    ---
    title: A Quick Example
    date: 2014-07-11 20:41:00 +0200
    permalink: /posts/a-quick-example
    id: 1234                            <-- boom.
    ---
    ... content ...

Of course something needs to handle the new `id` metadata. And that something needs to cause a redirect to the `permalink` URL when a user requests the `id` URL. Here again is a simplified version of what we're trying to do (the cbea.ms domain will be re-introduced later):

    $ curl -I http://chris.beams.io/1234
    HTTP/1.1 301 Moved Permanently
    Location: http://chris.beams.io/posts/some-longer-url

This seems like a simple task, but it's actually not easy to do with Jekyll. Jekyll generates a site once at startup and dumps out a bunch of HTML files. Afterward, the web server (Ruby's WEBrick) is just a black box for serving those files. There is no mechanism for telling the server how it should issue redirects for specific paths<sup><a name="ref-redirects" href="#fn-redirects">1</a></sup>.


### Get meta
We can still make the desired redirection happen, but we have to take a different approach. We can't tell the server to issue a 30x HTTP redirect, but we can create another simple page that tells the browser how to redirect using HTML:

`1234/index.html`

    <!DOCTYPE html>
    <html>
      <head>
        <meta http-equiv="refresh" 
              content="0;url=/posts/some-longer-url" />
      </head>
    </html>

[Meta refresh](https://en.wikipedia.org/wiki/Meta_refresh) FTW. This method isn't as clean or efficient as normal HTTP redirects, but it gets the job done. The user still requests the shortlink

    http://chris.beams.io/1234

and is ultimately still redirected to the original url.

    http://chris.beams.io/posts/some-longer-url

The important thing is that this approach doesn't compromise the desired URL scheme. This means the site could later be moved to a platform that supports HTTP redirects and nothing else would need to change.

### Automating redirect page creation
The meta refresh approach works, but the creation of these pages needs to be automated. Fortunately the Jekyll [alias generator](https://githubplugin that can be repurposed for this use: .com/tsmango/jekyll_alias_generator) plugin can help.

Using it means switching from our custom `id:` property to the plugin's generic `alias:` property. It looks like this:

    ---
    title: A Quick Example
    date: 2014-07-11 20:41:00 +0200
    permalink: /posts/a-quick-example
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
        <link rel="canonical" href="/posts/some-longer-url" />
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta http-equiv="refresh" content="0;url=/posts/some-longer-url" />
        </head>
        </html>

Note the `<link rel="canonical" ... />` element. This is a nice addition by the alias generator plugin. It's a [relatively recent](http://www.mattcutts.com/blog/canonical-link-tag/) standard agreed upon by major search engines to help them distinguish and [avoid indexing duplicate content](https://en.wikipedia.org/wiki/Canonical_link_element).

## Choosing an ID scheme
So that's how I got redirects worked out tk. Thus far I've been using `1234` as an example page ID. Now it's time to choose an actual scheme to use in practice.

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

 - **It basically requires a database**. To implement this, a script would have to be written to search all files for `alias:` entries, sort to find the highest ID value among them, then return that value incremented by one. If you think about it, this approach is really just creating a poor man's database from textfiles on a filesystem. Among other problems, this means you have to have access to all those files along with the correct tools in order to create an ID. That might be a constraint too far at some point in the future.

 - **Gaps will creep in over time**. An ID scheme that starts from 1 and increments for each new page carries with it some implied semantics. It suggests that the ID of the newest page is also equal to the total number of posts. But what if one or more posts are deleted after publication? The highest ID value is no longer equal to the number of posts. This isn't a huge problem but does violate an expectation. Similarly, readers may notice this scheme and think they can "url hack" their way through newer and older entries simply by incrementing and decrementing the ID in the URL. If there are gaps, they won't be able to do this in practice.

 - **No ability to "backdate" entries.** Another among the implied semantics of an incrementing ID scheme is that pages with higher ID values represent events chronologically newer events than pages with lower values. This is a reasonable assumption in the context of a typical blog. But having the flexibility to insert older pages could be useful in other contexts (some of which I'll explore below).

 - **Not necessarily portable.** Imagine I have two personal sites that use this incrementing ID scheme and at some point in the future I want to merge them. The IDs would collide. A reindexing would be required. A mapping of redirects from each old blog entry ID to each new one would need to be maintained. A scheme that creates IDs that are globally unique in the context of "me" would be better.

#### 2. Algorithmically reversible shortlinks
Tantek's [algorithmically reversible shortlinks](http://tantek.pbworks.com/w/page/21743973/Whistle) deserve a mention here. I like this design and Tantek's thinking behind it.

It's also relatively complex, requiring less-than-trivial code to implement and requires some up-front design of categories and prefixes that I wasn't quite comfortable with. It requires at least some thinking every time you post because one must at least decide which category/prefix a post will fall into before a shortlink ID can be created.

In short, while I think there's a lot to like in Tantek's approach, it's basically overengineered for my purposes. It might be perfect for others though. I recommend giving his docs a read in any case.

#### 3. Random numbers, random strings, hash values, etc
It's probably not fair to group all of these together. But in short, I mean to capture here more or less what most URL-shortening services do today. They typically create a short string of letters and/or numbers, that if not random, appear to be.

For example, if you feed [http://example.com](http://example.com) into TinyURL, the shortlink ID it returns is [`yvdle`](http://tinyurl.com/yvdle). I do not know how this value is determined, and as far as I know they don't advertise it. I'm sure most people don't care so long as it works.

These opaque shortlink IDs may be a reasonable design decision for a large-scale multiuser URL shortening service. However, when designing a personal shortening scheme, I'd prefer values that the author and reader can reason about—ideally something that communicates order, chronology, or information about the content itelf.

#### 4. Intentionally short human-readable names
For a url like the one on this page

    http://chris.beams.io/posts/epoch-shortlinks

why not simply create a shorter, single-word top-level alias?

    http://chris.beams.io/epoch

There are a several problems that disqualify this approach as a universal solution.

 - **It requires thinking.** Per criteria #3, if one is issuing posts at Twitter-level size and frequency, it becomes undesirable to have to 'design' a shortcut link for each 'tweet'.

 - **It requires duplicate checking**. For each new top-level shortlink created, one must check to ensure the name hasn't already been used. This is not a problem in the beginning. It becomes more burdensome the more posts one creates. This check could reasonably be automated, but at the cost of yet another moving part.

 - **It pollutes the top-level namespace**. Example: I create a shortlink named '/notes' today, but wish to create a new section of the site called '/notes' tomorrow. I cannot do the latter without breaking the former. A large number of top-level, dictionary-word shortlinks serves to pollute and inadvertently constrain that namespace over time.

That having been said, I still like this option, and predict I'll use it on occassion. It is not mutually exclusive with other, more automatable schemes. For example, all pages might be assigned a numeric shortlink ID, but certain pages might be deemed important enough to be given these one-off aliases to increase impact, memorizability, etc.

#### 5. Numeric date representation
For example, a post published on July 15th, 2014 at 8:50 AM might be assigned the following shortlink

    http://chris.beams.io/201407150850

There are a few problems here:

 - **It's not short**. At to-the-minute resolution, this string is 12 characters long. With seconds, 14. This is sufficient to avoid Twitter truncation given a short enough domain name, but these values are undesirably long in any case. Clever solutions such as Tantek's [NewBase60](http://ttk.me/w/NewBase60) number system could be employed to shorten the year and date, but this approach requires non-trivial custom code and does not deal with time resolutions more fine-grained than the day.

 - **It's lossy**. This solution loses time zone information. This may sound like negligible at first, but any representation of time that includes the hour is meaningless without a time zone alongside.

While the specific approach above isn't terribly attractive, a numeric representation of the date might make sense yet. Why not use [Unix time](https://en.wikipedia.org/wiki/Unix_time)?

Unix time is also called _epoch seconds_, because it represents the number of seconds elapsed since the so-called _Unix epoch_ of January 1st, 1970 00:00:00 UTC. It's an elegant and widely understood measurement of time that can be translated into any date format without any loss of information such as time zone.

For example, as I write this the current Unix time is `1405421716`:

    $ date +%s
    1405421716

At 10 digits, epoch seconds is already shorter than the the date strings considered above. It has the added benefit of being a simple number, easy to generate and manipulate in almost any programmatic context. Divide it by 60 for to-the-minute resolution and we're at 8 digits—within 'short enough' range for a shortlink:

    $ echo 1405421716 / 60 | bc
    23423695

Could this be the best shortlink option yet?

    http://chris.beams.io/23423695

Returning to the criteria above, this approach seems to meet them all. It is **reasonably short**, does **not require a database**, can be generated automatically with **no thinking required**, is **simple to generate** using standard unix tools or libraries available in every modern language, and is not only **future-proof**, but **past-proof**, in the sense that it allows for backdating entries without risk of ID collision or reindexing.

## Epoch win
When I thought of using epoch seconds for shortlinks, I was surprised I hadn't seen it done before. Perhaps it has been and I just didn't find it.  As I thought about it further, though, I began thinking beyond shortlinks and began thinking about personal timelines.

If the shortlink for a post is represented as its date of publication in epoch seconds (or minutes), it is not only a shortlink, but a timestamp. In the context of a personal website such as this one, that timestamp communicates what I was doing at that moment. It represents a point on the timeline of my life.

And such a timestamping mechanism need not be limited to traditional posts. These "timestamp URLs" could be used to refer to any event in my life that I wish to include on the timeline. It would be trivial to create backdated entries on the timeline, simply by calculating the Unix time of the event and creating a new page that explains what happened then.

For example, as I wrote earlier, I was born on July 2nd, 1978 at 7:02 AM in Great Falls, Montana (which is in the Mountain time zone). This is 268,232,520 seconds after the Unix epoch, or 4,470,542 minutes for concision.

    # Epoch seconds at my birth
    $ TZ=MST7MDT date -j -f "%m-%d-%Y %T" "07-02-1978 07:02:00" +%s
    268232520

    # Divide by 60 for 'epoch minutes'
    $ echo 268232520 / 60 | bc
    4470542

This means that if I had a page representing my birth at:

    http://chris.beams.io/events/birth

its shortlink/timestamp URL would be:

    http://chris.beams.io/4470542

This makes sense technically, but the number 4470542 is beginning to look a little confusing. After all, shouldn't the moment of my birth on my personal timeline be represented as zero? Indeed, the Unix epoch is an arbitrary date with regard to anything other than Unix itself.

Just imagine a person born earlier than 1970 making use of this scheme. If their birthday were January 1st, 1969 00:00:00 UTC, the timestamp of their birth would be a negative number:

    http://somebody.com/-525600

As one can see, it begins to get a little absurd—perhaps even ageist—to anchor a personal timeline directly on the Unix epoch.

Instead, what if we treated our birthdate as our zero-moment, as our own _personal epoch_? For the practical purposes of calculation and manipulation, we would need to express that value somewhere as an offset from Unix time, but everywhere else, the events in our lives can be timestamped intuitively as the number of minutes elapsed since zero—since the moment of our birth.

As calculated above, I was born 268,232,520 seconds after the Unix epoch. Let's call this number `$CBEAMS_EPOCH`.

    $ export CBEAMS_EPOCH=268232520

Just to confirm, let's ask `date` the same question in reverse: what was the human-readable date at Unix time 268232520?

    $ date -r $CBEAMS_EPOCH
    $ Sun Jul  2 07:02:00 MDT 1978    

Right. With `$CBEAMS_EPOCH` in hand, we have our offset. We can now easily calculate the number of seconds that have elapsed since my birth using `date` and a little subtraction.

Let's call the current Unix time `$UNIX_TIME`:

    $ export $UNIX_TIME=$(date +%s)
    $ echo $UNIX_TIME
    1405421716

And let's call the number of seconds that have elapsed since my birth `$CBEAMS_TIME`. It's just the current Unix time less the Unix time of my birth:

    $ let CBEAMS_TIME=$UNIX_TIME-$CBEAMS_EPOCH
    $ echo $CBEAMS_TIME
    1137189196

For a timestamp expressed in minutes, divide this value by 60:

    $ let CBEAMS_TIMESTAMP=$CBEAMS_TIME/60
    $ echo $CBEAMS_TIMESTAMP
    18953153

We now have a number suitable for use in a shortlink url, e.g.:

    http://chris.beams.io/18953153

---

## Tools

### etime
[`etime`](tk) is a shell script I wrote to automate the process of calculating the minutes since a personal epoch.

### post
[`post`](tk) is a script I wrote that uses `etime` to create a new text file in my Jekyll `_drafts` folder complete with metadata. It uses `etime` to populate the timestamp information.

## Limitations

### Scope
The notion of a personal epoch is only useful when reasoning about events in that particular person or entity's life. Things get confusing fast if times or timelines are being compared across two or more persons. So to be clear, I am not suggesting that people declare personal temporal sovereignty, expecting others to actively deal with their relative dates. The utility of these relative timestamps is limited, so far as I can tell, to personal websites / journals / chronicles / timelines, etc.

### External shortlinks
This shortlink scheme, as currently implemented using Jekyll is only useful for sharing links to this site. It is not useful as a general-purpose external link shortener. For example, if I wanted to share a link to a recent XKCD strip such as:

    http://xkcd.com/1393

The current implementation provides no way of offering a `cbea.ms` shortlink URL that does not first direct the user to a page on `chris.beams.io`. That page could meta refresh to the desired URL, but this indirection would be silly (and made all the more so by the fact that the xkcd URL is already shorter than anything I could produce with this scheme).

## Future directions
I don't intend to do anything with this idea other than use it for my personal shortlink scheme. However, one can imagine layering applications atop the idea of epoch-timestamped URLs.

### Timeline visualization
For example, if the pages pointed to by epoch-timestamped URLs included additional structured [event](http://schema.org/Event) [metadata](http://microformats.org/wiki/h-event), it would be straightforward in concept for an application like [Timeline3D](http://www.beedocs.com/timeline3D) to index and visualize them.

### Indexing external events
It's also interesting to think about the development of tools that import or index personal events from around the web. For example, a tool that imports all of a user's Tweets could use epoch-timestamped URLs based on the tweet's [`created_at` date ](https://dev.twitter.com/docs/api/1.1/get/statuses/show/%3Aid). The same goes for Facebook posts, Amazon product reviews, questions asked and answered on Q&A sites, issues and comments on bug trackers, comments on blogs, or any other activity a user might engage in online—so long as the associated service has an API and includes date metadata.

I'd love to see tools like this come into existence, helping folks get a handle on owning their data. Plus it would be amazing to look at those timelines. Think of how many things you do online everyday; what would you learn by being able to see and scroll through it, even programmatically analyze it all in one place? (Note that I'm not necessarily suggesting such timelines would be made public.)

---

## Other details

### Managing redirects from a custom shortlink domain
For greater concision I use a custom shortlink domain at [cbea.ms](http://cbea.ms). I manage this site's DNS using CloudFlare, and have a [Page Rule](http://blog.cloudflare.com/introducing-pagerules-url-forwarding) set up there to forward all requests to the full [chris.beams.io](http://chris.beams.io) domain.

For example, given the shortlink

    http://cbea.ms/18953153

the complete redirect flow is:

    $ curl -I http://cbea.ms/18953153
    HTTP/1.1 301 Moved Permanently
    Location: http://chris.beams.io/18953153

    $ curl -I http://chris.beams.io/18953153
    HTTP/1.1 200 OK
    ... browser handles meta refresh pointing
        to http://chris.beams.io/posts/whatever ...

    $ curl -I http://chris.beams.io/posts/whatever
    HTTP/1.1 200 OK
    ... browser displays actual content ...

### Dedicated Jekyll timestamp metadata
In the first section of this article I described using the Jekyll alias generator plugin to express timestamp shortlink urls, e.g.:

    ---
    title: A Quick Example
    date: 2014-07-11 20:41:00 +0200
    alias: /18904519
    ---
    ... content ...

I've since made a [slight modification](https://github.com/cbeams/chris.beams.io/commit/dfb03e10db7b8db62fdcb6476c51ba81b6b3397c#diff-1) to the alias generator plugin that allows for a custom `timestamp:` field. My pages now look like this:

    ---
    title: A Quick Example
    date: 2014-07-11 20:41:00 +0200
    timestamp: 18904519
    ---
    ... content ...

There are several reasons for doing this:

1. I prefer to leave the semantics of `alias:` dedicated to actual aliases for a page, e.g. putting a redirect in place after the renaming of a page or post.
2. The custom `timestamp:` field does not require values to have a leading `/`, as does the `alias:` field.
3. The `alias:` field allows for multiple values expressed as an array; the `timestamp:` field does not. This means it's easy to `grep` for pages with `timestamp:` fields, to `cut` and `sort` them, etc.

### Use of &lt;link rel="shortlink"&gt;
In the process of refining this idea and writing this article, I stumbled upon what I am now calling _The great rev="canonical" debate of 2009_. I'll spare the details here, but in short... `<link rel="shortlink">`. View source on this page and you'll see near the top the following two entries:

    <link rel="shortlink" href="http://cbea.ms/18947431"/>
    <link rel="shortlink" href="http://chris.beams.io/18947431"/>

This can be thought of as the inverse of...  tk

### On the use of epoch minutes vs. seconds
I chose minute vs second resolution in my timestamps for two reasons. First for concision (8 characters vs. 10). Second because it's hard to imagine doing anything that would require more than to-the-minute precision. Rapid-fire tweet-style posts would be one exception, but in my personal use of Twitter, these exceptions have been rare enough as to be negligible.

### Epoch metadata
If epoch timestamps were ever to become widely used, it would be a good idea to agree on a structured way to advertise:

1. the timestamp;
2. the personal epoch expressed as a Unix time offset;
3. the timescale of each.

Here's how it might look modeled with `<meta>` elements:

    <meta name="epoch-timestamp" content="value=18953153, scale=minutes">
    <meta name="epoch-offset" content="value=268232520, scale=seconds">

Equipped with this information, a user agent could "decode" a personal epoch timestamp in order to render it as a human readable date.

---

## Footnotes

<a href="#ref-redirects" name="fn-redirects">1</a>: ... tk
