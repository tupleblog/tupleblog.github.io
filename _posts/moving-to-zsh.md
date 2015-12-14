---
author: Tulakanr
layout: post
title: ย้ายมาใช้ Zsh
description: "จาก Bash สู่ Zsh ความแตกต่างที่ปรับตัวได้"
tags: [zsh, terminal, bash, oh-my-zsh, geek]
image:
  feature:
  credit:
  creditlink:
comments: true
share: true
---

# Moving to Zsh

Have a good time with **bash** for a long while, it's time to try another tempting shell - **Zsh**. So, this Gist is nothing but my collection for the environment that I've searched and applied to my system. There is also this kind of Gist in a [version of **bash**](https://gist.github.com/bluenex/801bfeb9eb308e1ad786).

### Why Zsh?
There are several shells out there but this is the one that is close to the **bash** with some useful and attractive features especially - yes, **theme**. Here are some good articles about how and why to choose **Zsh** over **bash**, enjoy trying!

- [Why Zsh is Cooler than Your Shell](http://www.slideshare.net/jaguardesignstudio/why-zsh-is-cooler-than-your-shell-16194692)
- [A Beautifully Productive Terminal Experience](http://mikebuss.com/2014/02/02/a-beautiful-productive-terminal-experience/)
- [Zsh is your friend](http://mikegrouchy.com/blog/2012/01/zsh-is-your-friend.html)

and this (I may soon leave **Oh-My-Zsh** to try this)

- [Ditching Oh-my-zsh for Prezto](http://linhmtran168.github.io/blog/2013/12/15/ditching-oh-my-zsh-for-prezto/)

# Dependencies

- Zsh -- built-in on OSX but better reinstall for the newer version
- Oh-My-Zsh -- Zsh configuration framework
- tmux -- terminal multiplexor
- reattach-to-user-namespace -- for `tmux` being able to copy to clipboard
- vim -- built-in on OSX but better for the newer version
- spf13 -- distribution of vim plugins
- youtube-dl -- youtube download script

### Installation
{% highlight bash %}
brew install zsh # Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # Oh-My-Zsh
brew install tmux # tmux
brew install reattach-to-user-namespace # tmux patch
brew install vim # editor
curl http://j.mp/spf13-vim3 -L -o - | sh # spf13
brew install youtube-dl # add-on
{% endhighlight %}

# Configuration
The files that will be added and edited are all in home directory ( `~` ) as following:

- `~/.zshrc`
- `~/.custom-bash`
- `~/.tmux.conf`

### .zshrc
By installing **Oh-My-Zsh**, there is nothing to do other than adding your preferred **Zsh** plugins and your personal aliases. For that, I choose to separate my aliases in another files and source in `.zshrc` instead.

{% highlight bash %}
# at around line 52
# I only need 2 plugins now.. lol
plugins=(gitfast web-search)

# at the end of the files
## Custom shell function
source ~/.custom-bash
{% endhighlight %}

### .custom-bash
Collection of my favorite stuffs from absurd to useful (hopefully).

{% highlight bash %}
# Export
export PATH="/usr/local/bin:$PATH"
export EDITOR='vim'

# Alias
## github page - jekyll serve
alias ghpjks='bundle exec jekyll serve'

## source .bash_profile
alias srcbpf='source ~/.bash_profile'
alias srcz='source ~/.zshrc'

## hide & show files
alias unhideFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

## directory shortcuts
alias projectDir='cd ~/Projects'
alias unityDir='cd ~/unity3d'

## command
#alias l='ls -tlcras'
alias s='du -sh'
alias mux='tmuxinator'

##########

# App shortcuts
## Safari
safari() {
  open -a Safari.app "$1"
}

## Chrome
chrome() {
  open -a "Google Chrome.app" "$1"
}

## Preview
preview() {
  open -a Preview.app "$1"
}

## VS Code
code() {
    if [[ $# = 0 ]];
    then
        echo $PWD
        open -a "Visual Studio Code" $PWD
    else
        [[ $1 = /* ]] && F="$1" || F="$PWD/${1#./}"
        echo $F
        open -a "Visual Studio Code" $F
    fi
}

##########

# Some useful stuffs
## Song Trimmer
## trimmer <song> <start(sec)> <duration(sec)>
trimmer() {
  ffmpeg -i "$1" -ss "$2" -t "$3" -acodec copy cut_"$1"
}

##########

# youtube-dl add-on
## due to certification error, this alias is to bypass

chk-ytdl-dir() {
if [ ! -d ~/Music/youtube-dl ]; then
  mkdir ~/Music/youtube-dl
  echo "created ~/Music/youtube-dl"
fi
}

ytdl() {
  ## checking
  testlen=$1
  if [[ $# -gt 2 ]]; then
    echo "Only 2 arguments are allowed!"
    return 1
  fi
  if [[ ${#testlen} -gt 4 ]]; then
    echo "Maximum length of option is 4.. (-sph or -vph)"
    return 1
  fi
  if [[ $1 == *"s"* && $1 == *"v"* ]]; then
    echo "Could not download both song and video at once!"
    return 1
  fi

  ## downloading
  chk-ytdl-dir
  curdir="$PWD"
  if [[ $1 != *"h"* ]]; then
    cd ~/Music/youtube-dl/
  else
    echo "Download to current path.."
  fi
  if [[ $1 == *"s"* ]]; then
    echo "Downloading song.."
    if [[ $1 == *"p"* ]]; then
      echo "With proxy.."
      youtube-dl -o "%(title)s.%(ext)s" -f "m4a" --proxy "" --no-check-certificate $2
    else
      youtube-dl -o "%(title)s.%(ext)s" -f "m4a" --no-check-certificate $2
    fi
  elif [[ $1 == *"v"* ]]; then
    echo "Downloading video.."
    if [[ $1 == *"p"* ]]; then
      echo "With proxy.."
      youtube-dl -o "%(title)s.%(ext)s" -f "best" --proxy "" --no-check-certificate $2
    else
      youtube-dl -o "%(title)s.%(ext)s" -f "best" --no-check-certificate $2
    fi
  else
    echo "No satisfied parameters filled.."
    echo "Please use -s for song, -v for video, -p if proxy and -h to save to current path."
  fi
  cd $curdir
}

chk-dup-song() {
  fdupes -r -d ~/Music/youtube-dl/
}
{% endhighlight %}

### .tmux.conf
Custom modification for tmux. By default tmux uses `C-b` as prefix which is pretty annoying for me (too lazy to `C-b`), so I change it to <code>`</code> for the sake of laziness. Note that this config is modified like this just because I like it this way - there is **no** principle to limit creativity.

Many key bindings have been changed in this config (mixed from sources below). If want to know which key mapped with which command, it can be checked by <code>`</code> + <code>?</code>.

#### Sources

- [Making the clipboard work between iTerm2, tmux, vim and OS X](http://evertpot.com/osx-tmux-vim-copy-paste-clipboard/)
- [Getting tmux to copy a buffer to the clipboard](http://unix.stackexchange.com/questions/15715/getting-tmux-to-copy-a-buffer-to-the-clipboard)
- [Enable Mouse Support in Tmux on OS X](http://www.davidverhasselt.com/enable-mouse-support-in-tmux-on-os-x/)
- [Increased Developer Productivity with Tmux, Part 2: ~/.tmux.conf](http://minimul.com/increased-developer-productivity-with-tmux-part-2.html)
- [TMUX – The Terminal Multiplexer (Part 2)](http://blog.hawkhost.com/2010/07/02/tmux-%E2%80%93-the-terminal-multiplexer-part-2/)

{% highlight bash %}
## BASIC STUFFS
# use zsh as default shell
set-option -g default-shell /bin/zsh

# using ` as prefix
unbind C-b
set-option -g prefix `
bind ` send-prefix

# change split keys
unbind %
bind - split-window -v
unbind '"'
bind | split-window -h

#unbind {
#bind { swap-pane -D
#unbind }
#bind } swap-pane -U

# easily source .tmux.conf
unbind r
bind-key r source-file ~/.tmux.conf \; \
  display-message "source-file done"

#count windows and panes from 1
set -g base-index 1
setw -g pane-base-index 1

## MOUSE
set -g mode-mouse on
set -g mouse-select-pane on
set -g mouse-resize-pane on
set -g mouse-select-window on

## COLOR
set -g default-terminal "screen-256color"

## PASTE BUFFER TO CLIPBOARD
# Copy-paste integration
set-option -g default-command "reattach-to-user-namespace -l zsh"

# Use vim keybindings in copy mode
setw -g mode-keys vi

# Setup 'v' to begin selection as in Vim
bind-key -t vi-copy v begin-selection
bind-key -t vi-copy y copy-pipe "reattach-to-user-namespace pbcopy"

# Update default binding of `Enter` to also use copy-pipe
unbind -t vi-copy Enter
bind-key -t vi-copy Enter copy-pipe "reattach-to-user-namespace pbcopy"

# Bind ']' to use pbpaste
bind ] run "reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer"

# Kill session
bind k confirm-before -p "kill-session #S? (y/n)" kill-session
{% endhighlight %}

### There is no [GitHipster (completion and highlighting)](https://gist.github.com/titipata/a91ea46bde973d457f26) here?
No, there is not. The reason is that **Zsh** supports **git** almost out of the box, plus with **Oh-My-Zsh**, it's good to go instantly without any help from git-completion script like in **bash**. Attached image below is the example of how git repo looks like for default **Oh-My-Zsh** theme.
