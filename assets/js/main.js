$(document).ready(() => {
    termLink();
    appLink();
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
/* when you hover one of them the other is highlighted */
let appLink = () => {
    // click the term
    $(".app-click").on("click", function() {
        if (this.hasAttribute("id")) {
            var id = $(this).attr("id");
            $(this).toggleClass("app-select");
            $("*[ref='#" + id + "']").toggleClass("app-select");
        } else {
            var ref = $(this).attr("ref");
            $(this).toggleClass("app-select");
            $(ref).toggleClass("app-select");
        };
    });
};
