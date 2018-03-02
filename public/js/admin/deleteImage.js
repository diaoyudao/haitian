var deleteImage1 = function() {
        var $list = $('#fileList');
        $list.empty();
        $("input[name=thumbnail_url1]").val('');
        $("input[name=image_url1]").val('');
        return false;
    }

    var deleteImage2 = function() {
        var $list = $('#fileList2');
        $list.empty();
        $("input[name=thumbnail_url2]").val('');
        $("input[name=image_url2]").val('');
        return false;
    }