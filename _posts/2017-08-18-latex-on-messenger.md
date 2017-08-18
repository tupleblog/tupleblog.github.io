---
author: tulakann
layout: post
title: "[nerd] Facebook Messenger รองรับการเรนเดอร์ (La)TeX Math แล้ว"
description: ""
tags: [Facebook, Messenger, Latex, Math, Code]
image:
  feature: post/latex_messenger/cover.jpg
  credit: Wikimedia Common
comments: true
share: true
date: 2017-08-18 14:30:00
---

สวัสดีครับผู้อ่านทุกท่าน วันนี้เราก็มีเรื่องเนิร์ดๆ กีคๆ มานำเสนออีกเช่นเคย โดยความเนิร์ดวันนี้ก็คือการที่ได้รับรู้ว่า Facebook Messenger รองรับการเรนเดอร์ [LaTeX](https://www.latex-project.org/) syntax แล้วจ้า โดยพวกเรารู้มาจากเพื่อนของ [@bachkukkik](https://www.facebook.com/kukkik.oparad) อีกที เนื่องจากยังหาข่าวหรืออ้างอิงที่ไหนไม่เจอนอกจาก[กระทู้นี้จาก Reddit](https://www.reddit.com/r/Physics/comments/6uc6fg/psa_latex_now_renders_on_facebook_messenger/) ก็จะขอเขียนจากเท่าที่ได้ลองเล่นดูละกัน โดยการเรนเดอร์แบบพิเศษนี้หลักๆ จะแบ่งเป็น TeX Math block กับ Inline code และ Fence code block ที่แสดงผลแตกต่างกัน เกริ่นแค่นี้พอ ลองไปเล่นจริงๆ กันดูเลยดีกว่า

## TeX Math block

เนื่องจากทางบล็อกเราค่อนข้างจะชื่นชอบการใช้งาน LaTeX อยู่ไม่น้อย บล็อกเก่าๆ เกี่ยวกับ LaTeX ก็มีอยู่บ้าง ([1](https://tupleblog.github.io/latex-on-atom/), [2](https://tupleblog.github.io/latex-ieeetran/), [3](https://tupleblog.github.io/bibtex-ieeetran/)) พอเห็นฟีเจอร์นี้มาก็อดตื่นเต้นไม่ได้ เล่นกันรัวๆ และจะมาแบ่งคนอื่นเล่นกันบ้าง เริ่มกันเลย

Facebook Messenger รองรับการเรนเดอร์ TeX Math ในรูปแบบที่แตกต่างจากปกติเล็กน้อยผ่านการครอบด้วย `$$` เช่น `$$ LaTeX syntax $$` ซึ่งเอนจินที่ใช้ในการเรนเดอร์ก็คือ [KaTeX](https://github.com/Khan/KaTeX) ซึ่งเป็น JS library ที่ช่วยในการเรนเดอร์ TeX Math นั่นเอง เรามาลองดูตัวอย่างกันเลยดีกว่า

ถ้าเราเขียนสมการนี้ `$$ x + y = 1 $$` มันก็จะเรนเดอร์ออกมาได้แบบนี้

<figure><center>
  <img src="/images/post/latex_messenger/latex1.jpg" data-action="zoom"/>
</center></figure>

ลองไปดูที่ซับซ้อนขึ้นมานิดนึง เป็นอันนี้ `$$ x=\frac{1+y}{1+2z^2} $$` สมการจะออกมาเป็นแบบนี้

<figure><center>
  <img src="/images/post/latex_messenger/latex2.jpg" data-action="zoom"/>
</center></figure>

ตัวอย่างสุดท้าย ลองเมตริกซ์กันไปเลย แบบนี้

```
A_{m,n} =
 \begin{pmatrix}
  a_{1,1} & a_{1,2} & \cdots & a_{1,n} \\
  a_{2,1} & a_{2,2} & \cdots & a_{2,n} \\
  \vdots  & \vdots  & \ddots & \vdots  \\
  a_{m,1} & a_{m,2} & \cdots & a_{m,n}
 \end{pmatrix}
```

จะได้ออกมาเป็น

<figure><center>
  <img src="/images/post/latex_messenger/latex4.jpg" data-action="zoom"/>
</center></figure>

สำหรับคนที่น่าจะได้ใช้ ก็คงต้องมีตื่นเต้นกันไม่มากก็น้อยแหละ (มั้ยอะ) เวลาคุยกับเพื่อนร่วมงานที่จำเป็นต้องใช้สมการอะไรพวกนี้ หรืออยากให้สมการที่เขียนเวลาคุยงานดูดีมีระดับก็สามารถทำได้ไม่ยากเลย ผ่าน Facebook Messenger นี่เอง อย่างไรก็ดีข้อจำกัดของการใช้ TeX Math syntax นี้คือไม่สามารถผสมกับการเขียนบรรยายได้ ก็คือถ้าเราต้องการจะแชร์สมการก็ต้องเขียนแต่สมการอย่างเดียวในข้อความนั้นแล้วค่อยอธิบายในข้อความต่อๆ ไป

## Code block

สำหรับเพื่อนๆ โปรแกรมเมอร์ เวลาที่เราต้องการจะแชร์ snippet กับเพื่อนก็มักจะใช้ [Markdown (md)](https://en.wikipedia.org/wiki/Markdown) ซึ่งเป็นภาษา Markup ที่ใช้ง่ายภาษานึงกัน แต่ **md** มันก็มีให้ใช้แค่บน GitHub, Bitbucket หรือ Slack อะไรพวกนั้น แต่ตอนนี้ Facebook Messenger ก็เริ่มสนับสนุนการแชร์โค้ดผ่านแชทแล้วเช่นกัน อันนี้ไม่รู้ว่าใช้เอนจินอะไรในการเรนเดอร์เหมือนกันแต่ก็ออกมาโอเคทีเดียว เรามาเริ่มกันที่ Inline code ก่อน

### Inline code

สำหรับ inline code ก็มักจะเอาไว้ใช้เวลาเราจะเขียนตัวแปร สมการสั้นๆ หรือค่าตัวเลขต่างๆ รวมเข้าไปกับการบรรยาย เพื่อให้ฟ้อนต์นั้นดูแตกต่างจากตัวหนังสือโดยรอบ ตัวอย่างเช่นถ้าเราเขียน

```
หนึ่งในสมการความสัมพันธ์ระหว่างระยะทาง เวลา และความเร็ว เขียนได้ว่า `S = ut + 1/2a(t^2)`
```

มันจะเรนเดอร์ออกมาเป็น

<figure><center>
  <img width="800" src="/images/post/latex_messenger/code1.jpg" data-action="zoom"/>

  <figcaption>
    <a title="Inline Code 1">
      เปรียบเทียบระหว่างการใช้ Inline code (บน) และไม่ใช้ (ล่าง)
    </a>
  </figcaption>
</center></figure>

ซึ่งคนที่ไม่ได้สนใจเท่าไหร่อาจจะเห็นว่ามันไม่ต่างกัน แต่ถ้าสังเกตอีกนิดจะเห็นว่าแบบที่ใช้ Inline code จะอ่านง่ายกว่าเนื่องจากฟ้อนต์ถูกเรนเดอร์ออกมาเป็น [Monospace](https://en.wikipedia.org/wiki/Monospaced_font) แล้วนั่นเอง สิ่งที่ทำให้ Code block แตกต่างจาก LaTeX Math ก็คือมันจะไม่เรนเดอร์ออกมาเป็นเครื่องหมายทางคณิตศาสตร์ได้นั่นเอง

### Fence code block

ในส่วนของ Fence code block บน Facebook Messenger นี้จะพิเศษสักหน่อย เพราะหลังเรนเดอร์จะมีสีพื้นหลังที่เปลี่ยนไปด้วย แต่หลักการใช้งานนั้นจากที่ลองเล่นดูคิดว่ามีความคล้ายกับ [GitHub Flavored Markdown (GFM)](https://help.github.com/articles/creating-and-highlighting-code-blocks/) มากๆ เลย ก็เลยจะขอหยิบบางตัวอย่างจากทาง GitHub มาแสดงบนนี้ด้วย

ขอยกตัวอย่างด้วย snippet ของภาษา JavaScript (JS) ที่มาจาก GitHub นี้ละกัน

~~~
```
  function test() {
    console.log("notice the blank line before this function?");
  }
```
~~~

จะเรนเดอร์ออกมาแบบนี้

<figure><center>
  <img src="/images/post/latex_messenger/code2.jpg" data-action="zoom"/>
</center></figure>

แต่ความพิเศษมันอยู่ตรงที่เราสามารถไฮไลท์ syntax ของแต่ละภาษาได้ด้วย เพียงแค่เพิ่มชื่อภาษาเข้าไปหลัง <code>```</code> นั่นเอง แบบนี้

~~~
```javascript
  function test() {
    console.log("notice the blank line before this function?");
  }
```
~~~

code ที่เรนเดอร์แล้วก็จะออกมามีสีไฮไลท์อย่างที่มันควรจะเป็นแบบนี้เลย แท่นน

<figure><center>
  <img src="/images/post/latex_messenger/code3.jpg" data-action="zoom"/>
</center></figure>

## คอมเม้นต์ส่งท้าย

จบกันไปแล้วสำหรับการยกตัวอย่างเท่าที่เราลองเล่นเองแล้วเจอมา หวังว่าคงจะเป็นประโยชน์(?)สำหรับผู้ที่สนใจทุกท่านได้ลองไปใช้ไปเล่นกันดู จริงๆ แล้วสิ่งที่มันเจ๋งที่สุดก็คือมันดูดีอ่านง่ายขึ้นนี่แหละ ถึงแม้ว่าอาจจะยังไม่สมบูรณ์เท่าไหร่และยังไม่มี documentation แต่เชื่อว่าอีกไม่นานน่าจะมีตามออกมาแน่นอน (ถ้าเค้าไม่เปลี่ยนใจพับแผนเก็บน่ะนะ) สำหรับบล็อกนี้ก็คงจะมีเท่านี้ ขออภัยสำหรับรูปที่อาจจะเยอะไปสักหน่อย ถ้าใครไปเล่นมาเจออะไรเด็ดๆ กว่านี้ก็เอามาแชร์กันบ้างนะครับ

สวัสดี
