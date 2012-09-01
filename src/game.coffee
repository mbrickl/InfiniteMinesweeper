#Game time in seconds
MAX_TIME=30
SQ_WIDTH=10
SQ_HEIGHT=10

class @Game
    constructor: ->
        @field = new Field
        @score = 0
        @inProgress = false
        @time = MAX_TIME
        @board = jQuery.infinitedrag("#board",{},{
            width: SQ_WIDTH,
            height: SQ_HEIGHT,
            start_col: 0,
            start_row: 0
            oncreate: ($element, col, row) =>
                if not window.game.field.array[$element.attr("id")]?
                    $element.attr("id",Field.coordinatesToIndex(col,row))
                    $element.addClass("untouched")
                else
                    $element.addClass(window.game.field.array[$element.attr("id")])
                $element.addClass("square")
                $element.click sqClick
        });
                

    updateScore: (increment) ->
        @score += increment
        $('#score').text(@score)
        true

    runClock: =>
        if @inProgress
            if @time <= 0
                @inProgress = false
            else
                @time--
                minutes = Math.floor(@time/60)
                seconds = @time%60
                $('#clock').text(minutes + ":" + (if seconds < 10 then "0" else "") + seconds)
                setTimeout this.runClock,1000
        true

    startClock: =>
        if not @inProgress
            @inProgress = true
            setTimeout this.runClock,1000
        true
            
    stopClock: =>
        @inProgress = false
        true
            

        