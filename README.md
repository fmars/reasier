# Reasier (make Read easier) 

## Intro
Reasier tries to sovle a combo of small problems each of which  has fkuced me up for some period of time. Eventually I cannot stand it and decided to do something. 


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


Alright this is the screenshot : (
![Screenshot](https://github.com/fmars/reasier/blob/master/demo.png)

## Usage
- Just do as the same \<c-]> and \<c-t> as how to use tag to jump. Use \<leader>t to toggle tag_stack
- Use \<leader>f to highlight current word without jumping to somewhere else like what does 'gd' and '*' do
- Use \<leader>p to toggle paste mode. (to whom paste a lot like me)

## FAQ
> Hey my \<esc> doesn't work, what happened?

* Type 'kj' in either insert mode or visual mode. If you don't like this, remove these from plugin/config.vim
    
    inoremap kj <Esc>
    vnoremap kj <Esc>
    inoremap <Esc> <Nop>
    vnoremap <Esc> <Nop>
    
> Hey how can I use my own \<leader> or what does \<leader> mean?

* Type ":help leader"

> Hey when the main file is close, tag_stack will also go. How can I prevent this?

* Seriously? Remove this from plugin/reasier.vim

    autocmd WinEnter * :call jump#AutoClose()
