---
author: Titipata
layout: post
title: "Analysis of Thai pop songs' lyrics"
description: ""
tags: [Python, Songs, Data, Code, Deepcut, Siam]
image:
  feature: post/songsim/atom_songsim.png
comments: true
share: true
date: 2018-04-09 22:30:00

---

## เกริ่นนำ

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
จากเพลงไทย 12,664 เพลง 2,785 ศิลปิน จาก [Siamzone](siamzone.com/music/thailyric/)
เพลงไทยเพลงไหนยาวที่สุด สั้นที่สุด เพลงไหนใช้คำซ้ำมากที่สุดหรือไม่ใช้คำซ้ำเลย
แล้วก็มาลองดูว่าศิลปินที่เราชอบนั้นชอบใช้เนื้อเพลงซ้ำๆกันหรือไม่อย่างไรฮะ


## Visualize song lyrics

ก่อนอื่นเราจะมาดูว่าเราจะพล็อตเนื้อเพลงกันได้อย่างไร ไม่น่าเชื่อว่าหลายๆเพลงนั้นเราสามารถ visualize เนื้อเพลงและดูว่าเพลงนั้นมีส่วนประกอบของเพลงเป็นอย่างไรบ้างได้ไม่ยากนัก เนื้อเพลงส่วนมากจะประกอบด้วยหลายๆส่วนด้วยกัน ได้แก่ `Introduction`, `Verse`, `Chorus`, `Bridge`

วิธีการก็คือว่าเราเรียงคำจากต้นเพลงจนจบเพลงจากซ้ายไปขวาและบนลงล่าง และคำไหนที่ใช้ซ้ำในเนื้อเพลงเราจะเติมเลข 1 เข้าไป
ส่วนถ้าไม่ซ้ำเลยก็เก็บเมทริกซ์ไว้เป็นศูนย์ ลองดูภาพด้านล่างเพื่อประกอบคำอธิบายได้เลย

<figure><center>
  <img width="300" src="https://colinmorris.github.io/SongSim/img/about/barbie.png" data-action="zoom"/>
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


ถ้าลองใส่เพลงอ้าว เข้าไปดูบ้างว่าจะได้หน้าตาเป็นตามนี้


<figure><center>
  <img width="400" src="/images/post/songsim/atom_auw.png" data-action="zoom"/>

  <figcaption>
    <a title="อ้าว อะตอม">
      พล็อตเนื้อเพลงอ้าว ของอะตอม ชนกันต์
    </a>
  </figcaption>
</center></figure>



## Statistics of Thai lyrics

หลังจากเรา visualize เนื้อเพลงไทยแล้ว มาสรุปเนื้อเพลงไทยกันบ้างว่าเพลงส่วนมากความยาวเป็นอย่างไรบ้าง
ในที่นี้เราโหลดเนื้อเพลงจากเว็บไซต์​ [Siamzone](https://www.siamzone.com/music/thailyric/)
โดยใช้เพลงทั้งหมด 12,664 เพลง จากศิลปิน 2,785 วงด้วยกัน

สิ่งแรกที่เราอยากจะรู้เลยคือส่วนมากเพลงไทยมีความยาวทั้งหมดกี่คำกันนะ ซึ่งเราสามารถพล็อต distribution
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
- ลืม, รักกันหนอ โดย Scrubb
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

ส่วนตัวอย่างศิลปินที่มีเนื้อเพลงโดยเฉลี่ยยาวที่สุด (รวมๆแล้วแต่เพลงเฉลี่ยแล้วร้องมากกว่า 1000 คำ!) ได้แก่

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

และสุดท้ายคือตัวอย่างศิลปินที่แต่ละเพลงร้องแค่ประมาณ​ร้อยกว่าคำเท่านั้น ได้แก่

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
      distribution ของจำนวนคำระหว่างเพลงฮิตกับเพลงปกติ
    </a>
  </figcaption>
</center></figure>

เราจะเห็นว่า distribution ต่างกันเล็กน้อยแต่ไม่มากนัก (0.705 สำหรับเพลงที่คนแชร์เยอะ และ 0.698 สำหรับเพลงทั่วไป)
 โดยเพลงที่มีคนแชร์เยอะมีอัตราการใช้คำซ้ำกันในเพลงมากกว่า
เพลงปกติแค่ประมาณ​ 1 เปอร์เซ็นต์เท่านั้น <b>ดังนั้นสำหรับเพลงไทยแล้วจะเพลงยาวเพลงสั้นนี่ไม่เกี่ยวว่าจะฮิตหรือไม่ฮิตนะ</b>

ศิลปินที่เราชอบอย่างอะตอม ชนกันต์ กับ แทททู คัลเลอร์ ใช้ซ้ำในเนื้อเพลงมากกว่าเพลงปกติ โดยอะตอมร้องเพลงซ้ำ
ด้วย repeated ratio สูงถึง 0.767 เลยทีเดียว ส่วนแทททู คัลเลอร์นี่ประมาณ​ 0.71 ซึ่งเนื้อเพลงมีความซ้ำสูงกว่าเพลงทั่วไป


# อารัมภบท

สำหรับโพสต์นี้เรานำข้อมูลเนื้อเพลงไทยกว่า 12,000 เพลงมาวิเคราะห์กัน เราเริ่มด้วยการ visualize ว่าแพทเทิร์นของเพลงเป็นอย่างไรบ้าง
หลังจากนั้นเราก็ดูว่ามีแพทเทิร์นแบบไหนรึเปล่าที่ทำให้เพลงฮิตที่มีคนเสิร์ชดูเยอะต่างจากเพลงทั่วไปโดยใช้สัดส่วนของการใช้คำซ้ำในเพลง
เราพบว่าเพลงฮิตส่วนมากการใช้คำซ้ำมากกว่าเพลงทั่วไปอยู่เล็กน้อย แต่ว่าไม่ได้มากเท่าไหร่
ซึ่งต่างจากเพลงฝรั่งที่เพลงฮิตส่วนมากจะเริ่มใช้คำซ้ำมากขึ้นเรื่อยๆ คงต้องรอดูต่อไปว่าเทรนเนื้อเพลงของบ้านเราจะเป็นไปในทิศทางไหน

ใครมีไอเดียเจ๋งๆที่อยากจะ visualize ก็พิมพ์หรืออีเมล์มาบอกกันได้เลยนะ
