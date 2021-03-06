// Generated by CoffeeScript 1.3.3
(function() {
  var LOSS_VAL, WIN_VAL;

  WIN_VAL = 10;

  LOSS_VAL = -10;

  this.sqClick = function(event) {
    switch (event.which) {
      case 1:
        return sqLeftClick(event.target);
      case 3:
        return sqRightClick(event.target);
      default:
        return true;
    }
  };

  this.sqLeftClick = function(target) {
    var val, vals, _i, _len;
    vals = new Array();
    window.game.field.clickSquare($(target).attr("id"), vals, !window.game.inProgress);
    window.game.startClock();
    for (_i = 0, _len = vals.length; _i < _len; _i++) {
      val = vals[_i];
      switch (val.result) {
        case "boom":
          updateBoard(target, "mine", "lose");
          break;
        case "money":
          updateBoard(target, val.newClass, "win");
      }
    }
    return true;
  };

  this.sqRightClick = function(target) {
    var val;
    val = window.game.field.markSquare($(target).attr("id"));
    updateBoard(target, val.newClass, "mark");
    return true;
  };

  this.updateBoard = function(target, newClass, status) {
    if (!$(target).hasClass(newClass)) {
      $(target).removeClass();
      $(target).addClass("square");
      $(target).addClass(newClass);
    }
    switch (status) {
      case "win":
        window.game.updateScore(WIN_VAL);
        break;
      case "lose":
        window.game.updateScore(LOSS_VAL);
    }
    return true;
  };

}).call(this);
