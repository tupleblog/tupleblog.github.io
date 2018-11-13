---
author: bachkukkik
layout: post
title: "ใครไปวิ่งงาน CMU Marathon 2019 บ้างจ๊ะ"
description: "webscraping, clean, plot แบบแมวๆ"
tags: [CMU Marathon, Marathon]
image:
  feature: post/cmu_marathon/cmu_marathon.png
comments: true
share: true
date: 2018-11-12 23:30:00
---

## เกริ่นนำ

ช่วงต้นเดือนกุมภาพันธ์ที่จะถึงนี้ ทางม.เชียงใหม่เค้าจัดให้ลงทะเบียน CMU Marathon เพื่อไปวิ่งที่เชียงใหม่กันครับ ซึ่งทางทีม tupleblog ส่งตัวแทนเข้าชิง 2 นายด้วยกัน ได้แก่จารย์มาย [@titipata](https://github.com/titipata) และผมเอง [@bachkukkik](https://github.com/bachkukkik) 

นอกจากนี้ยังมีเพื่อนสนิทจากเมืองกรุงไปร่วมแจมงานวิ่งอีกหลายท่านด้วย อาทิเช่น เหลียงธนบุรี แพนด้าหัวลำโพง จ๋อดาวคะนอง เป็นต้น จัดว่าเป็น Mini Party ของ tuple team เลยครับ

ตอนวันที่ 11/11 เวลา 11.11 น. (วันคนโสด เวลาคนเหงา) เป็นฤกษ์งามยามดีครับที่ทาง มช. เค้าเปิดให้ลงทะเบียนทางเว็บไซต์ พอทุกคนลงเสร็จก็นึกอยากรู้อยากเห็นขึ้นมาว่า เอ เพื่อนๆพี่ๆน้องๆที่ร่วมสมัครวิ่งงานเดียวกันนี่เค้าเป็นใครกัน จะวิ่งเท่าไรกันบ้าง จะได้เตรียมตัวได้ถูกต้องเหมาะสมครับ

สำหรับใครที่จะเช็คชื่อคนไปวิ่ง สามารถดูได้ทางลิ้งนี้นะครับ [https://go.cmu-marathon.com/retro-2019/runner](https://go.cmu-marathon.com/retro-2019/runner) เว็บเค้าทำไว้ดีมากทีเดียวครับ

## ด้วยความอยากรู้อยากเห็น

ผมอยากรู้จักทุกคนเลยครับ เลยจะใช้โปรแกรมภาษา Python การใน scrape เว็บออกมาดูครับว่า นักวิ่งของเราหน่วยก้านเป็นอย่างไรกันบ้าง โดยเริ่มจาก Code block ด้านล่างนี้เลยจ้า
```py
import pandas as pd
import requests
import seaborn as sns
import matplotlib.pyplot as plt

URL = 'https://go.cmu-marathon.com/retro-2019/runner/tableRunner?init=1&order=asc&offset=0&limit=10000'
data = requests.get(URL).json()
marathon_df = pd.DataFrame(data['rows'])
```
<figure><center>
  <img width="800" src="/images/post/cmu_marathon/marathon_df.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      marathon_df.head()
    </a>
  </figcaption>
</center></figure>

ได้มาเป็นตารางแบบที่ในเว็บเขาใช้ แต่ว่าได้มาทุกรายชื่อครับ และเราก็จะทำการ clean ข้อมูลจากภาษาไทยเป็นภาษาอังกฤษ เวลาพลอตกราฟจะได้อ่านง่ายครับ
```py
d = {'ชาย': 'M', 'หญิง': 'F'}
marathon_df['gender'] = marathon_df.gender.map(lambda x: d[x])

def clean_string(s):
    s = s.replace('ฟันรัน', 'Fun Run').replace('ชาย', '')
    s = s.replace('หญิง', '').replace('ชาวต่างชาติ', 'foreigner')
    s = s.replace('ขึ้นไป', '>')
    s = s.replace('ปี', 'yo').replace('ฮาล์ฟมาราธอน', 'Half Marathon')
    s = s.replace('มินิมาราธอน', 'Mini Marathon')
    s = s.replace('มาราธอน', 'Marathon')
    return s

marathon_df['courseList'] = marathon_df.courseList.map(lambda x: clean_string(x))
```
<figure><center>
  <img width="800" src="/images/post/cmu_marathon/cleand1_marathon_df.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      sum_df.groupby('gender').sum()
    </a>
  </figcaption>
</center></figure>

สรุปจำนวนนักวิ่งชายหญิงได้เป็นดังนี้ครับ: นั่งวิ่งชายทั้งหมด 3,606 คนและนักวิ่งหญิง 3,225 คน

<figure><center>
  <img width="800" src="/images/post/cmu_marathon/summary_runner.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      marathon_df.head()
    </a>
  </figcaption>
</center></figure>

## Plot แบบแมวๆ

อย่างแรกเลยที่ผมอยากรู้ก็คือทั้งนักวิ่งชาย นักวิ่งหญิงเนี่ย เค้าลงรายการไหนกันบ้าง ว่าแล้วก็ไปพลอตกราฟกันเลย ส่วนของโค้ดที่พลอตกราฟทั้งหมดต้องยกให้เครดิตจารย์มายครับ งานดี งานไวจริมๆ
```py
# เตรียมข้อมูลเพื่อตีกราฟ
sum_df = marathon_df.groupby(['courseList', 'gender']).size().reset_index().rename(columns={0: 'Number of runners'})

order = [
    'Fun Run', 'Mini Marathon  (16-19 yo)', 'Mini Marathon  (20-29 yo)',
    'Mini Marathon  (30-39 yo)', 'Mini Marathon  (40-49 yo)',
    'Mini Marathon  (50-59 yo)', 'Mini Marathon  (60 yo>)', 
    'Half Marathon  (20-29 yo)',
    'Half Marathon  (30-39 yo)', 'Half Marathon  (40-49 yo)',
    'Half Marathon  (50-59 yo)', 'Half Marathon  (60 yo>)',
    'Marathon  (20-29 yo)', 'Marathon  (30-39 yo)',
    'Marathon  (40-49 yo)', 'Marathon  (50-59 yo)',
    'Marathon  (60 yo>)', 'Marathon foreigner ']

# plot จริง
g = sns.catplot(x='courseList', 
                y='Number of runners', 
                hue='gender', 
                kind='bar', 
                data=sum_df, 
                order=order,
                palette="muted",
                size=7)
g.set_xticklabels(rotation=90, fontsize=15)
g.set_yticklabels(fontsize=15)
g.set_ylabels(fontsize=15)
g.set_xlabels(label='', fontsize=15)
g.despine(left=True)
```
<figure><center>
  <img width="800" src="/images/post/cmu_marathon/program_by_gender.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      โปรแกรมวิ่งแบ่งตามเพศและวัย
    </a>
  </figcaption>
</center></figure>

จากกราฟมีความน่าสนใจอยู่ว่า รายการวิ่งที่เบาๆ เน้นเป็นงานอดิเรก สาวๆจะชอบมากเป็นพิเศษครับ ให้ได้ชัดมากๆว่างาน Fun run / Mini Marathon นี่สาวๆทุกช่วงอายุให้ความสนใจเป็นอย่างมาก

แต่ก็ไม่ได้หมายความว่าหนุ่มๆจะไม่รักสุขภาพนะครับ แต่เหมือนจะชอบความ Challenge (หรือซาดิสต์ดีนะ) อธิบายได้จากกราฟครับ ชัดเจนว่างาน Half / Full Marathon นี่ ชายไทยจะชื่นชอบมากครับ

ที่น่าสนใจอีกข้อคือกลุ่มคนที่ชอบวิ่งงาน CMU Marathon ส่วนใหญ่จะอายุช่วง 30-39 ปีครับ

ส่วนผมกับจารย์มายน่ะหรอ สายบันเทิงครับ 10K พอ อิอิ

พลอตด้านล่างเทียบอัตราส่วนชายหญิงที่มาวิ่งของแต่ละโปรแกรมจ้า
```py
ratios = []
for c, df in marathon_df.groupby('courseList'):
    try:
        ratio = len(df[df.gender == 'F']) / len(df[df.gender == 'M'])
        total = len(df)
    except:
        ratio = 0
    ratios.append({'courseList': c, 'y': ratio, 'x': total})
ratio_df = pd.DataFrame(ratios)
ax = ratio_df.plot(x='x', 
                  y='y', 
                  kind='scatter', 
                  figsize=(6, 6), fontsize=15)
ax.set_xlabel('Number of Runners', fontsize=15)
ax.set_ylabel('Female/Male Ratio', fontsize=15)

ratio_df[['x', 'y', 'courseList']].apply(lambda x: ax.text(*x),axis=1);
plt.axhline(y=1, linewidth=1, color='grey')
```
<figure><center>
  <img width="800" src="/images/post/cmu_marathon/ratio_program.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      อัตราส่วนหญิงชายของแต่ละรายการวิ่ง (มี Fun run และ Mini Marathon เกือบทุกอายุที่อัตราส่วนของผู้หญิงมีมากกว่าผู้ชาย ที่เหลือผู้ชายมีมากกว่าฮะ)
    </a>
  </figcaption>
</center></figure>

อีกส่วนที่น่าสนใจมากๆคือ Size เสื้อของนักวิ่งครับ ตัวแทนเข้าชิงฝ่ายชายส่วนใหญ่จะมีขนาดประมาณ M-L ครับ ซึ่งถ้าสังเกตุจากความเกือบจะเป็น Bell-curve Distribution แล้ว ชายไทยก็ถือว่ามีไซส์มาตรฐานครับ (ผู้เขียนจำไม่ได้ว่าเสื้อขนาดเท่าไรยาวกี่นิ้ว อกกว้างกี่นิ้ว ครับ)

สำหรับนักวิ่งเข้าชิงฝ่ายหญิงนี่จะมีขนาดเสื้อทีมีความตัวผอม ตัวเล็กครับ ขนาดเสื้อส่วนใหญ่จะมีขนาด SS-M ซึ่งบางท่านที่มีส่วนสูง หรือ มีความเจ้าเนื้อมากเป็นพิเศษจึงต้องเพิ่มขนาดเสื้อให้เกินขนาด M ทำให้ Distribution ของขนาดเสื้อฝั่งนักวิ่งหญิงของงานนี้ไม่ได้เป็น Bell-curve แบบฝ่ายชายครับ
```py
size_df = marathon_df.groupby(['Shirt Size', 'gender'])\
    .size().reset_index().rename(columns={0: 'Number of runners'})

g = sns.catplot(x='Shirt Size', 
                y='Number of runners', 
                hue='gender', 
                kind='bar', 
                data=size_df, 
                order=['3S', 'SS', 'S', 'M', 'L', 'XL', '2XL', '3XL', '4XL'],
                palette="muted",
                height=7)
g.set_xticklabels(rotation=90, fontsize=15)
g.set_yticklabels(fontsize=15)
g.set_ylabels(fontsize=15)
g.set_xlabels(label='', fontsize=15)
g.despine(left=True)
```
<figure><center>
  <img width="800" src="/images/post/cmu_marathon/shirt_size.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      plot เรื่องขนาดเสื้อระหว่างชายหญิง
    </a>
  </figcaption>
</center></figure>

และนี้ก็เป็นการทำความรู้จักนักวิ่งงาน CMU Marathon แบบคร่าวๆนะครับ สำหรับท่านไหนอยากรู้จักนักวิ่งให้มากกว่านี้ ต้องไปโดนกันเองที่เชียงใหม่แล้วครับ ^^

Stay Hungry. Stay Foolish.

> ขอบคุณจารย์มาย [@titipata](https://github.com/titipata) ที่ช่วยทำ plotting ให้นะครับ นอกจากนี้ใน tupleteam ของเรายังมี จารย์ตุลย์ [@bluenex](https://github.com/bluenex) และ จารย์พี่ตั๋น [@kittinan](https://github.com/kittinan) เป็นผู้เขียน tupleblog ด้วย