# Square click handler
# 1 = Primary mouse button (left)
# 2 = Middle mouse button
# 3 = Alternate mouse button (right)
sqClick = (target) ->
    switch target.which
        when "1" then sqLeftClick(target)
        when "3" then sqRightClick(target)
        else return true

# Handle left click on square
sqLeftClick = (target) ->
    gField.clickSquare(target.id, vals, !gInProgress)
    gInProgress = true
    for val in vals
        switch val.result
            when "boom" then updateBoard(target, "mine", "lose")
            when "money" then updateBoard(target, val.newClass, "win")
    true
            
# Handle right click on square
sqRightClick = (target) ->
    val = gField.markSquare(target.id)
    updateBoard(target, val.newClass, "mark")
    true
    
##Update board display and score
updateBoard = (target, newClass, status) ->
    if not target.hasClass(newClass)
        target.removeClass()
        target.addClass("square")
        target.addClass(newClass)
    #Update score if necessary
    switch status
        when "win"
            gScore += WIN_VAL
        when "lose"
            gScore -= LOSS_VAL
    true        
    
    
    