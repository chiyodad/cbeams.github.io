<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:feedpress="http://feedpress.it/xmlns" version="1.0">

    <xsl:output method="html" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
    <xsl:variable name="title" select="atom:feed/atom:title"/>
    <xsl:variable name="siteUrl" select="atom:feed/atom:link[@rel='alternate']/@href"/>

    <xsl:variable name="feedUrl">
        <xsl:choose>
            <xsl:when test="atom:feed/atom:link[@rel='via']/@href">
                <xsl:value-of select="atom:feed/atom:link[@rel='via']/@href"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="atom:feed/atom:link[@rel='self']/@href">
                        <xsl:value-of select="atom:feed/atom:link[@rel='self']/@href"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text></xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:element name="html">
            <head>
                <title><xsl:value-of select="$title"/> — provided by FeedPress</title>
                <link href="/~files/feed.css" rel="stylesheet" type="text/css" media="all"/>
                <link rel="alternate" type="application/rss+xml" title="{$title}" href="{$feedUrl}"/>
                <meta name="viewport" content="width=device-width"/>
                <xsl:element name="script">
                    <xsl:attribute name="type">text/javascript</xsl:attribute>
                    <xsl:attribute name="src">http://static.feedpress.it/js/feed.js</xsl:attribute>
                </xsl:element>
            </head>
            <body onload="checkFeed('{$feedUrl}'); go_decoding();">
                <div id="cometestme" style="display:none;">
                    <xsl:text disable-output-escaping="yes">&amp;amp;</xsl:text>
                </div>
                <div id="main">
                    <div id="header" class="cf">
                        <xsl:apply-templates select="image"/>
                        <h1>
                            <xsl:choose>
                                <xsl:when test="$siteUrl">
                                    <a href="{normalize-space($siteUrl)}" title="Link to original website"><xsl:value-of select="$title"/></a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$title"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </h1>
                        <h2>proudly brought to you by FeedPress</h2>
                        <p class="about">FeedPress empowers this feed to let you add your favorite content easily in your reader of choice.<br/>
                            <a href="http://feedpress.it">Click here to press your own feed →</a></p>
                    </div>
                    <div id="subscribe">
                        <div id="feedinput">
                            <h4>Copy and paste the feed URL in your favorite reader to subscribe:</h4>
                            <input type="text" name="feed" value="{$feedUrl}" /> <input type="button" onclick="subscribeButton();" value="Subscribe" />
                        </div>
                        <div id="readerslinks">
                            <h4>Or directly click on one of these links:</h4>
                            <a class="subscribe" href="http://add.my.yahoo.com/rss?url={$feedUrl}"><img src="http://us.i1.yimg.com/us.yimg.com/i/us/my/addtomyyahoo4.gif" width="91" height="17" alt="addtomyyahoo4"/></a>
                            <a class="subscribe" href="http://www.feedly.com/home#subscription/feed/{$feedUrl}"><img src="http://s3.feedly.com/img/follows/feedly-follow-rectangle-volume-small_2x.png" width="61" height="20" alt="Subscribe with Feedly"/></a>
                            <a class="subscribe" href="http://www.netvibes.com/subscribe.php?url={$feedUrl}"><img src="http://www.netvibes.com/img/add2netvibes.gif" alt="Add to netvibes" /></a>
                        </div>
                        <xsl:if test="feedpress:newsletterId">
                            <xsl:variable name="nid" select="/rss/channel/feedpress:newsletterId"/>
                            <div id="newsletterlink">
                                <h4><a onclick="window.open('https://feedpress.it/e/mailverify?feed_id={$nid}', 'popupwindow', 'scrollbars=yes,width=550,height=520');return true" target="popupwindow" href="https://feedpress.it/e/mailverify?feed_id={$nid}">Subscribe to <xsl:value-of select="$title"/> by email</a></h4>
                            </div>
                        </xsl:if>
                    </div>
                    <ul>
                        <xsl:apply-templates select="atom:feed/atom:entry"/>
                    </ul>
                </div>
                <div id="footer">
                    <a href="https://feedpress.it"><img src="//feedpress.it/images/feedpress.png"/></a>
                    <p>FeedPress helps you building your audience with powerful tools for your feed.<br/>Webmasters, bloggers, podcasters, <a href="http://feedpress.it" target="_blank">let's press your feed</a>.</p>
                </div>
            </body>
        </xsl:element>
    </xsl:template>

    <xsl:template match="atom:entry" xmlns:dc="http://purl.org/dc/elements/1.1/">
        <li class="regularitem">
            <h4 class="itemtitle">
                <xsl:choose>
                    <xsl:when test="guid[@isPermaLink='true' or not(@isPermaLink)]">
                        <a href="{normalize-space(guid)}"><xsl:value-of select="atom:title"/></a>
                    </xsl:when>
                    <xsl:when test="atom:link">
                        <a href="{normalize-space(atom:link/@href)}"><xsl:value-of select="atom:title"/></a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="atom:title"/>
                    </xsl:otherwise>
                </xsl:choose>
            </h4>
            <h5 class="itemposttime">
                <xsl:if test="count(child::pubDate)=1"><span>Posted: </span><xsl:value-of select="pubDate"/></xsl:if>
                <xsl:if test="count(child::dc:date)=1"><span>Posted: </span><xsl:value-of select="dc:date"/></xsl:if>
            </h5>
            <div class="itemcontent" name="decodeable">
                <xsl:call-template name="outputContent"/>
            </div>
            <xsl:if test="count(child::enclosure)=1">
                <p class="mediaenclosure">Enclosure: <a href="{enclosure/@url}"><xsl:value-of select="child::enclosure/@url"/></a></p>
            </xsl:if>
        </li>
    </xsl:template>

    <xsl:template match="image">
        <a href="{normalize-space(link)}" title="Link to original website"><img src="{url}" id="feedimage" alt="{title}"/></a>
        <xsl:text/>
    </xsl:template>

    <xsl:template name="outputContent">
        <xsl:choose>
            <xsl:when test="atom:content">
                <xsl:value-of select="atom:content" disable-output-escaping="yes"/>
            </xsl:when>
            <xsl:when test="description">
                <xsl:value-of select="description" disable-output-escaping="yes"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>