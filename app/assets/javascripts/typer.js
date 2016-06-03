var Typer = Typer || {};

+function() {
  Typer.type = function(e, text, start) {
    if (!start || start < 0) {
      if (e.value.length > 0) {
        return;
      }
      start = 0;
      e.value = '';
    } else if (start >= text.length) {
      return;
    }
    e.value += text[start++];
    window.setTimeout(function() {
      Typer.type(e, text, start);
    }, Math.floor(Math.random() * 100) + (text[start] === '\n' ? 400 : 100));
  };
}();
