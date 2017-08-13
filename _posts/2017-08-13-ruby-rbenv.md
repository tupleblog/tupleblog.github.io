---
author: tulakann
layout: post
title: "[geek] ลง Ruby บน Mac OS X ยังไงให้ไม่หัวเสีย"
description: "หัวร้อนจากการลง Ruby มา พอสำเร็จแล้วก็ขอจดไว้หน่อย"
tags: [Ruby, rbenv, Installation]
image:
  feature: post/rubyrbenv/rubyrbenv.jpg
  credit: Wikimedia Common
  creditlink: https://commons.wikimedia.org/wiki/File:Ruby_logo.svg
comments: true
share: true
date: 2017-08-13 22:50:00
---

บล็อกสั้นวันนี้ขอเสนอการติดตั้ง Ruby ซึ่งวันนี้มันพังทำให้เราต้องเสียเวลาไปพอสมควร ไม่น่าเชื่อว่าภาษาที่คนใช้มากขนาดนี้จะไม่สามารถลงได้อย่างง่ายๆ ด้วยคำสั่งเดียว T_T แต่จากประสบการณ์การใช้งานทั้งบน Windows และ Mac OS X ก็ไม่ค่อยเจอปัญหาตอนติดตั้งบน Windows นะ คงเพราะมีคน build มาเป็น `.msi` ให้อย่างสะดวกสบาย ([ที่นี่](https://rubyinstaller.org/)) พอมาบน Mac ปัญหามันเกิดจาก

1. Mac มี built-in Ruby ตอนนี้มันก็ยังอยู่ในเครื่อง ลบก็ไม่ได้ ทำอะไรกับมันไม่ได้เลย `sudo` ไม่ช่วยอะไร เป็นเวอร์ชัน `2.0.0` สักอย่างอยู่
2. ก่อนจะพังเราเคยลง Ruby ไว้ทั้งผ่าน Homebrew และ rbenv และตอนนั้นเนื่องจากรีบๆ เลยไม่ได้เคลียร์พวก path ไว้ สุดท้ายก็ใช้ตัวที่ลงผ่าน Homebrew มาเรื่อยๆ จนมาเกิดปัญหารัน `gem` ไม่ผ่านวันนี้
3. เราใช้ [tmux](https://github.com/tmux/tmux/wiki) (Terminal Multiplexer) ด้วย ซึ่งเซตไว้หลาย sessions เพื่อแต่ละงานที่ต่างๆ กัน และด้วยการใช้ปลั๊กอินทั้ง tmux-resurrect และ tmux-continuum ทำให้เราไม่ค่อยปิดเปิด terminal สักเท่าไหร่ ซึ่งเวลาติดตั้งบางอย่างมันเป็นสิ่งจำเป็นที่ต้องทำ.. Ruby ก็เช่นกัน

ตอนแรกก็แค่ติด `sudo` แต่พอรันด้วย `sudo` ก็ยังไม่ผ่านไป error อย่างอื่นอีก ซึ่งไม่ได้แคปไว้ด้วย เข้าใจว่าไม่ค่อยได้อัพเดท Homebrew ในช่วงหลังๆ มานี้ พอมาอัพเดทบางอย่างเลยพังจากการ symlink อันมั่วถั่วขั้นสิบ error สุดท้ายที่จำได้คือมันเรียกหา `libyaml` แต่เราก็ลงไปแล้ว แค่มันหาไม่เจอเอง `brew install ruby` ไม่ได้ช่วย build ตามที่เราต้องการ ทางเลือกคงเหลือแค่ build from source ซึ่งก็เกือบจะลงมือละ โชคดีไปเช็คเจอ Path มันมี rbenv อยู่ ก็เกือบจะลืมไปละว่ามันคืออะไร

## rbenv

ก็นั่งอ่านๆ ไปสักพักหลายๆ คนก็แนะนำให้ลง Ruby ด้วย RVM หรือ rbenv ดีกว่า เปิดผ่านๆ ไปเรื่อยๆ นับ rbenv ได้มากกว่า RVM ก็เลยไปทาง rbenv ซะเลย เอางี้แหละไม่ได้ใช้เป็นภาษาหลัก ขอให้รัน `gem` ได้ก็กราบละตอนนี้ ถึงตอนนี้คนที่เคยใช้ก็อาจจะรู้แล้วว่า [RVM](https://rvm.io/) [rbenv](https://github.com/rbenv/rbenv) คืออะไร สองหน่อนี้มันคือตัวบริหารจัดการ environment ในการติดตั้ง Ruby มันทำให้เราสามารถลง Ruby หลายๆ เวอร์ชันพร้อมๆ กันได้ (ทำไมต้องลงหลายเวอร์ชัน นักพัฒนา Ruby เค้าใช้ชีวิตกันยังไง ฮือ) และเลือกที่จะทำงานกับ environment ที่ต้องการได้อย่างง่ายๆ แต่สำหรับเราแล้ว ช่วยลงให้มันรัน `gem` ได้ก็พอแล้ว 5555

เริ่มเลย ขั้นตอนเหล่านี้ดัดแปลงมาจาก [readme ของ rbenv](https://github.com/rbenv/rbenv) แล้วก็[บล็อกของ Robert Anderson](http://blog.zerosharp.com/installing-ruby-with-homebrew-and-rbenv-on-mac-os-x-mountain-lion/) นะ เนื่องจากเราเลือก rbenv ก็ลง rbenv ผ่าน Homebrew เนี่ยแหละ โก!

```sh
$ brew update
$ brew install rbenv
$ brew install ruby-build
```

แล้วก็หวังให้มันติดตั้งได้อย่างปลอดภัย ต่อมา จาก readme ของ rbenv เค้าบอกให้รัน `rbenv init -` ซึ่งมันก็จะเพิ่ม Path ให้ใน `~/.bash_profile` (ใครใช้ zsh ต้องย้ายไป `~/.zshrc` เองนะ)  เสร็จแล้วก็ลง Ruby เลย ในที่นี้ลงเวอร์ชัน `2.4.1` ถ้าอยากลองดูเวอร์ชันทั้งหมดที่ลงได้ก็รัน `rbenv install -l` ดูได้

```sh
$ rbenv install 2.4.1
$ rbenv rehash
```

เสร็จแล้วก็เช็คโลด 

```sh
$ ruby --version
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin16]
$ which ruby
/Users/username/.rbenv/shims/ruby
```

เย้ได้แล้ว ไหนลองปิด terminal แล้วเปิดใหม่ซิ

```sh
$ ruby --version
ruby 2.0.0p648 (2015-12-16 revision 53162) [universal.x86_64-darwin16]
$ which ruby
/usr/bin/ruby
```

อ่าว ไหงทำกะเรางี้ อยากกลับก็กลับงี้ก็ได้หรอ ไม่รู้เหมือนกันว่าอันนี้เป็น bug หรือ feature แต่เราอยากให้เปิด terminal ขึ้นมาปุ๊บก็ใช้อันที่ติดตั้งโดย rbenv เลยอ้ะ.. จริงๆ แล้วก็ไม่ยากแค่เพ่ิมบรรทัดนี้เข้าไปใน `~/.zshrc` 

```sh
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
```

เสร็จละ สรุปแล้ว `~/.zshrc` ของเราที่เพิ่มเข้าไปหน้าตาก็จะเป็นประมาณนี้

```sh
# Initialize rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
```

จริงๆ แล้วมันก็ไม่ได้ยากเล้ย แต่ทำไมไม่เห็นมี docs ที่เขียนไว้อย่างชัดเจนเป็นขั้นเป็นตอนเลย ต้องมาหวังพึ่ง[บล็อกของคุณ Robert Anderson](http://blog.zerosharp.com/installing-ruby-with-homebrew-and-rbenv-on-mac-os-x-mountain-lion/) ซะงั้น หรือคนอื่นเค้าไม่ได้ใช้ Ruby กับ `gem` กันแบบนี้ หรือติดตั้งแล้วไม่มีปัญหาแบบเรากันนะ ใครเคยเจอแบบไหนใช้ท่าง่ายกว่ายากกว่ายังไงก็มาแชร์กันหน่อยนะครับ จบดีกว่า ไปละ

