$(document).ready(() => {
    termLink();
    appLink();
    appNtClick();
    getPrl();
    collapsibleDiv();
    getTrans();
});

/* TERMS - link between the term in the text and in the commentary */
/* when you click on one of them the other is highlighted */
let termLink = () => {
    $("*[data-type='term']").each(function() {
        var term = $(this);
        $("*[data-type='l']").find(term).append('<i class="fa-solid fa-caret-right term-icon"></i>');
    });
    // click the term
    $("*[data-type='term']").on("click", function() {
        if (this.hasAttribute("id")) {
            var id = $(this).attr("id");
            $(this).toggleClass("term-select");
            $("*[ref='#" + id + "']").toggleClass("term-select");
        } else {
            var ref = $(this).attr("ref");
            $(this).toggleClass("term-select");
            $(ref).toggleClass("term-select");
        };
    });
};

/* APPARATUS ENTRY - link between the lemma in the text and the corresponding apparatus entry */
/* when you click on one of them the other is highlighted */
let appLink = () => {
    // click on the apparatus entry in the text
    $(".app-click").on("click", function() {
        var term = $(this);
        var target = $(this).attr("id");
        var btn = $(term).parents("div[data-type='lg']").find(".btn-collapse[data-target='app']");
        var app = $(term).parents("div[data-type='lg']").find(".btn-collapse[data-target='app']").attr("href");
        $(".app-select").removeClass("app-select");
        // highlight the apparatus entry
        $(".app-target[ref='#" + target + "']").addClass("app-select");
        // highlight the lemma in the text
        if (term.attr("data-type") !== "parallel") {
            $(term).addClass("app-select");
        };
        // open the apparatus entry        
        if (!$(app).hasClass("show")) {
            $(btn).click();
        };
    });
    // click on the apparatus entry in the apparatus 
    // and scrolls the text to the corresponding point
    $(".app-target").on("click", function() {
        var term = $(this);
        var target = $(this).attr("ref");
        var divToScroll = $(".lay-txt");
        $(".app-select").removeClass("app-select");
        $(term).addClass("app-select");
        // parallels
        if (term.attr("data-type") == "parallel") {
            // scroll to the point
            divToScroll.animate({
                scrollTop: $(target).parent().position().top + divToScroll.scrollTop() - 100
            }, 500, "swing");
            // open the parallel entry
            if (!$(target).hasClass("show")) {
                $(".btn-collapse[href='" + target + "']").click();
            };
        }
        // else
        else {
            // highlight the lemma in the text
            $(target).addClass("app-select");
            // scroll to the point
            divToScroll.animate({
                scrollTop: $(target).position().top + divToScroll.scrollTop() - 100
            }, 500, "swing");
        };
    });
};

/* APPARATUS ENTRY/NOTE - link between the apparatus entry and the corresponding note */
/* when you hover one of them the other is highlighted */
let appNtClick = () => {
    // click on the note in the app
    $(".nt-click").on("click", function() {
        var nt = $(this).attr("data-type");
        var id = $(this).attr("ref");
        $("button[data-bs-target='#" + nt + "']").click();
        $("." + nt + "-select").removeClass(nt + "-select");
        $(id).addClass(nt + "-select");
        // scroll to the entry in the apparatus
        $(nt).animate({
            scrollTop: $(id).offset().top - $(nt).offset().top
        }, 100);
    });
};

/* PARALLELS - click on a source and get the full-text */
let getPrl = () => {

    // arrays of titles and texts
    var titlesArr = [];
    var txtArr = [];
    $("div[data-type='parallel']").each(function() {
        var title = $(this).data("source");
        var txt = $(this).html();
        if (title !== undefined) {
            // array of titles
            if (!titlesArr.includes(title)) {
                titlesArr.push(title);
            };
            // array of full-texts
            if (!txtArr.includes(txt)) {
                txtArr.push(txt);
            };
        };
    });
        
    // titles
    titlesArr.forEach(function(title) {
        // create a div for title
        $("<div>", {
            class: "container-" + title + " mt-3"
        }).appendTo("#prl-targ");
        $(".container-" + title).html('<a class="btn-collapse introduction-base title-full-prl" data-bs-toggle="collapse" href="#' + title + '" role="button" aria-expanded="true" aria-controls="Open the parallel">' + title + "</a>");
        $("<div>", {
            class: "full-" + title + " prl-sec"
        }).appendTo(".container-" + title);
    });

    // texts
    txtArr.forEach(function(txt) {
        titlesArr.forEach(function(title) {
            if (txt.indexOf(title) !== -1) {
                $(".full-" + title).append('<div class="show" id=' + title + '>' + txt + '</div>');
            };
        });
    });

    // click on the open the entire parallel button
    $(".prl-bibl").click("on", function() {

        // remove translations
        $(".trans-active").removeClass("trans-active");

        // close the not clicked inline parallel
        var collapseId = $(this).parents(".collapse").attr("id");
        $(".collapse[data-type='parallel'][id!='" + collapseId + "']").removeClass("show");
        $(".btn-collapse[href!='" + collapseId + "'][data-target='prl']").attr("aria-expanded", "false");

        var ex = $(this).data("excerpt-ref");
        var src = $(this).data("source");
        // click on the parallel tab
        $("#prl-tab").click();
        // remove other selected txt
        $(".prl-select").removeClass("prl-select");
        // highlight the txt
        $("div[data-excerpt='" + ex + "']").addClass("prl-select");
        // open the collapsible div
        if ($(".title-full-prl[href='#" + src + "']").attr("aria-expanded") == "false") {
            $(".title-full-prl[href='#" + src + "']").attr("aria-expanded", "true");
            $(".full-" + src).addClass("prl-sec");
            $(".full-" + src).find(".collapse").addClass("show");
        };
        // scroll the txt to the top
        var txtToScroll = $("div[data-excerpt='" + ex + "']").parents(".prl-sec");
        var target = $("div[data-excerpt='" + ex + "']");
        txtToScroll.animate({
            scrollTop: $(target).position().top + 50
        }, 500, "swing");
        // highlight the stanza
        var prl = $(".prl-target[ref='#" + ex + "']").parents(".collapse[data-type='parallel']").attr("id");
        var target = $(".btn-collapse[href='#" + prl + "']").parents(".row[data-type='section']");
        $(target).find("div[data-type='lg']").addClass("prl-select");
        $(target).find(".btn-collapse[data-target='prl']").attr("aria-expanded", "true");
        // highlight the sigla
        $(".prl-target[ref='#" + ex + "']").addClass("prl-select");
    });

    // click on the txt
    $(".full-txt").click("on", function() {

        // remove translations
        $(".trans-active").removeClass("trans-active");

        var ex = $(this).data("excerpt");
        // remove other selected txt
        $(".prl-select").removeClass("prl-select");
        // highlight the txt
        $("div[data-excerpt='" + ex + "']").addClass("prl-select");
        // highlight the sigla
        $(".prl-target[ref='#" + ex + "']").addClass("prl-select");
        // open the inline parallel
        var prl = $(".prl-target[ref='#" + ex + "']").parents(".collapse[data-type='parallel']").attr("id");
        var target = $(".btn-collapse[href='#" + prl + "']").parents(".row[data-type='section']");
        if ($(".prl-target[ref='#" + ex + "']").parents(".collapse[data-type='parallel']").hasClass("show") == false) {
            $(".btn-collapse[href='#" + prl + "']").click();
        };

        // close the not clicked inline parallel
        $(".collapse[data-type='parallel'][id!='" + prl + "']").removeClass("show");
        $(".btn-collapse[href!='" + prl + "'][data-target='prl']").attr("aria-expanded", "false");

        // highlight the stanza
        $(target).find("div[data-type='lg']").addClass("prl-select");
        $(target).find(".btn-collapse[data-target='prl']").attr("aria-expanded", "true");
        // scroll the text of the edition
        var divToScroll = $(".lay-txt");
        divToScroll.animate({
            scrollTop: $(target).position().top + divToScroll.scrollTop() - 100
        }, 500, "swing");
    });

    // click on see all parallels
    $(".all-prl").on("click", function() {
        var originalStanza = $(this).parents(".row[data-type='section']").find(".col-md-12[data-type='lg']");
        // remove translations
        $(".trans-active").removeClass("trans-active");
        // click on the parallel tab
        $("#prl-tab").click();
        // highlight all the parallels
        var allPrl = ($(this).attr("ref").split(" "));
        $(".full-txt.prl-select").removeClass("prl-select");
        allPrl.forEach(function(prl) {
            if (prl !== "") {
                $(".full-txt[data-excerpt='" + prl + "']").addClass("prl-select");
            };
        });
        // highlight the original stanza
        $(originalStanza).addClass("prl-select");
    });

};

/* DIMENSIONS COLLAPSE - on default the collapsible div have to measure 0 */
let collapsibleDiv = () => {
    $(".title-full-prl").on("click", function() {
        if ($(this).attr("aria-expanded") == "true") {
            $(this).next().addClass("prl-sec");
        } else {
            $(this).next().removeClass("prl-sec");
        };
    });
};

/* TRANSLATION - click on a stanza and get the translation and vice versa */
let getTrans = () => {

    // click on a translated stanza
    $("div[data-type='translation']").on("click", function() {
        var stanza = $(this);
        var n = $(this).data("n");
        
        // highlight the translated stanza
        $(".trans-active").removeClass("trans-active")
        $(stanza).addClass("trans-active");

        // highlight the original stanza
        $("div[data-type='section'][data-n='" + n + "']").addClass("trans-active");

        // scroll to the original stanza
        var divToScroll = $(".lay-txt");
        var target = $("div[data-type='section'][data-n='" + n + "']");
        divToScroll.animate({
            scrollTop: $(target).position().top + divToScroll.scrollTop() - 100
        }, 500, "swing");

    });

    // click on the original stanza
    $("div[data-type='section']").click(function(e){
        if (e.offsetX <= parseInt($(this).css("borderLeftWidth"))) {
            var stanza = $(this);
            var n = $(this).data("n");

            // click the translation tab
            $("#trl-tab").click();

            // highlight the original stanza
            $(".trans-active").removeClass("trans-active")
            $(stanza).addClass("trans-active");

            // highlight the original stanza
            $("div[data-type='translation'][data-n='" + n + "']").addClass("trans-active");

            // scroll to the translated stanza
            var divToScroll = $(".lay-txt");
            var target = $("div[data-type='translation'][data-n='" + n + "']");
            divToScroll.animate({
                scrollTop: $(target).position().top + divToScroll.scrollTop() - 100
            }, 500, "swing");

        };
    });

};