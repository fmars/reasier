# Reasier (make Read easier) 

## Intro
Reasier is a combo of small pieces of shut. Each of them has fkuced me up for some period of time. Eventually I cannot stand it and decided to do something. 


## What
When you try to understanding some unfamiliar codebase, you wanna
* figure out where are you after jumping back and forth by ctags <C-]>, 
* just highlight current variable without jumping to anywhere else

Then here Reasier comes to help, to make read source code easier, in tiny extent. It inclueds couple small features like visualize tag stack, highlight current word, toggle paste mode (lol), etc.

## Installation
[pathogen.vim](https://github.com/tpope/vim-pathogen) is the recommended way to install Reasier.

    cd ~/.vim/bundle
    git clone https://github.com/fmars/reasier.git

Then reload vim and check out `:help Reasier.txt`.

## Dependencies
[Exuberant ctags 5.5](http://ctags.sourceforge.net/)

(You are not trying to tag without tag file right)

## Notes
Please read plugin/config.vim file before using. It contains some simple setting. Not everyone likes what I like, so remove anything which you dislike. (setting your own <leader> by change the first line of code)
## Demo
I use quicktime player to record, and [ffmpeg, gifsicle](https://gist.github.com/dergachev/4627207) to convert to gif.

Now let's take a look at this shit.
![Screencapture GIF](https://github.com/fmars/reasier/blob/master/demo.gif)
Alright this is some screenshot : (
![Screenshot](https://github.com/fmars/reasier/blob/master/demo.png)

