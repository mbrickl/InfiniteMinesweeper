MINE_PROPORTION = 0.2
TIME_PENALTY = 10
POINTS_PER_SQUARE = 100

class Field
    constructor: ->
        @array = []
    clickSquare: (x, y) ->
        square = getSquare(x,y)
        if square.isChecked == NOT_CHECKED or square.isChecked == QED
            redraw(x, y, status)
            if square.isMine()
                timer -= 10
            else
                points += POINTS_PER_SQUARE
        
        initializeOthers(index, x, y)

    initializeOthers: (x, y) ->
        count = 0
        #upper left square
        x -= 1
        y -= 1
        if getSquare(x, y).isMine == MINE then count += count
        
        #upper square
        x += 1
        if getSquare(x, y).isMine == MINE then count += count
        
        #upper right square
        x += 1
        if getSquare(x, y).isMine == MINE then count += count
        
        #right square
        y += 1
        if getSquare(x, y).isMine == MINE then count += count
        
        #right bottom square
        y += 1
        if getSquare(x, y).isMine == MINE then count += count
        
        #bottom square
        x -= 1
        if getSquare(x, y).isMine == MINE then count += count
        
        #bottom left square
        x -= 1
        if getSquare(x, y).isMine == MINE then count += count
        
        #left square
        y -= 1
        if getSquare(x, y).isMine == MINE then count += count
        

    coordinatesToIndex: (x, y) ->
        "x" + x + "y" + y
        
    getSquare: (x, y, forceMine = no) ->
        index = coordinatesToIndex(x,y)
        if not @array[index]?
            @array[index] = new Square(if forceMine or Math.random() < MINE_PROPORTION then MINE else NOT_MINE)
        else if @array[index].isMine == UNKNOWN
            @array[index].isMine = if forceMine or Math.random() < MINE_PROPORTION then MINE else NOT_MINE
        @array[index]    
    
    redraw: (x, y, status) ->
        #do redraw stuff here.