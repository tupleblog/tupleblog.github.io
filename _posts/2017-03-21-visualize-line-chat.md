---
layout: post
title: ลองเอา LINE chat มาวิเคราะห์
author: Titipata
description: คนเหงาและว่างเลยลองเขียนโค้ดเพื่อวิเคราะห์ไลน์แชท
image:
  feature:
tags: [Data, Data Science, Python]
comments: true
date: 2017-03-21 13:45:00
---

เรื่องของเรื่องมีอยู่ว่าเราชอบแชทกับสาวๆบน LINE chat (ไลน์) จริงๆสำหรับเราตอนนี้ก็มีคนเดียวนั่นแหละ แต่เวลาคุยกับสาวทีไรเพื่อนสนิท
ซึ่งก็ไม่ใช่ใครที่ไหน [@bluenex](https://github.com/bluenex) นี่เองแหละ จะชอบถามไถ่ว่าคุยไปถึงไหนแล้ว
คุยอะไรไปบ้าง ไหนเราจะโดนสาวเทแบบคนก่อนๆรึเปล่า หรือทักเค้าไปฝ่ายเดียวรึเปล่า

ปกติคนส่วนมากก็คงจะแคปหน้าจอแขทไปให้ดู แต่แค่แคปหน้าจอไปให้ [@bluenex](https://github.com/bluenex) อย่างเดียวมันก็ชอบจะหาว่าเราเอาแต่ส่วนที่
เค้าตอบดีๆมาให้ดู มันไม่ค่อยจะยอมเชื่อซะเท่าไหร่ แต่ถ้าจะส่งทั้ง chat log ไปให้ก็ไม่โอเค เขินน่ะ สุดท้ายเลยมันบอกไปว่า เดี๋ยวส่งสรุปไปให้ดูละกัน

นั่นแหละครับ เรื่องมันก็เริ่มขึ้นประมาณนี้ เหตุเกิดในเวลาเที่ยงคืนวันจันทร์ เราเลยกดโหลด chat log จากไลน์แชทมา และเริ่มวิเคราะห์แชทโดยใช้ Python

ในบล็อกนี้เราจะมาพูดถึงกระบวนการณ์คร่าวๆที่เราใช้เพื่อวิเคระห์ไลน์แชทกัน จริงๆแล้วเราเอาแชทมาพลอตอะไรได้เยอะแยะเลยนะ
วันนี้จะมาลองพลอตอะไรง่ายๆกัน

โค้ดทั้งหมด host อยู่บน Github ที่ [titipata/visualize_line_chat](https://github.com/titipata/visualize_line_chat)
ไปลองติดตาม หรือโคลนมาลองใช้กับแชทตัวเองก็ได้

### หน้าตาของ Line text file

```
2017.03.10 Friday
07:38 user1 hello
08:06 user2 hi, how are you?
08:37 user1 i'm doing great, i'm going to get Thai food tonight.
08:38 user1 and go to the gym later :)
08:40 user2 aww, have fun. send me some photos
2017.03.11 Saturday
01:39 user2 aww, i just got ramen today
01:39 user1 did you like it!?
07:54 user2 hahahahahah yupp
```

หน้าตาของแชทที่โหลดมาก็เป็นประมาณข้างบน จากไฟล์ข้างบน เราสามารณ library ของ Python ที่ชื่อ `csv` เพื่อแปลง text file
เป็น list ได้

```python
lines = csv.reader(open(file_name))
chats = list(lines)
chats = [c[0] for c in chats if len(c) > 0]
...
```

list ท้ายสุดที่เราได้มีหน้าตาประมาณนี้

```
[[2017.03.10, 07:38 user1 hello],
 [2017.03.10, 08:06 user2 hi, how are you?],
 [2017.03.10, 08:37 user1 i'm doing great, i'm going to get Thai food tonight.],
  ...
 [2017.03.11, 01:39 user2 aww, i just got ramen today],
 [2017.03.11, 01:39 user1 did you like it!?],
 [2017.03.11, 07:54 user2 hahahahahah yupp],
  ...
```

หน้าที่แรกของเราคือแค่ loop ไปแต่ละบรรทัด แล้วเอาวันที่มาใส่ข้างหน้าแชทแต่ละอัน
ที่เราทำนี้ก็เพื่อว่าในตอนท้ายเราจะสามารถใช้ฟังค์ชันชื่อ `groupby` จาก library
ชื่อว่า `itertools` เพื่อใช้จัดกลุ่มข้อมูลของเราที่มีวันที่เดียวกันเข้าด้วยกันได้ตาม key ซึ่งในที่นี้
ก็คือวันที่นี่เอง

หน้าตาของ code ของ `groupby` เป็นประมาณด้านล่าง

```python
from itertools import groupby

group_chats = []
for key, group in groupby(chats, lambda x: x[0]):
    group_chats.append({'date': key, 'chats': [g[1] for g in group]})
```

หลังจากนั้น เราแค่นับจำนวนและพล็อตจำนวนของ chat ในแต่ละวัน เพียงใช้คำสั่งที่ชื่อว่า `len`

```python
chats_per_day = []
for group_chat in group_chats:
    dt = parser.parse(group_chat['date'])
    chats_per_day.append([dt, len(group_chat['chats'])])
```

สำหรับใครที่โหลดสคริปมาจาก Github [titipata/visualize_line_chat](https://github.com/titipata/visualize_line_chat)
ก็สามารถใช้ฟังค์ชันตามด้านล่างได้เลย เราเขียนฟังค์ชัน `plot_chat_per_day` ไว้ใน `line_utils.py`

```python
import line_utils
chats = line_utils.read_line_chat('path/to/chat_history.txt')
line_utils.plot_chat_per_day(chats_dict)
```

พอพล็อตออกมา จำนวนแชทที่เราแชทกันในแต่ละวันหน้าตาประมาณนี้

<figure><center>
  <img width="auto" src="/images/post/line/total_activities.png" data-action="zoom"/>
</center></figure>

## เรากับเธอใครแชทเยอะกว่ากัน?

เวลาเราแชทกับคนคนนึง บางทีเราคิดว่าเค้าแชทมาเยอะกว่า หรือบางทีเราก็แชทไปเยอะกว่า
แต่เราไม่รู้หรอกว่าจำนวนที่เราแชทไปหรือเค้าแชทมามันต่างกันมากขนาดไหน ถ้าสมมติเราแชทกับใครซักคน
ถ้าแชทไปในปริมาณที่เท่าๆกันก็น่าจะดี ไหนเรามาลองดูกันว่าปริมาณแชทของเราสองคนเป็นยังไงบ้าง

เทคนิกที่ใช้ก็คล้ายๆเดิม เพียงแต่ตอนนี้เราต้องจัดกลุ่มทั้งวันที่และชื่อผู้ใช้งาน จากนั้นเราต้องนับจำนวนของแชทในแต่ละกลุ่ม

ก่อนอื่นเราจะต้องแยกแชทที่มี เช่น `'01:39 user2 aww, i just got ramen today'` ให้เป็น dictionary
ดังต่อไปนี้

```python
{'time': "01:39", 'user': "user2", 'text': "aww, i just got ramen today"}
```

พอเราได้ dictionary ของ python แล้ว ใช้เทคนิกเดิมตามข้างต้นเพื่อจัดกลุ่มวันที่และชื่อผู้ใช้งานเข้าด้วยกัน
เราสามารถใช้คำสั่งเดิมคือ `groupby` แต่ว่าใส่ key เข้าไปเป็น `date` และ `user` แทน

```python
grouper = itemgetter("date", "user")
chats_per_day = []
for key, group in groupby(sorted(chat_users, key=grouper), grouper):
    temp_dict = dict(zip(["date", "user"], key))
    temp_dict["n_chat"] = len([item for item in group])
    chats_per_day.append(temp_dict)
```

สำหรับใครที่โหลดสคริปมาก็แค่พิมพ์ตามนี้เลย

```python
import line_utils
chats = line_utils.read_line_chat('path/to/chat_history.txt')
line_utils.plot_chat_users_per_day(chats)
```

<figure><center>
  <img width="auto" src="/images/post/line/user_activities.png" data-action="zoom"/>
</center></figure>

สีฟ้าคือจำนวนแชทของผม ส่วนสีชมพูคือจำนวนแชทของเธอ เรากับเธอแชทไปมาพอๆกันเลยนะ
ไม่รู้ว่าดีหรือไม่ดี สำหรับเราคิดว่าดีนะเพราะเราไม่ได้คุยไปฝ่ายเดียว :)

## เราแชทกันเวลาไหนมั่ง

นอกจากแต่ละวันที่แชทแล้ว เราก็อยากจะรู้บ้างว่า ส่วนมากที่เราแชทกันช่วงไหนนะ ส่วนมากเราแชทกันวันธรรมดา
หรือว่าวันหยุด วันศุกร์เราแชทกันเยอะมั้ย?​

เราเริ้มด้วยลิสต์ของแชทที่มี เช่น `'01:39 user2 aww, i just got ramen today'` ตามเคย
จากนั้นก็แบ่งมันออกเป็น dictionary ตามนี้

```python
{'time': "01:39", 'user': "user2", 'text': "aww, i just got ramen today"}
```

เมื่อเราได้ dictionary มาแล้ว สิ่งที่ต้องทำต่อก็คือการแบบช่วงเวลาเป็นหลายๆช่วงเช่น เก้าโมงถึงเที่ยงวัน เป็นหนึ่งช่วง
เที่ยงวันถึงบ่ายสามโมงเป็นอีกช่วงนึง จริงๆแล้วเราก็ตั้งเป็นแค่ตัวเลข 0, 1, ..., 7 ถ้าเราแบ่ง 24 ชั่วโมงเป็น 8 ช่วง

ส่วนวันนั้น ใน Python เราสามารถใช้ library ที่ชื่อ `datetime` และ `dateutil` ในการแปลงวันเป็นวันอาทิตย์ถึงวันเสาร์ได้
โค้ดสำหรับการแปลงวันที่เป็นวันในสัปดาห์หน้าตาเป็นตามด้านล่าง

```python
from dateutil import parser
def day_of_week(day, n_bin=8):
    return parser.parse(day).weekday()
```

จากนั้นเราสามารถจัดกลุ่มวันและช่วงเวลาของวันเข้าด้วยกันแล้วนับจำนวนแชทได้เลย
เราเขียน script ใน `line_utils.py` ไว้ชื่อว่า `plot_punch_card_activities`

```python
import line_utils
chats = line_utils.read_line_chat('path/to/chat_history.txt')
line_utils.plot_punch_card_activities(chats)
```

พอพล็อตออกมาจะได้หน้าตาประมาณนี้

<figure><center>
  <img width="auto" src="/images/post/line/punch_card.png" data-action="zoom"/>
</center></figure>

ส่วนมากเราคุยกันประมาณช่วงเช้ากับช่วงเย็นของวันที่อเมริกา (เวลาของเราเอง) ก็ประมาณช่วงค่ำๆที่ไทยกับช่วงเช้าๆ
ที่เหลือก็ปล่อยให้เวลากับตัวเองมั่งเนอะ อิอิ


## สรุป

ในโพสต์นี้ เราได้ดาวน์โหลดแชทจากไลน์มา และใช้ Python ลองสรุปข้อมูลที่เราได้จากแชทดังต่อไปนี้

- จำนวนแชทที่แชทกันไปต่อวัน
- จำนวนแชทของแต่ละคนต่อวัน
- แชทกันส่วนมากที่เวลาไหนของวันบ้าง

ใครที่สนใจดูโค้ดเต็มๆก็ไปอ่านกันต่อได้ที่ [titipata/visualize_line_chat](https://github.com/titipata/visualize_line_chat)
ส่วนถ้าใครมีคำถามหรือมีไอเดียอยากจะพล็อตอะไรอย่างอื่น ก็ส่งข้อความมาบอกกันหรือพิมพ์ไว้ด้านล่างได้
ไว้ว่างๆเราจะมาลองนั่งเขียน Python เล่นดู :)
