/**
 * [Convert emoji unicode to html image]
 * @param  {unicode string} emoji [description]
 * @return {string}       [description]
 */
function emojiUnicodeToImage(emoji) {
  if (value = Config.reversemap[emoji]) {
    icon = $.emojiarea.icons[':' + value + ':'];
    return $.emojiarea.createIcon(icon);
  }

  return '';
}

/**
 * [Render emoji unicode as html images from string]
 * @param  {string} input [description]
 * @return {string}       [description]
 */
function emojify(input) {
  if (!input) return '';
  if (!Config.rx_codes) Config.init_unified();

  return input.replace(Config.rx_codes, function(emoji) {
    return emojiUnicodeToImage(emoji);
  });
};
