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
    $(".prl-bibl").on("click", function() {
        var excerpt = $(this).data("excerpt-ref");
        // hide the translation
        // show the full-text of parallels
        $("#full-prl").removeClass("d-none").addClass("col-md-5");
        $("#trl").addClass("d-none").removeClass("col-md-5");
        // print the full-text of parallels
        var src = $(this).attr("data-source");
        var arr = [];
        $("div[data-source='" + src + "']").each(function() {
            var txt = $(this).html();
            arr.push(txt);
        });
        $(".title-full-prl").html(src);
        $(".lay-full-prl").html(arr);
        // highlight the clicked parallel in the full-text of parallels
        $(".bg-orange").removeClass("bg-orange");
        $("div[data-excerpt='" + excerpt + "']").addClass("bg-orange");
    });
};