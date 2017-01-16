
$(document).ready(function(){

    var archive = '';
    var potw = '';
    $.getJSON("custom/js/potw.json", function(json) {
        text = JSON.stringify(json);
        var obj = JSON.parse(text);
        potw = potw +
            '<p style="margin-top: 20px; margin-bottom: 10px; font-weight: bold;">' + obj.title +
            '<span style="font-size: 12px; color: grey; font-weight: normal;">  -  ' + obj.date + '</span>';
        if (obj.description != '' && obj.description != undefined ) {
            potw = potw + '<a style="margin: 0px; padding: 0px;" href="#" class="tooltipped" data-position="top" data-delay="50" data-tooltip="' + obj.description + '">' +
                '<i class="material-icons" style="margin: 0px; padding: 0px; font-size: 14px; margin-left: 10px;">info</i></a></p>'
        }

        potw = potw + '<a href="' + obj.dealurl + '">' +
                '<img src="' + obj.picurl + '" id="img-weekpicture">';
        $("#bottom-tab1").html(potw);


        archive = archive +
            '<ul class="collapsible" data-collapsible="accordion">' +
                '<li>' +
                    '<div class="collapsible-header grey lighten-4 active">' + obj.title +
                        '<span style="font-size: 12px; color: grey; font-weight: normal;">  -  ' + obj.date + '</span>' +
                    '</div>' +
                    '<div class="collapsible-body" style="margin: 0px;">' +
                        '<div class="row">' +
                            '<div class="col s4">' +
                                '<img style="margin-top: 10px; margin-bottom: 10px; width: 100%;" src="' + obj.picurl + '">' +
                            '</div>';
        if (obj.description != undefined ) {
            archive = archive + '<div class="col s8" style="margin-top: 10px;">' + obj.description + '</div>';
        }
        archive = archive +
                        '</div>' +
                    '</div>' +
                '</li>';
        for (i=0; i < obj.archived.length; i++) {
            archive = archive +
                '<li>' +
                    '<div class="collapsible-header grey lighten-4 active">' + obj.archived[i].title +
                        '<span style="font-size: 12px; color: grey; font-weight: normal;">  -  ' + obj.archived[i].date + '</span>' +
                    '</div>' +
                    '<div class="collapsible-body" style="margin: 0px;">' +
                        '<div class="row">' +
                            '<div class="col s4">' +
                                '<img style="margin-top: 10px; margin-bottom: 10px; width: 100%;" src="' + obj.archived[i].picurl + '">' +
                            '</div>';
            if (obj.description =! undefined) {
              archive = archive + '<div class="col s8" style="margin-top: 10px;">' + obj.archived[i].description + '</div>';
            }
            archive = archive +
                        '</div>' +
                    '</div>' +
                '</li>';
        }
        archive = archive + '</ul>';
        $("#bottom-tab2").html(archive);
    });
    setTimeout(function(){
        $('.tooltipped').tooltip({delay: 50});
        $('.collapsible').collapsible();
    }, 100)
});