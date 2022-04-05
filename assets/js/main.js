$(document).ready(() => {
    termLink();
    appLink();
    appNtClick();
    closeApp();
    getPrl();
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

// close the section of the apparatus
let closeApp = () => {
    $("#app-see .btn-app").on("click", function() {
        $("#app-see").removeClass("show");
        $(".app-nt-comp .btn-collapse").attr("aria-expanded", "false");
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
        var txt = $(this).clone().html();
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
    });

    // texts
    txtArr.forEach(function(txt) {
        titlesArr.forEach(function(title) {
            if (txt.indexOf(title) !== -1) {
                $(".container-" + title).append('<div class="show" id=' + title + '>' + txt + '</div>');
            };
        });
    });

    // click on the open the entire parallel button
    $(".prl-bibl").click("on", function() {
        var ex = $(this).data("excerpt-ref");
        // remove other selected txt
        $(".prl-select").removeClass("prl-select");
        // highlight the corresponding txt
        $("div[data-excerpt='" + ex + "']").addClass("prl-select");
        // highlight the corresponding sigla
        $(".prl-target[ref='#" + ex + "']").addClass("prl-select");
    });

    // click on the txt
    $(".full-txt").click("on", function() {
        var ex = $(this).data("excerpt");
        // remove other selected txt
        $(".prl-select").removeClass("prl-select");
        // highlight the corresponding txt
        $("div[data-excerpt='" + ex + "']").addClass("prl-select");
        // highlight the corresponding sigla
        $(".prl-target[ref='#" + ex + "']").addClass("prl-select");
        // open the corresponding inline parallel
        var prl = $(".prl-target[ref='#" + ex + "']").parents(".collapse[data-type='parallel']").attr("id");
        var target = $(".btn-collapse[href='#" + prl + "']").parents(".row[data-type='section']");
        if ($(".prl-target[ref='#" + ex + "']").parents(".collapse[data-type='parallel']").hasClass("show") == false) {
            $(".btn-collapse[href='#" + prl + "']").click();
        };
        // scroll the text of the edition
        var divToScroll = $(".lay-txt");
        divToScroll.animate({
            scrollTop: $(target).position().top + divToScroll.scrollTop() - 100
        }, 500, "swing");
    });

};