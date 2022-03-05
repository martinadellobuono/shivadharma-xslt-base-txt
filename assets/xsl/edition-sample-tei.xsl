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
                    <script src="https://kit.fontawesome.com/3f44d79208.js" crossorigin="anonymous"></script>
                </head>
                <body>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="border col-md-12 px-4 pt-2">
                                <header>
                                    <h1 class="h2">
                                        <xsl:value-of select="//tei:title[@type='main']"/>
                                        <xsl:text> </xsl:text>
                                        <span class="text-secondary">Scholarly Digital Edition</span>
                                    </h1>
                                    <h2 class="h5 text-muted" data-type="{//tei:editor/name()}">
                                        Edited by 
                                        <span id="{//tei:editor/@xml:id}">
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
                            <div class="border col-md-6 lay-txt">
                                <xsl:copy>
                                    <xsl:apply-templates select="//tei:text"/>
                                </xsl:copy>
                            </div>
                            <!-- translation -->
                            <div class="col-md-3 border lay-prl">
                                <div class="row p-4">
                                    translation
                                </div>
                            </div>
                            <!-- parallels -->
                            <div class="col-md-3 border lay-prl">
                                <div class="row p-4">
                                    parallels
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 border-top lay-btn p-4">
                                <ul class="nav nav-pills" id="tools-txt" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="btn-app btn-sm nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#app" type="button" role="tab" aria-controls="app" aria-selected="true">Apparatus</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="btn-ph-nt btn-sm nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#ph-nt" type="button" role="tab" aria-controls="ph-nt" aria-selected="false">Philological notes</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="btn-lt-nt btn-sm nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#lt-nt" type="button" role="tab" aria-controls="lt-nt" aria-selected="false">Literary notes</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="btn-hs-nt btn-sm nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#hs-nt" type="button" role="tab" aria-controls="hs-nt" aria-selected="false">Historical notes</button>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="tab-content" id="tools-txt">
                            <div class="lay-app tab-pane fade show active" id="app" role="tabpanel" aria-labelledby="app-tab">
                                <div class="col-md-12 px-4">
                                    <div class="row">
                                        <xsl:apply-templates select="//tei:app"/>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="ph-nt" role="tabpanel" aria-labelledby="ph-nt-tab">
                                <div class="col-md-12 px-4">
                                    <div class="row">
                                        <xsl:apply-templates select="//tei:note[@type='philological']"/>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="lt-nt" role="tabpanel" aria-labelledby="lt-nt-tab">
                                Literary notes
                            </div>
                            <div class="tab-pane fade" id="hs-nt" role="tabpanel" aria-labelledby="hs-nt-tab">
                                Historical notes
                            </div>
                        </div>
                    </div>
                    <script src="assets/js/jquery/jquery-3.6.0.slim.min.js"></script>
                    <script src="assets/bootstrap/js/bootstrap.js"></script>
                    <script src="assets/js/main.js"></script>
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
    
    <!-- intro base-text -->
    <xsl:template match="tei:div[@type='chapter']/tei:head[@type='introduction']">
        <div class="row">
            <div class="col-md-12 p-4">
                <span class="{@type}-base" data-type="{@type}">
                    <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)] | node()/tei:lem"/>
                </span>
            </div>
        </div>
    </xsl:template>

    <!-- intro commentary -->
    <xsl:template match="div[@type='commentary']/tei:head[@type='introduction']">
        <span data-type="{@type}">
            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)] | node()/tei:lem" />
        </span>
    </xsl:template>

    <!-- lg -->
    <xsl:template match="tei:lg">
        <div class="col-md-12 px-4 py-2" data-type="{name()}" data-met="{@met}">
            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:gap)]"/>
            <xsl:apply-templates select="tei:gap"/>
        </div>
    </xsl:template>

    <!-- l -->
    <xsl:template match="tei:l">
        <xsl:variable name="app-loc">
            <xsl:value-of select="./ancestor::tei:div[@type='section']/@n"/>
            <xsl:value-of select="./ancestor::tei:l/@n"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="../@met = 'Anuṣṭubh'">
                <xsl:choose>
                    <xsl:when test="./@n = 'a'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app | ancestor-or-self::tei:note)] | node()/tei:lem" />
                        </span>
                    </xsl:when>
                    <xsl:when test="./@n = 'b'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app | ancestor-or-self::tei:note)] | node()/tei:lem" />
                            <span data-type="single-danda"> | </span>
                            <br/>
                        </span>
                    </xsl:when>
                    <xsl:when test="./@n = 'c'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app | ancestor-or-self::tei:note)] | node()/tei:lem" />
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app | ancestor-or-self::tei:note)] | node()/tei:lem" />
                            <xsl:text> </xsl:text>
                            <span data-type="double-danda"> || <span><xsl:value-of select="./ancestor::tei:div[@type='chapter']/@n"/></span>.<span><xsl:value-of select="./ancestor::tei:div[@type='section']/@n"/></span> || </span>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="./@n = 'b'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app | ancestor-or-self::tei:note)] | node()/tei:lem" />
                            <xsl:text> </xsl:text>
                            <span data-type="single-danda"> | </span>
                            <br/>
                        </span>
                    </xsl:when>
                    <xsl:when test="./@n = 'd'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app | ancestor-or-self::tei:note)] | node()/tei:lem" />
                            <xsl:text> </xsl:text>
                            <span data-type="double-danda"> || <span><xsl:value-of select="./ancestor::tei:div[@type='chapter']/@n"/></span>.<span><xsl:value-of select="./ancestor::tei:div[@type='section']/@n"/></span> ||</span>
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app | ancestor-or-self::tei:note)] | node()/tei:lem" />
                            <br/>
                        </span>    
                    </xsl:otherwise> 
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- commentary -->
    <xsl:template match="tei:div[@type='commentary'][not(descendant::tei:head)]">
        <div class="bg-light col-md-12 p-4" data-type="{@type}">
            <a class="btn btn-collapse btn-primary btn-br btn-sm" data-bs-toggle="collapse" href="#sec-comm" role="button" aria-expanded="true" aria-controls="Open the commentary">
                Commentary
            </a>
        </div>
        <div id="sec-comm" class="bg-light col-md-12 pb-4 px-4 show" data-type="{@type}">
            <xsl:apply-templates select="@* | node()"/>
        </div>
    </xsl:template>

    <!-- commentary -->
    <xsl:template match="tei:div[@type='commentary'][(descendant::tei:head)]">
        <div id="sec-comm" class="bg-light col-md-12 p-4 show" data-type="{@type}">
            <xsl:apply-templates select="@* | node()"/>
        </div>
    </xsl:template>

    <!-- commentary > gloss -->
    <xsl:template match="tei:div[@type='commentary']/tei:gloss">
        <xsl:variable name="app-loc">
            <xsl:value-of select="tei:app/@loc"/>
        </xsl:variable>  
        <span data-type="{name()}">
            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
            <xsl:apply-templates select="node()/tei:lem" />
            <span class="danda"> | </span>
        </span>
    </xsl:template>

    <!-- commentary > introduction -->
    <xsl:template match="tei:head/tei:gloss">
        <xsl:variable name="app-loc">
            <xsl:value-of select="tei:app/@loc"/>
        </xsl:variable>  
        <span data-type="{../@type}">
            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:app)]"/>
            <xsl:apply-templates select="node()/tei:lem" />
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
        <!-- app loc -->
        <xsl:variable name="app-loc">
            <xsl:value-of select="./ancestor::tei:div[@type='section']/@n"/>
            <xsl:value-of select="./ancestor::tei:l/@n"/>
        </xsl:variable>    
        <div data-loc="{$app-loc}" data-type="{name()}">
            <span class="app-click" ref="#{@xml:id}">
                <span data-type="loc"><xsl:value-of select="$app-loc"/></span>
                <xsl:text> </xsl:text>
                <!-- lem -->
                <xsl:apply-templates select="tei:lem" mode="lemapp"/>
                <!-- rdg -->
                <xsl:choose>
                    <!-- gap -->
                    <xsl:when test="./ancestor::tei:gap">
                        <xsl:apply-templates select="./tei:rdg" mode="rdgap"/>
                    </xsl:when>
                    <!-- post correctionem -->
                    <xsl:when test="./tei:rdg/following-sibling::tei:witDetail/@type = 'pc'">
                        <xsl:apply-templates select="./tei:rdg" mode="rdgpc"/>
                    </xsl:when>
                    <!-- normal rdg -->
                    <xsl:otherwise>
                        <xsl:apply-templates select="./tei:rdg" mode="rdg"/>
                    </xsl:otherwise>
                </xsl:choose>
            </span>
            <!-- notes -->
            <xsl:if test="./following-sibling::tei:note[@type='philological']">
                <span class="nt-click ms-3" data-type="ph-nt" ref="#{./following-sibling::tei:note[@type='philological']/@xml:id}">
                    <i class="fa-solid fa-caret-right"></i> Note
                </span>
            </xsl:if>
        </div>
    </xsl:template>

    <!-- lem in txt -->
    <xsl:template match="tei:lem">
        <xsl:choose> 
            <xsl:when test="@rend = 'circlefront'">
                <span id="{../@xml:id}" class="app-click" data-type="{name()}" data-wit="{@wit}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'circleback'">
                <span id="{../@xml:id}" class="app-click" data-type="{name()}" data-wit="{@wit}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>  
            <xsl:when test="@rend = 'circlearound'">
                <span id="{../@xml:id}" class="app-click" data-type="{name()}" data-wit="{@wit}">
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
    <xsl:template match="tei:l/tei:app/tei:lem[@rend] | tei:l/tei:app/tei:rdg[@rend] | tei:gap/tei:app/tei:lem[@rend] | tei:l/tei:gap/tei:rdg[@rend] | tei:gloss/tei:app/tei:lem[@rend] | tei:gloss/tei:rdg[@rend]" mode="lemapp">
        <xsl:choose>
            <!-- circles -->
            <xsl:when test="@rend = 'circlefront'">
                <span data-type="{name()}" data-wit="{@wit}">
                    °<xsl:apply-templates/>
                </span>
                <span data-type="divider"> ] </span>
            </xsl:when>
            <xsl:when test="@rend = 'circleback'">
                <span data-type="{name()}" data-wit="{@wit}">
                    <xsl:apply-templates/>°
                </span>
                <span data-type="divider"> ] </span>
            </xsl:when>
            <xsl:when test="@rend = 'circlearound'">
                <span data-type="{name()}" data-wit="{@wit}">
                    °<xsl:apply-templates/>°
                </span>
                <span data-type="divider"> ] </span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <!-- omission -->
                    <xsl:when test="./descendant::tei:gap">
                        <span data-type="app-om-lem" data-wit="{@wit}">
                            om.
                        </span>
                    </xsl:when>
                    <!-- basic app -->
                    <xsl:otherwise>
                        <span data-type="{name()}" data-wit="{@wit}">
                            <xsl:apply-templates/>
                        </span>
                        <span data-type="divider"> ] </span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <!-- wit -->
        <span><xsl:value-of select="./@wit"/></span>

        <!-- wit -->
        <!--<xsl:variable name="wit-lem">
            <xsl:value-of select="substring-after(./@wit, '#')"/>
        </xsl:variable>
        <span data-type="wit" title="witness" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="right" data-bs-content="Settlement: {//tei:witness[@xml:id = $wit-lem]/descendant::tei:settlement}">
            <span><xsl:value-of select="//tei:witness[@xml:id = $wit-lem]/descendant::tei:idno/node()[not(self::tei:sub or self::tei:sup)]"/></span>
            <sup><xsl:value-of select="//tei:witness[@xml:id = $wit-lem]/descendant::tei:idno/tei:sup"/></sup>
            <sub><xsl:value-of select="//tei:witness[@xml:id = $wit-lem]/descendant::tei:idno/tei:sub"/></sub>
        </span>--> 
    </xsl:template>
    
    <!-- rdg -->
    <xsl:template match="tei:l/tei:app/tei:rdg | tei:gloss/tei:app/tei:rdg" mode="rdg">  
        <span class="ms-3" data-wit="{@wit}">
            <span data-type="{name()}"><xsl:value-of select="."/></span>
            <xsl:text> </xsl:text>
            <!-- wit -->
            <span><xsl:value-of select="./@wit"/></span>
            <!--<xsl:variable name="wit-rdg">
                <xsl:value-of select="substring-after(./@wit, '#')"/>
            </xsl:variable>
            <span data-type="wit" title="witness" data-bs-container="body" data-bs-toggle="popover" data-bs-placement="right" data-bs-content="Settlement: {//tei:witness[@xml:id = $wit-rdg]/descendant::tei:settlement}">
                <span><xsl:value-of select="//tei:witness[@xml:id = $wit-rdg]/descendant::tei:idno/node()[not(self::tei:sub or self::tei:sup)]"/></span>
                <sup><xsl:value-of select="//tei:witness[@xml:id = $wit-rdg]/descendant::tei:idno/tei:sup"/></sup>
                <sub><xsl:value-of select="//tei:witness[@xml:id = $wit-rdg]/descendant::tei:idno/tei:sub"/></sub>
            </span>-->
        </span>
    </xsl:template>

    <!-- gap -->
    <xsl:template match="tei:lg/tei:gap">
        <span id="{./tei:app/@xml:id}" class="app-click" data-type="{name()}" data-met="{@met}">
            <span class="text-muted">→</span>
        </span>
    </xsl:template>

    <!-- rdg in gap -->
    <xsl:template match="tei:gap/tei:app/tei:rdg" mode="rdgap">  
        <span class="ms-3" data-type="{name()}" data-wit="{@wit}">
            <!-- wit -->
            <xsl:for-each select="tokenize(translate(./@wit, ' ', ''), '#')">  
                <span data-type="app-om-rdg">
                    <xsl:value-of select="."/>
                    <xsl:text> </xsl:text>
                </span>
            </xsl:for-each>
            <span data-type="app-om-ins"> inserts: </span>
            <span data-type="{name()}">
                <xsl:apply-templates select="./tei:lg" mode="gaplg"/>
            </span>
        </span>
    </xsl:template>

    <!-- lg in gap -->
    <xsl:template match="tei:gap/tei:app/tei:rdg/tei:lg" mode="gaplg">
        <span class="gap-lg">
            <xsl:apply-templates select="@* | node()" mode="gapl"/>
        </span>
    </xsl:template> 

    <!-- l in gap -->
    <xsl:template match="tei:gap/tei:app/tei:rdg/tei:lg/tei:l" mode="gapl">
        <xsl:choose>
            <xsl:when test="../@met = 'Anuṣṭubh'">
                <xsl:choose>
                    <xsl:when test="./@n = 'a'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()" />
                        </span>
                    </xsl:when>
                    <xsl:when test="./@n = 'b'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()" />
                            <span data-type="single-danda"> | </span>
                        </span>
                    </xsl:when>
                    <xsl:when test="./@n = 'c'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()" />
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()" />
                            <xsl:text> </xsl:text>
                            <span data-type="double-danda"> || </span>
                        </span>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="./@n = 'b'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()" />
                            <xsl:text> </xsl:text>
                            <span data-type="single-danda"> | </span>
                        </span>
                    </xsl:when>
                    <xsl:when test="./@n = 'd'">
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()" />
                            <xsl:text> </xsl:text>
                            <span data-type="double-danda"> || </span>
                        </span>
                    </xsl:when>
                    <xsl:otherwise>
                        <span data-type="{name()}" data-n="{@n}">
                            <xsl:apply-templates select="@* | node()" />
                        </span>    
                    </xsl:otherwise> 
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- post correctionem -->
    <xsl:template match="tei:l/tei:app/tei:rdg | tei:gloss/tei:app/tei:rdg" mode="rdgpc">  
        <span class="ms-3" data-wit="{@wit}">
            <span data-type="{name()}"><xsl:value-of select="."/></span>
            <span> added </span>
            <span data-type="pc">p.c.</span>
            <span> in </span>
            <!-- wit -->
            <span><xsl:value-of select="./@wit"/></span>
        </span>
    </xsl:template>

    <!-- note > philological --> 
    <xsl:template match="tei:note[@type='philological']">
        <div data-type="{name()}" id="{@xml:id}">
            <xsl:variable name="app-loc">
                <xsl:value-of select="./ancestor::tei:div[@type='section']/@n"/>
                <xsl:value-of select="./ancestor::tei:l/@n"/>
            </xsl:variable>
            <span data-type="loc">
                <xsl:value-of select="$app-loc"/>
            </span>
            <span><xsl:value-of select="."/></span>
        </div>
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
