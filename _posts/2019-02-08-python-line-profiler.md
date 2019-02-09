---
author: kittinan
layout: post
title: "[Python] profiler ด้วย line_profiler"
description: "internet"
tags: [python, line_profiler]
image:
  feature: /post/line_profiler/kernprof.png
comments: true
share: true
date: 2019-02-08 22:30:00
---

## เกริ่นนำ
ในการเขียนโปรแกรมนอกจากความถูกต้องในการทำงานของโปรแกรมแล้ว เราต้องการโปรแกรมที่ทำงานได้รวดเร็ว แต่บางทีเราก็ไม่รู้ว่าจะต้อง Optimize โปรแกรมกันตรงไหน วันนี้ผมจึงมาแนะนำการใช้งาน [line_profiler](https://github.com/rkern/line_profiler) เพื่อทำ profiler ในการตรวจสอบความเร็วในการทำงานของโค้ด Python ในแต่ละบรรทัดกันเลย


## ติดตั้ง
ติดตั้ง Package ผ่าน pip กันตามปกติ

```bash
pip install line_profiler
```

### แบบ Annotation

เพียงแค่เพิ่ม annotation  @profile ไว้ก่อนฟังชั่นที่ต้องการตรวจสอบประสิทธิภาพเท่านั้น

```python
import time

@profile
def number():
	s = 0
	for i in range(500):
		s += i
	time.sleep(1)
	return s

print(number())
```

จากโค้ดด้านบนผมได้เซฟไฟล์ไว้ชื่อ test.py และทำการรันด้วยคำสั่ง

```bash
kernprof -l test.py
```

ก็จะมีไฟล์ test.py.lprof ปรากฎขึ้นมา เราก็แสดงผลด้วยคำสั่ง

```bash
python -m line_profiler  test.py.lprof
```

<figure><center>
  <img src="/images/post/line_profiler/kernprof.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      ผลลัพธ์ที่ได้
    </a>
  </figcaption>
</center></figure>

### วิธีการดูผลลัพท์

- Hit - จำนวนครั้งที่บรรทัดนี้ถูกทำงาน 
- Time - เวลาที่ใช้ในการทำงาน หน่วยเป็น Microsecond 
- Per Hit - เวลาเฉลี่ยเมื่อบรรทัดนี้ถูกทำงาน หน่วยเป็น Microsecond 
- % Time - สัดส่วนเวลาทั้งหมดที่ใช้คิดเป็น %

จากตัวอย่างด้านบนก็จะเห็นว่าช้าที่สุดนั้นอยู่ตรงบรรทัดที่ sleep ไป 1 วินาที

### Jupyter Notebook ก็ใช้ได้

หากใครใช้งาน Jupyter notebook ก็สามารถใช้ line_profiler ได้เหมือนกัน เพียงแค่โหลด extension line_profiler ขึ้นมาด้วยคำสั่ง

```python
%load_ext line_profiler
```

หากต้องการตรวจสอบประสิทธิภาพของ function ก็แค่รัน function นั้นใน format นี้

```python
%lprun -f [function name] [call function]

#Example
%lprun -f number number()
```

<figure><center>
  <img src="/images/post/line_profiler/notebook_prof.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      ตัวอย่างการใช้งาน line_profiler บน Google Colab
    </a>
  </figcaption>
</center></figure>

เมื่อเรารันคำสั่งก็จะมี popup เด้งขึ้นมาแสดงผลข้อมูลของแต่ละบรรทัด

## สุดท้าย
[line_profiler](https://github.com/rkern/line_profiler) สามารถทำ profiler โค้ดเราในแต่ละบรรทัดได้ง่ายมาก จึงหวังว่าจะเป็นประโยชน์แก่ทุกท่าน