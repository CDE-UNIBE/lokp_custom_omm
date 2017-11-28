
$(document).ready(function(){

    var archive = '';
    var potw = '';
    $.getJSON("custom/js/potw.json", function(json) {
        text = JSON.stringify(json);
        var obj = JSON.parse(text);
        $("#bottom-tab1").html(getPotwHtml(obj));

        var archiveHtml = '<ul class="collapsible" data-collapsible="accordion">';
        for (var i=0; i < obj.archived.length; i++) {
            archiveHtml += getPotwArchive(obj.archived[i], i === 0);
        }
        archiveHtml += '</ul>';
        $("#bottom-tab2").html(archiveHtml);
    });

    setTimeout(function(){
        $('.tooltipped').tooltip({delay: 50});
        $('.collapsible').collapsible();
    }, 100);


});

function getPotwHtml(entry) {
    var subtitle = '';
    if (entry.subtitle) {
        subtitle = '<p class="potw-subtitle">' + entry.subtitle + '</p>';
    }
    var description = '';
    if (entry.description) {
        description = '<a href="#" class="tooltipped potw-description" data-position="top" data-delay="50" data-tooltip="' + entry.description + '"><i class="material-icons">info</i></a>';
    }
    var html = [
        '<div class="potw-text">',
            '<p class="potw-title">' + entry.title + '</p>',
            subtitle,
            '<span class="potw-date">' + entry.date + '</span>',
            description,
        '</div>',
        '<a href="#" onclick="setMapPosition(' + entry.latitude + ',' + entry.longitude + ',' + entry.zoomlevel + ',\'' + entry.contextlayer + '\');"><img src="' + entry.picurl + '" id="img-weekpicture"></a>'
    ];
    return html.join('');
}

function getPotwArchive(entry, active) {
    var activeCss = active === true ? ' active' : '';
    var descHelptext = '';
    if (entry.description) {
        descHelptext = '<a href="#" class="tooltipped potw-description" data-position="top" data-delay="50" data-tooltip="' + entry.description + '"><i class="material-icons">info</i></a>';
    }
    var descriptionContent = '';
    if (entry.subtitle) {
        descriptionContent = '<p class="potw-subtitle">' + entry.subtitle + descHelptext + '</p>';
    }
    var html = [
        '<li>',
            '<div class="collapsible-header grey lighten-4' + activeCss + '">',
                entry.title,
                '<span class="potw-date">  -  ' + entry.date + '</span>',
            '</div>',
            '<div class="collapsible-body">',
                '<div class="row">',
                    '<div class="col s4">',
                        '<a href="#" onclick="setMapPosition(' + entry.latitude + ',' + entry.longitude + ',' + entry.zoomlevel + ',\'' + entry.contextlayer + '\');">',
                            '<img class="potw-image" src="' + entry.picurl + '">',
                        '</a>',
                    '</div>',
                    '<div class="col s8 potw-description">',
                        descriptionContent,
                    '</div>',
                '</div>',
            '</div>',
        '</li>'
    ];
    return html.join('');
}

function setMapPosition(lat, lon, zoom, contextlayer) {
    var fromProjection = new OpenLayers.Projection("EPSG:4326");   // Transform from WGS 1984
    var toProjection = new OpenLayers.Projection("EPSG:900913");
    var position = new OpenLayers.LonLat(lon, lat).transform(fromProjection, toProjection);
    map.setCenter(position, zoom);
    if (contextlayer) {
        var input = $('input[value="' + contextlayer + '"]');
        if (!input.is(':checked')) {
            input.click();
        }
    }
}
