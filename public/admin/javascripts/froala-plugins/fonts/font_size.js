/*!
 * froala_editor v1.1.7 (http://editor.froala.com)
 * Copyright 2014-2014 Froala
 */

$.Editable.prototype.execCommand = $.extend($.Editable.prototype.execCommand, {
  fontSize: function (cmd, val, param) {
    this.fontExec('font-size', cmd, val);
  }
});

$.Editable.commands = $.extend($.Editable.commands, {
  fontSize: {
    title: 'Font Size',
    icon: 'fa fa-text-height',
    seed: [{
      min: 11,
      max: 52
    }]
  }
});

$.Editable.prototype.command_dispatcher = $.extend($.Editable.prototype.command_dispatcher, {
  fontSize: function (command) {
    var dropdown = this.buildDropdownFontsize(command);
    var btn = this.buildDropdownButton(command, dropdown);
    this.$bttn_wrapper.append(btn);
  }
});

/**
 * Dropdown for fontSize.
 *
 * @param command
 * @returns {*}
 */
$.Editable.prototype.buildDropdownFontsize = function(command) {
  var dropdown = '<ul class="fr-dropdown-menu f-font-sizes">';

  // Iterate color seed.
  for (var j = 0; j < command.seed.length; j++) {
    var font = command.seed[j];

    for (var k = font.min; k <= font.max; k++) {
      dropdown += '<li data-cmd="' + command.cmd + '" data-val="' + k + 'px"><a href="#"><span>' + k + 'px</span></a></li>';
    }
  }

  dropdown += '</ul>';

  return dropdown;
};