#Game time in seconds
MAX_TIME=300

class Game
    constructor: ->
        @field = new Field
        @score = 0
        @inProgress = false
        @time = MAX_TIME

    updateScore: (increment) ->
        @score += increment
        $('score').text=@score

    runClock: ->
        if this.inProgress
            @time--
            $('clock').text=@time/60 + ":" + @time%60
            setTimeout runClock,1000

    startClock: ->
        if not @inProgress
            @inProgress = true
            setTimeout runClock,1000
            
    stopClock: ->
        @inProgress = false
            

        