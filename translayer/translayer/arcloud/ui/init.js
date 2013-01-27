var map;
var panel;
var currentpt;
var prevpt;
var balloon;
var xyzloc;
function $(id) {
    return document.getElementById(id);
}

function $c(type) {
    return document.createElement(type);
}

function init() {
    initialize();
    panel = $('panel');
    xyzloc = new newLocation();
    panel.appendChild(xyzloc.A_html);
}

function initialize() {
    var mapOptions = {
        center : new google.maps.LatLng(40.446, -98.261),
        zoom : 5,
        mapTypeId : google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
    google.maps.event.addListener(map, 'click', function(event) {
        if (currentpt == prevpt)
            if (balloon)
                balloon.setMap(null);
        prevpt = currentpt;
        balloon = marker(event.latLng);
        setText(event.latLng);

    });
    getLocation();

}

function marker(loc) {
    if (currentpt) {
        var mark = new google.maps.Marker({
            position : loc,
            map : map,
            title : 'Point ' + currentpt,
            cpt : currentpt
        });
        google.maps.event.addListener(mark, 'click', function(event) {
            clearText(mark.cpt);
            mark.setMap(null);
        });
        return mark;
    }
    return false;

}

function clearText(pt) {
    if (balloon) {
        $('ptlat' + pt).value = "";
        $('ptlng' + pt).value = "";
 $('newLocation').A_Location[currentpt-1]={};
    }
}

function setText(loc) {
    if (balloon) {
        $('ptlat' + currentpt).value = loc.lat();
        $('ptlng' + currentpt).value = loc.lng();
        var pt={};
        pt['name']='point'+currentpt;
        pt['loc']=[loc.lng(),loc.lat()];
        $('newLocation').A_Location[currentpt-1]=pt;
    }
}

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(setLocation);
    }
}

function setLocation(position) {
    map.setCenter(new google.maps.LatLng(position.coords.latitude, position.coords.longitude));
    map.setZoom(14);
}

function newLocation() {

    this.A_html = $c('div');
    this.A_html.A_Locationtype = "";
    this.A_html.A_Location ={};
    this.A_html.A_Name='';
    this.A_html.A_Alt='';
    this.A_html.tags={};
    this.A_html.id = 'newLocation';
    var select = createSelect([{
        value : 'Polygon',
        text : 'Quad'
    }, {
        value : 'Point',
        text : 'Point'
    }]);
    select.addEventListener('change', function() {
        $('newLocation').A_Locationtype = this.value;
        if ($('Quad'))
           {
                Remove('Quad');
                Remove('restform');
           }
        if (this.value != 'none')
           {
               $('newLocation').appendChild(Quad(this.value));
               $('newLocation').appendChild(restForm());
           } 
        else {
            initialize();
            currentpt = '';
            prevpt = '';
            balloon = '';
        }
    })
    var lab = $c('label');
    lab.appendChild(document.createTextNode('Select a type of Location'));
    lab.appendChild(select);
    this.A_html.appendChild(lab);
}
function restForm(){
    var div=$c('div');
    div.id='restform';
   div.className='clear' 
    var name=$c('input');
    name.type='text';
    name.placeholder='Location Name';
    name.onchange=function(){$('newLocation').A_Name=this.value};
    div.appendChild(name);
    var alt=$c('input');
    alt.type='text';
    alt.onchange=function(){$('newLocation').A_Alt=this.value};
    alt.placeholder="Alt Name";
    var textarea=$c('textarea');
    textarea.onchange=function(){
        $('newLocation').tags=this.value;
    };
    textarea.placeholder="Enter tags by comma separated";
    div.appendChild(alt);
    var submit=$c('input');
    submit.type='button';
    submit.value="Insert";
    submit.onclick=function(){execute();};
    div.appendChild(textarea);
    div.appendChild($c('br'));
    div.appendChild(submit);
        return div;
}
function execute(){
        var json={};
        json['type']=xyzloc.A_html.A_Locationtype;
        json['location']=xyzloc.A_html.A_Location;
        json['name']=xyzloc.A_html.A_Name;
        json['alt']=xyzloc.A_html.A_Alt;
        json['tags']=xyzloc.A_html.tags.split(',');
        json=JSON.stringify(json);
       
        ajax("data="+json,"../query/Insert.php",function(x){alert(x)});
      
}
function Quad(what) {
    var div = $c('div');
    div.id = 'Quad';
    if (what == 'Polygon')
        j = 4;
    else if (what == 'Point')
        j = 1;

    for (var i = 0; i < j; i++) {
        var lab = $c('label');
        lab.appendChild(document.createTextNode('Point Lat ' + (i + 1)));
        var lab1 = $c('label');
        lab1.appendChild(document.createTextNode('Point Lng ' + (i + 1)));
        var text = $c('input');
        text.type = 'text';
        text.id = 'ptlat' + (i + 1);
        text.readOnly='readonly';
        var text1 = $c('input');
        text1.type = 'text';
        text1.id = 'ptlng' + (i + 1);
        text1.readOnly='readonly';
        lab.appendChild(text);
        lab1.appendChild(text1);
        var opt = $c('input');
        opt.type = 'radio';
        opt.name = 'select';
        opt.value = (i + 1);

        opt.onclick = function() {
            currentpt = this.value;
        };
        var div1 = $c('div');
        div1.className = 'points';
        div1.appendChild(opt);
        div1.appendChild(lab);
        div1.appendChild(lab1);
        div.appendChild(div1);
    }
    return div;

}

function createSelect(arr) {
    var SelectType = $c('select');
    var x = $c('option');
    x.value = "none";
    x.text = "none";
    SelectType.add(x);
    for (x in arr) {
        var opt = $c('option');
        opt.value = arr[x].value;
        opt.text = arr[x].text;
        SelectType.add(opt);
    }
    return SelectType;
}
function ajax(data,url,callback)
{   
var xmlhttp;
if (window.XMLHttpRequest)
  {// code for IE7+, Firefox, Chrome, Opera, Safari
  xmlhttp=new XMLHttpRequest();
  }
else
  {// code for IE6, IE5
  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  }
xmlhttp.onreadystatechange=function()
  {
  if (xmlhttp.readyState==4 && xmlhttp.status==200)
    {
    callback(xmlhttp.responseText);
    }
  }
xmlhttp.open("POST",url,true);
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
xmlhttp.send(data);
}

function Remove(EId) {
    return ( EObj = document.getElementById(EId)) ? EObj.parentNode.removeChild(EObj) : false;
}