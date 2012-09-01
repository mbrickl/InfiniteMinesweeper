@NOT_MINE = 0
@MINE = 1
@UNKNOWN = 2

@NOT_CHECKED = 0
@CHECKED = 1
@MARKED = 2
@QED = 3

class @Square    
    constructor: (@isMine = NOT_MINE, @isChecked = NOT_CHECKED, @index, @number = -1) ->
    
    getClass: ->
        switch @isChecked
            when NOT_CHECKED
                return ""
            when MARKED
                return "marked"
            when QED
                return "qed"
            when CHECKED
                if @isMine == MINE
                    if @number <= 0
                        return "boom"
                    else
                        return "boom" + @mines
                else
                    if @number <= 0
                        return "clear"
                    else
                        return "clear" + @mines