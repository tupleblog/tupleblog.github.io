---
author: tulakann
layout: post
title: "[geek] บันทึกการย้ายมาสู่ Zsh"
description: "จาก bash สู่ Zsh อยากย้ายก็ย้ายดื้อๆ"
tags: [Zsh, Terminal, Bash, Oh-my-zsh, Geek]
image:
  feature: post/zsh/blog-zsh.jpg
comments: true
share: true
date: 2015-12-15 12:00:00
---

สวัสดีทุกคน บล็อกใหม่มาอีกละแถมเป็นบล็อก geek อีกตะหาก จริงๆ ก็ไม่ได้ตั้งใจจะเขียน แต่เนื่องจากไปขุดเจอ [Gist](https://gist.github.com/bluenex/9880dc376b9adada792d) ที่เคยเขียนไว้ก็เลยนึกขึ้นได้ว่าเอามาแปลงบล็อกด้วยดีกว่า เผื่อมีใครมาเจอแล้วสนใจอยากลองหรือมาแลกเปลี่ยนกันมันก็น่าจะหาเจอง่ายกว่าทิ้งไว้ใน Gist แบบนั้น ว่าแล้วก็เริ่มเลยดีกว่า

# ย้ายมาสู่ Zsh
หลังจากใช้ bash และ default terminal มาตั้งแต่เริ่มใช้แมคก็เริ่มรู้สึกอยากลองอะไรใหม่ๆ โดยเฉพาะหลังจากได้มารู้จักกับ [tmux (A Terminal Multiplexer)](https://tmux.github.io/) แล้วต้องตั้งค่าหลายขั้นตอนเพื่อใช้เม้าส์ (ก่อนที่ OS X 10.11 จะมาถึง) ก็เลยได้ฤกษ์ย้ายมาใช้ [iTerm2](https://www.iterm2.com/) และคิดว่าไหนๆ ก็ไหนๆ แล้ว อยากลองใช้ Zsh ดูพอดี ย้ายมันทั้งคู่เลยละกัน ก็เลยจัดการย้ายทั้ง terminal ทั้ง shell พร้อมๆ กันซะเลย หลังจากย้ายเสร็จก็ได้จดขั้นตอนไว้ใน Gist แล้วก็เอามาแปลงเป็นบล็อกนี้ ซึ่งมันก็ไม่มีอะไรมากไปกว่าการเป็นบันทึกของสิ่งต่างๆ ที่ได้ค้นหามาแล้วก็เอามาปรับแต่งใช้เอง จริงๆ แล้วเคยเขียน [Gist ทำนองนี้](https://gist.github.com/bluenex/801bfeb9eb308e1ad786)แต่เป็นเวอร์ชันของ bash ไว้ด้วย

### ทำไมต้อง Zsh ล่ะ?
เอาจริงๆ ก็ไม่มีเหตุผลที่ชัดเจน แต่จำได้ว่าตอนนั้นได้ยินเกี่ยวกับ Zsh กับ [fish shell](http://fishshell.com/) พร้อมๆ กัน เลยนึกอยากลองขึ้นมา แต่ fish shell ค่อนข้างจะปรับแต่งยากเล็กน้อยเนื่องจากโครงสร้างสคริปต์ที่แตกต่างจาก bash ปกติ กอปรกับไอเราก็ขี้เกียจเรียนรู้มากขนาดนั้น ก็เลยตัดสินใจลองย้ายมา Zsh ด้วยเหตุผลหลักๆ ที่ว่ามันมีธีมให้เลือกหรือเขียนเองก็ได้ แล้วก็ autocompletion ที่ทำได้ยืดหยุ่นกว่า bash แต่ก็นั่นแหละ จริงๆ คืออยากลองของใหม่นั่นเอง

พูดถึงในมุมมองของเราไปแล้ว ก็ขอเอาลิงค์เกี่ยวกับว่าทำไมถึงเลือกที่จะใช้ Zsh และจะทำยังไงถ้าอยากย้ายมาฝากด้วย ก็ขอให้สนุกกับการทดลองนะ

- [Why Zsh is Cooler than Your Shell](http://www.slideshare.net/jaguardesignstudio/why-zsh-is-cooler-than-your-shell-16194692)
- [A Beautifully Productive Terminal Experience](http://mikebuss.com/2014/02/02/a-beautiful-productive-terminal-experience/)
- [Zsh is your friend](http://mikegrouchy.com/blog/2012/01/zsh-is-your-friend.html)

ส่วนอันนี้คือปลั๊กอินของ Zsh ก็มีสองตัวที่ดังๆ คือ **Oh-My-Zsh** กับ **Prezto** แต่อันนี้เราเองก็ยังคงใช้ Oh-My-Zsh อยู่ ยังไม่ได้ย้ายแต่อย่างใด

- [Ditching Oh-my-zsh for Prezto](http://linhmtran168.github.io/blog/2013/12/15/ditching-oh-my-zsh-for-prezto/)

# เริ่มติดตั้ง
เกริ่นยาวอีกละ ไปเริ่มติดตั้งเลยละกัน ในส่วนนี้ก็เป็นการบันทึกการติดตั้งของเราเอง ซึ่งก็มีหลายอย่างที่ไม่ได้จำเป็นเช่น **tmux**, [**spf13**](https://github.com/spf13/spf13-vim) หรือ [**youtube-dl**](https://github.com/rg3/youtube-dl) แต่ก็ไม่เป็นไร อยากข้ามขั้นไหนก็ข้ามโลด แล้วก็สมมติว่ามี [Homebrew](http://brew.sh/) อยู่แล้วด้วยเนาะ ถ้าไม่มีก็จิ้มตามลิงค์ไปดูวิธีติดตั้งได้

### Dependencies
- **Zsh -** จริงๆ มีติดมากับแมคอยู่แล้ว แต่จะดีกว่าถ้าลงเวอร์ชันใหม่
- **Oh-My-Zsh -** ปลั๊กอินสำหรับ Zsh แต่ผู้พัฒนาเค้าเรียกว่า Zsh configuration framework น่ะนะ
- **tmux -** ก็เอ่อไม่รู้จะอธิบายยังไง แต่มันคือ terminal multiplexer ไม่รู้จะบอกประโยชน์ยังไง แต่ใช้แล้วก็สะดวกดี
- **reattach-to-user-namespace -** อันนี้เพื่อให้ `tmux` สามารถก็อปปี้ไปลงคลิปบอร์ดได้ บน Linux ไม่ต้องลงนะ
- **vim -** text editor on terminal ก็มีติดมากับแมคเช่นกัน แต่ลงใหม่สดใหม่กว่า
- **spf13 -** อันนี้คือ distribution of vim plugins ข้ามๆ ไปก็ได้ ปัญหาเยอะเหมือนกัน ถึงเราจะยังใช้อยู่ก็เถอะ
- **youtube-dl -** อันนี้แถม เป็น command line app เขียนด้วย python ไว้โหลด youtube (ไม่ควรเผยแพร่ไฟล์ที่โหลดมาไม่ว่ากรณีใดๆ นะ)

### Installation
```bash
brew install zsh # Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" # Oh-My-Zsh
brew install tmux # tmux
brew install reattach-to-user-namespace # tmux patch
brew install vim # editor
curl http://j.mp/spf13-vim3 -L -o - | sh # spf13
brew install youtube-dl # add-on
```

# การปรับแต่ง
หลักๆ แล้วไฟล์ที่จะต้องใช้ในการปรับแต่งก็จะอยู่ใน home directory ( `~` ) หลักๆ ที่เราใช้ก็มีสามอันนี้

- `~/.zshrc`
- `~/.custom-bash`
- `~/.tmux.conf`

### `.zshrc`
`.zshrc` นี่ก็เทียบได้กับ `.bashrc` คือจะโดนเรียกทุกครั้งที่เปิดหน้าต่างใหม่ของ terminal อย่างไรก็ตามบนแมคก็มี[ข้อยกเว้น](http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html)อยู่ ถ้าสนใจก็ลองไปอ่านดูได้ ในส่วนของการตั้งค่า เนื่องจากเราได้ทำการติดตั้ง **Oh-My-Zsh** ด้วย จึงทำให้เราไม่ต้องทำอะไรกับมันมากนัก เพราะพวกการเซ็ต path หรือตั้งค่าอื่นๆ ที่จะทำให้ไฟล์รกเราจะไปทำ[ที่อื่น](http://stackoverflow.com/questions/7464677/can-i-create-my-own-bashrc-file-something-like-xyzrc-and-then-import-it-from) แทน แล้วค่อย `source` ไฟล์นั้นใน `.zshrc`

สรุปก็คือ ใน `.zshrc` เราทำแค่สองอย่างคือใส่[ปลั๊กอิน](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins)ของ **Oh-My-Zsh** แล้วก็ `source` ไฟล์ดอท (dot file)

```bash
# ประมาณบรรทัดที่ 52 เราใช้สามอันนี้ อยากใส่อะไรก็ลองไปอ่านดูนะ แปะลิงค์ไว้ตรงคำว่าปลั๊กอิน
plugins=(web-search chucknorris tmuxinator)

# ที่ท้ายสุดของไฟล์ จะให้ source ไฟล์ดอทของเรา
source ~/.custom-bash
```

### `.custom-bash`
อันนี้เป็นคอลเล็กชันของเราเอง ก็ตัดๆ ออกไปบ้าง เหลือไว้แค่บางอันเพราะมันไร้สาระเกิน

```bash
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

## VS Code
code () {
  VSCODE_CWD="$PWD" open -n -b "com.microsoft.VSCode" --args $* ;
}

##########

# Some useful stuffs
## Song Trimmer
## trimmer <song> <start(sec)> <duration(sec)>
trimmer() {
  ffmpeg -i "$1" -ss "$2" -t "$3" -acodec copy cut_"$1"
}

##########
```

### `.tmux.conf`
สุดท้ายเป็นการตั้งค่า tmux ซึ่งใครไม่ได้ลงก็ไม่ต้องสนใจตรงนี้เลยก็ได้ โดยปกติ tmux จะต้องกดคีย์ผสมโดยจะมีปุ่มนำที่เรียกว่า prefix แล้วก็ปุ่มตามเป็นคำสั่ง ซึ่งค่าเริ่มต้นมันต้องกด `C-b` หรือ `control-b` แต่ขี้เกียจกดสองปุ่มไง ก็เลยย้ายไปไว้ที่ปุ่ม <code>`</code> แต่จริงๆ แล้วเราจะตั้งเป็นอะไรก็ได้ ไม่ได้มีข้อจำกัดอะไร ใครถนัดอะไรก็ตั้งตามนั้นได้โลด

คีย์ผสมพวกนี้ก็เกิดจากการตั้งขึ้นเอง โดยรวมๆ ยำๆ มาจากลิงค์ด้านล่าง ถ้าตั้งใหม่แล้วลืมว่าคีย์ไหนทำอะไรก็สามารถเช็คได้จากใน **tmux** โดยกด <code>`</code> + <code>?</code>

#### ที่มาของการตั้งค่า tmux

- [Making the clipboard work between iTerm2, tmux, vim and OS X](http://evertpot.com/osx-tmux-vim-copy-paste-clipboard/)
- [Getting tmux to copy a buffer to the clipboard](http://unix.stackexchange.com/questions/15715/getting-tmux-to-copy-a-buffer-to-the-clipboard)
- [Enable Mouse Support in Tmux on OS X](http://www.davidverhasselt.com/enable-mouse-support-in-tmux-on-os-x/)
- [Increased Developer Productivity with Tmux, Part 2: ~/.tmux.conf](http://minimul.com/increased-developer-productivity-with-tmux-part-2.html)
- [TMUX – The Terminal Multiplexer (Part 2)](http://blog.hawkhost.com/2010/07/02/tmux-%E2%80%93-the-terminal-multiplexer-part-2/)

```bash
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

# easily source .tmux.conf
unbind r
bind-key r source-file ~/.tmux.conf \; \
  display-message "source-file done"

#count windows and panes from 1
set -g base-index 1
setw -g pane-base-index 1

## MOUSE
# tmux 2.1+
set-option -g mouse on
# tmux 1.8-
# set -g mode-mouse on
# set -g mouse-select-pane on
# set -g mouse-resize-pane on
# set -g mouse-select-window on

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
```

# สรุป
ก็หมดละสำหรับการตั้งค่าของเรา ซึ่งอันนี้เป็นเวอร์ชันเมื่อสามเดือนก่อนแล้วก็มีตัดๆ อะไรบางอย่างทิ้งไปบ้าง แต่ก็น่าจะยังใช้ได้เหมือนเดิม ถ้ามีอะไรจะแนะนำหรือแลกเปลี่ยนก็ทิ้งคอมเม้นต์ไว้ได้นะครับ สุดท้ายนี้ขอฝาก [Gist ของ `youtube-dl`](https://gist.github.com/bluenex/40496729bc721d7b4be0) ไว้หน่อยเผื่อจะมีประโยชน์ (ล่ะมั้ง) :p
