$(document).ready(() => {
    termLink();
    appLink();
    appNtClick();
    clsOpnSec();
    closeApp();
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
        // unselect the apparatus entry
        if ($(this).hasClass("app-select")) {
            $(".app-select").removeClass("app-select");
        // select the apparatus entry
        } else {
            var term = "#" + $(this).attr("id");           
            var target = $(".app-target[ref='" + term + "']");
            var btn = $(term).parents("div[data-type='lg']").find(".btn-collapse");
            var app = $(term).parents("div[data-type='lg']").find(".btn-collapse").attr("href");
            // open the inline apparatus only if it is not a lacuna
            if (!$(target).hasClass("app-lac")) {
                if (!$(app).hasClass("show")) {
                    $(btn).click();
                };
            };
            // identify the apparatus entry
            $(".app-select").removeClass("app-select");
            $(term).addClass("app-select");
            $(target).addClass("app-select");
        };
    });
    // click on the apparatus entry in the apparatus
    $(".app-target").on("click", function() {
        // unselect the apparatus entry
        if ($(this).hasClass("app-select")) {
            $(".app-select").removeClass("app-select");
        // select the apparatus entry
        } else {
            var term = $(this);
            var target = $(this).attr("ref");
            $(".app-select").removeClass("app-select");
            $(term).addClass("app-select");
            $(target).addClass("app-select");
            // scroll the text if the apparatus entry refers to a lacuna
            var divToScroll = $(".lay-txt");
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

/* CLOSE SECTIONS */
/* when you click on close button the section is closed */
let clsOpnSec = () => {
    $(".icon-cls").on("click", function() {
        var cls = $(this);
        var opn = $(this).next(".icon-opn");
        var sec = $(this).parent(".sec");
        var cl = $(this).parent(".sec").attr("class").split(" ");

        $(cl).each(function() {
            if (this.indexOf("col-md-") != -1) {
                var clRem = "" + this;
                $(cls).hide();
                $(opn).show();
                $(sec).removeClass(clRem).addClass("col-md-1");
                $(sec).find(".row").hide();
                $(sec).next(".sec").css("background", "red");
            };
        });

    });
    $(".icon-opn").on("click", function() {
        var cls = $(this);
        var opn = $(this).prev(".icon-cls");
        var sec = $(this).parent(".sec");
        var cl = $(this).parent(".sec").attr("class").split(" ");
        $(cl).each(function() {
            if (this.indexOf("col-md-") != -1) {
                var clRem = "" + this;
                $(cls).hide();
                $(opn).show();
                $(sec).removeClass(clRem).addClass("col-md-1");
                $(sec).find(".row").show();
            };
        });
    });
};
