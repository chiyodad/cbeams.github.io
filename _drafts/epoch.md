---
layout: post
title: Epoch
---
I was born in Great Falls, Montana on the 2nd of July, 1978 at 7:02am. That date is the beginning of time with regard to anything I could have experienced, done or influenced. It is my zero-moment, my personal [epoch](http://en.wiktionary.org/wiki/epoch).

The zero-moment for the Unix operating system was midnight on the 1st of January, 1970 UTC. This is called the _Unix epoch_, and the number of seconds that have elapsed since then is called _epoch seconds_, or [Unix time](). This is a wonderfully simple way of representing any date with a single number.

For example, here is the `date` command displaying Unix time `0` in human-readable form:

    $ TZ=UTC date -r 0
    Thu Jan  1 00:00:00 UTC 1970

I am writing this post in Vienna, Austria on the 10th of July, 2014 at 4:20pm. Here's `date` again—this time with no arguments—to tell me so:

    $ date
    Thu Jul 10 16:20:00 CEST 2014

Or, the current date displayed in epoch seconds:

    $ date "+%s"
    1405002000

In Unix time, then, this post is 1,405,002,000 seconds old. That number is a simple, portable timestamp that can be translated into any format, time zone, etc. Elegant, right?

    $ date -r 1405002000 "+%d/%m/%Y %H:%M %Z"
    10/07/2014 16:20 CEST

