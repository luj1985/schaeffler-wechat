(function($) {
    var TMPLS = {
        news: [
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_title" id="auto_reply_title" class="control-label">回复消息标题: </label>',
            '  </div>',
            '  <div class="col-sm-10 controls">',
            '    <input name="auto_reply[title]" id="auto_reply_title" class="form-control input-large input-with-feedback" type="text">',
            '  </div>',
            '</fieldset>',
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_pic_url" id="auto_reply_pic_url" class="control-label">回复图片: </label>',
            '  </div>',
            '  <div class="col-sm-4 controls">',
            '    <input name="auto_reply[pic_url]" id="auto_reply_pic_url" class="form-control input-large input-with-feedback" type="text" disabled>',
            '  </div>',
            '  <div class="col-sm-4 controls">',
            '    <div class="btn btn-success fileinput-button">',
            '      <i class="glyphicon glyphicon-plus"></i>',
            '      <span>图片上传</span>',
            '      <input type="file" id="upload" class="form-control"/>',
            '    </div>',
            '    <span id="progress"></span>',
            '  </div>',
            '</fieldset>',
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_url" id="auto_reply_url" class="control-label">回复链接: </label>',
            '  </div>',
            '  <div class="col-sm-10 controls">',
            '    <input name="auto_reply[url]" id="auto_reply_url" class="form-control input-large input-with-feedback" type="text">',
            '  </div>',
            '</fieldset>',
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_description" id="auto_reply_description" class="control-label">回复消息正文: </label>',
            '  </div>',
            '  <div class="col-sm-10 controls">',
            '    <textarea name="auto_reply[description]" rows="" cols="" id="auto_reply_description" class="form-control input-large input-with-feedback"></textarea>',
            '  </div>',
            '</fieldset>'
        ].join('\n'),
        text: [
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_description" id="auto_reply_description" class="control-label">回复消息正文: </label>',
            '  </div>',
            '  <div class="col-sm-10 controls">',
            '    <textarea name="auto_reply[description]" rows="" cols="" id="auto_reply_description" class="form-control input-large input-with-feedback"></textarea>',
            '  </div>',
            '</fieldset>'
        ].join('\n')
    };


    function render(rtype, obj) {
        $('#reply_editor').html(TMPLS[rtype]);

        $('input[name="auto_reply[title]"]').val(obj.title);
        $('input[name="auto_reply[pic_url]"]').val(obj.pic_url);
        $('input[name="auto_reply[url]"]').val(obj.url);
        $('textarea[name="auto_reply[description]"]').val(obj.description);

        $progress = $('#progress');

        $('#upload').fileupload({
            dataType: 'json',
            paramName: 'file',
            type: 'POST',
            url: '/admin/images/upload',
            done: function(e, data) {
                var result = data.result,
                    link = result.link;
                $('input[name="auto_reply[pic_url]"]').val(link);
            },
            progressall: function(e, data) {
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $progress.html(progress + "%");
                if (progress === 100) {
                    $progress.html('');
                }
            }
        });
    }

    $.fn.auto_reply = function(obj) {
        var rtype = $('select[name="auto_reply[rtype]"]').val();

        render(rtype, obj);

        $('select[name="auto_reply[rtype]"]').on('change', function() {
            var rtype = $(this).val();

            obj.title = $('input[name="auto_reply[title]"]').val();
            obj.pic_url = $('input[name="auto_reply[pic_url]"]').val();
            obj.url = $('input[name="auto_reply[url]"]').val();
            obj.description = $('textarea[name="auto_reply[description]"]').val();

            render(rtype, obj);
        });
    };
})(jQuery)