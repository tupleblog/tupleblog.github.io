---
author: bachkukkik
layout: post
title: "[Tutorial] Python for Business ฉบับพ่อค้า Part 2"
description: ""
tags: [Python, Business, Retail, Data, Code]
image:
  feature: post/python_for_business/cover01.png
  credit: https://www.425degree.com/
comments: true
share: true
date: 2018-03-16 22:30:00

---

## ท้าวความเดิม จาก [Part 1](https://tupleblog.github.io/Python-for-Business-part1/)

เราได้หัดการใช้ Python อ่านข้อมูลจากไฟล์ Excel ต่างๆ, เตรียมข้อมูลให้พร้อมในการใช้งาน, ประกอบรายงานใหม่ขึ้นมา และ Export ไฟล์ลงไปที่ Directory ที่เลือกไว้ (Read -> Clean -> Join -> Export) ซึ่งในที่สุดเราได้รายงานภาพรวมธุรกิจมา 2 ชิ้นคือ 1. รายงานสรุปยอดสินค้าขายต่อวันเทียบสินค้าคงเหลือ 2. รายงานสรุปกำไรรายสินค้าต่อวันเทียบจำนวนคงเหลือ

สำหรับ Part 1 เราได้เคลียร์ 3 ข้อนี้จบไป
1. อ่านข้อมูลจาก Spreadsheet ที่ต้องการ (Load Data)
2. เตรียมข้อมูลให้พร้อมในการใช้งาน (Clean Data)
3. แสดงผลแบบ Pivot Table และ เขียนกลับไปเป็น Spreadsheet (Export Data)

ส่วนใน Part 2 เราจะมาต่อกันที่ 2 ข้อนี้กันนะครับ

1. เขียน Function Search สินค้า (Filter Data)
2. Plot Graph ให้เห็นภาพรวม (Data Visualization)

สำหรับเนื้อหาครั้งนี้ ขอขอบคุณ [425degree.com](https://www.425degree.com/) ที่เอื้อเฟื้อข้อมูลเบื้องตันให้ ข้อมูลและตัวอย่างโค้ดได้ถูกดัดแปลงเพื่อให้เหมาะกับ Tutorial ในครั้งนี้ [ซึ่งผมรวมไว้ที่ลิ้งนี้แล้วครับ](https://github.com/tupleblog/tuple_code/tree/master/python_for_business)

ผู้อ่านท่านใดสนใจซื้อ เคส กระเป๋า หูฟัง เรียนเชิญที่ร้านนี้ครับ สั่งง่าย ส่งไว ได้ของชัวร์ครับ

## Motivation

รายงานภาพรวมที่เราเพิ่งทำกันไป สามารถให้ insight เราได้หลายอย่าง แต่ก็เป็นเพียงคำตอบหนึ่งของคำถามอีกมากมายที่เหล่าพ่อค้าแม่ขายอยากจะรู้ครับ

ลองคิดถึงสถานการณ์ว่ามีลูกค้ามาติดต่อซื้อของที่ร้าน หลายครั้งลูกค้าสนใจอยากรู้แค่ราคาของสินค้าหรือแค่อยากรู้ว่าที่ร้านมีสินค้าพร้อมขายไหม สำหรับเหตุการณ์ดังกล่าวคุณลูกค้า(หรือแม้แต่ตัวพ่อค้าเอง)ไม่จำเป็นต้องรู้รายละเอียดส่วนอื่นๆในร้านเลยก็ได้ ซึ่งรายงานภาพรวมที่เราทำกันไปแล้วก็มีข้อมูลมากมายหลากหลายเหลือเกิน รายงานนี้จึงอาจไม่เหมาะจะใช้ในสถานการณ์ดังกล่าวซะทีเดียว ซึ่งวันนี้เราจะเขียน Function แสดงข้อมูลเฉพาะบางส่วนจากรายงานภาพรวมกันนะครับ

อีกเหตุการณ์ที่น่าสนใจคือ สมมุติว่าพ่อค้ากำลังวางแผนการตลาด / วางแผนสินค้าคงคลัง เขาอาจจะต้องการเข้าใจสถานการณ์ของยอดขายย้อนหลังตลอด 6 เดือนที่ผ่านมา ซึ่งรายงานภาพรวมของเราก็พอให้ insight ได้บ้างแต่พอมีตัวเลขเยอะมากๆเข้าก็อาจจะดูไม่ถนัดแล้วทำให้การสื่อสาร / ตัดสินใจผิดพลาดไป กรณีนี้เราจะทำ Data Visualization มาเพื่อแสดงภาพรวมที่แท้จริงและใช้เป็นไกด์ไลน์สำหรับการค้นคว้าขั้นต่อๆไปด้วยครับ

## เริ่มเนื้อหาตรงนี้เลยนะครับ

### Filter Data

เราลองมาอุ่นเครื่องกันก่อนด้วยการทำความเข้าใจการ Filtering Data

การทำ Filter คือการกรองข้อมูลที่เตรียมไว้เรียบร้อยแล้วมาแสดงผลเฉพาะแค่บางส่วนเพื่อให้ได้คำตอบที่ต้องการครับ ถ้าให้เปรียบเทียบก็เหมือนการร่อนทองออกจากโคลนครับผม

ยกตัวอย่างว่าเราต้องการทราบกำไรรายสินค้าต่อวันเทียบจำนวนคงเหลือ แต่อยากรู้แค่ 7 วันย้อนหลังเท่านั้น เราสามารถทำได้โดยการคัดกรอง รายงานสรุปกำไรรายสินค้าต่อวันเทียบจำนวนคงเหลือที่เราสร้างไว้แล้วใน [Part 1](https://tupleblog.github.io/Python-for-Business-part1/) ซึ่งโค้ดจะหน้าตาประมาณนี้ครับ
```py
pivot_Order_profit[pivot_Order_profit.columns[pd.np.r_[-3,-11:-4,-2,-1]]].sort_values('GrossProfit7D', ascending=False)
```
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_filter01.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      รายงานสรุปกำไรรายสินค้าต่อวันเทียบจำนวนคงเหลือ 7 วันย้อนหลัง เรียงจากมากไปน้อย
    </a>
  </figcaption>
</center></figure>

ผมขออธิบายแจกแจงโค้ดเล็กน้อยนะครับเพราะต่อไปจะใช้เทคนิคนี้บ่อยหน่อย หลายๆท่านจะได้เข้าใจเนื้อหาได้ง่ายขึ้นด้วย

โค้ดด้านล่างนี้ผมใช้สำหรับสร้างชุดตัวเลขขึ้นมาครับ โดยที่ตัวเลขชุดนี้มี `type` เป็น `array` หรือ `numpy.ndarray` หากผู้อ่านจำใน Part 1 ได้ เราเคย import pandas และ numpy เอาไว้แล้ว จังหวะจะใช้ก็ต้องตอนนี้แล้วครับผม
```py
pd.np.r_[-3,-11:-4,-2,-1]
```
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_filter02.png" data-action="zoom"/>
</center></figure>

ส่วนโค้ดนี้ใช้เลือกชื่อของหลัก(Header)ที่ต้องการแสดงผลนะครับ โดยเป็นหลักที่เราเลือกถูกกำหนดโดยตัวเลข -3, -11,.. เป็นต้นนะครับ และที่เราไม่ใส่ `[ -3, -11, -10,  -9,  -8,  -7,  -6,  -5,  -2,  -1]` ลงไปตรงๆเลยก็เพราะ `df.columns[...]` ของ pandas แกรับ input เฉพาะ `numpy.ndarray` เท่านั้น
```py
pivot_Order_profit.columns[pd.np.r_[-3,-11:-4,-2,-1]]

# pivot_Order_profit.columns สั่งให้แสดงเฉพาะ Header ....
# pd.np.r_[-3,-11:-4,-2,-1] กำหนดตำแหน่งของ Header อีกที
```
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_filter03.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      แสดง Header ที่ต้องการคัดกรอง
    </a>
  </figcaption>
</center></figure>

ซึ่ง Header ดังกล่าวก็จะใส่เข้าไปใน `pivot_Order_profit[....]` ใช้สำหรับการคัดกรองข้อมูลที่ต้องการแสดง พร้อมกันนี้ผมขอจัดอันดับกำไรสินค้า 7 วันย้อนหลังจากมากลงไปน้อยด้วย method `.sort_values('GrossProfit7D', ascending=False)`
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_filter04.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      ดูโค้ดพร้อมผลลัพธ์ชัดๆอีกที
    </a>
  </figcaption>
</center></figure>

### รู้จักกับ Function (สำหรับ Beginner เท่านั้น)

เราเพิ่งทำ Filtering Data ไป ทุกอย่างเรียบร้อยสวยงามยกเว้นเรื่องเดียวครับคือโค้ดมันยาวเหยียดเหลือเกิน ทำให้มีโอกาสพิมพ์ผิดและเกิด Error ได้ง่าย ดังนั้นเราควรสร้าง Function เพื่อแสดงผลลัพธ์โดยที่เป้าหมายของ Function คือทำให้แสดงผลได้ด้วยโค้ดสั้นๆ

สำหรับผู้อ่านที่ยังไม่รู้จัก Function นะครับ อธิบายคร่าวๆได้ว่า Function เป็นการรวบรวมชุดคำสั่งและไปขึ้นไว้กับชื่อๆนึง โดยถ้าชื่อดังกล่าวนั้นถูกเรียกใช้งานเมื่อไร ชุดคำสั่งภายใต้ชื่อนั้นจะถูกเรียกไปด้วยครับ

ลองยกตัวอย่างจากโค้ดด้านบนนะครับ method `.sort_values(...)` เป็นคำสั่งที่ทำหน้าที่เรียงลำดับเลขให้เรา ซึ่งหากถามผมว่า `.sort_values(...)` ใช้วิธีการอะไร ตรรกะแบบไหนในการจัดเรียงลำดับเลขให้เรา ผมคงต้องตอบว่าไม่รู้เหมือนกันเพราะชุดคำสั่งก็ถูกซ่อนอยู่ภายใต้ชื่อ `.sort_values(...)` แต่รู้อยู่อย่างเดียวและอย่างเดียวก็พอ คือ `.sort_values(...)` มันเรียงเลขให้เราได้จริงๆ

Ok! สรุปสิ่งที่ได้เรียนรู้จาก `.sort_values(...)` ก็คือผู้ใช้ Function ไม่จำเป็นต้องรู้รายละเอียดว่า Function นั้นทำงานยังไงแต่รู้แค่ว่ามันทำอะไรได้ก็พอ! และพอถึงจังหวะจะใช้ก็ call Function มาใช้เลยครับ

***method และ function มีความแตกต่างในรายละเอียดอยู่บ้าง สำหรับผู้ที่สนใจอ่านเพิ่มเติมเกี่ยวความแตกต่างระหว่าง method และ function นะครับ [เชิญอ่านต่อที่ลิ้งนี้เลยครับ](https://stackoverflow.com/questions/155609/difference-between-a-method-and-a-function)***

Function ของ python มีโครงสร้างประมาณนี้ครับผม หากโค้ดบล็อคใดๆมีย่อหน้า(indentation)อยู่ถัดเข้าไปทางขาวของย่อหน้า `def` ชุดคำสั่งดังกล่าวก็จะไปขึ้นอยู่กับ `function_name` นั้นๆโดยที่มี input เป็น `parameters` และ output เป็น `something` ครับ
```py
def function_name(parameters):
    |
    <code block>
    |
    return something
```

### ตัวอย่าง Function สำหรับ Tutorial นี้

ลองสมมุติว่าพ่อค้าอยากรู้กำไรต่อวันเทียบจำนวนคงเหลือ 7 วันย้อนหลังแต่แสดงผลเฉพาะสินค้าที่มีชื่อนี้รหัสนั้น โดยพ่อค้าจะใส่ Keyword เข้าไปเป็นชื่อสินค้าหรือรหัสสินค้าก็ได้แล้วได้คำตอบออกมาเลย ซึ่ง Keyword ที่ใส่เข้าไปอาจจะใส่ตัวเล็กตัวใหญ่แบบไหนก็ได้นะครับ

เราน่าจะพอเขียน Function สำหรับคัดกรองคำตอบไปประมาณนี้ครับผม
```py
def profit_table_any_cond(string):
    def profit_table_detail(string):
        return pivot_Order_profit[pivot_Order_profit['รายละเอียด'].str.contains(string, case=False, na=False)][pivot_Order_profit.columns[pd.np.r_[-3,-11:-4,-2,-1]]].sort_values('GrossProfit7D', ascending=False)

    def profit_table_SKU(string):
        return pivot_Order_profit[pivot_Order_profit.index.str.contains(string, case=False, na=False)][pivot_Order_profit.columns[pd.np.r_[-3,-11:-4,-2,-1]]].sort_values('GrossProfit7D', ascending=False)
    return pd.concat([profit_table_detail(string), profit_table_SKU(string)])
```
ยังจำคำสั่ง `pivot_Order_profit.columns[pd.np.r_[-3,-11:-4,-2,-1]]` ด้านบนกันได้อยู่ใช่ไหมครับ ส่วนนี้ให้ผลลัพธ์เป็น Header สำหรับการกรองข้อมูลนะครับ ใครลืมก็ย้อนไปดูด้านบน

`pivot_Order_profit['รายละเอียด'].str.contains(string, case=False, na=False)` คำสั่งนี้ใช้คัดกรองเฉพาะรายการที่ชื่อสินค้าตรงกับ Keyword ที่พ่อค้าใส่เข้ามานะครับ โดยที่เราจะไม่สนใจตัวเล็กตัวใหญ่ และเราข้าม Missing Value ไปด้วยเลยนะครับ

ส่วน `pivot_Order_profit.index.str.contains(string, case=False, na=False)` จะเกี่ยวกับ Keyword ฝั่งรหัสสินค้า(เป็น index ของเราตั้งแต่ Part 1)

ผู้อ่านจะพอเห็นอยู่ว่า function ที่เราสร้างขึ้นมาเป็น function ที่ซ้อนใน function อีกทีนึงหรือที่เราเรียกกันว่า Nested function นะครับ โดยผลลัพธ์สุดท้ายของ Top-level Function `profit_table_any_cond(string)` จะเป็นผลลัพธ์ 2 function ย่อยของเรา(`profit_table_detail(string)` และ `profit_table_SKU(string)`)รวมกันครับ ซึ่งผลลัพธ์สุดท้ายจะถูกรวมออกมาโดยใช้โค้ดว่า `return pd.concat([profit_table_detail(string), profit_table_SKU(string)])`

*หากใครอยากรู้เพิ่มเติมเกี่ยวกับ Nested Function [อ่านได้จากลิ้งนี้ครับ](https://stackoverflow.com/questions/1589058/nested-function-in-python)*

หากเราลองรันคำสั่ง `profit_table_any_cond('uS317')` ดูจะได้คำตอบอย่างในรูปนะครับ *ผู้อ่านอาจจะลองเปลี่ยน* `'uS317'` *เป็น* `'utj urbana'`*หรือสับเปลี่ยนตัวอักษรเล็กใหญ่ดูได้ครับ*
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_filter05.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      3 คำสั่งในภาพจะให้ผลลัพธ์แบบเดียวกัน เนื่องจากกรองข้อมูลออกมาได้ชุดเดียวกันทั้งหมด
    </a>
  </figcaption>
</center></figure>

ทำนองเดียวกันเราสามารถสรุปยอดสินค้าขายต่อวันเทียบสินค้าคงเหลือ 7 วันย้อนหลังแบบเจาะจงสินค้าได้โดยใช้ Function แบบครั้งก่อนได้เลยแต่แตกต่างกันที่ Function ใหม่ใช้ข้อมูลยอดขายแทนข้อมูลกำไร
```py
def order_table_any_cond(string):
    def order_table_detail(string):
        return pivot_Order_box[pivot_Order_box['รายละเอียด'].str.contains(string, case=False, na=False)][pivot_Order_box.columns[pd.np.r_[-3,-11:-4,-1,-2]]]

    def order_table_SKU(string):
        return pivot_Order_box[pivot_Order_box.index.str.contains(string, case=False, na=False)][pivot_Order_box.columns[pd.np.r_[-3,-11:-4,-1,-2]]]
    return pd.concat([order_table_detail(string), order_table_SKU(string)])
```

ลอง call Function `order_table_any_cond(string)` ดูซักหน่อยโดยใช้ `'Us347'` เป็น input Keyword
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_filter06.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      แสดงยอดสินค้าขายต่อวันเทียบสินค้าคงเหลือ 7 วันย้อนหลังของสินค้าที่มีรหัส US347
    </a>
  </figcaption>
</center></figure>

แถมอีกสัก Function ละกัน อันนี้เอาไว้แสดงราคาขายกับสต็อก โดยที่อันไหนมีคำว่า `'เลิก'` แล้วก็ไม่่ต้องโชว์ครับผม จะได้บอกลูกค้าถูกว่าของชิ้นนี้ราคาเท่าไร มีของพร้อมส่งไหม
```py
def filter_Stock_any_cond(string):
    def filter_Stock_by_detail(string):
        return df_Stock[df_Stock['รายละเอียด'].str.contains(string, case=False, na=False)][df_Stock.columns[pd.np.r_[0,1,2]]][df_Stock['รายละเอียด'].str.contains('เลิก') == False]

    def filter_Stock_by_SKU(string):
        return df_Stock[df_Stock.index.str.contains(string, case=False, na=False)][df_Stock.columns[pd.np.r_[0,1,2]]][df_Stock['รายละเอียด'].str.contains('เลิก') == False]
    return pd.concat([filter_Stock_by_detail(string), filter_Stock_by_SKU(string)])
```

Call `filter_Stock_any_cond('Us347')` จะได้ผลในรูปด้านล่าง ซึ่งเห็นได้ชัดเจนว่า US347-AL-C (เลิก)Phosphorescence Glowing iPhone X Case Windu ที่เคยมีคำตอบใน `order_table_any_cond('Us347')` ไม่มีอยู่ในคำตอบของ `filter_Stock_any_cond('Us347')`
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_filter07.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      ข้อมูล SKU, รายละเอียด, ราคาขาย, Stock จากการรัน filter_Stock_any_cond('Us347')
    </a>
  </figcaption>
</center></figure>

## Data Visualization : “A picture is worth a thousand words"

ขอย้อนกลับไปใน Part 1 ที่เราปิดงานด้วยการทำรายงานภาพรวมธุรกิจ แล้วลองเปิดไฟล์กำไรที่เรา Export ไว้ จะได้หน้าตาประมาณนี้ครับ
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_visualize01.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      ไฟล์ profit_ย้ายแล้วจ้า.xlsx ที่ Export ไว้ใน Part 1
    </a>
  </figcaption>
</center></figure>

ตัวรายงานแม้ว่าจะมีความสมบูรณ์แค่ไหน แต่ถ้ามีตัวเลขเยอะๆแบบนี้ก็ตาลายได้เหมือนกันครับ ยิ่งถ้าต้องการโฟกัสเฉพาะบาง SKU ยกตัวอย่างเช่น US347-AL เรายิ่งดูไม่ออกเลยว่าช่วงไหนขายดี ข่วงไหนยอดตก กลายเป็นว่ารายงานที่ทำออกมาเพื่อให้เห็นภาพรวมกลับไม่สามารถบรรลุวัตถุประสงค์ได้

นี้เป็นเพราะข้อมูลมีเยอะเกินไปจนสมองของเราประมวลผลไม่ทันครับ ซึ่งเราจะแก้โดยใช้ Data Visualization มาเล่าภาพรวมให้เราเข้าใจ ให้เราเห็นภาพ ซึ่งจริงๆแล้วรูป Cover ที่ผู้อ่านเห็นด้านบนก็คือผลงาน Data Visualization ที่เราจะทำกันในวันนี้แหละครับ

Library สำหรับการทำ Visualization ของ Python มีให้เลือกมากมายทีเดียวครับ แต่ที่ผมเลือกใช้ในวันนี้ชื่อ bokeh ครับ เหตุผลที่ใช้คือ bokeh ไม่เสียตังครับ ฮ่าๆๆๆ นอกจากนี้ยังสามารถพล็อตแบบ interactive ด้วย ความหมายคือเราสามารถคลิกๆลากๆภายในกราฟและได้เห็นข้อมูลที่เปลี่ยนไปตาม action ของเราได้เลยครับ

บอกก่อนว่าการพล็อตค่อนข้างเป็นศิลปะครับ มันไม่ตายตัว ซึ่งที่จะทำใน Tutorial นี้ก็เป็นแค่หนึ่งในสิบล้านวิธีการพล็อตสำหรับข้อมูลชุดนี้นะครับ

โดยในพล็อตตัวอย่าง ผมจะทำ [Punch card Plot - GitHub Style](https://bokeh.pydata.org/en/latest/docs/gallery/unemployment.html) จากข้อมูลกำไรรายสินค้าต่อวันและการฟีเจอร์อื่นๆที่อยากได้สำหรับพล็อตนี้ก็คือ
1. สามารถไล่สีของพล็อตตามตัวเลขในรายงานได้
2. มีแถบสีสำหรับชี้แจ้งว่าสีนี้แปลว่าตัวเลขอะไร
3. สามารถเอาเม้าส์ไปจ่อที่พล็อตแล้วพล็อตแจ้งข้อมูลอื่นๆเพิ่มเติมเฉพาะในตำแหน่งเม้าสได้ (Interactive plotting)
<figure><center>
  <img width="800" src="/images/post/python_for_business/cover.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      Punch card Plot - GitHub Style ก็จะหน้าตาประมาณนี้ครับ
    </a>
  </figcaption>
</center></figure>

*สำหรับพล็อตแบบอื่นๆของ bokeh ลองเช็คดูใน [Gallery](https://bokeh.pydata.org/en/latest/docs/gallery.html) ของเค้าได้ครับ*

## import bokeh

Ok! เรามาสร้างกราฟกันโดยเริ่มจากการเรียก Libray เข้ามาครับ แต่เราไม่ได้เอามาทั้ง bokeh นะครับแต่จะเรียกเฉพาะที่จำเป็นสำหรับ [Punch card Plot - GitHub Style](https://bokeh.pydata.org/en/latest/docs/gallery/unemployment.html)
```py
from bokeh.io import show, output_notebook
from bokeh.models import (ColumnDataSource,
                          HoverTool,
                          LinearColorMapper,
                          BasicTicker,
                          PrintfTickFormatter,
                          ColorBar)
from bokeh.plotting import figure
```

จะพล็อตให้ดีก็ต้องมีข้อมูลให้พร้อมครับ ว่าแล้วก็เรียกข้อมูลกำไรรายสินค้าต่อวันย้อนหลัง 7 เดือนและตั้งชื่อข้อมูลว่า `data` นะครับ ซึ่ง `data` ก็คือ `pivot_Order_profit` ที่ตัดข้อมูลที่ไม่เกี่ยวของออกไปก่อน เช่น รายละเอียด จำนวนสินค้าคงเหลือ เป็นต้น

พร้อมกันนี้เราก็ตั้งชื่อหลัก(Column) ชื่อแถว(index) และตั้งตัวแปรไว้ใช้งานในอนาคตด้วยเลย
```py
# ข้อมูลหลัก
data = pivot_Order_profit[pivot_Order_profit.columns[pd.np.r_[-214:-4]]]

# ตั้งชื่อ + ตั้งตัวแปรเพิ่มเติม
data.columns.name = 'Date'
data.index.name = 'SKU'
SKU = list(data.index)
date = list(data.columns)
```
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_visualize02.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      ลองเรียก data จะได้ข้อมูลชุดนี้ครับ
    </a>
  </figcaption>
</center></figure>

แต่ข้อมูลชุดนี้มีปัญหานิดหน่อยครับตรงที่ bokeh ไม่เข้าใจข้อมูลที่ถูก pivot ไปแล้ว เพราะฉะนั้นเราต้องเอาตาราง pivot มาจัดเรียงให้เป็นตารางแบบก่อน pivot ครับ

โชคดีที่ Pandas มีคำสั่งเฉพาะทางให้เลยทำให้เราไม่ต้องมาเรียงด้วยมือ โดยเราจะใช้ method `.stack()` ในการจัดเรียงข้อมูล โค้ดอาจจะยาวหน่อยแต่ไม่ต้องตกใจไปครับ
```py
# ทำการปรับข้อมูลแล้วตั้งชื่อให้ชื่อใหม่ว่า df_plot
df_plot = pd.DataFrame(data.stack(), columns=['GProfit']).reset_index().join(pivot_Order_profit['รายละเอียด'], on='SKU').reset_index().rename(columns={"รายละเอียด": 'detail'})
```
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_visualize03.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      หน้าตาของตารางใหม่ df_plot
    </a>
  </figcaption>
</center></figure>
อธิบายโค้ด : สำหรับชื่อหลัก, ชื่อแถวของวันที่และรหัสสินค้าเราตั้งไว้แล้วตั้งแต่โค้ดก่อนหน้านะครับ ส่วน `columns=['GProfit']` ใช้ตั้งชื่อหลักของตัวเลขกำไรในข้อมูล นอกจากนี้เรายังได้ `.join(pivot_Order_profit['รายละเอียด']` เพื่อให้มีข้อมูลรายละเอียดสินค้าสำหรับแต่ละ SKU และปิดท้ายด้วยการเปลี่ยนชื่อหลัก `'รายละเอียด'` เป็น `'detail'` เพราะว่าภาษาอังกฤษทำงานง่ายกว่าสำหรับ bokeh

หลังจากเตรียมข้อมูลแล้ว เรามาดู setup ของพล็อตกันบ้าง ซึ่งเราจะเริ่มกันที่การเล่นสีนะครับโดยผมจะแบ่งสีเป็น 25 ขั้นจากแดงอ่อนไปแดงเข้มและมีความห่างขั้นละ 200(บาท) ถ้านับกำไรจาก 0 ก็จะไปสุดที่ 5000 บาทพอดีครับ โดยสีจะถูก map ให้ตรงกับเลขกำไรที่ทำขั้นบันไดเอาไว้

นอกจากนี้ feed ข้อมูลเข้าไปได้เลย แล้วก็ทำ tools bar ไว้ใช้ขยาย บันทึก รีเซ็ตกราฟ ฯลฯ
```py
colors = ['#feeaea',
'#fcdcdc',
'#facdcd',
'#f9bebe',
'#fab1b1',
'#faa3a3',
'#f99292',
'#f68080',
'#f17070',
'#ed6161',
'#e54f4f',
'#df4040',
'#d83131',
'#d12323',
'#c71616',
'#be0a0a',
'#b20303',
'#a40202',
'#950101',
'#870101',
'#750101',
'#670101',
'#5c0101',
'#4d0101',
'#3d0101', ]

mapper = LinearColorMapper(palette=colors, low=0, high=5000)

source = ColumnDataSource(df_plot)

TOOLS = "hover,save,pan,box_zoom,reset,wheel_zoom"
```

setup ต่างๆพร้อมแล้วก็ประกอบร่างกันเลย : วาง Layout, กำหนดช่องไฟ, แล้วก็ลงสีเข้าไปในช่องได้เลย

หากใครงงโค้ดไม่ต้องตกใจนะครับ ลองตามๆไปก่อน เพราะโค้ดส่วนนี้ผมเองก็[ลอกจากตัวอย่าง](https://bokeh.pydata.org/en/latest/docs/gallery/unemployment.html)มาตรงๆเหมือนกันครับ
```py
# figure ทำหน้าที่เป็น Layout ของกราฟ, กำหนดความกว้าง ความสูง และตำแหน่งของ Element ต่างๆ
p = figure(title = '425 Profit by SKU (from {0} to {1})'.format(date[0], date[-1]),
           x_range = SKU, y_range=list(reversed(date)),
           x_axis_location = 'above', plot_width = len(data.index) * 12, plot_height = 1600,
           tools = TOOLS, toolbar_location="below")

# ส่วนนี้ใช้ customize ขนาด องศา และช่องไฟ
p.grid.grid_line_color = None
p.axis.axis_line_color = None
p.axis.major_tick_line_color = None
p.axis.major_label_text_font_size = '5pt'
p.axis.major_label_standoff = 0
p.xaxis.major_label_orientation = 1

# rect เอาไว้ลงสีในกรอบบสี่เหลี่ยมครับผม โดย feed data ที่เตรียมไว้เข้ามาและลงสีเข่้มอ่อนตามที่ map เอาไว้กับตัวเลขกำไร
p.rect(x='SKU',y='Date',width=1, height=1,
       source=source,
       fill_color={'field': 'GProfit', 'transform':mapper},
       line_color=None)

output_notebook() # กำหนดให้แสดงผลใน tab เดิม

show(p, notebook_handle=True) # คำสั่งแสดงผลงาน
```
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_visualize04.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      Data Visualization 1st attempt
    </a>
  </figcaption>
</center></figure>

กราฟมาแล้ว! เรียกว่ามาถูกทางเลยครับ แต่ยังต้องเพิ่มเติม Color bar เอาไว้ใช้เป็น reference ในการอ่านข้อมูล นอกจากนี้ยังขาดการจัดเรียงข้อมูล interactive ให้สวยๆ ว่าแล้วก็ไปลุยกันต่อเลยจ้า
```py
# setup color bar กันก่อน โดยให้แบ่งเป็น 25 สีและ mapper เข้าไปตามเลขกำไร
color_bar = ColorBar(color_mapper=mapper, major_label_text_font_size = '5pt',
                     ticker=BasicTicker(desired_num_ticks=len(colors)),
                     label_standoff=6, border_line_color=None, location=(0, 0))

# เพิ่ม color bar ไว้ทางขวาของกราฟ เอาไว้ดูเป็น reference
p.add_layout(color_bar, 'right')

# กำหนดการแสดงข้อมูลเวลาเอาเม้าส์ไปจ่อบนกราฟ ให้แสง SKU, รายละเอียด, กำไร และวันที่ของแต่ละ plot
p.select_one(HoverTool).tooltips = [
     ('SKU', '@SKU'),
     ('รายละเอียด', '@detail'),
     ('GProfit', '@GProfit{1,111.11} THB'),
     ('Date', '@Date'),
]

output_notebook() # กำหนดให้แสดงผลใน tab เดิม

show(p, notebook_handle=True) # คำสั่งแสดงผลงาน
```
<figure><center>
  <img width="800" src="/images/post/python_for_business/data_visualize05.png" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      Data Visualization final attempt
    </a>
  </figcaption>
</center></figure>
พล็อตกราฟย้อนหลัง 6 เดือนมันก็จะดูคูลๆหน่อยครับ สิบปากว่าไม่เท่าตาเห็นจริงๆ

Data Visualization ช่วยให้เราเห็นภาพอย่างแท้จริง รู้เลยว่าสินค้าตัวไหนให้กำไรเยอะ ตัวไหนเป็นสินค้ามาใหม่ ตัวไหนสร้างยอดต่อเนื่อง ทำให้พ่อค้าบ้านๆอย่างเรานำข้อมูลไปวางแผนงานต่างๆได้ตรงประเด็นมากขึ้นเยอะครับ ^^

## สรุปทั้ง 2 Part

และแล้วก็มาถึงจุดสิ้นสุดของ Tutorial นี้นะครับ เราลองมาทบทวนอีกครั้งว่าเราได้อะไรกันไปบ้าง

ใน Part 1 เราได้ใช้ Python ในการเตรียมรายงานภาพรวมธุรกิจให้เรา เริ่มจากการการนำข้อมูลที่มีมาทำการปรับปรุงให้พร้อมใช้งาน(Read -> Clean -> Join) และ Export รายงานออกมา ซึ่งเราสามารถใช้ Script เดิมรันข้อมูลใหม่ๆได้ทุกวัน เหมาะกับรายงานที่ต้องทำเป็นประจำ

ส่วนใน Part 2 เราได้ใช้ Python ในการเขียน Function ในการคัดกรองรายละเอียดสินค้าแบบเจาะลึก และได้ทำ Data Visualization อย่างง่ายกัน

อย่างไรก็ตามสิ่งที่สำคัญไม่น้อยกว่าการวิเคราะห์ข้อมูลก็คือการเก็บข้อมูลนะครับ เราควรปรับวิธีการบันทีกข้อมูลเป็นประจำและหมั่นตรวจสอบรอยรั่วของการเก็บข้อมูลเหล่านั้น

สำหรับ Tutorial นี้ หากมีผิดพลาดผมต้องขออภัยอีกครั้งนะครับและขอขอบคุณผู้อ่านทุกท่านที่สละเวลามาอ่าน blog นี้

ไว้เจอกันใหม่ blog ถัดไปนะครับ สวัสดี
> สุดท้ายนี้ ผมขอขอบคุณจารย์ตุลย์ [@bluenex](https://github.com/bluenex) และ จารย์มาย [@titipata](https://github.com/titipata) ที่ช่วยพิสูจน์อักษรทั้ง 2 Part ขอขอบคุณ [425degree](https://www.425degree.com/)ที่ช่วยสนับสนุนข้อมูลเบื้องต้นให้นะครับ
