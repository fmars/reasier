# reasier ( make you read easier )
side project.
It's very common to use vim to read some codebase. And it's also very common that when I use vim I'm thinking what if vim can do blablabla then that's would be wonderful.
So I tried to implement all those functionalities what I want to have when I use vim to read source code. .

TODO
- 1. <c-]> triggers split window/refresh window with new tag stack
- 2. <c-t> triggers close window/refresh window with new tag stack
- 3. in __tag_stack__ window, disable other keys
- 4. in __tag_stack__ window, jump to corresponding function when hit enter
- 5. in __tag_stack__ window, show help when hit ?
- 6. add gobal toggle whether enble plugin functionalities
- 7. add gobal toggle for tag stack window visibility
- 8. deal with edge cases: <c-]> on token without tag
