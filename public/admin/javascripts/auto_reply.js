(function($) {
    var newsTmpl = $([
        '<fieldset class="form-group">',
        '  <div class="col-sm-2 controls">',
        '    <label for="auto_reply_title" class="control-label">回复消息标题: </label>',
        '  </div>',
        '  <div class="col-sm-10 controls">',
        '    <input name="auto_reply[title]" id="auto_reply_title" class="form-control input-large input-with-feedback" type="text">',
        '  </div>',
        '</fieldset>',
        '<fieldset class="form-group">',
        '  <div class="col-sm-2 controls">',
        '    <label for="auto_reply_pic_url" class="control-label">回复图片: </label>',
        '  </div>',
        '  <div class="col-sm-6 controls">',
        '    <input name="auto_reply[pic_url]" id="auto_reply_pic_url" class="form-control input-large input-with-feedback" type="text">',
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
        '    <label for="auto_reply_url" class="control-label">回复链接: </label>',
        '  </div>',
        '  <div class="col-sm-10 controls">',
        '    <input name="auto_reply[url]" id="auto_reply_url" class="form-control input-large input-with-feedback" type="text">',
        '  </div>',
        '</fieldset>',
        '<fieldset class="form-group">',
        '  <div class="col-sm-2 controls">',
        '    <label for="auto_reply_description" class="control-label">回复消息正文: </label>',
        '  </div>',
        '  <div class="col-sm-10 controls">',
        '    <textarea name="auto_reply[description]" id="auto_reply_description" class="form-control input-large input-with-feedback"></textarea>',
        '  </div>',
        '</fieldset>'
    ].join('\n'));

    $progress = $('#progress', newsTmpl);

    $('#upload', newsTmpl).fileupload({
        dataType: 'json',
        paramName: 'file',
        type: 'PUT',
        url: '/admin/images/upload?path=absolute',
        done: function(e, data) {
            var result = data.result,
                link = result.link;
            $('input[name="auto_reply[pic_url]"]', newsTmpl).val(link);
        },
        progressall: function(e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $progress.html(progress + "%");
            if (progress === 100) {
                $progress.html('');
            }
        }
    });


    var textTmpl = $([
        '<fieldset class="form-group">',
        '  <div class="col-sm-2 controls">',
        '    <label for="auto_reply_description" class="control-label">回复消息正文: </label>',
        '  </div>',
        '  <div class="col-sm-10 controls">',
        '    <textarea name="auto_reply[description]" id="auto_reply_description" class="form-control input-large input-with-feedback"></textarea>',
        '  </div>',
        '</fieldset>'
    ].join('\n'));

    var TEMPLATES = {
        news: newsTmpl,
        text: textTmpl
    };

    function render(rtype) {
        var html = TEMPLATES[rtype];
        return $('#reply_editor').html(html);
        
    }

    $.fn.auto_reply = function(obj) {
        var $rtype = $('select[name="auto_reply[rtype]"]');

        $rtype.on('change', function() {
            render($(this).val());
        });

        var html = render($rtype.val());

        // form data initialize
        $('input[name="auto_reply[title]"]', html).val(obj.title);
        $('input[name="auto_reply[pic_url]"]', html).val(obj.pic_url);
        $('input[name="auto_reply[url]"]', html).val(obj.url);
        $('textarea[name="auto_reply[description]"]', html).val(obj.description).emojiarea({
            buttonLabel : '插入表情'
        });

        $('.emoji-wysiwyg-editor', html).addClass('form-control input-large input-with-feedback');
    };
})(jQuery)