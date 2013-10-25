$( document ).ready(function() {

    $('.datetime').datetimepicker({dateFormat: 'yy-mm-dd ', timeFormat: 'hh:mm TT ', ampm: true});

    $(".origin_field").geocomplete();
    $.fn.geocomplete($(".origin_field"));

    $(".destination_field").geocomplete();
    $.fn.geocomplete( $(".destination_field"));

    $('.comment_field').wysihtml5({
        "stylesheets": [],
        "font-styles": false,
        "emphasis": true,
        "lists": false,
        "html": false,
        "link": false,
        "image": false,
        "color": false
    });

    initializeTableLinks();

});