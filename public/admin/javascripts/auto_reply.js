(function($) {
    var TMPLS = {
        news: [
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_title" value="" id="auto_reply_title" class="control-label">回复消息标题: </label>',
            '  </div>',
            '  <div class="col-sm-10 controls">',
            '    <input name="auto_reply[title]" value="" id="auto_reply_title" class="form-control input-large input-with-feedback" type="text">',
            '    <span class="help-inline"></span>',
            '  </div>',
            '</fieldset>',
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_pic_url" value="" id="auto_reply_pic_url" class="control-label">回复图片: </label>',
            '  </div>',
            '  <div class="col-sm-10 controls">',
            '    <input name="auto_reply[pic_url]" value="" id="auto_reply_pic_url" class="form-control input-large input-with-feedback" type="url">',
            '    <span class="help-inline"></span>',
            '  </div>',
            '</fieldset>',
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_url" value="" id="auto_reply_url" class="control-label">回复链接: </label>',
            '  </div>',
            '  <div class="col-sm-10 controls">',
            '    <input name="auto_reply[url]" value="" id="auto_reply_url" class="form-control input-large input-with-feedback" type="url">',
            '    <span class="help-inline"></span>',
            '  </div>',
            '</fieldset>',
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_description" value="" id="auto_reply_description" class="control-label">回复消息正文: </label>',
            '  </div>',
            '  <div class="col-sm-10 controls">',
            '    <textarea name="auto_reply[description]" rows="" cols="" id="auto_reply_description" class="form-control input-large input-with-feedback"></textarea>',
            '    <span class="help-inline"></span>',
            '  </div>',
            '</fieldset>'
        ].join('\n'),
        text: [
            '<fieldset class="form-group">',
            '  <div class="col-sm-2 controls">',
            '    <label for="auto_reply_description" value="" id="auto_reply_description" class="control-label">回复消息正文: </label>',
            '  </div>',
            '  <div class="col-sm-10 controls">',
            '    <textarea name="auto_reply[description]" rows="" cols="" id="auto_reply_description" class="form-control input-large input-with-feedback"></textarea>',
            '    <span class="help-inline"></span>',
            '  </div>',
            '</fieldset>'
        ].join('\n')
    };
    $.fn.auto_reply = function() {
        var rtype = $('select[name="auto_reply[rtype]"]').val();
        $('#reply_editor').html(TMPLS[rtype]);
    }
})(jQuery)