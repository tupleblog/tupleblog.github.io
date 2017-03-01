---
layout: post
title: Hands-on Tensorflow
author: Titipata
description: "ลองใช้ tensorflow open-source library น้องใหม่จาก Google"
image:
  feature: post/tensorflow/blogimg-tensorflow.jpg
  credit: wired.com
  creditlink: http://www.wired.com/wp-content/uploads/2015/11/google-tensor-flow-logo-F-1200x630.jpg
tags: [Machine Learning, Tensorflow, Google]
comments: true
---

## Hands-on Tensorflow

เมื่อไม่นานมานี้ Google พึ่งออก Open-Source Library สำหรับ Machine Learning ในนาม [TensorFlow](https://www.tensorflow.org/) ออกมาเปิดให้ทุกคนโหลดมาใช้กันจาก Github ได้อย่างไม่ยาก library นี้เขียนให้ออกมาใช้งานได้กับภาษาโปรแกรมมิ่งที่ตอนนี่เรียกได้ว่าใช้กันอย่างแพร่หลายในวงการวิจัยนั่นก็คือ Python นั่นเอง แถมการ install ก็ง่ายดาย แค่บรรทัดเดียวก็ได้ TensorFlow มาใช้กันบน Python แล้ว ลองไปดูวีดีโอแนะนำจาก Google เลยดีกว่า (สำหรับชาว Geek ดูแล้วอาจจะต้องยิ้มเพราะ Jeff Dean จาก Google ที่คิด page rank algorithm อยู่ในวีดีโอซะด้วยนะ)

<iframe width="560" height="315" src="https://www.youtube.com/embed/oZikw5k_2FM" frameborder="0"> </iframe>

มาพูดถึงภาพรวมของ TensorFlow ดีกว่า หลังจากที่เราลองโหลดมาใช้งานนั้น ข้อดีและจุดเด่นของ TensorFlow คือเราสามารถเขียน Neural Network ได้ง่ายมากๆ เมื่อเทียบกับ Neural Network หรือ Deep Learning library อื่นๆ ใน Python เช่น [Theano](http://deeplearning.net/software/theano/) หรือ
[Caffe](http://caffe.berkeleyvision.org/) นอกจากนั้น flow ในการเขียนโค้ดค่อนข้างเข้าใจง่าย และอ่านง่ายมากๆ แถม TensorFlow ยังมากับ Tensor Board ที่เราสามารถดูได้ว่าตอนนี้ข้อมูลของเรา flow ไปยังจุดไหนของ Neural Network หรือ Deep Learning บ้าง ลดระยะเวลาทำความเข้าใจโครงสร้างของ Neural Network ไปได้อย่างมาก เราคิดว่าทั้งสองข้อนี้ซึ่งถือเป็นจุดเด่นของ library เลยก็ว่าได้ ลองดูภาพเพิ่มเติมด้านล่าง

<figure><center>
  <img src="http://1.bp.blogspot.com/-vDKYuCD8Gyg/Vj0B3BEQfXI/AAAAAAAAAyA/9tWmYUOxo0g/s1600/cifar10_2.gif" data-action="zoom"/>
</center></figure>

ส่่วนข้อเสียของ library ก็ยังมีอีกหลายอย่างที่ต้องใช้เวลากว่าจะเข้าที่เข้าทาง ได้แก่ documentation เป็นต้น ตอนนี้ documentation ยังไม่สมบูรณ์อย่างมาก คนที่อยากจะใช้ TensorFlow เพื่อสร้างโมเดลที่ซับซ้อนขึ้น ตอนนี้อาจจะต้องเข้าไปอ่านโค้ดโดยตรงจาก Github เป็นหลัก นอกจากนั้นเรื่องของเวลาที่ใช้ในการเรียนรู้โมเดลหรือ training time ก็ยังไม่ดีมากนักเมื่อเทียบกับ library อื่นๆ ถึงแม้ว่าจะเขียนโมเดลได้เร็วแต่อาจจะต้องใช้เวลาในการฝึกโมเดลมากกว่านั่นเอง


โอเค พูดถึงรายละเอียดเบื้องต้นแล้ว เราต้องมาลองหนึ่งในแอพพลิเคชั่นสนุกๆ ของ Deep Learning ที่เขียนจาก TensorFlow เราจะมาลองให้คอมพิวเตอร์เห็นตัวหนังสือเยอะๆๆ และให้มันทำนายตัวอักษรถัดไป เผื่อวันข้างหน้า เราจะได้ไม่ต้องเขียนเอง แต่ให้คอมพิวเตอร์เขียนให้แทน อิอิ โค้ดเพิ่มเติมสามารถลองได้จาก [char-rnn-tensorflow](https://github.com/sherjilozair/char-rnn-tensorflow) อธิบายอย่างง่ายๆ คือเราสร้าง Neural network แล้วใส่ลิสต์ของตัวอักษรเข้าไป เช่นคำว่า `hello` คอมพิวเตอร์ก็จะเห็นแค่เพียง `h > e`, `e > l`, `l > l`, `l > o` เป็นต้น และเมื่อเราใส่ตัวอักษรเข้าไปมากๆ เช่นใส่ตัวอักษรของหนังสือทั้งเล่มเข้าไป หรือใส่ตัวอักษรจากบทกวีเข้าไป โมเดลก็เริ่มที่จะปะติดปะต่อตัวอักษรเข้าด้วยกันและเริ่มเขียนได้เองนั่นเอง

ตัวอย่างข้างล่าง เราได้ใส่ตัวอักษรทั้งหมดจากบทเขียนของ William Shakespeare เข้าไปในโมเดลที่สร้าง TensorFlow ด้านล่างคือคือบทกวีที่กลั่นออกมาจาก TensorFlow ล้วนๆ ไม่ได้ปรุงแต่ง ลองดูกันว่ามันเสมือนจริงขนาดไหน (อ่านเพิ่มเติมจาก [The Unreasonable Effectiveness of Recurrent Neural Networks](http://karpathy.github.io/2015/05/21/rnn-effectiveness/))

> That though did tells and hunger a happides: here's
blest his queen appare; wants, sir, three person's man;'
And these fortunes but both the scelling thempour.
<br>
<b>PETRUCHIO</b>: Well, any that, that? This given it, thou sprite
Is tize in the dust not precious chattes.
I would the wearin

> <b>Servant</b>: Out dispairoof, till this fount from the tear,
He deep of noble desires for my own.
<br>
<b>ARIEL</b>: No mouth of a hallers, to rateld me fairers!
<br>
<b>Third Citizen</b>: How have sounden commance is almost sailor,
With thou lift.

จะเห็นได้ว่าตัวอักษรที่กลั่นออกมามีความเป็นบทกวีมากๆ ถึงแม้ว่าจะไม่มีเนื้อหาชัดเจนก็ตาม

ช่วงทิ้งท้ายนี้ เราคิดว่ายังมีแอพพลิเคชั่นอีกมากมายท่ีสามารถนำ TensorFlow มาใช้งาน จากตัวอย่างข้างบน เราอาจจะไม่ต้องเขียนเก่งอย่างนิ้วกลมหรือ ทรงกลด บางยี่ขัน ในอนาคตเราอาจเพียงใส่ตัวหนังสือจากหนังสือทั้งหมดจากทั้งสองนักเขียน แล้วคอมพิวเตอร์อาจจะมีทักษะการเขียนเท่าๆ กับรุ่นใหญ่ทั้งสองก็ได้ :)

ถ้าใครสนใจงานวิจัยทางด้านนี้ภาควิชาวิศวกรรมศาสตร์ไฟฟ้าและคอมพิวเตอร์ที่จุฬาฯ ก็มีอาจารย์เก่งๆ หลายท่านที่น้องๆ หรือเพื่อนๆ สามารถสอบถามข้อมูลเพิ่มเติมได้
