
$(document).ready () =>
    window.game = new Game()
    $("#start").click window.game.startClock
    #Bind click handler
    $("#square").click sqClick
