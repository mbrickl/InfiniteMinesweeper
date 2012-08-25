# Square click handler
# 1 = Primary mouse button (left)
# 2 = Middle mouse button
# 3 = Alternate mouse button (right)
squareClick = (target) ->
    switch (target.which)
        when "1"