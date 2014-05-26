$(function() {
    $('.articles_list').on('click', '.delete_article', function(e) {
        e.preventDefault();
        var article = $(this).closest('li.list-group-item');
        var id = article.data('article-id');
        var title = article.data('article-title');
        var $selected = $('.articles_selection');
        var html = '';
        html += '<option value="' + id + '">';
        html += title;
        html += '</option>';
        $selected.append(html);
        article.remove();
    });

    $('.add_article').on('click', function(e) {
        e.preventDefault();
        var $selected = $('.articles_selection option:selected');
        var text = $selected.text();
        var id = $('.articles_selection').val();
        if (id) {
            var html = '';
            html += '<li class="list-group-item" data-article-id="' + id + '" data-article-title="' + text + '">';
            html += '<input type="hidden" name="menu[selected_articles][]" value="' + id + '">';
            html += '<a href="/admin/articles/edit/' + id + '">';
            html += '<i class="icon-edit"></i>';
            html += text;
            html += '</a>';
            html += '<a href="#" class="delete_article pull-right">';
            html += '<i class="icon-trash"></i>';
            html += '</a>';
            html += '</li>';
            $('.articles_list').append(html);
            $selected.remove();
        }
    });
});