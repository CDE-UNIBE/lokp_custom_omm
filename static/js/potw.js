
$(document).ready(function(){

    potw = {
        "picurl":"/custom/img/potw/pictureoftheweek.jpeg",
        "dealurl":"http://dev.mmlandreporting.info/activities/html/4a29982a-23a3-4c3b-ab1c-b606d1349d72",
        "text":"Headline"
    };


    $("#bottom-tab1").html(
        '<p style="margin-top: 20px; margin-bottom: 10px; font-weight: bold;">' + potw.text + '</p>' +
        '<a href="' + potw.dealurl + '">' +
            '<img src="' + potw.picurl + '" id="img-weekpicture">' +
        '</a>'
    );
});