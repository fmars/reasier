# reasier ( make you read easier )
side project.
It's very common to use vim to read some codebase. And it's also very common that when I use vim I'm thinking what if vim can do blablabla then that's would be wonderful.
So I tried to implement all those functionalities what I want to have when I use vim to read source code. .

TODO
-  <c-]> triggers split window/refresh window with new tag stack
-  <c-t> triggers close window/refresh window with new tag stack
-  in __tag_stack__ window, disable other keys
-  in __tag_stack__ window, jump to corresponding function when hit enter
-  in __tag_stack__ window, show help when hit ?
-  add gobal toggle whether enble plugin functionalities
-  add gobal toggle for tag stack window visibility
-  deal with edge cases: <c-]> on token without tag
-  hit <c-]> but tag no found, hit <c-t> but already reach end of tag stack
