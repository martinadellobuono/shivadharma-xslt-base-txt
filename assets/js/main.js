$(document).ready(() => {
    termLink();
    appLink();
    appNtClick();
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
    // click on the term
    $(".app-click").on("click", function() {
        if (this.hasAttribute("id")) {
            var id = $(this).attr("id");
            // remove already selected entry
            $(".app-select").removeClass("app-select");
            // select the new entry
            $("#" + id).addClass("app-select");
            $("*[ref='#" + id + "']").addClass("app-select");
            // scroll to the entry in the apparatus
            $(".lay-app").animate({
                scrollTop: $("*[ref='#" + id + "']").offset().top - $(".lay-app").offset().top
            }, 100);
        };
        if (this.hasAttribute("ref")) {
            var id = $(this).attr("ref");
            // remove already selected entry
            $(".app-select").removeClass("app-select");
            // select the new entry
            $(id).addClass("app-select");
            $("*[ref='" + id + "']").addClass("app-select");
            // scroll to the entry in the apparatus
            $(".lay-txt").animate({
                scrollTop: $(id).offset().top - $(".lay-txt").offset().top
            }, 100);
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
