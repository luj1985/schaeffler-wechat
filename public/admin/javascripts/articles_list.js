$(function() {
    $('.articles-list').on('click', '.delete-article', function(e) {
        e.preventDefault();
        var article = $(this).closest('li.list-group-item'),
            id = article.data('article-id'),
            title = article.data('article-title');

        var $selected = $('.articles-selection');
        var html = '';
        html += '<option value="' + id + '">';
        html += title;
        html += '</option>';
        $selected.append(html);
        article.remove();
    });

    $('.add-article').on('click', function(e) {
        e.preventDefault();
        var $selected = $('.articles-selection option:selected');
        var text = $selected.text();
        var id = $('.articles-selection').val();
        if (id) {
            var html = '';
            html += '<li class="list-group-item" data-article-id="' + id + '" data-article-title="' + text + '">';
            html += '<input type="hidden" name="menu[selected_articles][]" value="' + id + '">';
            html += '<a href="/admin/articles/edit/' + id + '">';
            html += '<i class="icon-edit"></i>';
            html += text;
            html += '</a>';
            html += '<a href="#" class="delete-article pull-right">';
            html += '<i class="icon-trash"></i>';
            html += '</a>';
            html += '</li>';
            $('.articles-list').append(html);
            $selected.remove();
        }
    });

    $('.pages-list').on('click', '.delete-page', function(e) {
        e.preventDefault();
        var page = $(this).closest('li.list-group-item'),
            id = page.data('page-id'),
            title = page.data('page-title');

        var $selected = $('.pages-selection');
        var html = '';
        html += '<option value="' + id + '">';
        html += title;
        html += '</option>';
        $selected.append(html);
        page.remove();
    });


    $('.add-page').on('click', function(e) {
        e.preventDefault();
        var $selected = $('.pages-selection option:selected');
        var text = $selected.text();
        var id = $('.pages-selection').val();
        if (id) {
            var html = '';
            html += '<li class="list-group-item" data-page-id="' + id + '" data-page-title="' + text + '">';
            html += '<input type="hidden" name="menu[selected_pages][]" value="' + id + '">';
            html += text;
            html += '<a href="#" class="delete-page pull-right">';
            html += '<i class="icon-trash"></i>';
            html += '</a>';
            html += '</li>';
            $('.pages-list').append(html);
            $selected.remove();
        }
    });

});