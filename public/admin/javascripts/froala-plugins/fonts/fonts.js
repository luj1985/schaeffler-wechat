/*!
 * froala_editor v1.1.7 (http://editor.froala.com)
 * Copyright 2014-2014 Froala
 */

/**
 * Set font size or family.
 *
 * @param val
 */
$.Editable.prototype.fontExec = function (prop, cmd, val) {
  document.execCommand('fontSize', false, 1);

  this.saveSelectionByMarkers();

  // Remove all fonts with size=3.
  var main_fonts = [];
  this.$element.find('font').each(function(index, elem) {
    var $span = $('<span>').attr('data-font', prop).css(prop, val).html($(elem).html());
    if ($(elem).parents('font').length === 0) {
      main_fonts.push($span);
    }
    $(elem).replaceWith($span);
  });

  var setFontSize = function(i, elem) {
    $(elem).css(prop, '');
  };

  // Set font-property for the fonts.
  for (var i = 0; i < main_fonts.length; i++) {
    var font = main_fonts[i];
    $(font).find('*').each(setFontSize);
  }

  this.$element.find('span[data-font="' + prop + '"] > span[data-font="' + prop + '"]').each(function(index, elem) {
    if ($(elem).attr('style')) {
      $(elem).before('<span class="close-span"></span>');
      $(elem).after('<span data-font="' + prop + '" style="' + prop + ': ' + $(elem).parent().css(prop) + ';" data-open="true"></span>');
    }
  });

  var oldHTML = this.$element.html();
  oldHTML = oldHTML.replace(new RegExp('<span class="close-span"></span>', 'g'), '</span>');
  oldHTML = oldHTML.replace(new RegExp('data-open="true"></span>', 'g'), '>');

  this.$element.html(oldHTML);

  this.beautifyFont(prop);

  // Remove no style spans.
  this.$element.find('span[style=""]').each(function(index, elem) {
    $(elem).replaceWith($(elem).html());
  });

  // Check span with parent.
  this.$element.find('span[data-font="' + prop + '"]').each(function(index, elem) {
    if ($(elem).css(prop) == $(elem).parent().css(prop)) {
      $(elem).replaceWith($(elem).html());
    }
  });

  this.$element.find('span[data-font="' + prop + '"]').each(function (index, elem) {
    if ($(elem).text() === '') {
      $(elem).replaceWith($(elem).html());
    }
  })

  this.beautifyFont(prop);

  this.restoreSelectionByMarkers();
  this.repositionEditor();

  // (val)
  this.callback(cmd, [val]);
}

$.Editable.prototype.beautifyFont = function (prop) {
  // Join spans.
  var found = true;
  var cleanFont = $.proxy(function() {
    this.$element.find('span[data-font="' + prop + '"] + span[data-font="' + prop + '"]').each(function(index, elem) {
      if ($(elem).css(prop) == $(elem).prev().css(prop) && elem.previousSibling && elem.previousSibling.tagName == 'SPAN') {
        $(elem).prepend($(elem).prev().html());
        $(elem).prev().remove();
        found = true;
      }
    });

    this.$element.find(
      'span[data-font="' + prop + '"] + span.f-marker[data-type="true"] + span[data-font="' + prop + '"], ' +
      'span[data-font="' + prop + '"] + span.f-marker[data-type="false"] + span[data-font="' + prop + '"]'
    ).each(function(index, elem) {
      if ($(elem).css(prop) == $(elem).prev().prev().css(prop) && elem.previousSibling && elem.previousSibling.tagName == 'SPAN' && elem.previousSibling.previousSibling && elem.previousSibling.previousSibling.tagName == 'SPAN') {
        $(elem).prepend($(elem).prev().clone());
        $(elem).prepend($(elem).prev().prev().html());
        $(elem).prev().prev().remove();
        $(elem).prev().remove();
        found = true;
      }
    });
  }, this);

  while (found) {
    found = false;

    cleanFont();
  }
}
