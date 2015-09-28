# reasier ( make you read easier )
side project.
It's very common to use vim to read some codebase. And it's also very common that when I use vim I'm thinking what if vim can do blablabla then that's would be wonderful.
So I tried to implement all those functionalities what I want to have when I use vim to read source code. .

TODO
####Main window 
-  <c-]> triggers split window/refresh window with new tag stack
-  <c-t> triggers close window/refresh window with new tag stack
-  add gobal toggle whether enble plugin functionalities
-  add gobal toggle for tag stack window visibility
-  deal with edge cases: <c-]> on token without tag
-  hit <c-]> but tag no found, hit <c-t> but already reach end of tag stack


####tag_stack window
-  disable other keys
-  jump to corresponding function when hit enter
-  show help when hit ?
-  syntax based color and highlight
