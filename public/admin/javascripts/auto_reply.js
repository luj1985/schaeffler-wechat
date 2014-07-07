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
            '  <div class="col-sm-10 controls">',
            '    <input name="auto_reply[pic_url]" id="auto_reply_pic_url" class="form-control input-large input-with-feedback" type="url">', '  </div>',
            '</fieldset>',
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_url" id="auto_reply_url" class="control-label">回复链接: </label>',
            '  </div>',
            '  <div class="col-sm-10 controls">',
            '    <input name="auto_reply[url]" id="auto_reply_url" class="form-control input-large input-with-feedback" type="url">',
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

    $.fn.init_reply = function(obj) {
        var rtype = $('select[name="auto_reply[rtype]"]').val();

        $('#reply_editor').html(TMPLS[rtype]);

        $('input[name="auto_reply[title]"]').val(obj.title);
        $('input[name="auto_reply[pic_url]"]').val(obj.pic_url);
        $('input[name="auto_reply[url]"]').val(obj.url);
        $('textarea[name="auto_reply[description]"]').val(obj.description);
    };

    $.fn.auto_reply = function() {
        var rtype = $('select[name="auto_reply[rtype]"]').val();

        var title = $('input[name="auto_reply[title]"]').val(),
            pic = $('input[name="auto_reply[pic_url]"]').val(),
            url = $('input[name="auto_reply[url]"]').val(),
            description = $('textarea[name="auto_reply[description]"]').val();

        $('#reply_editor').html(TMPLS[rtype]);

        $('input[name="auto_reply[title]"]').val(title);
        $('input[name="auto_reply[pic_url]"]').val(pic);
        $('input[name="auto_reply[url]"]').val(url);
        $('textarea[name="auto_reply[description]"]').val(description);
    };
})(jQuery)