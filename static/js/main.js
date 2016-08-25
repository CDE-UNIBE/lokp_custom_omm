$(".read-more").click(function(event) {
    // Get the parent node
    var rowfluid = $(this).parents(".row-fluid");
    var next = rowfluid.nextUntil(":not(.blog-content)");
    if (next.hasClass("hidden")) {
        next.removeClass("hidden");
    } else {
        next.addClass("hidden");
    }

    // Toggle the read more icon
    var child = $(this).children("i");
    if (child.hasClass("icon-double-angle-right")) {
        child.removeClass("icon-double-angle-right");
        child.addClass("icon-double-angle-left");
    } else {
        child.removeClass("icon-double-angle-left");
        child.addClass("icon-double-angle-right");
    }
});

$(document).ready(function(){
    $('.slider').slider({full_width: true});
    $('.modal-trigger').leanModal();
});