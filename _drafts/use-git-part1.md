---
author: tulakann
layout: post
title: มาเริ่มใช้ Git กัน
description: "จะว่าสอนก็ไม่ใช่ เรียกว่านำทางละกัน ใครยังไม่เคยใช้มาใช้กันเถอะ"
tags: [git, tutorial]
image:
  feature:
  credit:
  creditlink:
comments: true
share: true
---

# เกริ่นนำ
สวัสดี วันนี้เราจะมาเขียนภาคต่อจากบล็อกก่อนของ @titipata ที่ได้มา[แนะนำให้รู้จักกับ Git](http://tupleblog.github.io/git-intro/) ไว้ บล็อกนี้ตั้งใจเขียนขึ้นเพื่อเป็นการนำทางเวอร์ชันภาษาไทยแก่ผู้เริ่มต้นที่อยากเริ่มใช้งาน git ผ่าน CLI (Command Line Interface) และจะค่อยๆ เพิ่มคำสั่งหรือทริคต่างๆ ไปเรื่อยๆ สำหรับคนที่ใช้เวอร์ชัน GUI (Graphical User Interface) อยู่แล้วถ้าได้ลองใช้ผ่าน CLI ดูสักครั้งอาจจะชอบก็เป็นได้

เนื่องจากเราอยากเขียนสำหรับผู้ที่เริ่มต้นจริงๆ ถึงแม้จะเพิ่งรู้จัก CLI ใหม่ๆ ก็น่าจะทำตามได้ ดังนั้นสิ่งที่จะทำในบล็อกนี้ก็จะค่อยๆ ไปเป็นขั้นเป็นตอนประมาณนี้

- ติดตั้ง git ทั้งบน Windows, Mac และ Linux
- ตั้งค่า git เพื่อใช้งานครั้งแรก
- สร้าง local git repository (repo)
- สร้างความเปลี่ยนแปลงบน repo
- สร้าง remote repo บน Github
- push ความเปลี่ยนแปลงไปยัง remote repo
- clone remote repo แล้วทำการแก้ไข
- pull ความเปลี่ยนแปลงจาก remote repo

หลักๆ สำหรับบล็อกนี้ก็น่าจะประมาณนี้ ไปเริ่มกันเลยดีกว่า

## เตรียมความพร้อม
สิ่งแรกสุดที่เราต้องมีคือ git นั่นเอง บล็อกของ @titipata ก็กล่าวไว้บ้างแล้ว แต่ถ้ายังไม่ได้ติดตั้งก็ลงมือได้

- **Windows** ไปดาวน์โหลดตัวติดตั้งได้จากหน้าเว็บของ Git เลย - [https://git-scm.com/downloads](https://git-scm.com/downloads) แล้วก็ next ยาวๆ จนเสร็จ
- **Mac** ก็ไปดาวน์โหลดที่หน้าเว็บได้เช่นกัน หรือถ้าใครมี Homebrew หรือ MacPorts ก็ลงผ่าน terminal ได้เลย `brew install git` หรือ `port install git` ก็ว่ากันไป
- **Linux** ตามแต่ distro ของท่านเลย - [https://git-scm.com/download/linux](https://git-scm.com/download/linux)

การใช้งานบน Windows ให้เปิดโปรแกรม Git Bash ขึ้นมา ส่วนบน Mac และ Linux ก็เปิด terminal ขึ้นมา เท่านี้ก็พร้อมลุยกันแล้ว

สิ่งที่ต้องทำต่อมาคือการระบุตัวตนโดยเราจะต้องใส่ชื่อกับอีเมล์ของเราให้ git จำไว้ เพื่อเวลาที่มีการแก้ไขจะได้รู้ว่าใครเป็นคนแก้ไข โดยอีเมล์แนะนำให้ใช้อันเดียวกับที่สมัคร Github ส่วนชื่อก็อะไรก็ได้ เหมือน username บน Github ก็ดี

{% highlight bash %}
$ git config --global user.name "Your Name"
$ git config --global user.email yourEmail@example.com
{% endhighlight %}

พูดถึง Github ถ้ายังไม่มีแอคเคาท์ก็ไปสมัครไว้ก่อนเลยนะ ที่นี่เลย [https://github.com/join](https://github.com/join)

## คำสั่งพื้นฐาน

### คำสั่ง CLI
ก่อนจะไปใช้คำสั่ง git คำสั่ง CLI ก็เป็นสิ่งที่ต้องรู้ด้วย ไม่งั้นเราจะไปต่อกันไม่ได้ ถ้าใครรู้แล้วก็ข้ามไปคำสั่ง git ได้เลย คำสั่งที่ต้องรู้คือ

- `pwd` (print working directory (dir)) ใช้เมื่ออยากรู้ว่าตอนนี้เราอยู่ที่ dir ไหน
- `cd` (change dir) เพื่อเปลี่ยนไปยัง dir อื่น
- `ls` (list) ดูว่าใน dir ที่เราอยู่มีไฟล์หรือโฟลเดอร์อะไรบ้าง
- `mkdir` (make dir) สร้างโฟลเดอร์ใหม่ขึ้นมา
- `touch` สร้างไฟล์ใหม่

เอ้า ตัวอย่างมา..
{% highlight bash %}
$ pwd
/Users/username
$ ls
Desktop    Documents    Downloads
$ cd Desktop
$ pwd
/Users/username/Desktop
$ cd ..
/Users/username
$ mkdir gitrepo
$ ls
Desktop    Documents    Downloads    gitrepo
$ cd gitrepo
$ touch readme.md
$ ls
readme.md
{% endhighlight %}

ก็ประมาณนี้ ตอนนี้เราก็ได้สร้างไฟล์ `readme.md` ไว้ในโฟลเดอร์ชื่อ `gitrepo` แล้ว อันนี้จำไว้ด้วยนะว่าอยู่ไหน ถ้ารู้สึกว่ายังไม่คุ้นเคยที่จะทำทุกอย่างผ่าน CLI ก็เปิดโฟลเดอร์ `gitrepo` ที่ได้สร้างไว้ขึ้นมาเลย

### คำส่ัง git
โดยพื้นฐานแล้ว git มีคำสั่งที่หลากหลายมากมายมหาศาลมาก แต่เราจะเริ่มกันด้วยคำสั่งเบื้องต้นที่ทำให้เราสามารถใช้งานได้ก่อนอันได้แก่

- `git init` ใช้สร้าง local repo ขึ้นมา
- `git add` ใช้ stage เพื่อติดตามตามความเปลี่ยนแปลงของไฟล์
- `git commit` ใช้เพื่อบันทึกความเปลี่ยนแปลงที่เกิดขึ้นสู่ local repo
- `git push` ใช้เพื่อส่ง commit ไปยัง remote repo
- `git clone` ใช้เพื่อคัดลอก repo จาก remote มายัง local
- `git fetch` ใช้ดึงความเปลี่ยนแปลงจาก remote มายัง local แต่ยังไม่รวมเข้าด้วยกัน
- `git merge` ใช้รวมความเปลี่ยนแปลงที่ได้มาจาก `fetch` เข้ากับ local
- `git pull` ใช้ดึงความเปลี่ยนแปลงจาก remote มายัง local และรวมเข้าด้วยกัน (มีค่าเท่ากับ `fetch`+`merge`)
- `git log` ใช้เพื่อดูว่า git repo มี commit อะไรแล้วบ้าง


## ทดลองกับของจริง
อะ รู้จักแล้วก็ไปกันต่อเลย ต่อไปเราจะสร้าง Github repo กัน ไปที่เว็บ [http://github.com](http://github.com)

<figure><center>
  <img src="/images/post/usegit/newrepo.png" data-action="zoom"/>
</center></figure>

พอล็อกอินเรียบร้อยเราก็จะอยู่ที่หน้าหลัก ดูข้างบนด้านขวากด **+** เลือก create new repository แล้วก็ตั้งชื่ออะไรก็ได้ เสร็จแล้วเราก็จะมาอยู่ในหน้า repo ที่พึ่งสร้างเมื่อกี้ ก็ให้ copy ชื่อ repo ไว้ โดยเลือกเป็นแบบ `https` ก่อน จากนั้น
ก็เปิด terminal ขึ้นมา แล้วเริ่มตามนี้เลย

#### init local repo & add remote repo
{% highlight bash %}
$ cd gitrepo
$ ls
readme.md

# create local git repo
$ git init
Initialized empty Git repository in /Users/username/gitrepo/.git/

# check whether there is remote repo or not
$ git remote -v

# add remote repo to this git repo
$ git remote add origin ******
$ git remote -v
origin  ****** (fetch)
origin  ****** (push)
{% endhighlight %}

#### check status
{% highlight bash %}
$ git status
On branch master

Initial commit

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        readme.md

nothing added to commit but untracked files present (use "git add" to track)
{% endhighlight %}

#### stage files & check status
{% highlight bash %}
# stages everything use .
$ git add .
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   readme.md
{% endhighlight %}

#### commit staged files
{% highlight bash %}
$ git commit -m "initial commit"
[master (root-commit) 4670b09] initial commit
1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 readme.md
{% endhighlight %}

#### check commits log
{% highlight bash %}
$ git log

# ตรงนี้จะเข้าหน้าใหม่ ใช้ลูกศรเพื่อนำทาง หรือกด q เพื่อออก
commit 4670b09ea1dc6b6bf4eafecc434e687204347ac5
Author: yourUsername <yourEmail@example.com>
Date:   Wed Dec 16 00:34:46 2015 +0900

    initial commit
(END)
{% endhighlight %}
