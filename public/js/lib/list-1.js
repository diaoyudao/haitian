var PAGER={
create:function(total,param,vid, jump_func){
vid = vid || 'pager';
param = param||""; 
var pg_name = (('pager' == vid)?'pg': (vid+'_pg'));
 var page=laypage({
    cont:vid,pages:total,
    curr:function(){
        var page=getUrlParamValue(pg_name); 
        return page?page:1
    }(),
    jump:jump_func || function(e,first){
    if(!first){location.href="?"+pg_name+"="+e.curr+param}}
}); 
return page
}
}; 


function getUrlParamValue(name)
{
    if(!name || '' == name) {
        console.log('name -s null');
        return null;
    }
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r!=null) {
        console.log(name, r[2],unescape(r[2]));
        return  unescape(r[2]);         
    }
    return null;
}