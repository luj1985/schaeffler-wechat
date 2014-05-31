$(function() {
    var json = {
        "menu": {
            "button": [{
                "name": "促销活动",
                "sub_button": [{
                    "type": "view",
                    "name": "活动介绍",
                    "url": "http:\/\/schaeffler.ihavekey.com\/activity\/intro",
                    "sub_button": []
                }, {
                    "type": "click",
                    "name": "活动兑奖",
                    "key": "activity",
                    "sub_button": []
                }]
            }, {
                "type": "click",
                "name": "测试入口1",
                "key": "activity",
                "sub_button": []
            }, {
                "type": "click",
                "name": "测试入口2",
                "key": "activity",
                "sub_button": []
            }]
        }
    };
    $.getJSON('/admin/wmenus/wechat.json', function(response) {
        var menu = response.menu;
        var $toolbar = $('<ul class="wechat-toolbar">');
        $.each(menu.button, function() {
            var $button = $('<li class="button">'),
                $link = $('<a href="#">' + this.name + '</a>');

            var sub_buttons = this.sub_button || [];
            if (sub_buttons.length > 1) {
                $button.addClass("dropup")
                $link.addClass("dropdown-toggle").attr('data-toggle', 'dropdown');

                var sub_menus = $('<ul class="dropdown-menu">');
                $.each(sub_buttons, function() {
                    sub_menus.append('<li>' + this.name + '</li>')
                });
                $button.append(sub_menus);
            }
            $button.append($link);
            $toolbar.append($button);
        });
        $('.iphone-display').html($toolbar);
        $('.menu_contents').html(JSON.stringify(menu, null, ' '));
    });

});