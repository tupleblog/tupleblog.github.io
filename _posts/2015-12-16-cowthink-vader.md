---
author: Titipata
layout: post
title: สตาร์วอร์บน Mac terminal
description: "เปลี่ยน terminal เป็นสไตล์สตาร์วอร์"
tags: [Atom, LaTeX, editor]
image:
  feature: starwars.jpg
comments: true
share: true
date: 2015-12-16 12:00:00
---

## เปลี่ยน terminal เป็นสไตล์สตาร์วอร์

พูดถึงสตาร์วอร์ Star Wars, the Force Awaken ที่กำลังจะเข้าฉายในเร็ววันนี้แล้ว สาวกสตาร์วอร์คงตั้งหน้าตั้งตารอดูอย่างใจจดใจจ่อ ทางดิสนีย์และลูคัสฟิล์มก็ออกของเล่นมามากมาย เช่น BB-8 droid
แต่ราคาก็เอาเรื่องอยู่ ประมาณ 150 เหรียญสหรัฐหรือห้าพันกว่าบาทเลย ส่วนผมในฐานะแฟนสตาร์วอร์งบน้อยแล้ว เรายังมีทางเลือกหลายทางเพื่อแสดงความเป็นสาวก วิธีแรกง่ายๆเลยคือเข้าเลือกฝั่งสตาร์วอร์บน Google: [https://www.google.com/starwars/](https://www.google.com/starwars/) แค่นี้ก็เปลี่ยน Google Maps และ Youtube เป็นธีมสตาร์วอร์ได้ แต่สำหนับคนที่ใช้ Mac terminal ก็มีวิธีทำให้ตัวเองเป็นสาวกสตาร์วอร์แบบกีคๆด้วยเช่นกัน ต้องขอบคุณตุลย์ (Tulakanr) ที่เผยแพร่ลัทธิมาให้

โอเค เราเริ่มต้นจากเปิด terminal (App > others > terminal) และโหลด package management system สำหรับ Mac OSX ซึ่งเราแนะนำให้ใช้ [Homebrew](http://brew.sh/) (จริงๆมีอีกมากมายให้เลือก เช่น MacPorts เป็นต้น) วิธีโหลด Homebrew นั้นก็ไม่ยากเลย แค่พิมพ์ตามข้างล่างนี้บน terminal

{% highlight bash %}
$ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ brew install cowsay
$ brew install fortune
{% endhighlight %}

โดย cowsay เราจะสามารถพิมพ์รูปวัวพูดหรือคิดบน terminal ได้ ส่วน fortune จะดึงวลีอย่างสุ่มขึ้นมา โดยเราสามารถเปลี่ยนรูปวัวเป็นรูปอื่นๆได้ ในที่นี้เราจะเปลี่ยนให้มันเป็ Cowth Vader (Darth Vader) โดยเราสามารถใส่ flag `-f vader` เข้าไป

{% highlight bash %}
$ fortune | cowthink -f vader
{% endhighlight %}

<figure><center>
  <img width="400" src="/images/cowth.jpg" data-action="zoom"/>
</center></figure>

จริงๆ ใครที่อยากได้รูปแบบอื่นๆ cowthink ก็ยังมีอีกหลายแบบให้เลือก ลองพิมพ์
{% highlight bash %}
$ cowsay -l
beavis.zen bong bud-frogs bunny cheese cower daemon default dragon
dragon-and-cow elephant elephant-in-snake eyes flaming-sheep ghostbusters
head-in hellokitty kiss kitty koala kosh luke-koala meow milk moofasa moose
mutilated ren satanic sheep skeleton small sodomized stegosaurus stimpy
supermilker surgery telebears three-eyes turkey turtle tux udder vader
vader-koala www
{% endhighlight %}

เท่านี้ เราแค่เอา `fortune | cowthink -f vader` ไปใส่ในไฟล์ `.bash_profile` ทุกครั้งที่เปิด terminal ก็จะมี Cowth Vader โผล่มาพร้อมกับประโยคแบบสุ่มแล้ว ยังไม่หมดเท่านั้น เรายังสามารถดูสตาร์วอร์ภาค 4 The New Hope ได้จาก terminal เช่นกัน ลองพิมพ์ตามข้างล่างบน terminal เพื่อดูสตาร์วอร์กัน

{% highlight bash %}
telnet towel.blinkenlights.nl
{% endhighlight %}

ลองเพียงแค่สองอย่างนี้ พลังก็จะสถิตอยู่กับท่านแล้วหล่ะ
