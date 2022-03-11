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
                        <!-- lay 0 -->
                        <div class="row">
                            <div class="border col-md-12 px-3 pt-2">
                                <h1 class="h4">
                                    <xsl:value-of select="//tei:title[@type='main']"/>
                                    <xsl:text> </xsl:text>
                                    <span class="text-secondary">Scholarly Digital Edition</span>
                                    <span class="h6 text-muted" data-type="{//tei:editor/name()}">
                                        Edited by 
                                        <span id="{//tei:editor/@xml:id}">
                                            <xsl:value-of select="//tei:editor"/>
                                        </span>
                                    </span>
                                </h1>
                            </div>
                        </div>
                        <!-- lay 1 -->
                        <div class="row lay-1">
                            <!-- apparatus > damages -->
                            <div class="border col-md-2 sec" id="app-dmg">
                                <div class="icon-cls">
                                    <i class="fa-solid fa-xmark"></i>
                                </div>
                                <div class="icon-opn">
                                    <i class="fa-solid fa-expand"></i>
                                </div>
                                <div class="row p-3 lay-dmg scrollbar">
                                    <div class="row">
                                        <xsl:apply-templates select="//tei:gap[@start]" mode="gapapp"/>
                                    </div>
                                </div>
                            </div>
                            <!-- text and commentary -->
                            <div class="border col-md-5 sec" id="txt">
                                <div class="icon-cls">
                                    <i class="fa-solid fa-xmark"></i>
                                </div>
                                <div class="icon-opn">
                                    <i class="fa-solid fa-expand"></i>
                                </div>
                                <div class="row p-3 lay-txt scrollbar">
                                    <xsl:apply-templates select="//tei:text"/>
                                </div>
                            </div>
                            <!-- translation -->
                            <div class="border col-md-3 sec" id="trl">
                                <div class="icon-cls">
                                    <i class="fa-solid fa-xmark"></i>
                                </div>
                                <div class="icon-opn">
                                    <i class="fa-solid fa-expand"></i>
                                </div>
                                <div class="row p-3 lay-trs scrollbar">
                                    <div class="row">
                                        translation
                                    </div>
                                </div>
                            </div>
                            <!-- parallels -->
                            <div class="border col-md-2 sec" id="prl">
                                <div class="icon-cls">
                                    <i class="fa-solid fa-xmark"></i>
                                </div>
                                <div class="icon-opn">
                                    <i class="fa-solid fa-expand"></i>
                                </div>
                                <div class="row p-3 lay-prl scrollbar">
                                    <div class="row">
                                       parallels
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- lay 2 -->
                        <!-- apparatus -->
                        <div class="app-nt-comp collapse lay-2 row" id="app-see">
                            <div class="col-md-12 border-top lay-btn pt-3">
                                <div>
                                    <button class="btn-app btn-sm nav-link active">
                                        <i class="fa-solid fa-xmark"></i>
                                        Apparatus
                                    </button>
                                </div>
                                <div class="lay-app scrollbar">
                                    <xsl:apply-templates select="//tei:app"/>
                                </div>
                            </div>
                        </div>
                        <!-- lay 3 -->
                        <!-- notes -->
                        <div class="row lay-3">
                            <div class="col-md-12 border-top lay-btn pt-3">
                                <ul class="nav nav-pills" role="tablist">
                                    <li class="nav-item" role="presentation">
                                        <button class="btn-ph-nt btn-sm nav-link active" id="profile-tab" data-bs-toggle="tab" data-bs-target="#ph-nt" type="button" role="tab" aria-controls="ph-nt" aria-selected="false">Philological notes</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="btn-lt-nt btn-sm nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#lt-nt" type="button" role="tab" aria-controls="lt-nt" aria-selected="false">Literary notes</button>
                                    </li>
                                    <li class="nav-item" role="presentation">
                                        <button class="btn-hs-nt btn-sm nav-link" id="contact-tab" data-bs-toggle="tab" data-bs-target="#hs-nt" type="button" role="tab" aria-controls="hs-nt" aria-selected="false">Historical notes</button>
                                    </li>
                                </ul>
                            </div>
                            <div class="app-nt-comp tab-content">
                                <div class="tab-pane fade show active" id="ph-nt" role="tabpanel" aria-labelledby="ph-nt-tab">
                                    <xsl:apply-templates select="//tei:note[@type='philological']"/>
                                </div>
                                <div class="tab-pane fade" id="lt-nt" role="tabpanel" aria-labelledby="lt-nt-tab">
                                    Literary notes
                                </div>
                                <div class="tab-pane fade" id="hs-nt" role="tabpanel" aria-labelledby="hs-nt-tab">
                                    Historical notes
                                </div>
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
        <div class="row px-4 py-2" data-type="{@type}">
            <xsl:apply-templates select="@* | node()"/>
        </div>
    </xsl:template>
    
    <!-- intro base-text -->
    <xsl:template match="tei:div[@type='chapter']/tei:head[@type='introduction']">
        <div class="row px-4">
            <div class="col-md-12">
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
        <div class="col-md-12" data-type="{name()}" data-met="{@met}">
            <xsl:apply-templates select="@* | node()[not(ancestor-or-self::tei:gap)]"/>
            <xsl:apply-templates select="tei:gap"/>
            <span class="btn-collapse" data-bs-toggle="collapse" href="#app-inline-{../@n}" aria-expanded="false" aria-controls="app-inline-{../@n}"> app.</span>
        </div>
        <!-- inline app -->
        <div class="collapse pt-2" id="app-inline-{../@n}">
            <div class="app-nt-comp border card card-body">
                <xsl:apply-templates select="./descendant::tei:app"/>
                <span class="btn-collapse" data-bs-toggle="collapse" href="#app-see" aria-expanded="false" aria-controls="See the entire apparatus">Open the entire apparatus of the edition</span>
            </div>
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
        <div id="sec-comm" class="bg-light col-md-12 pb-4 px-3 show" data-type="{@type}">
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
    
    <!-- apparatus > philological -->
    <xsl:template match="tei:app">
        <!-- app loc -->
        <xsl:variable name="app-loc">
            <xsl:value-of select="./ancestor::tei:div[@type='section']/@n"/>
            <xsl:value-of select="./ancestor::tei:l/@n"/>
        </xsl:variable>
        <div class="app-target" ref="#{@xml:id}" data-loc="{$app-loc}" data-type="{name()}">
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
                <!-- normal rdg -->
                <xsl:otherwise>
                    <xsl:apply-templates select="./tei:rdg" mode="rdg"/>
                </xsl:otherwise>
            </xsl:choose>
            <!-- notes -->
            <xsl:if test="./following-sibling::tei:note[@type='philological']">
                <span class="nt-click ms-3" data-type="ph-nt" ref="#{./following-sibling::tei:note[@type='philological']/@xml:id}">
                    <i class="fa-solid fa-caret-right"></i>
                    Note
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
                <xsl:text> </xsl:text>
                <span data-type="divider-lem"></span>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="@rend = 'circleback'">
                <span data-type="{name()}" data-wit="{@wit}">
                    <xsl:apply-templates/>°
                </span>
                <xsl:text> </xsl:text>
                <span data-type="divider-lem"></span>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:when test="@rend = 'circlearound'">
                <span data-type="{name()}" data-wit="{@wit}">
                    °<xsl:apply-templates/>°
                </span>
                <xsl:text> </xsl:text>
                <span data-type="divider-lem"></span>
                <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <!-- omission -->
                    <xsl:when test="./descendant::tei:gap[not(@start)]">
                        <span data-type="app-om-lem" data-wit="{@wit}">
                            om.
                        </span>
                    </xsl:when>
                    <!-- basic app -->
                    <xsl:otherwise>
                        <span data-type="{name()}" data-wit="{@wit}">
                            <xsl:apply-templates/>
                        </span>
                        <xsl:text> </xsl:text>
                        <span data-type="divider-lem"></span>
                        <xsl:text> </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <!-- wit -->
        <span data-type="wit"><xsl:value-of select="./@wit"/></span>
    </xsl:template>
    
    <!-- rdg -->
    <xsl:template match="tei:l/tei:app/tei:rdg | tei:gloss/tei:app/tei:rdg" mode="rdg">
        <span class="ms-3" data-wit="{@wit}">
            <xsl:choose>
                <!-- post correctionem -->
                <xsl:when test="./descendant::tei:witDetail[@type='pc']">
                    <span data-type="{name()}"><xsl:value-of select="."/></span>
                    <span> added </span>
                    <span data-type="pc">p.c.</span>
                    <span> in </span>
                    <!-- wit -->
                    <span data-type="wit"><xsl:value-of select="./@wit"/></span>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="@rend = 'circlefront'">
                            °<span data-type="{name()}"><xsl:value-of select="."/></span>
                        </xsl:when>
                        <xsl:when test="@rend = 'circleback'">
                            <span data-type="{name()}"><xsl:value-of select="."/></span>°
                        </xsl:when>
                        <xsl:when test="@rend = 'circlearound'">
                            °<span data-type="{name()}"><xsl:value-of select="."/></span>°
                        </xsl:when>
                        <xsl:otherwise>
                            <span data-type="{name()}"><xsl:value-of select="."/></span>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text> </xsl:text>
                    <!-- wit -->
                    <span data-type="wit"><xsl:value-of select="@wit"/></span>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>    

    <!-- omission -->
    <!-- omission in apparatus -->
    <xsl:template match="tei:lg/tei:gap">
        <span id="{./tei:app/@xml:id}" class="app-click" data-type="{name()}" data-met="{@met}">
            <span class="text-muted">om.</span>
        </span>
    </xsl:template>

    <!-- omission in gap in apparatus -->
    <xsl:template match="tei:gap/tei:app/tei:rdg/tei:lg" mode="gaplg">
        <span class="gap-lg">
            <xsl:apply-templates select="@* | node()" mode="gapl"/>
        </span>
    </xsl:template>

    <!-- l in omission in apparatus -->
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

    <!-- rdg in omission in apparatus -->
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

    <!-- lacuna -->
    <!-- lacuna in text -->
    <xsl:template match="tei:lg/tei:l/tei:gap">
        <span id="{@xml:id}" class="app-click" data-type="{name()}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- lacuna in apparatus -->
    <xsl:template match="tei:gap[@start]" mode="gapapp">
        <xsl:variable name="app-loc">
            <xsl:value-of select="./ancestor::tei:div[@type='section']/@n"/>
            <xsl:value-of select="./ancestor::tei:l/@n"/>
        </xsl:variable>
        <div class="app-lac app-target col-md-12" ref="#{@xml:id}" data-loc="{$app-loc}" data-type="{name()}">
            <span data-type="loc"><xsl:value-of select="$app-loc"/></span>
            <xsl:text> </xsl:text>
            <span data-type="{name()}" data-wit="{@wit}">
                <xsl:value-of select="./@start"/>
                <span data-type="divider-lac"></span>
                <xsl:value-of select="./@end"/>
            </span>
            <xsl:text> </xsl:text>
            <span data-type="divider-lem"></span>
            <xsl:text> </xsl:text>
            <span data-type="dam"> dam. </span>
            <span data-type="wit"><xsl:value-of select="./@wit"/></span>
        </div>
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
