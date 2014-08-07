/*!
 * froala_editor v1.1.7 (http://editor.froala.com)
 * Copyright 2014-2014 Froala
 */

$.Editable.prototype.execCommand = $.extend($.Editable.prototype.execCommand, {
  fontFamily: function (cmd, val, param) {
    this.fontExec('font-family', cmd, val);
  }
});

$.Editable.commands = $.extend($.Editable.commands, {
  fontFamily: {
    title: 'Font Family',
    icon: 'fa fa-font'
  }
});

$.Editable.prototype.command_dispatcher = $.extend($.Editable.prototype.command_dispatcher, {
  fontFamily: function (command) {
    var dropdown = this.buildDropdownFontFamily();
    var btn = this.buildDropdownButton(command, dropdown, 'fr-family');
    this.$bttn_wrapper.append(btn);
  }
});

/**
 * Dropdown for font family.
 *
 * @param command
 * @returns {*}
 */
$.Editable.prototype.buildDropdownFontFamily = function() {
  var dropdown = '<ul class="fr-dropdown-menu">';

  // Iterate format block seed.
  for (var j = 0; j < this.options.fontList.length; j++) {
    var cmd = this.options.fontList[j];

    var format_btn = '<li data-cmd="fontFamily" data-val="' + cmd + '">';
    format_btn += '<a href="#" data-text="true" title="' + cmd + '" style="font-family: ' + cmd + ';">' + cmd + '</a></li>';

    dropdown += format_btn;
  }

  dropdown += '</ul>';

  return dropdown;
};