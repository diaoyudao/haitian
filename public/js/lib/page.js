/**
 * Created by Administrator on 2016/11/23.
 */

function showPageCommon(config) {
    return function (page, total) {
        var str = '<li class="active" id=#'+page+'>' + page + '</li>';

        for (var i = 1; i <= 2; i++) {
            if (page - i > 1) {
                str = '<li>' + (page - i) + '</li> ' + str;
            }
            if (page + i < total) {
                str = str + ' ' + '<li>' + (page + i) + '</li>';
            }
        }

        if (page - 3 > 1) {
            str = '... ' + str;
        }

        if (page > 1) {
            str = '<li>1</li>' + ' ' + str;
        }

        if (page + 3 < total) {
            str = str + ' ...';
        }

        if (page < total) {
            str = str + ' ' + '<li>' + total + '</li>';
        }

        return str;
    }
}

var showPages = showPageCommon({
//        color: 'blue'
});