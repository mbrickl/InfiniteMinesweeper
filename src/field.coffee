MINE_PROPORTION = 0.2

class @Field
    constructor: ->
        @array = []
    
    #---------
    # NAME:         clickSquare
    # DESCRIPTION:  called by the UI to click on a SQUARE
    # PARAMETERS:
    #  index (I) - should be in the format of XXX_YYY
    #  result (IO,DEF=[]) an array of objects with the following properties
    #   "index" : the index of the square clicked
    #   "square" : the css class the square should now be
    #   "result" :  "boom" if a mine was clicked
    #               "money" if a space was cleared
    #               "nothing" if a space was already clicked
    #  ifFirstClick (I,DEF=no) whether this is the first click
    #---------
    clickSquare: (index, result = [], isFirstClick = no) ->
        square = getSquare(index, if isFirstClick then NOT_MINE else undefined)
        if square.isChecked == NOT_CHECKED or square.isChecked == QED
            if square.isMine()
                 outcome = "boom"
            else
                outcome = "money"
        
            square.number = getCount(index)
        else
            outcome = "nothing"
        
        result.push({"index" : index, square: square.getClass(), "result" : outcome})
        
        if square.number == 0 and outcome == "money"
            clearSurroundingSquares(index, result)
        return result

    clearSurroundingSquares: (index, result) ->
        coord = indexToCoordinates(index)
        x = coord[0]
        y = coord[1]
        
        #upper left
        clickSquare(coordinatesToIndex(x - 1, y - 1), result)
        #upper
        clickSquare(coordinatesToIndex(x, y - 1), result)
        #upper right
        clickSquare(coordinatesToIndex(x + 1, y - 1), result)
        #right
        clickSquare(coordinatesToIndex(x + 1, y), result)
        #lower right
        clickSquare(coordinatesToIndex(x + 1, y + 1), result)
        #lower
        clickSquare(coordinatesToIndex(x, y + 1), result)
        #lower left
        clickSquare(coordinatesToIndex(x - 1, y + 1), result)
        #left
        clickSquare(coordinatesToIndex(x - 1, y), result)

    markSquare: (index) ->
        square = getSquare(index, UNKNOWN)
        if square.isChecked == NOT_CHECKED
            square.isChecked = MARKED
        else if square.isChecked == MARKED
            square.isChecked = QED
        else if square.isChecked == QED
            square.isChecked = NOT_CHECKED
        
        return { "square" : square.getClass() }

    getCount: (index) ->
        count = 0
        coord = indexToCoordinates(index)
        x = coord[0]
        y = coord[1]
        
        #upper left square
        if getSquare(coordinatesToIndex(x - 1, y - 1)).isMine == MINE then count += 1
        #upper square
        if getSquare(coordinatesToIndex(x, y - 1)).isMine == MINE then count += 1
        #upper right square
        if getSquare(coordinatesToIndex(x + 1, y - 1)).isMine == MINE then count += 1
        #right square
        if getSquare(coordinatesToIndex(x + 1, y)).isMine == MINE then count += 1
        #right bottom square
        if getSquare(coordinatesToIndex(x + 1, y + 1)).isMine == MINE then count += 1
        #bottom square
        if getSquare(coordinatesToIndex(x, y + 1)).isMine == MINE then count += 1
        #bottom left square
        if getSquare(coordinatesToIndex(x - 1, y + 1)).isMine == MINE then count += 1
        #left square
        if getSquare(coordinatesToIndex(x - 1, y)).isMine == MINE then count += 1
        
        return count

    indexToCoordinates: (index) ->
        return split(index, "_")
    coordinatesToIndex: (x, y) ->
        return x + "_" + y
    
    getSquare: (index, forceMine = undefined) ->
        index = coordinatesToIndex(x,y)
        if not @array[index]?
            if forceMine?
                @array[index] = new Square(forceMine)
            else
                @array[index] = new Square(if Math.random() < MINE_PROPORTION then MINE else NOT_MINE)
        else if @array[index].isMine == UNKNOWN and forceMine != UNKNOWN
            if forceMine?
                @array[index] = new Square(forceMine)
            else
                @array[index].isMine = if Math.random() < MINE_PROPORTION then MINE else NOT_MINE
        return @array[index]    