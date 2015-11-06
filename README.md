# Reasier (make Read easier) 

## Intro
Reasier is a combo of small pieces of shut. Each of them has fkuced me up for some period of time. Eventually I cannot stand it and decided to do something. 

When you try to understanding some unfamiliar codebase, you wanna
* figure out where are you after jumping back and forth by ctags <C-]>, 
* just highlight current variable without jumping to anywhere else

Then here Reasier comes to help, to make read source code easier, in tiny extent. It inclueds couple small features like visualize tag stack, highlight current word, toggle paste mode (lol) etc.

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
-  auto close tag stack if main file is closed



#### TODO
-  mosh issue if .swp exists

<a href="http://www.wtfpl.net/"><img
       src="http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-4.png"
       width="80" height="15" alt="WTFPL" /></a>
