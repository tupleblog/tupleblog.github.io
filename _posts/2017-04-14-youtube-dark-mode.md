---
layout: post
title: Youtube Dark Mode
author: Titipata
description: enable your secret Youtube dark mode
image:
  feature: post/youtube-dark/darkmode.png
tags: [Data, Data Science, Python]
comments: true
date: 2017-04-14 21:45:00
read_time: 5
---

สำหรับโพสต์นี้ เราแปลบทความจาก [lifehacker](http://lifehacker.com/how-to-enable-youtubes-secret-dark-mode-in-chrome-1794327293)
(แปลมาตรงๆเลย)

เรื่องมีอยู่สั้นๆว่าเราสามารถเปลี่ยน Youtube ของเราให้เป็น Dark mode ได้ โดยวิธีทำก็ไม่ยากเลย


- เข้าไปที่ YouTube
- เปิดขึ้นมา developer menu ขึ้นมาโดยกด `Ctrl+Shift+I` บน Windows หรือ `Option+Command+I` บน Mac
(สำหรับคนที่ใช้ Chrome คลิ้กตามนี้ก็ได้ `View > Developer > Developer Tools`)
- พอเปิดขึ้นมาแล้วข้างขวา ให้เราใส่โค้ดลงไปดังนี้ `document.cookie="VISITOR_INFO1_LIVE=fPQ4jCL6EiE"` ใน console
- หลังจากนั้นปิด developer menu แล้วรีเฟรชเพจ (`Command+r` หรือ `Command+Shift+r` บน Mac)
- เมื่อรีเฟรชแล้วกดไปที่ icon ของเราจากนั้นเราจะเห็นบรรทัดใหม่ขึ้นมาว่า `Dark Mode: On/Off` เราก็เปลี่ยนเป็น `On`

<figure><center>
  <img width="300" src="/images/post/youtube-dark/user_darkmode_on.png" data-action="zoom"/>
</center></figure>

หน้าตาของ YouTube Dark Mode ค่อนข้างคูลเลยทีเดียว เหมาะสำหรับ developer หรือใครก็ตามที่ชอบหน้าจอดำ :)

<figure><center>
  <img width="auto" src="/images/post/youtube-dark/darkmode.png" data-action="zoom"/>
</center></figure>
