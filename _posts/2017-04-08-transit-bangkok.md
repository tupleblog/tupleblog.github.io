---
layout: post
title: เก็บข้อมูลจาก Bangkok Transit และเขียนฟังก์ชันง่ายๆ
author: Titipata
description: เก็บข้อมูลจากเว็บไซต์ Bangkok Transit แต่สุดท้ายเพื่อตระหนักได้ว่าพวกเราควรมีเว็บไซต์ขนส่งมวลชนที่ดีกว่านี้
image:
  feature:
tags: [Data, Data Science, Python]
comments: true
date: 2017-04-08 21:45:00
read_time: 25
---

จริงๆแล้วเราเป็นคนที่ใช้บริการขนส่งมวลชนมาตลอดเลยนะ ปกติแล้วก็ไม่ได้ขับรถอะไร
เวลาเดินทางในกรุงเทพฯ จะไปหาที่จอดรถแต่ละที บางทีเดินหรือวิ่งเอาเร็วกว่าซะด้วยซ้ำ

พอพูดถึงเวลาจะเดินทางในกรุงเทพฯ สมัยนี้ทุกคนก็คงเลือกใช้ Google Maps กันหมดแล้ว
แต่จริงๆแล้วรู้รึเปล่าว่าเราก็มีเว็บไซต์ขนส่งมวลชนเหมือนกัน ลองเข้าไปดูกันได้ที่ [transitbangkok.com](http://www.transitbangkok.com/)

ถ้าถามเราว่าทำไมเราต้องมีข้อมูลพวกนี้ด้วย แค่ใช้ Google ก็พอมั้ง  ในส่วนตัวของเราคิดว่าการที่กรุงเทพฯมีข้อมูลพวกนี้อยู่กับตัวเอง
ถือว่าเป็นเรื่องที่ดีมาก ลองคิดดูว่าถ้ากรุงเทพฯสามารถเก็บข้อมูลต่างๆที่เกี่ยวกับขนส่งมวลชนได้ด้วยตัวเอง ซึ่งไม่ใช่แค่เก็บว่าป้ายรถเมล์อยู่ที่ไหน หรือเดินทางจากที่นึงไปอีกที่นึงต้องไปยังไงบ้าง แต่มีขึ้นมูลอื่นๆที่เกี่ยวข้องกับการเดินทางด้วย เช่น คนเดินทางจากที่ไหนไปที่ไหนช่วงไหนบ้าง

ลองนึกดูว่าถ้ากรุงเทพฯ สามารถเก็บข้อมูลพวกนี้ได้ เค้าสามารถเอาข้อมูลมาวิเคราะห์​แล้วก็ออกแบบระบบขนส่งมวลชนที่ดีขึ้นได้ในอนาคต
ถ้าเรามัวแต่พึ่ง Google Maps ก็เหมือนเราให้คนอื่นมองจากข้างนอก
แต่เราไม่สามารถเข้าใจจังหวัดของเราเลย

เวิ่นไปซะเยอะ ซึ่งไม่น่าจะช่วยอะไรได้ เราลองมาดูภาพรวมก่อนว่าเราทำอะไรกับเว็บนี้ได้บ้าง

[transitbangkok.com](http://www.transitbangkok.com/) เป็นเว็บดีไซน์ใช้งานไม่ยากมาก
เว็บนี้เก็บข้อมูลของป้ายรถเมล์และเส้นทางเดินรถสายต่างๆในกรุงเทพฯ นอกจากนั้นเราสามารถเสิร์ชหาเส้นการเดินทาง จากป้ายนึงไปอีกป้ายนึงได้ด้วย เช่น จากจุฬาฯไปสีลม เป็นต้น

ในโพสต์นี้ เราจะมาลองเก็บข้อมูลจากเว็บไซต์กัน โดยใช้ไลบรารี่ที่ชื่อว่า `BeautifulSoup`
นอกจากนั้น เราจะเขียน python function เพื่อให้เรา
ใส่ข้อมูลจุดตั้งต้นและปลายทางของการเดินทาง แล้วให้วิธีการเดินทางออกมาว่าต้องเดินทางไปยังไง

ใครที่อยากจะเข้าไปดูโค้ดเต็มๆก็เข้าไปดูได้ที่ [github.com/titipata/bangkok_transit](https://github.com/titipata/bangkok_transit)
ขอบคุณ `@bluenex` และ `@bachkukkik` ที่ช่วยเช็คโค้ดด้วย นั่งเขียนกันตอนดึกมากๆนอกเวลางาน
บางทีก็เบลอเขียนตัวแปรผิดๆถูกๆ


<figure><center>
  <img width="auto" src="/images/post/transit/front_page.png" data-action="zoom"/>
</center></figure>


## เก็บข้อมูล

เราเริ่มกันที่หน้า [transitbangkok.com/bangkok_bus_routes.php](`http://www.transitbangkok.com/bangkok_bus_routes.php`) ซึ่งเป็นหน้าที่เก็บข้อมูลของป้ายรถเมล์ต่างๆในกรุงเทพฯ
หน้าที่ของเราคือเก็บลิงค์ของแต่ละป้ายรถเมล์มา จากนั้นใช้ลิงค์เข้าไปแต่ละเพจเพื่อเก็บว่ารถเมล์สายไหนผ่านบ้าง

หน้าตาขอโค้ดที่ใช้เก็บลิงค์เป็นประมาณนี้

```py
import requests
from bs4 import BeautifulSoup

body = requests.get('http://www.transitbangkok.com/bangkok_bus_routes.php')
soup = BeautifulSoup(body.text, "lxml")
stations = []
for link in soup.find_all('a'):
    if '/stations/' in link.get('href'):
        stations.append(link.get('href'))
stations = list(set(stations))
```

ส่วนโค้ดที่ใช้เข้าไปเก็บข้อมูลแต่ละหน้า   ลองดูได้[ที่นี่](https://github.com/titipata/bangkok_transit/blob/master/transit.py#L23-L51)

ใครที่ไม่อยากโหลดเอง เราได้เก็บข้อมูลของป้ายรถเมล์และสายรถเมล์ที่วิ่งผ่านไว้ใน CSV file แล้ว[ที่นี่เลย](
https://raw.githubusercontent.com/titipata/bangkok_transit/master/data/stations.csv)


## เสิร์ชป้ายใกล้เคียง

บางทีเวลาเสิร์ชชื่อป้ายรถเมล์​หรือจุดที่เราจะไป ถ้าใน Google เค้ามี auto-correction หรือแก้คำผิดให้ แต่สำหรับ Python นั้น มีไลบรารี่ที่ติดมาด้วยชื่อว่า `difflib` โดยใน `difflib` นี้มีฟังก์ช่ันติดมาด้วยที่ช่วยให้เราหาคำที่เขียนใกล้เคียงได้ชื่อว่า `get_close_matches`

อันนี้ไว้ใช้เวลา input ของเราเขียนเกือบถูกแล้ว แต่อาจจะมีเขียนผิดไปตัวนึง เราก็ยังแก้คำให้ไป
ใกล้เคียงที่สุดกับสถานีที่เรามี

จากนั้นเราแค่เอาสถานีทั้งหมดมาต่อกัน (`list1 + list2`) แล้วก็ใช้ `get_close_matches` หาได้เลย

```py
from difflib import get_close_matches

stations_english = [station['station_name'] for station in stations]
stations_thai = [station['station_thai_name'] for station in stations]
station_closest = get_close_matches(query , stations_thai + stations_english, n=1, cutoff=0.6)
```

ถ้าโหลด `transit.py` มา ข้างในนั้นจะมีฟังก์ชันชื่อ `transit.query_station('บางรัก', stations)`
โดยฟังก์ชันนี้จะรีเทิร์นป้ายที่มีชื่อใกล้เคียงที่สุดกับที่เราใส่เข้าไป


## วีธีการไปจากจุดเริ่มต้นถึงจุดสุดท้าย

[transitbangkok.com](http://www.transitbangkok.com/) มี query format หรือว่า
พูดง่ายๆคือเราสามารถส่งป้ายสถานีไปบนเว็บไซต์แล้วมันจะให้วิธีการเดินทางกลับมา โดย query มีหน้าตาประมาณนี้ (`station_start`, `station_end` คือป้ายรถเมล์ภาษาอังกฤษตาม)

```py
query_link = 'http://www.transitbangkok.com/showBestRoute.php?from=%s&to=%s&originSelected=false&destinationSelected=false&lang=en' \
            % (station_start['query'], station_end['query'])
```

`%s` ใน Python เป็นวิธีแทนสตริงเข้าไป เช่น `"hello %s" % "world" = "hello world"` เป็นต้น


ท้ายสุดแล้ว เราแค่ส่ง query ไปให้ที่เว็บไซต์แล้วเก็บข้อมูลมาเป็นอันจบ

```py
route_request = requests.get(query_link)
soup_route = BeautifulSoup(route_request.content, 'lxml')
descriptions = soup_route.find('div', attrs={'id': 'routeDescription'})

route_descrtions = []
for description in descriptions.find_all('img'):
    action = description.next_sibling
    to_station = action.next_sibling
    n = action.find_next_siblings('a')
    if 'travel' in action.lower():
        lines = [to_station.find_next('b').text] +  [a.contents[0] for a in n]
    else:
        lines = []
    desp = {'action': action,
            'to': to_station.text,
            'lines': lines}
    route_descrtions.append(desp)
```

จริงๆแล้ว format ของเว็บไซต์นี้มันทำให้เราดึงข้อมูลออกมาลำบากกว่านี้เยอะ ลองไปดูโค้ดเต็มๆกันได้
เราแค่โชว์โค้ดส่วนที่ดูตรงไปตรงมา แต่จริงๆแล้วมันซับซ้อนกว่านี้เล็กน้อย

ถ้าเราจัดรูปแบบถูกต้อง หน้าตาของ output ที่ได้จะเป็นประมาณนี้

```py
[{'action': 'Walk by foot to ',
  'lines': [],
  'to': 'Sanam Luang'},
 {'action': 'Travel to ',
  'lines': ['2', '15', '44', '47', '201', '203', '512'],
  'to': 'Khok Wua'},
 {'action': 'Walk by foot to ',
  'lines': [],
  'to': 'Democracy Monument'},
 {'action': 'Travel to ',
  'lines': ['59', '157', '159', '503', '509'],
  'to': 'Sanam Pao'}]
```

สำหรับคนที่ใช้ `transit.py` ก็เขียนแค่ข้างล่างได้เลย

```py
transit.get_commute_instruction('ท่าพระจันทร์', 'สนามเป้า', stations)
```

## อารัมภบท

ในบล้อกนี้เราได้พูดถึงเว็บไซต์ transit ของกรุงเทพฯ และเข้าไปดูว่ามี data อะไรที่เราดึงออกมาใช้ได้บ้าง

นอกจากนั้นเราก็เขียนฟังก์ชันในภาษา Python เพื่อหาวิธีการเดินทางมาดูได้โดยตรงจากเว็บไซต์

แต่พอเก็บข้อมูลมาทั้งหมดแล้ว ทำให้ตระหนักได้ว่า เห้ย! ทำไมกรุงเทพฯที่เป็นเมืองใหญ่ขนาดนี้
ซึ่งต้องมีระบบการคมนาคมที่ต้องใช้ครอบคลุมทั้งพื่นที่ แต่ข้อมูลที่ระบบการคมนาคมในกรุงเทพฯมีนั้นช่างน้อยนิด

น้อยนิดในที่นี้คือเรามีข้อมูลของรถเมล์เพียง 200 และป้ายรถเมล์เพียง 300 ป้าย

ถึงเวลาแล้วที่ระบบการคมนาคมควรเปลี่ยนแปลง (เว็บไซต์)?
