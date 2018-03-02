	function IMAGE(a, e, i, r, n, t, s) {
	    var p;
	    var a = a || "fileList";
	    var e = e || "#filePicker";
	    var i = i || 100;
	    var r = r || 100;
	    var n = n || true;
	    var s = s || n ? "/service/upload/image/upload" + "?thb=1&w=" + i + "&h=" + r : "/service/upload/image/upload";
	    var d = $('#' + a);
	    var o = $("#btn-star");
	    var f_err = function(tp) {
	        if (tp == "F_EXCEED_SIZE") {
	            layer.msg('图片不能大于2M！', {
	                icon: 2,
	                time: 1000
	            });
	        }
	    };
	    var l = l || function(e) {
	        var n = $('<div id="' + e.id + a + '" class="file-item thumbnail">' + "<img>" + '<div class="info">' + e.name + "</div>" + "</div>"),
	            t = n.find("img");
	        d.empty();
	        d.append(n);
	        p.makeThumb(e, function(a, e) {
	            if (a) {
	                t.replaceWith("<span>不能预览</span>");
	                return
	            }
	            t.attr("src", e)
	        }, i, r)
	    };
	    var u = function(e, i) {
	        var r = $("#" + e.id + a),
	            n = r.find(".progress span");
	        if (!n.length) {
	            n = $('<p class="progress"  style="height:30px;line-height:30px;width:100px;"><span style="color:#000;font-size:20px;"></span></p>').appendTo(r).find("span");
	        }
	        var temp = (i * 100).toFixed(2) + "%";
	        n.text(temp);
	    };
	    var t = t || function(e, i) {
	        $("input[name=thumbnail_url]").val(i.thumbnail_url);
	        $("input[name=image_url]").val(i.image_url);
	        $("#" + e.id + a).addClass("upload-state-done")
	    };
	    var v = function(e) {
	        var i = $("#" + e.id + a),
	            r = i.find("div.error");
	        if (!r.length) {
	            r = $('<div class="error"></div>').appendTo(i)
	        }
	        r.text("上传失败")
	    };
	    var c = function(e) {
	        $("#" + e.id + a).find(".progress").remove();
	        $("#filePicker").attr("display", "none")
	    };
	    this.init = function() {
	        p = WebUploader.create({
	            swf: '/public/huiadmin/lib/webuploader/0.1.5/Uploader.swf',
	            auto: true,
	            compress: false,
	            fileSingleSizeLimit: 2 * 1024 * 1024,
	            server: s,
	            pick: e,
	            resize: false,
	            accept: {
	                title: "Images",
	                extensions: "gif,jpg,jpeg,bmp,png",
	                mimeTypes: "image/gif,image/jpg,image/jpeg,image/png"
	            }
	        });
	        p.on("error", f_err);
	        p.on("fileQueued", l);
	        p.on("uploadProgress", u);
	        p.on("uploadSuccess", t);
	        p.on("uploadError", v);
	        p.on("uploadComplete", c)
	    };
	    return this
	}