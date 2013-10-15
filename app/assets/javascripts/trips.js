$( document ).ready(function() {

    $(".origin_field").geocomplete();
    $.fn.geocomplete($(".origin_field"));

    $(".destination_field").geocomplete();
    $.fn.geocomplete( $(".destination_field"));
});