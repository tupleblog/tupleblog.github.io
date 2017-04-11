---
layout: post
title: สอนเขียน visualization ของคุณวิภาวี จากโพสต์ของ the Momentum
author: Titipata
description: visualization ไม่ยากอย่างที่คิด
image:
  feature:
tags: [Data, Data Science, Python]
comments: true
date: 2017-04-08 21:45:00
read_time: 25
---

เพิ่งเห็นโพสต์ของคุณวิภาวีออกมาเมื่อวาน ว่าด้วยเค้าเอาไลน์แชทมาพล็อตเทียบระหว่าง 4 เดือนแรกตอนเริ่มคบกัน กับ 4 เดือนก่อนที่จะเลิกกัน

คุณวิภ (ไม่ได้รู้จักเป็นการส่วนตัวนะ) ได้เขียนโค้ดไว้บน Github ด้วยที่ [wipaweeeeee/callMeAdele](https://github.com/wipaweeeeee/callMeAdele)

สืบเนื่องจาก [blog ที่แล้วของเรา](http://tupleblog.github.io/visualize-line-chat/)ว่าด้วยการวิเคราะห์​ LINE แชทเช่นกัน เราจะมาลองใช้ [`rune.js`](http://runemadsen.github.io/rune.js/index.html) ที่คุณวิภใช้ มาพล็อตไลน์แชทของตัวเองบ้าง

เราจะลองพล็อตงานของคุณวิภกัน แต่ลองแค่งานเดียวพอนะ เค้าให้ชื่อชิ้นงานว่า `ramble`

## โหลดแชทเช่นเคย

เริ่มด้วยเราโหลดไลน์แชทมาก่อนเช่นเดิม จากนั้นเราพึ่งตัวช่วย Python ฟังก์ชันที่เราเขียนไว้ใน [titipata/visualize_line_chat](https://github.com/titipata/visualize_line_chat) ซะหน่อย

หน้าที่ของพวกเราคือการนับจำนวนตัวอักษรที่พิมพ์ไปในแต่ละแชทของแต่ละคนเท่านั้น
เราจะเปลี่ยนหน้าตาแชทตามข้างล่าง

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

ให้เป็นไฟล์สกุล `json` หน้าตาประมาณนี้

```py
[{"user_id":0,"chat_length":2,"char_length":11},
 {"user_id":0,"chat_length":6,"char_length":33},
 ...
]
```

เทคนิกของเราก็คล้ายๆเดิม เราต้องแยก user ออกมาจากแชทก่อน จากนั้นก็นับจำนวนตัวอักษรในแต่ละแชท
โค้ด Python หน้าตาประมาณนี้หล่ะ

```py
import line_utils
import pandas as pd
chats = line_utils.read_line_chat('line_chat.txt') # อ่านไลน์แชท แล้วเก็บไว้เป็น python dictionary
users = line_utils.get_users(chats) # เก็บชื่อผู้ใช้งานออกมา
chats_split = [line_utils.split_chat(chat, users) for d, chat in chats['chats']] # แยกแชทออกมาเป็น (time, user, text)
users_dict = dict(zip(users, [0, 1]))
line_chat_tuple = [(users_dict.get(user), len(text)) for (time, user, text) in chats_split if users_dict.get(user) is not None]
```

หลังจากนั้นก็ใช้ `pandas` ไลบรารี่ในการเอาเปลี่ยน chat เป็นสกุล `json` แบบที่คุณวิภใช้ได้ละ
เขียนแค่อีก 2 บรรทัดเท่านั้น

```py
line_df = pd.DataFrame(line_chat_tuple, columns=['user_id', 'char_length'])
line_df[['user_id', 'char_length']].to_json('example.json', orient='records')
```

เอาไฟล์นี้อัพโหลดไปที่ไหนก็ได้ เราอัพโหลดไปบน `gist.github.com` แล้วเก็บลิงค์​ของ raw json file
มา

## พล็อตโดยใช้ rune.js

โอเค หลังจากที่เราอัพโหลด json ไฟล์ไปซักที่่แล้ว ถึงเวลาที่จะมาพล็อตกันโดยใช้ `rune.js` ซึ่งเป็น
javascript library ใช้สำหรับพล็อตโดยเฉพาะ เราต้องสร้างโฟล์เดอร์ที่ประกอบด้วยไฟล์​ดังต่อไปนี้

- `rune.js` ซึ่งดาวน์โหลดได้จาก [runemadsen/rune.js/releases/](https://github.com/runemadsen/rune.js/releases/tag/0.4.5)
- `index.html`
- `sketch.js`

สองไฟล์หลังนั้นคุณวิภได้เขียนไว้ให้แล้วที่ [wipaweeeeee/callMeAdele](https://github.com/wipaweeeeee/callMeAdele) เราได้จัดไฟล์ไว้ให้ด้วย
 สามารถเข้าไปดูใน
[titipata/visualize_line_chat/tree/master/runejs_example](https://github.com/titipata/visualize_line_chat/tree/master/runejs_example) ได้นะ

หน้าตาของ `index.html` เป็นดังต่อไปนี้

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>ramble</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script type="text/javascript" src="rune.js"></script>
  <style type="text/css">
    body {
      background-color: white;
    }
    #canvas svg {
      background-color: white;   
      display: block;
      margin: auto;   
    }
    #canvas {
      background-color: white;
      display: flex;
      justify-content: center;
      height: 100vh;
    }
  </style>
</head>
<body>
  <div id="canvas"></div>
  <canvas id="blankcanvas" style="display: none"></canvas>
  <script type="text/javascript" src="sketch.js"></script>
</body>
</html>
```

ส่วนหน้าตาของ `sketch.js` นั้นเป็นดังต่อไปนี้ แต่เราต้องเปลี่ยน `url: ` เป็นลิงค์ไปที่ไฟล์ `json` ที่เราอัพโหลดไว้แทนนะ (อีกทีนึง เราอัพโหลดไปที่ `gist.github.com` แต่จะอัพกันไปที่ไหนก็ได้ตามสะดวก)

```javascript
var r = new Rune({
  container: "#canvas",
  width: 380,
  height: 380,
  debug: false,
});

$.ajax({
  type: 'GET',
  url: "https://gist.githubusercontent.com/titipata/9a5ff79c53dedd36368388a72bd72db7/raw/3fa3048b830365d468c04a3e321770c2de9684a5/example.json",
  dataType: 'json',
  success: function(result){
  var x = 0;
  var y = 0;
  var xt = 0;
  var yt = 0;
  for( var i = 0; i < result.length; i++ ) {
    if ( result[i].chat_length.length != 0 ) {
      if( result[i].user_id == 1 ) {
        r.rect(x, y, 2, result[i].char_length)
         .stroke(false)
         .fill(180)

      if( y > r.height ) {
        x += 3;
        y = 0;
        r.rect(x, y, 2, result[i].char_length)
         .stroke(false)
         .fill(180)
        }
      }

      if(result[i].user_id == 0) {
        r.rect(xt, yt, 2, result[i].char_length)
         .stroke(false)
         .fill(0)

        if( yt > r.height) {
          xt += 3;
          yt = 0;
          r.rect(xt, yt, 2, result[i].char_length)
           .stroke(false)
           .fill(0)
        }
      }
      y += result[i].char_length;
      yt += result[i].char_length;
    }
  }
  r.draw();
  }
});
```

## ชิ้นงาน

พอเปิด `index.html` ขึ้นมาก็จะได้งานแบบที่คุณวิภทำละ ไม่ยากอย่่างที่คิดเลยนะเนี่ย

<figure><center>
  <img width="auto" src="/images/post/line/ramble_plot.png" data-action="zoom"/>
</center></figure>

แต่เรายังไม่ได้เลิกนะ (เพราะยังไม่มีแฟน) ก็เลยยังไม่มีพล็อต 4 เดือนก่อนเลิก ฮ่าๆ

ใครว่างๆก็ไปลองเล่นกันได้นะ :)
