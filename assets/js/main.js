$(document).ready(() => {
    //selectedEntry();
    termLink();
});

/*let selectedEntry = () => {
    $(".entry").on("click", function() {
        var entry = $(this);
        if ($(".popover[id='" + $(entry).attr("aria-describedby") + "']").hasClass("show")) {
            $(entry).addClass("entry-selected");
        } else {
            $(entry).removeClass("entry-selected");
        };
    });
};*/

/* TERMS - link between the term in the text and in the commentary */
/* when you hover one of them the other is highlighted */
let termLink = () => {
    $("*[data-type='term']").each(function() {
        var term = $(this);
        $("*[data-type='l']").find(term).append('<i class="fa-solid fa-caret-right term-icon"></i>');
        // click the term
        $(term).on("click", function() {
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
    });
};
