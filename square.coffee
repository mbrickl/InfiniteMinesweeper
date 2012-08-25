SQUARE_DEFAULT = 0
SQUARE_MINE = 1
SQUARE_MARK = 2
SQUARE_MARKMINE = 3
SQUARE_CLICK = 4
SQUARE_CLICKMINE = 5

class Square    
    constructor: (@state = SQUARE_DEFAULT) ->
    isMine: ->
        @state | 1
    isClicked: ->
        @state | 2
    isMarked: ->
        @state | 4
