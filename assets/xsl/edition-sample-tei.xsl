<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
    <xsl:output method="html" indent="yes" omit-xml-declaration="yes" encoding="UTF-8"/>

    <!-- edition -->
    <xsl:template match="/">
        <xsl:result-document>
            <html xmlns:foaf="http://xmlns.com/foaf/0.1/">
                <head>
                    <title></title>
                    <link rel="shortcut icon" href="assets/img/favicon/favicon.ico"/>
                    <link rel="stylesheet" type="text/css" href="assets/style/style.css"/>
                    <link rel="stylesheet" type="text/css" href="assets/bootstrap/css/bootstrap.min.css"/>
                    <script src="https://kit.fontawesome.com/3f44d79208.js" crossorigin="anonymous">script</script>
                </head>
                <body>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="border col-md-12 p-4">
                                <header>
                                    <h1 class="h2">
                                        <xsl:value-of select="//tei:title[@type='main']"/>
                                        <xsl:text> </xsl:text>
                                        <span class="text-secondary">Scholarly Digital Edition</span>
                                    </h1>
                                    <h2 class="fst-italic h5 text-muted">Edited by 
                                        <span data-type="{//tei:editor/name()}" id="{//tei:editor/@xml:id}">
                                            <xsl:value-of select="//tei:editor"/>
                                        </span>
                                    </h2>
                                    <xsl:if test="//tei:div[@type='chapter']">
                                        <h5 data-type="{//tei:div[@type='chapter']/@type}">
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="upper-case(substring(//tei:div[@type='chapter']/@type, 1, 1))"/>
                                            <xsl:value-of select="substring(//tei:div[@type='chapter']/@type, 2)"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="//tei:div[@type='chapter']/@n"/>
                                        </h5>
                                    </xsl:if>
                                </header>
                            </div>
                        </div>
                        <div class="row">
                            <!-- text and commentary -->
                            <div class="border col-md-9 lay-txt">
                                <xsl:copy>
                                    <xsl:apply-templates select="//tei:text"/>
                                </xsl:copy>
                            </div>
                            <!-- parallels -->
                            <div class="col-md-3 border lay-prl">
                                <div class="row">
                                    parallels
                                </div>
                            </div>
                        </div>
                        <!-- apparatus -->
                        <div class="row lay-app">
                            <div class="col-md-12 border p-4">
                                <a class="btn btn-collapse btn-primary btn-cob" data-bs-toggle="collapse" href="#sec-app" role="button" aria-expanded="true" aria-controls="Open the apparatus">
                                    Apparatus
                                </a>
                                <div class="collapse mt-4 row show" id="sec-app">
                                    <xsl:apply-templates select="//tei:app"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script src="assets/js/jquery/jquery-3.6.0.slim.min.js"></script>
                    <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                    <script src="assets/js/main.js"></script>
                    <script>
                        var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
                        var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
                        return new bootstrap.Popover(popoverTriggerEl)
                        })
                    </script>
                    <script>
                        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
                        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                        return new bootstrap.Tooltip(tooltipTriggerEl)
                        })
                    </script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <!-- teiHeader -->
    <xsl:template match="tei:teiHeader"/>

    <!-- section -->
    <xsl:template match="tei:div[@type='section']">
        <div class="row" data-type="{@type}">
            <xsl:apply-templates select="@* | node()"/>
        </div>
    </xsl:template>

    <!-- base text -->
    <xsl:template match="tei:div[@type='base-text']">
        <div class="col-md-12 p-4" data-type="{@type}">
            <xsl:apply-templates select="@* | node()"/>
        </div>
    </xsl:template>
    
    <!-- intro -->
    <xsl:template match="tei:head[@type='introduction']">
        <div class="row">
            <div class="col-md-12 p-4">
                <span data-type="{@type}">
                    <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
                    <xsl:apply-templates select="node()/tei:lem" mode="lemtxt"/>
                </span>
            </div>
        </div>
    </xsl:template>

    <!-- lg -->
    <xsl:template match="tei:lg">
        <div data-type="{name()}" data-met="{@met}">
            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:gap)]"/>
            <xsl:apply-templates select="tei:gap"/>
        </div>
    </xsl:template>

    <!-- gap -->
    <xsl:template match="tei:lg/tei:gap">
        <div id="{./tei:app/@xml:id}" class="app-click" data-type="{name()}" data-met="{@met}">
            <span class="text-muted">Gap</span>
        </div>
    </xsl:template>

    <!-- l -->
    <xsl:template match="tei:l">
        <xsl:variable name="app-loc">
            <xsl:value-of select="tei:app/@loc"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="../@met = 'Anuṣṭubh'">
                <xsl:choose>
                    <xsl:when test="./@n = 'a'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
                            <xsl:apply-templates select="node()/tei:lem" mode="lemtxt"/>
                        </span>
                    </xsl:when>
                    <xsl:when test="./@n = 'b'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
                            <xsl:apply-templates select="node()/tei:lem" mode="lemtxt"/>
                            <br/>
                        </span>
                    </xsl:when>
                    <xsl:when test="./@n = 'c'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
                            <xsl:apply-templates select="node()/tei:lem" mode="lemtxt"/>
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
                            <xsl:apply-templates select="node()/tei:lem" mode="lemtxt"/>
                            <xsl:text> </xsl:text>
                            <span data-type="double-danda"> || <span><xsl:value-of select="./ancestor::tei:div[@type='section']/@n"/></span> || </span>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="./@n = 'b'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
                            <xsl:apply-templates select="node()/tei:lem" mode="lemtxt"/>
                            <xsl:text> </xsl:text>
                            <span data-type="danda"> | </span>
                            <br/>
                        </span>
                    </xsl:when>
                    <xsl:when test="./@n = 'd'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
                            <xsl:apply-templates select="node()/tei:lem" mode="lemtxt"/>
                            <xsl:text> </xsl:text>
                            <span data-type="double-danda"> || <span><xsl:value-of select="./ancestor::tei:div[@type='section']/@n"/></span> ||</span>
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
                            <xsl:apply-templates select="node()/tei:lem" mode="lemtxt"/>
                            <br/>
                        </span>    
                    </xsl:otherwise> 
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- commentary -->
    <xsl:template match="tei:div[@type='commentary']">
        <div class="bg-light col-md-12 p-4" data-type="{@type}">
            <xsl:apply-templates select="@* | node()"/>
        </div>
    </xsl:template>

    <!-- commentary > gloss -->
    <xsl:template match="tei:gloss">
        <xsl:variable name="app-loc">
            <xsl:value-of select="tei:app/@loc"/>
        </xsl:variable>  
        <span data-type="{name()}">
            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
            <xsl:apply-templates select="node()/tei:lem" mode="lemtxt"/>
            <span class="danda"> | </span>
        </span>
    </xsl:template>

    <!-- commentary > term -->
    <xsl:template match="tei:term">
        <span data-type="{name()}">
            <xsl:apply-templates select="@* | node()"/>
        </span>
    </xsl:template>

    <!-- quote -->
    <xsl:template match="tei:quote">
        <xsl:variable name="quote-src">
            <xsl:value-of select="substring-after(@source, '#')"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="@sameAs != ''">
                <span data-type="{name()}" title="{name()}" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="right" data-bs-content='{//tei:citedRange[@xml:id = $quote-src]/preceding-sibling::tei:ref}, {//tei:citedRange[@xml:id = $quote-src]}: "{@sameAs}"'>
                    <xsl:apply-templates select="@* | node()"/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span data-type="{name()}" title="{name()}" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="right" data-bs-content="{//tei:citedRange[@xml:id = $quote-src]/preceding-sibling::tei:ref}, {//tei:citedRange[@xml:id = $quote-src]}">
                    <xsl:apply-templates select="@* | node()"/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:variable name="root">
        <xsl:value-of select="/descendant::tei:witness"/>
    </xsl:variable>
    
    <!-- apparatus -->
    <xsl:template match="tei:app">
        <div class="app-click" ref="#{@xml:id}" data-loc="{@loc}" data-type="{name()}">
            <span data-type="loc"><xsl:value-of select="@loc"/></span>
            <xsl:text> </xsl:text>
            <!-- lem -->
            <xsl:apply-templates select="tei:lem" mode="lemapp"/>
            <!-- rdg -->
            <xsl:choose>
                <xsl:when test="./ancestor::tei:gap">
                    <xsl:apply-templates select="./tei:rdg" mode="rdgap"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="./tei:rdg" mode="rdg"/>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <!-- lem in txt -->
    <xsl:template match="tei:lem" mode="lemtxt">
        <xsl:choose> 
            <xsl:when test="@rend = 'circlefront'">
                <span id="{../@xml:id}" class="app-click term-inline" data-type="{name()}" data-wit="{@wit}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when> 
            <xsl:otherwise> 
                <span id="{../@xml:id}" class="app-click" data-type="{name()}" data-wit="{@wit}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- lem in app -->
    <xsl:template match="tei:l/tei:app/tei:lem[@rend] | tei:l/tei:app/tei:rdg[@rend] | tei:gap/tei:app/tei:lem[@rend] | tei:l/tei:gap/tei:rdg[@rend]" mode="lemapp">
        <xsl:choose>
            <xsl:when test="@rend = ''">
                <span data-type="{name()}" data-wit="{@wit}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span data-type="{name()}" data-wit="{@wit}">
                    °<xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose> 
        <span data-type="divider"> ] </span>
        <!-- wit -->
        <xsl:for-each select="tokenize(translate(./@wit, ' ', ''), '#')">  
            <span>
                <xsl:value-of select="."/>
                <xsl:text> </xsl:text>
            </span>
        </xsl:for-each>
    </xsl:template>

    <!-- rdg -->
    <xsl:template match="tei:l/tei:app/tei:rdg" mode="rdg">  
        <span class="ms-3" data-type="{name()}" data-wit="{@wit}">
            <xsl:value-of select="."/>
            <!-- wit -->
            <xsl:for-each select="tokenize(translate(./@wit, ' ', ''), '#')">  
                <span>
                    <xsl:value-of select="."/>
                    <xsl:text> </xsl:text>
                </span>
            </xsl:for-each>
        </span>
    </xsl:template>

    <!-- rdg in gap -->
    <xsl:template match="tei:gap/tei:app/tei:rdg" mode="rdgap">  
        <span class="ms-3" data-type="{name()}" data-wit="{@wit}">
            <!-- wit -->
            <xsl:for-each select="tokenize(translate(./@wit, ' ', ''), '#')">  
                <span>
                    <xsl:value-of select="."/>
                    <xsl:text> </xsl:text>
                </span>
            </xsl:for-each>
            <span data-type="om-ins"> inserts: </span>
            <span data-type="{name()}"><xsl:value-of select="."/></span>
        </span>
    </xsl:template>

    <!-- uvaca -->
    <xsl:template match="tei:div[@type='uvaca']">
        <div class="row">
            <div class="col-md-12 p-4" data-type="uvaca">
                <span>
                    <xsl:apply-templates select="@* | node()"/>
                </span>
            </div>
        </div>
    </xsl:template>

    <!-- attributes -->
    <xsl:template match="@*">
        <xsl:choose>
            <xsl:when test="name() = 'xml:id'">
                <xsl:attribute name="id">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="name() = 'ref'">
                <xsl:attribute name="ref">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="name() = 'xml:lang'">
                <xsl:attribute name="lang">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="{concat('data-', name())}">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
