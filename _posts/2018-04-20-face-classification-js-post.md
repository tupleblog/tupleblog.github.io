---
author: Titipata
layout: post
title: "Face Classification on Web Browser using TensorFlow.js"
description: "เรานำ Artificial Intelligence (AI) มาตรวจจับอารมณ์และเพศของใบหน้าบนเว็บบราวเซอร์โดยใช้ TensorFlow.js"
tags: [Python, TensorFlow, TensorFlow.js, Face, Classification]
image:
  feature: post/face-classification/example.png
comments: true
share: true
date: 2018-04-20 22:30:00

---

สำหรับใครที่ไม่อยากอ่านโพสต์ เข้าไปลองกันเลยที่ [tupleblog.github.io/face-classification-js](https://tupleblog.github.io/face-classification-js/) ฮะ
(โมเดลมีขนาดประมาณ 1 MB ทั้งหมด 2 โมเดลนะ ใครที่ mobile data เหลือน้อยก็ระวังนิดนึงถ้าจะลองเล่นบนมือถือ)

<figure><center>
  <img width="500" src="/images/post/face-classification/interface.png" data-action="zoom"/>

  <figcaption>
    <a title="นายก">
      ลองเล่นกันได้ที่ <a href="https://tupleblog.github.io/face-classification-js/">https://tupleblog.github.io/face-classification-js/</a>
    </a>
  </figcaption>
</center></figure>


## เกริ่นนำ

เค้าว่ากันว่าใบหน้าของเราเนี่ยบ่งบอกอารมณ์ เวลาคนเรามองหน้ากันก็รู้เลยว่าอีกฝั่งนึงอารมณ์เป็นแบบไหน
ในเมื่อคนเราสามารถจับอารมณ์ของหน้าตาได้ AI ก็น่าจะทำได้เช่นกัน

เมื่อปีที่แล้วกลุ่มนักวิจัยจาก Sankt Augustin ประเทศเยอรมันและ University of Edinburg ประเทศอังกฤษได้
ตีพิมพ์[วารสาร](https://github.com/oarriaga/face_classification/blob/master/report.pdf) ซึ่งเค้าใช้ Deep Convolutional Neural Network ที่เทรนเพื่อจับอารมณ์และเพศจากหน้าตา ซึ่งแลปที่ทำเป็นกลุ่ม Robotics
ซึ่งเค้าอยากจะนำเทคนิคนี้ไปใช้กับหุ่นยนต์ที่ใช้ดูแลผู้สูงอายุในอนาคต

โดยวิธีการทำนั้น เค้าใช้ข้อมูลหลักๆสองอันคือ FER-2013 สำหรับเทรนโมเดลตรวจจับอารมณ์ และ IMDB สำหรับตรวจจับเพศ
ในบทความนี้เค้าจับความแม่นยำของระบบสำหรับตรวจจับเพศ ทำได้ถึง 96 เปอร์เซ็นต์เลยทีเดียว
ส่วนอารมณ์ได้ความแม่นยำประมาณ​ 66 เปอร์เซ็นต์ ผู้เขียนได้เปิดให้คนเข้ามาลองใช้โค้ด (open source) กันบน Github ที่
[oarriaga/face_classification](https://github.com/oarriaga/face_classification) ด้วย


## Face Classification using TensorFlow.js

ในบล็อกนี้ทางทีมงาน [`tubleblog`](https://tupleblog.github.io/) ได้ร่วมมือกับ
[@kittinan](https://github.com/kittinan) ผู้เคยได้รางวัล Bug Bounty จาก Facebook  
โดยเราอยากจะนำโมเดลตรวจจับอารมณ์และเพศจากใบหน้าใส่ขึ้นไปบนเว็บบราวเซอร์
เป้าหมายคือเราอยากทำให้คนสามารถลองเล่นโมเดลบนบราวเซอร์ได้ง่ายๆฮะ

เรานำข้อมูลสำหรับเทรนโมเดลอันเดียวกับที่วารสารใช้ แต่ว่าเปลี่ยนหน้าตาของ network โดยนำ
[MobileNet](https://research.googleblog.com/2017/06/mobilenets-open-source-models-for.html)
ที่ Google เปิดเป็น open source เมื่อปีที่แล้วมาใช้แทน หลังจากเทรนโมเดลเสร็จเรียบร้อยก็แปลงโมเดลที่ได้
โดยใช้ `TensorFlow.js` เพื่อให้เราสามารถโหลดเอาไปใช้งานบนเว็บบราวเซอร์ได้

สำหรับอัลกอริทึม Face detection พวกเราใช้ [`tracking.js`](https://trackingjs.com/)
ที่มีคนเขียนไว้เรียบร้อยเพื่อตรวจจับใบหน้าในภาพ
แล้วจากนั้นเราก็นำภาพที่ได้ไปให้โมเดลทำนายว่าอารมณ์ของคนนั้นเป็นอย่างไรและเป็นเพศอะไร
ถ้าใครอยากดูว่าโปรแกรมหน้าตาเป็นอย่างไรนั้น พวกเราได้ใส่โค้ดเกือบทั้งหมดไว้บน Github ฮะ
ตามไปดูกันได้[ที่นี่](https://github.com/tupleblog/face-classification-js)


### ทดลองใช้งานกับภาพลุงตู่และ ดร. สมคิด

เราลองโหลดภาพของท่านนายกรัฐมนตรีและรองนายกรัฐมนตรีจากเว็บไซต์ข่าวแล้วลองอัพโหลดดูว่าผลจะเป็นยังไง

<figure><center>
  <img width="500" src="/images/post/face-classification/example.png" data-action="zoom"/>

  <figcaption>
    <a title="นายก">
      ทดลองใช้ tupleblog.github.io/face-classification-js กับภาพของท่านนายกรัฐมนตรี (ที่มาจาก www.prachachat.net)
    </a>
  </figcaption>
</center></figure>

สำหรับภาพนี้ท่านนายกเศร้า 50 เปอร์เซ็นต์และโกรธ​ 50 เปอร์เซ็นฮะ

<figure><center>
  <img width="500" src="/images/post/face-classification/example-2.png" data-action="zoom"/>

  <figcaption>
    <a title="นายก">
      ทดลองใช้ tupleblog.github.io/face-classification-js กับภาพของท่านรองนายกรัฐมนตรี (ที่มาจาก naewna.com)
    </a>
  </figcaption>
</center></figure>

ส่วนภาพของ ดร. สมคิด อารมณ์ดีครับ happy 70 เปอร์เซ็นต์


## ทำไมโมเดลยังไม่ดี?

แน่นอนว่าถ้าใครลองเล่นกันดูจะพบว่า บางทีเราจับอารมณ์และเพศได้ไม่ตรง
ปัญหานี่เป็นปัญหาที่เกิดขึ้นตอนเก็บข้อมูลสำหรับเทรนโมเดล
เนื่องจากข้อมูลที่เราใช้นั้นเป็นภาพหน้าตาของดาราและฝรั่งเป็นส่วนใหญ่
เมื่อเทรนแล้วมาใช้กับพวกเราคนไทยที่หน้าตาไม่เหมือนกับชาวต่างชาติจึงเกิดความผิดพลาดขึ้นนั่นเอง
(มักเรียกว่าโมเดลไม่ generalized หรือว่าโมเดลมี bias ฮะ สาเหตุเพราะมี bias ใน training data)

ส่วนใบหน้าที่ตรวจจับแล้วไม่เจอ สาเหตุนั้นเพราะว่าเราใช้เทคนิคการตรวจจับหน้าแบบง่ายมากๆโดยใช้ของ `tracking.js`
อาจจะต้องแก้โค้ดกันซักนิดถึงจะดีขึ้นครับ


## อารัมภบท

ในบล็อกนี้เราเทรนโมเดลมาตรวจจับอารมณ์กับเพศจากภาพกันโดยใช้ `MobileNet` และแปลงโมเดลให้เอาไปใช้
ได้บนเว็บบราวเซอร์โดยใช้ [`TensorFlow.js`](https://js.tensorflow.org/)
ความแม่นยำอาจจะไม่ดีนักและเราได้ถกเถียงว่าทำไมความแม่นยำถึงไม่ดีเท่าที่ควรนั่นก็เพราะว่าข้อมูลที่ใช้เป็นภาพหน้าฝรั่งเอาซะมาก ไม่ใช่คนไทย

**แล้วอยากจะทำอะไรต่อ?** สิ่งที่พวกเรากำลังทำตอนนี้ก็คือเอา face-classification
ไปใช้กับผู้สูงอายุครับ ตอนนี้เรากำลังพัฒนาเกมซึ่งวัดระดับความ happy จากใบหน้าให้คนแก่เอาไว้เล่นฮะ
ถ้าใครทำใบหน้าให้ happy ได้ยาวๆก็จะยิ่งได้คะแนนมากฮะ
พวกเราคิดว่าเกมนี้น่าจะเป็นประโยชน์ต่อผู้สูงอายุที่อาจจะเหงาๆและอยากหาอะไรทำครับ ใครอยากลองเล่นแบบ webcam ที่ยังไม่ใช่เกม
ไปลองเล่นกันได้ที่ [face-classification-js/webcam.html](https://tupleblog.github.io/face-classification-js/webcam.html)
(แนะนำให้ใช้คอมพิวเตอร์เพราะมือถืออาจจะช้าหน่อย)

ทิ้งทายอีกทีสำหรับใครที่อยากเข้าไปดูโค้ด พวกเราจะอัพเดทโค้ดเรื่อยๆที่ [/github.com/tupleblog/face-classification-js](https://github.com/tupleblog/face-classification-js)
ถ้าชอบก็อย่าลืมกด star กันได้เลย :)
