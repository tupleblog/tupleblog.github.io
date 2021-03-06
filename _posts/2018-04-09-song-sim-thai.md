---
author: Titipata
layout: post
title: "Analysis of Thai pop songs' lyrics"
description: "วิเคราะห์เนื้อเพลงไทยจาก 12,000 เพลง จากกว่า 2,800 ศิลปิน"
tags: [Python, Songs, Data, Code, Deepcut, Siam]
image:
  feature: post/songsim/atom_songsim.png
comments: true
share: true
date: 2018-04-09 22:30:00

---

# เกริ่นนำ

คือเราไปอ่านบล็อกโพสต์ที่ดังมากในปลายปีที่ผ่านมาจาก [Vox](https://www.vox.com/videos/2017/10/13/16469744/repetition-in-music)
ซึ่งเค้าใช้เทคนิคพล็อตเข้ามาช่วยในการดูลักษณะของเพลง และนอกจากนั้นก็เอามาวิเคราะห์ว่าเพลงในปัจจุบันมีการใช้คำซ้ำกันมากขึ้นขนาดไหน

โดยสรุปคือว่าเพลงฮิตติดชาร์ตในปัจจุบันมักจะใช้คำซ้ำกันมากขึ้นเรื่อยๆ และเทรนนี้ยิ่งเติบโตขึ้นเรื่อยๆในแต่ละปี
โดยเค้าพบว่าเพลงที่ติด Top 100 ของ Billboard ส่วนมากจะมีท่อนที่ร้องซ้ำกันเยอะกว่าเพลงทั่วไป ตัวอย่างก็เช่นเพลง
Yeah Right ของ Vince Staples ซึ่งท่อนฮุคร้องเพียงแค่ 2 คำเท่านั้นคือแค่

```
Boy yeah right, yeah right, yeah right
(Boy yeah right, yeah right, yeah right)
Boy yeah right, yeah right, yeah right
(Boy yeah right, yeah right, yeah right)
Boy yeah right, yeah right, yeah right
(Boy yeah right, yeah right, yeah right)
Boy yeah right, yeah right, yeah right
(Boy yeah)
```

<iframe width="560" height="315" src="https://www.youtube.com/embed/C6iAzyhm0p0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

(แหม่ จะร้องกันแค่นี้จริงๆหรอ 555)

โอเค มาเข้าเรื่องกันก่อนดีกว่า คือในเมื่อเค้าวิเคราะห์เพลงต่างประเทศได้ แสดงว่าเราก็สามารถลองวิเคราะห์เพลงไทยได้เหมือนกันน่ะสิ
เพราะเดี๋ยวนี้ก็มีไลบรารี่หลากหลายที่ตัดคำไทยได้แล้วเช่น [`deepcut`](https://rkcosmos.github.io/deepcut/) จาก True Corporation เป็นต้น เราก็สามารถเอาไลบรารี่มาใช้ตัดเนื้อเพลงเพื่อวิเคราะห์กันได้ละ

ในโพสต์นี้เราจะมาลองดูกันว่าเราสามารถ visualize เนื้อเพลงในรูปของเมทริกซ์ได้อย่างไร และจากนั้นจะมาดูกันว่า
จากเพลงไทย 12,664 เพลง 2,785 ศิลปิน จาก [Siamzone](https://www.siamzone.com/music/thailyric/)
เพลงไทยเพลงไหนยาวที่สุด สั้นที่สุด เพลงไหนใช้คำซ้ำมากที่สุดหรือไม่ใช้คำซ้ำเลย
แล้วก็มาลองดูว่าศิลปินที่เราชอบนั้นชอบใช้เนื้อเพลงซ้ำๆกันหรือไม่อย่างไรฮะ


## Visualize song lyrics

ก่อนอื่นเราจะมาดูว่าเราจะพล็อตเนื้อเพลงกันได้อย่างไร ไม่น่าเชื่อว่าหลายๆเพลงนั้นเราสามารถ visualize เนื้อเพลงและดูว่าเพลงนั้นมีส่วนประกอบของเพลงเป็นอย่างไรบ้างได้ไม่ยากนัก เนื้อเพลงส่วนมากจะประกอบด้วยหลายๆส่วนด้วยกัน ได้แก่ `Introduction`, `Verse`, `Chorus`, `Bridge`

วิธีการก็คือว่าเราเรียงคำจากต้นเพลงจนจบเพลงจากซ้ายไปขวาและบนลงล่าง และคำไหนที่ใช้ซ้ำในเนื้อเพลงเราจะเติมเลข 1 เข้าไป
ส่วนถ้าไม่ซ้ำเลยก็เก็บเมทริกซ์ไว้เป็นศูนย์ ลองดูภาพด้านล่างเพื่อประกอบคำอธิบายได้เลย

<figure><center>
  <img width="300" src="https://colinmorris.github.io/SongSim/img/about/barbie.png" data-action="zoom"/>
  <figcaption>
    <a title="example">
      ตัวอย่างมาจาก [SongSim](https://colinmorris.github.io/SongSim/#/about) ของ Colin Morris ฮะ
    </a>
  </figcaption>  
</center></figure>

สำหรับต่อไปนี้เราจะลองพล็อต Song similarity เมทริกซ์กันเองบ้าง โดยเราจะยืมเพลงแผลเป็นของ
อะตอม ชนกันต์ มาพล็อตซะหน่อย ทั้งนี้ขอบคุณเนื้อเพลงจากเว็บไซต์ [Siamzone](https://www.siamzone.com/music/thailyric/10627)
มา ณ ​ที่นี้ด้วยฮะ

<iframe width="560" height="315" src="https://www.youtube.com/embed/OWFBOxCFMX4" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

วิธีการคำนวณและพล็อต Song similarity เมทริกซ์สามารถเขียนได้ตามด้านล่างนี้เลย

```py
import deepcut
import matplotlib.pyplot as plt
from scipy.spatial.distance import euclidean, pdist, squareform

def similarity_func(u, v):
    if u != v:
        return 1
    else:
        return 0

def plot_song_sim(words):
    words = [word for word in words if word.strip() not in ('', '*')]
    D = squareform(pdist(np.array(words).reshape(-1, 1), similarity_func))
    plt.matshow(1 - D, cmap='Greys',  interpolation='nearest')
    plt.xticks([], [])
    plt.yticks([], [])
    plt.show()

tokenized_lyrics = deepcut.tokenize(lyrics) # ตัดคำจากเนื้อเพลง
plot_song_sim(tokenized_lyrics) # ลิสต์ของคำที่ตัดมาเรียบร้อย
```

ลองใส่เพลงแผลเป็นของอะตอมเข้าไป พอพล็อตออกมาแล้วจะเห็นว่าเราสามารถแบ่งเนื้อเพลงแผลเป็น ออกได้ตามสัดส่วนโดนดูจากเมทริกซ์ ได้แก่
`Intro`, `Verse`, `Chorus`, `Bridge`, `Chorus`, ...

<figure><center>
  <img width="400" src="/images/post/songsim/atom_songsim.png" data-action="zoom"/>

  <figcaption>
    <a title="แผลเป็น อะตอม">
      พล็อตเนื้อเพลงแผลเป็น ของอะตอม ชนกันต์
    </a>
  </figcaption>
</center></figure>


ถ้าลองใส่เพลงอ้าวเข้าไปดูบ้างก็จะได้หน้าตาเป็นตามนี้


<figure><center>
  <img width="400" src="/images/post/songsim/atom_auw.png" data-action="zoom"/>

  <figcaption>
    <a title="อ้าว อะตอม">
      พล็อตเนื้อเพลงอ้าว ของอะตอม ชนกันต์
    </a>
  </figcaption>
</center></figure>



## ที่สุดของเพลงไทย

หลังจากเรา visualize เนื้อเพลงไทยแล้ว เราจะมาสรุปเนื้อเพลงไทยกันบ้างว่าเพลงส่วนมากความยาวเป็นอย่างไรบ้าง
เพลงไหนที่ใช้คำว่ารักมากที่สุด เพลงไหนใช้คำว่าเขามากที่สุด จากเพลงทั้งหมด 12,664 เพลง จากศิลปิน 2,785 วง
ที่เราโหลดมาจากเว็บไซต์​ [Siamzone](https://www.siamzone.com/music/thailyric/)

ก่อนอื่นสิ่งแรกที่เราอยากจะรู้เลยคือส่วนมากเพลงไทยมีความยาวทั้งหมดกี่คำกันนะ ซึ่งเราสามารถพล็อต distribution
จำนวนของคำของเพลงทั้งหมดที่ดาวน์โหลดมา ซึ่งได้เป็นหน้าตาตามด้านล่าง

<figure><center>
  <img width="400" src="/images/post/songsim/lyrics_length.png" data-action="zoom"/>

  <figcaption>
    <a title="ความยาวเนื้อเพลง">
      distribution ของความยาวเนื้อเพลง นับตามจำนวนคำ
    </a>
  </figcaption>
</center></figure>

โดยเฉลี่ยแล้วเพลงไทยมีความยาวประมาณ​ 308 คำ ส่วนฐานนิยมของจำนวนคำอยู่ที่ประมาณ​ 275 คำ

ตัวอย่างเพลงที่สั้นที่สุดที่เราเจอ ได้แก่เพลงต่อไปนี้ฮะ

- เพลงสรรเสริญพระบารมี เขียนโดย สมเด็จพระเจ้าบรมวงศ์เธอ เจ้าฟ้ากรมพระยานริศรานุวัดติวงศ์
- โศรกเศร้าเสียเหลือเกิน โดย อัสนี วสันต์
- ลาวคำหอม โดย ฮัท จิรวิชญ์
- แม่ โดย พอส
- เวตาล โดย Modern Dog
- ลืม, รักกันหนอ โดย Scrubb (รักกันหนอเป็นเพลงเก่าที่เอามีทำใหม่ฮะ ต้นฉบับเป็นของดิอิมพอสสิเบิ้ล)
- สักวันหนึ่ง โดย แคล แคลอรีน
- วันหนึ่ง โดย Sofa (คนเขียนโพสต์ชอบเพลงนี้มากฮะ แต่เนื้อเพลงเป็นคนละเวอร์ชัน)

ไม่รู้ว่าผู้อ่านจะรู้จักกันบ้างรึเปล่าแต่เพลงสั้นๆหลายเพลงนี่เพราะใช้ได้เลยนะ

ส่วนเพลงที่ยาวที่สุดที่เราเจอ ได้แก่

- หนีไม่พ้น โดย วิน ศิริวงศ์ (ท่อนแร็พยาวมากจริงๆ)
- Just Holla โดย ไทยเทเนียม (คนเขียนชอบเพลงนี้มากๆฮะ)
- สาด โดย ก้านคอคลับ
- ไม่มีทาง โดย ทาทายัง
- อยู่ไม่นิ่ง โดย ทูพี เซาท์ไซด์
- ควัน โดย เวย์ ปริญญา อินทชัย
- ทะลึ่ง โดย ไทยเทเนียม
- กูลิขิต โดย เต้ย ณัฐพงษ์ หอมเทียน

เพลงยาวๆนี่ต้องยกให้สาวกเพลงฮิปฮอปและแร็พเลย

<iframe width="560" height="315" src="https://www.youtube.com/embed/22w_4lzMCBg" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


เพลงที่ร้องคำว่า <b>รัก</b> มากที่สุดในหนึ่งเพลง ร้องได้สูสีกันมากๆ ได้แก่

- รักไม่รัก โดย ลุลา (57 ครั้ง)
- ก่อการรัก โดย ช็อกโกแล็ต คิท (56 ครั้ง)
- ที่รัก โดย พริกไทย (55 ครั้ง)
- รักเถอะ โดย อาร์ม วีรยุทธ จันทร์สุข (53 ครั้ง)
- รักดูก่อน โดย กรุงเกษม (52 ครั้ง)
- แสงไฟ โดย เดอะทอย (50 ครั้ง)
- ยังไงก็รัก โดย รวม เดอะสตาร์ (43 ครั้ง)
- รัสเซียน รูเล็ตต์ (ซินดองมา) โดย ริค วชิรปิลันธ์ โชคเจริญรัตน์ (42 ครั้ง)
- รักเธอมาก...ก โดย ลาฟเฟอร์ แอมเมอร์ (42 ครั้ง)
- รักเธอ เบื่อเธอ โดย นูโว (41 ครั้ง)
- น้องเปิ้ล โดย พาราด็อกซ์ (น้องเปิ้ลน่ารักไป 40 ครั้ง)

<iframe width="560" height="315" src="https://www.youtube.com/embed/Mi4Is4TJT9c" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

เพลงที่ร้องคำว่า <b>เธอ</b> มากที่สุดในหนึ่งเพลง ร้องได้สูสีกันมากๆ ได้แก่

- ลิฟท์ (Lift) โดย กรู๊ฟไรเดอร์ส (67 ครั้ง)
- เธอแหละ โดย เซเว่น (62 ครั้ง)
- มีแฟนแล้ว โดย โอ๊ต ปราโมทย์ ปาทาน (57 ครั้ง)
- รักเธอ เบื่อเธอ โดย นูโว (56 ครั้ง)
- แค่เธอบังคับ โดย เนโกะ จัมพ์ (54 ครั้ง)
- อาจจะเป็นเธอ โดย เคลียร์ (53 ครั้ง)
- เชิญ โดย ฟิน (51 ครั้ง)
- วอนนา บี ยัวร์ เกิร์ล (Wanna Be Your Girl) โดย วิหค (51 ครั้ง)
- เธอ เธอ เธอ โดย มิสเตอร์ เลซี่ (51 ครั้ง)
- ไม่รักเธอแล้ว โดย เดอะ ซิส (50 ครั้ง)
- ซินเดอเรลลา (Cinderella) โดย แทททู คัลเล่อร์ (49 ครั้ง)
- ใครกัน โดย เอ็กซ์โซติก เพอร์คัสชั่น (48 ครั้ง)
- ใช่เธอหรือเปล่า โดย แอนนิต้า (47 ครั้ง)
- ถ้าฉันเป็นเธอ โดย บอล จารุลักษณ์ ชยะกุล (47 ครั้ง)
- ให้เธอ โดย โมเม นภัสสร บูรณะศิริ	(47 ครั้ง)
- เมียจ๋า โดย อริสมัน	(47 ครั้ง)
- คิดถึงได้ไหม โดย มิณทร์ ยงสุวิมล	(46 ครั้ง)
- ไม่รู้จะอธิบายยังไง โดย โปเตโต้	(46 ครั้ง)
- สรุปไม่ได้ โดย อนัน อันวา (46 ครั้ง)
- กิฟต์ (Gift) โดย มาร์กี้ ราศรี บาเล็นซิเอก้า (45 ครั้ง)
- ฤดูหนาว โดย ยูม่า	(45 ครั้ง)
- กระโดดกอด โดย เคลียร์	(45 ครั้ง)
- ขอรักได้ไหม โดย สราญรมย์แบน	(45 ครั้ง)

<iframe width="560" height="315" src="https://www.youtube.com/embed/bxClla2UWGI" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

เพลงที่ร้องคำว่า <b>ฉัน</b> มากครั้งที่สุด ได้แก่

- ไม่รู้จะอธิบายยังไง โดย โปเตโต้ (66 ครั้ง)
- ถ้าฉันเป็นเธอ โดย บอล จารุลักษณ์ ชยะกุล (60 ครั้ง)
- โปรดลงโทษ (กระทืบ) ฉัน โดย สโลโจ (45 ครั้ง)
- ไม่รักเธอแล้ว โดย เดอะ ซิส (42 ครั้ง)
- บอกฉันหน่อย โดย บลิสโซนิค (42 ครั้ง)
- ฉันรักเธอ โดย ฝน พรินดา มนตรีวัต (41 ครั้ง)
- ฉันก็สู้คน โดย นิโคล เทริโอ (41 ครั้ง)
- ปากกา โดย พลอย ณัฐชา สวัสดิ์รักเกียรติ (40 ครั้ง)
- เมียจ๋า โดย อริสมัน (39 ครั้ง)
- แข็งใจ โดย น้ำเย็น สรอรรถ สุตตะ (38 ครั้ง)
- มองฉันที โดย อิมเมจ สุธิตา ชนะชัยสุวรรณ (38 ครั้ง)
- ไม่ได้จริงจัง โดย พริ้นฟีน (38 ครั้ง)
- Bye Bye โดย พีฮ็อต วัชรินทร์ พึ่งสุข (37 ครั้ง)
- ไม่ได้ตาฝาด โดย เม จีระนันท์ กิจประสาน (37 ครั้ง)
- ขอวอน 1 (Together I) โดย สมเกียรติ (37 ครั้ง)
- เกมเศรษฐี โดย สามบาทห้าสิบ (37 ครั้ง)
- ขอร้องขอเถอะ โดย ซีโร่ (37 ครั้ง)
- แอบชอบ โดย ละอองฟอง (37 ครั้ง)
- เสเพล โดย เกลอ (36 ครั้ง)
- เปลี่ยน โดย อิ้งค์ วรันธร เปานิล (36 ครั้ง)

<iframe width="560" height="315" src="https://www.youtube.com/embed/5lMgJx8WPic" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


เพลงที่ร้องคำว่า <b>เขา</b> มากครั้งที่สุด ได้แก่

- ทิ้งเขาซะ (Leave Him) โดย เค-โอทิค (62 ครั้ง)
- ปฏิเสธเขาไป โดย เป๊ก อ๊อฟ ไอซ์ (53 ครั้ง)
- เหตุผลของคนหมดรัก (Just The Way You Lie) โดย ป๊อปปี้ ชัชชญา ส่งเจริญ (44 ครั้ง)
- ต่างมุม โดย แอม เสาวลักษณ์ ลีละบุตร (37 ครั้ง)
- แอ๊ป สตอรี (App Story) โดย มาช่า วัฒนพานิช (35 ครั้ง)
- 7 นาที โดย แอลกอฮอ (32 ครั้ง)
- แค่เพียงเขาไม่เคย โดย เครสเชนโด้ (30 ครั้ง) คนเขียนชอบเพลงนี้มากๆครับ ขอดันหน่อย
- ดูนางให้ดูเสื้อ โดย วิด ไฮเปอร์ (30 ครั้ง)
- แฟนเผลอ โดย แอลโอจี (30 ครั้ง)
- หาก โดย โซฟา (29 ครั้ง)
- เขาลืม โดย ปาล์มมี่ (28 ครั้ง)
- ยิ้ม โดย ปุ๊ อัญชลี จงคดีกิจ (28 ครั้ง)


<iframe width="560" height="315" src="https://www.youtube.com/embed/E18q02AXkZY" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


เพลงที่ร้องคำว่า <b>ทำไม</b> มากครั้งที่สุด ได้แก่

- ทำไมโก (Why Lies) โดย เดอะจั๊กส์ (ร้องไปถึง 117 ครั้งใน 1 เพลงขุ่นพระ) ลองฟังดูแล้วจะรู้ว่า<b>ทำไม</b>
- บ่นเมีย โดย โน้ต เชิญยิ้ม (30 ครั้ง)
- กะโปโล โดย นิโคล เทริโอ (30 ครั้ง)
- ทำเป็นไม่ทัก โดย ปาล์มมี่ (25 ครั้ง)


### อื่นๆ

- เพลงที่ร้องคำว่า <b>ไม่</b> มากครั้งที่สุด: รักเธอไม่มีหมด โดย บุดดาเบลส (88 ครั้ง), ไม่ใช่ ไม่ใช่ โดย นิโคล เทริโอ (71 ครั้ง) ตามด้วย ถูกแล้ว โดย บี-คิง (70 ครั้ง)
- เพลงที่ร้องคำว่า <b>เหนื่อย</b> มากครั้งที่สุด: แฟชั่น โดย เครสเชนโด้ (33 ครั้ง)
- เพลงที่ร้องคำว่า <b>เพราะ</b> มากครั้งที่สุด: เพราะความรักมันไม่เลือกเวลาเกิด โดย โลโมโซนิค (24 ครั้ง)
- เพลงที่ร้องคำว่า <b>ไหม</b> มากครั้งที่สุด: ไม่รักแล้วจะหลอก โดย เกิร์ลลี่ เบอร์รี่ (50 ครั้ง)
- เพลงที่ร้องคำว่า <b>หาย</b> มากครั้งที่สุด: จ.เจ ใจหาย โดย เจ เจตริน วรรธนะสิน (40 ครั้ง)
- เพลงที่ร้องคำว่า <b>เกรงใจ</b> มากครั้งที่สุด: เกรงใจ โดย โฟร์ มด (34 ครั้ง)
- เพลงที่ร้องคำว่า <b>อย่า</b> มากครั้งที่สุด: โปรดอย่าเคืองผมเลย โดย อีทีซี (76 ครั้ง), และมีหลายเพลงที่เราชอบ เช่น
พอ โดย อีโบล่า (36 ครั้ง), โปรดอย่ามาสงสาร โดย ตู่ ภพธร สุนทรญาณกิจ (33 ครั้ง), รักสนุก โดย จีน กษิดิศ (30 ครั้ง)
- เพลงที่ร้องคำว่า <b>นาน</b> มากครั้งที่สุด: นาน นาน โดย ไอซ์ รัชตา (33 ครั้ง), อีกไม่นาน โดย จุ๋ยจุ๋ยส์ (31 ครั้ง) เพลงนี้โปรดเลย
- (แถม) Bodyslam ใช้คำว่า<b>ชีวิต</b>ไป 177 ครั้งในเนื้อเพลง โดยเพลงที่มีคำว่า<b>ชีวิต</b>มากที่สุดคือเพลง ชีวิตเป็นของเรา โดย Bodyslam ใช้คำว่า<b>ชีวิต</b>ถึง 40 เพลงจากทั้งหมด 61 เพลง แต่จริงๆแล้วเพลงที่ร้องคำว่าชีวิตมากครั้งที่สุด
คือเพลงคนล่าฝันของคาราบาว นอกจากนั้นพี่ตูนต้องร้องคำว่า<b>ฝัน</b>ไปถึง 95 ครั้งจาก 61 เพลงฮะ


ศิลปินที่ใช้คำว่า <b>รัก</b> มากที่สุดในเนื้อเพลง ถ้าไปดูคอนเสิร์ตอาจจะกระอักคำว่ารักตายไปเลย ได้แก่

- อ๊อฟ ปองศักดิ์ รัตนพงษ์ (425 ครั้ง)
- เบิร์ด ธงไชย แมคอินไตย์ (353 ครั้ง)
- ปาน ธนพร แวกประยูร (343 ครั้ง)
- บี้ สุกฤษฎิ์ วิเศษแก้ว (341 ครั้ง)
- แคลช (337 ครั้ง)
- โบ สุนิตา ลีติกุล (323 ครั้ง)
- พั้นช์ วรกาญจน์ โรจนวัชร (308 ครั้ง)
- พาราด็อกซ์ (307 ครั้ง)
- ดัง พันกร บุณยะจินดา (295 ครั้ง)
- ไอซ์ ศรัณยู วินัยพานิช (293 ครั้ง)
- อีทีซี (289 ครั้ง)
- ลาบานูน (283 ครั้ง)
- ปนัดดา เรืองวุฒิ (268 ครั้ง)
- ลิปตา (267 ครั้ง)
- นิว & จิ๋ว (265 ครั้ง)
- โรส ศิรินทิพย์ หาญประดิษฐ์ (258 ครั้ง)
- บิ๊กแอส (251 ครั้ง)
- บอดี้สแลม (251 ครั้ง)
- แทททู คัลเล่อร์ (251 ครั้ง)
- ซีล (250 ครั้ง)

ถัดจากนั้นได้แก่ ทาทา ยัง, เป๊ก ผลิตโชค, กะลา, มายด์, ว่าน ธนกฤต พานิชวิทย์, โปเตโต้, แก้ม วิชญาณี เปียกลิ่น,
ไอน้ำ, เอ็ม อรรถพล ประกอบของ, พลพล พลกองเส็ง, น้ำชา ชีรณัฐ ยูสานนท์, แอน ธิติมา, มาช่า วัฒนพานิช, โซคูล,
โต๋ ศักดิ์สิทธิ์ เวชสุภาพร, แพนเค้ก, พริกไทย, เอบี นอร์มอล, เครสเชนโด้, นัท มีเรีย, บอย โกสิยพงษ์
(บอกเลยว่าคนเขียนโพสต์อยากจะแชร์ลิสต์ทั้งหมดเลย แต่เนื้อที่อาจจะไม่พอ)


<iframe width="560" height="315" src="https://www.youtube.com/embed/ENG-Hy_n2Ck" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


มีศิลปินที่ไม่เคยใช้คำว่า <b>รัก</b> ในเพลงเลยทั้งหมด 470 วงจากทั้งหมด 2785 วง คิดเป็นประมาณ 16.8 เปอร์เซ็นของ
ศิลปินทั้งหมด (ส่วนมากจะออกมาไม่กี่เพลงหรือเป็นเพลงพิเศษ) ตัวอย่างเช่น อะบิวส์ เดอะ ยูธ, ต้อย หมวกแดง, สยาม ซีเครท เซอร์วิส, สภาพสุภาพ, เดธ ออฟ อะ เซลส์แมน, ช็อกโกแลต คิท, TWO PILLS AFTER MEAL, Plastic Plastic, อภิรมย์, อีเล็คทริค นีออน แลมป์, ภูมิจิต,...

ตัวอย่างศิลปินที่มีเนื้อเพลงโดยเฉลี่ยยาวที่สุด (รวมๆแล้วแต่เพลงเฉลี่ยแล้วร้องมากกว่า 1000 คำ!) ได้แก่

- ก้านคอ บอยส์
- ไทยเทเนี่ยม
- แร็คคูนส์ ปาร์ตี้
- ชิงก์ 99
- โซน่า
- เวย์​ ปริญญา อินทชัย
- ก้านคอคลับ
- แก๊งดาวหกแฉก
- นิกกี้ พิ้ม

<iframe width="560" height="315" src="https://www.youtube.com/embed/Xv4xuMD6V3A" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

ใครจะไปจำเนื้อร้องตามกันไหวนะเนี่ย

และสุดท้ายตัวอย่างศิลปินที่แต่ละเพลงร้องแค่ประมาณ​ร้อยกว่าคำเท่านั้น ได้แก่

- เดอะ วอยซ์ คิดส์
- สภาพสุภาพ
- บอม พงศกร โตสุวรรณ
- พราว (คนเขียนชอบวงนี้ฮะ 555)
- เดธ ออฟ อะ เซลส์แมน
- คัฑลียา มารศรี
- ภูมิจิต
- อร อรอรีย์ จุฬารัตน์
- อริสมันต์ พงษ์เรืองรอง


<iframe width="560" height="315" src="https://www.youtube.com/embed/FNicQERhyUs" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


ต่อไปเราจะมาดูกันว่าเพลงไทยที่ฮิตๆนั้น จะใช้คำซ้ำกันมากกว่าเพลงที่ไม่ค่อยฮิตมั้ย
เราจะวัดจำนวนคำที่ไม่ซ้ำกันหารตัวจำนวนคำทั้งหมดที่ร้องในแต่ละเพลง ซึ่งจะเรียกว่า repeated ratio
โดยเราจะเอาค่านี้มาเปรียบเทียบระหว่างเพลงที่มีคนแชร์เยอะในเพจ Siamzone กับเพลงที่มีคนแชร์ไม่เยอะมาก
ถ้ายิ่งใช้คำซ้ำบ่อยๆในเนื้อเพลง repeated ratio ก็จะยิ่งมาก ส่วนถ้าใช้คำไม่ซ้ำเลย repeated ratio จะเป็นศูนย์
(อย่างเช่นเพลงสรรเสริญพระบารมี เป็นเพลงที่ใช้คำไม่ซ้ำกันเลย)

```py
def calculate_repeated_ratio(words):
    repeated_ratio = 1 - len(set(words)) / len(words)
    return repeated_ratio
```

<figure><center>
  <img width="400" src="/images/post/songsim/repeated_ratio.png" data-action="zoom"/>

  <figcaption>
    <a title="อ้าว อะตอม">
      distribution ของจำนวนคำที่ใช้ซ้ำระหว่างเพลงฮิตกับเพลงปกติ
    </a>
  </figcaption>
</center></figure>

<figure><center>
  <img width="400" src="/images/post/songsim/word_dist.png" data-action="zoom"/>

  <figcaption>
    <a title="อ้าว อะตอม">
      distribution ของจำนวนคำที่ใช้ระหว่างเพลงฮิตกับเพลงปกติ
    </a>
  </figcaption>
</center></figure>

เราจะเห็นว่า distribution ต่างกันเล็กน้อยแต่ไม่มากนัก (0.705 สำหรับเพลงที่คนแชร์เยอะ และ 0.698 สำหรับเพลงทั่วไป)
 โดยเพลงที่มีคนแชร์เยอะมีอัตราการใช้คำซ้ำกันในเพลงมากกว่า
เพลงปกติแค่ประมาณ​ 1 เปอร์เซ็นต์เท่านั้น <b>ดังนั้นสำหรับเพลงไทยแล้วจะเพลงยาวเพลงสั้นนี่ไม่เกี่ยวว่าจะฮิตหรือไม่ฮิตนะ</b>

ถ้าดูที่จำนวนคำ distribution ก็แทบไม่ต่างกันเช่นกัน โดยเพลงฮิตมีความยาวเพลงเฉลี่ยประมาณ 317 คำ ต่างกับเพลงทั่วไป
ที่มีจำนวนคำที่ร้องต่อเพลงประมาณ​ 305 คำ

ศิลปินที่เราชอบอย่างอะตอม ชนกันต์, แทททู คัลเลอร์ และ the TOYS ใช้ซ้ำในเนื้อเพลงมากกว่าเพลงปกติ โดยอะตอมร้องเพลงซ้ำ
ด้วย repeated ratio สูงถึง 0.767 เลยทีเดียว ส่วนแทททู คัลเลอร์กับ the TOYS นี่ประมาณ​ 0.71, 0.723 โดยเฉลี่ย ซึ่งเนื้อเพลงของศิลปินที่เราชอบมีความซ้ำสูงกว่าเพลงทั่วไปเล็กน้อยฮะ


## สัดส่วนของคำต่างๆในเพลง

สุดท้ายเราจะมาดูกันว่าถ้าดูแต่ละคำที่ใช้ในเพลง คำไหนที่ปรากฏในเนื้อเพลงมากที่สุดฮะ ในที่นี้เราจะสุ่มคำหลักๆที่คิดว่าคนชอบใช้กัน เช่นคำว่า ใจ ไม่ เธอ รัก เคย เรา เพราะ เวลา เขา วินาที อะไรแบบนี้


<figure><center>
  <img width="400" src="/images/post/songsim/keywords.png" data-action="zoom"/>

  <figcaption>
    <a title="สัดส่วนของจำนวนเพลง">
      สัดส่วนของจำนวนเพลงที่ใช้คำที่เราสนใจ เกือบทุกเพลงมีคำว่า `ใจ` กับ `ไม่` หรือไม่ก็ `เธอ` นะ (อรั้ย)
    </a>
  </figcaption>
</center></figure>

จากเพลงทั้งหมดที่เรามี มีคำว่า<b>ฉัน</b> 95,390 คำ คำว่า<b>เธอ</b> 135,600 คำ แต่คำว่า<b>เขา</b> แค่ 14,227 คำ
<b>ส่วนมากเพลงไทยพูดถึงฉันกับเธอ ไม่ค่อยพูดถึงเขาซักเท่าไหร่</b> :P

คำว่า<b>เช้า</b>ถูกใช้ไป 1,150 ครั้ง ส่วน<b>คืน</b>ถูกใช้ไป 6,222 ครั้ง (เยอะกว่า 5 เท่า!)
สงสัยไปจีบกันตอนกลางคืน เช้าๆยังไม่ค่อยตื่นแน่ๆ

ส่วนคำว่า<b>รัก</b>ถูกใช้ไปทั้งหมด 60,112 ครั้ง คำว่า<b>รอ</b>ถูกใช้ไป 13,152 ครั้ง
คำว่า<b>ไม่</b>ถูกใช้ไปทั้งหมดถึง 121,221 ครั้งด้วยกัน คงต้องดูกันอีกทีว่าทำไมใช้เยอะขนาดนี้นะ


# อารัมภบท

สำหรับโพสต์นี้เรานำข้อมูลเนื้อเพลงไทย 12,000 กว่าเพลงมาวิเคราะห์กัน เราเริ่มด้วยการ visualize ว่าแพทเทิร์นของเพลงเป็นอย่างไรบ้าง
หลังจากนั้นเราก็ดูว่ามีแพทเทิร์นแบบไหนรึเปล่าที่ทำให้เพลงฮิตที่มีคนเสิร์ชดูเยอะต่างจากเพลงทั่วไปโดยใช้สัดส่วนของการใช้คำซ้ำในเพลง
เราพบว่าเพลงฮิตส่วนมากการใช้คำซ้ำมากกว่าเพลงทั่วไปอยู่เล็กน้อย แต่ว่าไม่ได้มากเท่าไหร่
ซึ่งต่างจากเพลงฝรั่งที่เพลงฮิตส่วนมากจะเริ่มใช้คำซ้ำมากขึ้นเรื่อยๆ คงต้องรอดูต่อไปว่าเทรนเนื้อเพลงของบ้านเราจะเป็นไปในทิศทางไหน

ใครมีไอเดียเจ๋งๆที่อยากจะ visualize ก็พิมพ์หรืออีเมล์มาบอกกันได้เลยนะ
