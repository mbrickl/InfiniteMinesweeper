WIN_VAL=10
LOSS_VAL=-10

# Square click handler
# 1 = Primary mouse button (left)
# 2 = Middle mouse button
# 3 = Alternate mouse button (right)
@sqClick = (event) ->
    switch event.which
        when 1 then sqLeftClick(event.target)
        when 3 then sqRightClick(event.target)
        else return true

# Handle left click on square
@sqLeftClick = (target) ->
    vals = new Array();
    window.game.field.clickSquare($(target).attr("id"), vals, !window.game.inProgress)
    window.game.startClock()
    for val in vals
        switch val.result
            when "boom" then updateBoard(target, "mine", "lose")
            when "money" then updateBoard(target, val.newClass, "win")
    true
            
# Handle right click on square
@sqRightClick = (target) ->
    val = window.game.field.markSquare($(target).attr("id"))
    updateBoard(target, val.newClass, "mark")
    true
    
##Update board display and score
@updateBoard = (target, newClass, status) ->
    if not $(target).hasClass(newClass)
        $(target).removeClass()
        $(target).addClass("square")
        $(target).addClass(newClass)
    #Update score if necessary
    switch status
        when "win"
            window.game.updateScore(WIN_VAL)
        when "lose"
            window.game.updateScore(LOSS_VAL)
    true        
    
    
    