---
author: tulakann
layout: post
title: Github Pages ยกเครื่องใหม่ เร็วขึ้นด้วย Jekyll 3.0
description: "เมื่อเร็วๆ นี้ Github ได้โพสต์บล็อกกล่าวถึงการอัพเกรดเครื่องในมาใช้ Jekyll 3.0 และเนื่องจากบล็อกนี้ก็พึ่งพิง Github Pages กับ Jekyll อย่างเต็มตัว พอมีอะไรเปลี่ยนแปลงก็ควรจะเขียนถึงสักหน่อย"
tags: [Github, Jekyll, Update]
image:
  feature: post/ghpjk/ghp-cover.jpg
comments: true
share: true
---

เมื่อเร็วๆ นี้ Github ได้โพสต์บล็อก [GitHub Pages now faster and simpler with Jekyll 3.0](https://github.com/blog/2100-github-pages-now-faster-and-simpler-with-jekyll-3-0) กล่าวถึงการอัพเกรดเครื่องในมาใช้ Jekyll 3.0 และเนื่องจากบล็อกนี้ก็พึ่งพิง Github Pages กับ Jekyll อย่างเต็มตัว พอมีอะไรเปลี่ยนแปลงก็ควรจะเขียนถึงสักหน่อย

การอัพเกรดในครั้งนี้ Github ต้องการที่จะทำให้การใช้งาน Github Pages ร่วมกับ Jekyll นั้นง่ายและเร็วขึ้นด้วยการอัพเกรดเวอร์ชันของ Jekyll มาเป็นรุ่น(เกือบ)ล่าสุด รวมไปถึงทำให้ประสบการณ์ในการเขียน Markdown นั้นใกล้เคียงกับที่ใช้กันบน Github.com มากที่สุดด้วย สำหรับประเด็นหลักๆ ที่ Github ได้กล่าวถึงก็มีประมาณนี้

### ปรับการสนับสนุนเอนจิน Markdown
Markdown อาจเปรียบได้กับภาษากลางของชุมชน open source แต่ก็ไม่ได้หมายความว่ามันจะมีรูปแบบการเขียนที่เป็นหนึ่งเดียว ดังนั้นมันก็เลยเกิด fragmentation ขึ้นจากการที่มันมีหลายเอนจินให้เลือกใช้ ทาง Github ก็ตัดสินใจแก้ปัญหานี้โดยการสนับสนุนเอนจินเดียวนั่นก็คือ [**kramdown**](http://kramdown.gettalong.org/) ใครที่ยังใช้ [Rdiscount](https://github.com/davidfstr/rdiscount) หรือ [Redcarpet](https://github.com/vmg/redcarpet) อยู่ก็ยังคงเรนเดอร์ได้ตามปกติจนถึงวันที่ 1 พฤษภาคม 2016 นี้ โดยผลการคอมไพล์อาจจะช้าสักหน่อยและตามมาด้วยอีเมล์แจ้งเตือน Deprecation จาก Github สิ่งที่เราต้องทำก็เพียงไปแก้เอนจินของเราในไฟล์ `_config.yml` ให้ใช้ **kramdown** ซะ หรือไม่ก็ลบตรงส่วน Markdown ออกไปเลยก็ได้

### ปรับการสนับสนุน Highlighter
ในสายนักพัฒนาโปรแกรมแน่นอนว่าจะต้องมีการเขียนโค้ด ซึ่งการเน้น syntax ต่างๆ ก็เป็นสิ่งสำคัญที่จะช่วยให้เราอ่านโค้ดได้เร็วขึ้น โดยแต่เดิม Jekyll สนับสนุุน Highlighter หลายตัวเช่น Pygments, Coderay และ Rouge แต่ในการยกเครื่องครั้งล่าสุดนี้ Github Pages จะสนับสนุนแค่เพียง **Rouge** เท่านั้น

โดยปกติเมื่อเราต้องการจะเน้นสีของโค้ดใน Jekyll เราจะต้องใช้ [Liquid tag highlight](http://jekyllrb.com/docs/templates/#code-snippet-highlighting)  แต่จากการเปลี่ยนมาใช้ **kramdown** + **Rough** เราสามารถที่จะใช้ [backtick-style fenced code blocks](https://help.github.com/articles/creating-and-highlighting-code-blocks/) เหมือนการเขียน Markdown ปกติได้เลย

### เร่งความเร็ว
สิ่งที่เห็นได้ชัดอย่างหนึ่งของ Jekyll 3.0 คือรัน local ได้เร็วขึ้น นอกจากนี้ยังมีฟีเจอร์ใหม่ซึ่งก็คือ **Liquid profiler** โดยเติม `--profile` เข้าไปตอนรัน Jekyll จะแสดงผลการ build ของเพจดังภาพ ทำให้เราสามารถรู้ได้ว่ามีตรงไหนที่เราจะทำให้มันเร็วขึ้นได้อีกมั้ย

<figure><center>
  <img src="https://cloud.githubusercontent.com/assets/282759/12624447/1f0d3928-c4fd-11e5-86f7-64d5a6d581b7.png" data-action="zoom"/>
</center></figure>

### อื่นๆ
- Jekyll เลิกสนับสนุน relative permalinks ตั้งแต่เวอร์ชัน 2.0 ดังนั้นในการอัพเกรดครั้งนี้ก็ทำให้ Github Pages เลิกสนับสนุนตามไปด้วย อย่างไรก็ตามปัญหานี้จะเกิดก็ต่อเมื่อเราประกาศใช้ `relative_permalinks: true` เท่านั้น

- Github Pages จะเลิกสนับสนุน Textile โดยให้เปลี่ยนมาใช้ Markdown แทนภายในวันที่ 1 พฤษภาคม 2016 นี้

หลักๆ ก็ประมาณนี้ ถ้าใครใช้อะไรที่มันกำลังจะโดนทิ้งก็ได้ฤกษ์เปลี่ยนกันแล้วล่ะ สำหรับ tupleblog นั้นเราใช้ [HPSTR theme](https://github.com/mmistakes/hpstr-jekyll-theme) ซึ่งใช้ Coderay เป็น highlighter ตอนนี้ก็เลยโดนเตือนรัวๆ

```bash
  Deprecation: You are using 'enable_coderay', use syntax_highlighter: coderay in your configuration file.
  Deprecation: You are using 'kramdown.coderay' in your configuration, please use 'syntax_highlighter_opts' instead.
  Deprecation: You are using 'coderay_line_numbers'. Normalizing to line_numbers.
  Deprecation: You are using 'coderay_line_numbers_start'. Normalizing to line_numbers_start.
  Deprecation: You are using 'coderay_tab_width'. Normalizing to tab_width.
  Deprecation: You are using 'coderay_bold_every'. Normalizing to bold_every.
  Deprecation: You are using 'coderay_css'. Normalizing to css.
```

บล็อกเราโคลน repo ของ HPSTR มาเป็นเวลานานมากแล้ว ตั้งแต่ยังไม่มีการสนับสนุน Jekyll 3.0 เดี๋ยวก็คงต้องมานั่งทำให้มันรองรับทุกอย่างตามการอัพเกรดของ Github Pages ในครั้งนี้เร็วๆ นี้ สำหรับการอัพเกรดในเครื่องเราเพื่อ local preview ก็ทำได้ไม่ยาก ฝากไว้ตรงนี้เลยละกัน

### การติดตั้ง Jekyll สำหรับ Github Pages
1. เช็คเวอร์ชันของ Ruby ก่อนโดยรัน `ruby --version` อย่างน้อยต้องเวอร์ชัน 2.0.0 ถ้าไม่ถึงหรือไม่มีก็ตามไปอ่านวิธีติดตั้งได้ [ที่นี่](https://www.ruby-lang.org/en/downloads/) เลย
2. ลง Bundler ด้วยก็จะดี เพื่อช่วยจัดการกับแพคเกจต่างๆ ที่ใช้กับ Jekyll ได้ง่ายขึ้น หรือจะไม่ลงก็แล้วแต่ความสะดวกใจ `gem install bundler`
3. ลง Jekyll ผ่าน github-pages gem โดยถ้าไม่ได้ลง bundler ก็ให้ใช้ `gem install github-pages` แทน แต่อาจมีปัญหากับการจัดการแพคเกจบ้างเล็กน้อยซึ่งก็ต้องไปงมกันต่อไป แต่ถ้าลง bundler จากข้อเมื่อกี้ก็ให้สร้างไฟล์ชื่อ `Gemfile` ใน root ของ repo โดยในไฟล์ใส่ตามด้านล่าง แล้วก็รัน `bundle install` เป็นอันเสร็จ

```bash
source 'https://rubygems.org'
gem 'github-pages'
```

### แก้ไขไฟล์ \_config.yml
เอาตามนี้เลยละกัน จริงๆ ไม่ต้องใส่อะไรเลยก็ได้ Github Pages จะเรนเดอร์โดยตั้งค่าเริ่มต้นเป็น kramdown กับ Rouge เอง แต่ถ้าจะตั้งก็ตามนี้เลยก็ได้
{% highlight bash %}
markdown: kramdown
kramdown:
  input: GFM
highlighter: rouge
# The release of Jekyll Now that you're using
version: v3.0.2
{% endhighlight %}

สำหรับบล็อกนี้ก็จบตรงนี้ละกัน มาใช้ Github Pages กันเยอะๆ นะ :)


ที่มา - [Github blog](https://github.com/blog/2100-github-pages-now-faster-and-simpler-with-jekyll-3-0)
