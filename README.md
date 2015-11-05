# Reasier (make you read easier)
When read a big codebase by vim, jump back and forth between functions and files, I'm usually thinkg that it would be wonderful if vim could do this, it would be great if vim could do that. It would definitely boost my reading or cooding speed.

After thinking those things in head so many times, I decided to write them down. So Reasier comes which named for make you read easier. It inclueds couple small features like visualize tag stack, highlight current word, etc.

![screenshot1](http://i.imgur.com/WrqFZzg.png)

TODO
####Main window 
-  <c-]> triggers split window/refresh window with new tag stack
-  <c-t> triggers close window/refresh window with new tag stack
-  add gobal toggle whether enble plugin functionalities
-  add gobal toggle for tag stack window visibility
-  deal with edge cases: <c-]> on token without tag
-  hit <c-]> but tag no found, hit <c-t> but already reach end of tag stack
-  hit <c-[> jump to tag most recently popped tag


####tag_stack window
-  disable other keys
-  jump to corresponding function when hit enter
-  show help when hit ?
-  syntax based color and highlight
-  automatic close the tag_stack window when main window is closed

####Others
-  switch between cpp and hpp files
-  Vim, jump to beginning of a function from any point in the mid
-  All the window, control by keyboard
-  toggle paste mode

####Fixes
-  unexpected close file when hit <C-t> and tag stack is empty
-  if any kinds of 'tag not found' will break reasier
-  multiple entry of one tag


#### TODO
-  auto close tag stack if main file is closed
-  mosh issue if .swp exists
