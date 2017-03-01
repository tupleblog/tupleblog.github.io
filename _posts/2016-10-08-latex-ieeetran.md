---
author: tulakann
layout: post
title: บันทึกการใช้คลาส IEEEtran บน LaTeX สำหรับ IEEE conference paper [1]
description: "การเขียนครั้งนี้รู้สึกว่าเปิดกูเกิลไปเยอะมาก ซึ่งก็ได้รวบรวมลงบุคมาร์คไปเรียบร้อย แต่มันก็คงจะดีกว่าถ้าเอามาเขียนรวมๆ กันในที่เดียว"
tags: [Latex, IEEE, Conference, Paper]
image:
  feature: post/latexieee/feature.jpg
  credit: IEEE
  creditlink: http://ctan.megagod.net/tex-archive/macros/latex/contrib/IEEEtran/IEEEtran_HOWTO.pdf
comments: true
share: true
date: 2016-10-08 00:30:00
---

ห่างหายการเขียนบล็อกไปนาน ในที่สุดก็กลับมาอีกครั้ง คราวนี้มาแนววิชาการนิดๆ กีคหน่อยๆ เกี่ยวกับเครื่องมือที่ใช้ในการเขียนเปเปอร์ ซึ่งก็คือ LaTeX นั่นเอง บล็อกนี้จะไม่เกริ่นถึงการติดตั้งละ ทึกทักเอาเองว่ามีอยู่ในเครื่องแล้ว ใช้เป็นระดับนึงแล้ว แต่ถ้าเป็นผู้เริ่มต้นใหม่เลยและมีความสนใจอยากลองติดตั้งก็ลองอ่าน[บล็อกเก่า](http://tupleblog.github.io/latex-on-atom/)ดูได้ครับ ในบล็อกนี้จะกล่าวถึงการใช้ LaTeX เขียนเปเปอร์สำหรับประชุมวิชาการที่ IEEE เป็นผู้ดูแลเป็นหลัก โดยการอ้างอิงในบล็อกนี้จะมีตัวช่วยคือ BibTeX และ Mendeley อย่างไรก็ตามสำหรับเราแล้วการเขียนเปเปอร์วิชาการนี่มันยากจริงๆ ยากจนรู้สึกพ่ายแพ้ขณะเขียน ย่ิงเป็นพวกกลัวโดนจับผิด จะอ้างแต่ละทีก็ลำบากจิตลำบากใจยิ่งนัก เพราะงั้นในบล็อกนี้เราจะไม่พูดถึงเทคนิคการเขียนเปเปอร์อย่างไรให้ดีแม้แต่น้อย ว่ากันแต่เรื่องเครื่องมือล้วนๆ วิชาการส่งไปทางนู้น [@titipata](https://twitter.com/titipat_a) เพราะทางนี้ไม่ค่อยสันทัดเท่าไหร่ฮะ

เช่นเคยเรายังคงใช้ Atom เขียน LaTeX อยู่เหมือนบล็อกเก่าที่แปะไว้ข้างบนแต่สำหรับโปรแกรมเปิด pdf นั้นได้ย้ายมาใช้ [Skim](http://skim-app.sourceforge.net/) แทนแล้ว (ถ้าใครอยู่บนวินโดว์ก็น่าจะใช้ [Adobe Reader](https://get.adobe.com/reader/) ได้นะ) เนื่องมาจาก[แพคเกจที่ใช้เปิด pdf ในอะตอม](https://atom.io/packages/pdf-view)นั้นทำงานค่อนข้างช้าเมื่อเปเปอร์เริ่มมีความเยอะ ส่วนแพคเกจอะตอมอื่นๆ ที่ต้องติดตั้งเพิ่มจากบล็อกเก่าก็จะมี [latexer](https://atom.io/packages/latexer) ที่ช่วยได้มากเวลาเราจะอ้างถึงเปเปอร์ที่อยู่ในไฟล์ BibTeX

# เตรียมความพร้อม
ถึงบรรทัดนี้ก็สมมติว่าพร้อมเขียนละ แต่เพื่อความลื่นไหลในการอ่านเราจะดาวน์โหลดและติดตั้งสิ่งที่จำเป็นให้ครบซะก่อนที่จะไปต่อ ทั้งแพคเกจบน LaTeX รวมไปถึงโปรแกรมจัดการสื่ออ้างอิง

## LaTeX template
สำคัญมากอันนี้ เพราะเราจะไม่เขียนเองทั้งหมดแน่นอน ทาง IEEE ก็เตรียมไว้ให้อย่างเพียบพร้อมที่[หน้าเว็บนี้](http://www.ieee.org/conferences_events/conferences/publishing/templates.html) หรือถ้าอยากกดตรงๆ เลยก็จิ้มข้างล่าง

- [LaTeX Archive Contents (PDF, 63 KB)](http://www.ieee.org/documents/IEEEtran.zip)
- [LateX Bibliography Files](http://www.ieee.org/documents/IEEEtranBST2.zip)

ซึ่งเค้าก็มี[เปเปอร์วิธีใช้งาน](http://ctan.megagod.net/tex-archive/macros/latex/contrib/IEEEtran/IEEEtran_HOWTO.pdf)มาให้ด้วย (รูปที่ใช้เปิดบล็อกนี้ที่เห็นข้างบนนั่นแหละ) เขียนไว้ค่อนข้างละเอียด บล็อกนี้จริงๆ แล้วก็สรุปสิ่งที่(คิดว่า)จำเป็นมาจากคอมเมนต์ในเทมเพลตกับเปเปอร์นี้แหละ ถ้าใครสงสัยตรงไหนเพิ่มเติมก็ลองตามไปอ่านที่ต้นทางดูได้ครับ

## LaTeX packages
แพคเกจที่เราต้องเพิ่มมาเองจะมีหลักๆ ก็คือ `breakurl`, `hyperref`, `multirow` และ `booktabs` แต่ถ้าใครลง LaTeX ตัวเต็มเราก็ไม่แน่ใจเหมือนกันว่าจะต้องลงมั้ย ยังไงก็ลองลงดูก่อนได้ ถ้ามี Tex Live Utility ก็ใช้ตามสะดวก หรือถ้าไม่มีก็รันคำสั่งเอาก็ได้

```bash
sudo tlmgr install <package name>
```

## Reference Manager
ที่มีอยู่ก็หลายเจ้ามาก ที่คุ้นๆ หูกันก็อาจจะเป็น Endnote ที่มีความผูกพันธ์อย่างเหนียวแน่นกับ MS Word แต่ก็่อย่างที่เกริ่นไว้ว่าบล็อกนี้จะใช้ Mendeley อะเนาะ เพราะงั้นก็ติดตั้งเลยดีกว่า ([ไปหน้าดาวน์โหลด](https://www.mendeley.com/download-mendeley-desktop/)) หรือถ้าใครใช้อย่างอื่นอยู่แล้วที่สามารถคัดลอกข้อมูลผู้แต่งออกมาเป็น BibTeX entry ได้ก็ใช้อันนั้นเลยก็ได้ครับ

## เริ่มสำรวจไฟล์เทมเพลต
ทีนี้เรามาแตกไฟล์ที่โหลดมาเมื่อกี้จะพบว่ามีอยู่สองโฟลเดอร์ซึ่งก็คือ IEEEtran กับ IEEEtranBST2 โดยภายในแต่ละโฟลเดอร์ก็จะมีไฟล์เต็มไปหมด แต่ไฟล์ที่เราจะใช้กันในตอนนี้มีเท่านี้

### IEEEtran

- IEEEtran.cls
- bare_conf.tex

### IEEEtranBST2

- IEEEabrv.bib
- IEEEexample.bib
- IEEEfull.bib
- IEEEtran.bst
- IEEEtranS.bst

โดยที่ไฟล์หลักที่เราจะทำการแก้ไขคือ bare_conf.tex นั่นเอง ก่อนจะเริ่มทุกสิ่งก็ให้สร้างโฟลเดอร์สำหรับโปรเจคขึ้นมาแล้วก็ copy ไฟล์ที่จะใช้ไปรวมกันไว้ จากนั้นก็เปลี่ยนชื่อ bare_conf.tex ซะหน่อย บล็อกนี้เปลี่ยนเป็น my_conf_paper.tex ตอนนี้เราก็จะมีโฟลเดอร์สำหรับเปเปอร์นี้พร้อมทั้งไฟล์ที่ต้องใช้หน้าตาแบบนี้

<figure><center>
  <img src="/images/post/latexieee/folder.png" data-action="zoom"/>
</center></figure>

## ลองคอมไพล์ครั้งแรก
มาถึงจุดนี้เราก็จะมาลองคอมไพล์กันดูว่าหน้าตาเทมเพลตของเปเปอร์นี้จะออกมาเป็นยังไง เวลาคอมไพล์ก็ใช้แพคเกจ `latex` บนอะตอมนี่แหละ ปุ่มลัดคือ `ctrl`+`alt`+`b` เมื่อคอมไพล์เสร็จโปรแกรมที่ใช้ในการเรียกไฟล์ตามที่ตั้งค่าไว้ในแพคเกจ `latex` จะถูกเรียกขึ้นมา เนื่องจากบล็อกนี้คงไม่เขียนอะไรเยอะเลยตั้งค่าให้ใช้ `pdf-view` เพื่อแสดงในอะตอมไปเลยละกัน

_**NOTE** หลังจากใช้ `pdf-view` ไปสักพักก็พบความช้าอย่างคาดไม่ถึง เลยกลับไปใช้ Skim เหมือนเดิม.._

<figure><center>
  <img src="/images/post/latexieee/openinatom.png" data-action="zoom"/>

  <figcaption>
    <a title="">
      ตั้งค่าให้แสดงไฟล์ pdf บนอะตอมที่นี่ อย่าลืมลงแพคเกจ pdf-view
    </a>
  </figcaption>
</center></figure>

ไฟล์ที่ได้ออกมาก็จะหน้าตาโล้นๆ ประมาณนี้

<figure><center>
  <img src="/images/post/latexieee/firstbuild.png" data-action="zoom"/>
</center></figure>

ลองสังเกตในโฟลเดอร์ดูจะพบว่ามีไฟล์แปลกๆ ขึ้นมาหลายอันเช่น `.log` `.aux` เป็นต้น ซึ่งพวกนี้เป็นไฟล์จำเป็นในกระบวนการคอมไพล์ เราสามารถลบได้ด้วยปุ่มลัด `ctrl`+`alt`+`c`

# การใช้คลาส IEEEtran
ในที่สุดก็ได้เข้าเรื่องซะที ขออภัยที่เกริ่นเยอะไปหน่อย มาถึงตรงนี้การเขียนก็ไม่ใช่เรื่องยากอีกต่อไป จริงๆ ก็แค่เลื่อนๆ หาสิ่งที่เราต้องการแก้ ส่วนมากก็จะเป็น `\section{}` กับ `\subsection{}` แล้วก็เพิ่มลดอะไรไปตามสะดวก เดี๋ยว LaTeX จะจัดการจัดหน้าและเว้นช่องไฟตัวอักษรให้อย่างสวยงามเอง เนื่องจากมันง่ายขนาดนี้ บล็อกนี้ก็เลยจะมาพูดถึงสิ่งที่มันไม่ได้โชว์หรือเปิดใช้มาตั้งแต่ต้นกัน โดยจะเริ่มไล่ไปตามคอมเมนต์ในไฟล์ my_conf_paper.tex ตั้งแต่บรรทัดที่ 66-67 เป็นต้นไป

## Citation packages
บรรทัดที่ 95 จะเจอ `\usepackage{cite}` อยู่ ก็จัดการ uncomment โลด จริงๆ แล้วเหมือน cite เป็น built-in module แต่เค้าใส่มาให้ก็เปิดซะหน่อย

```tex
% *** CITATION PACKAGES ***
%
\usepackage{cite}
% cite.sty was written by Donald Arseneau
```

## Graphics related packages
บรรทัดที่ 116-154 อันนี้สำคัญมาก เพราะเป็นแพคเกจที่ช่วยในการจัดการไฟล์รูปภาพต่างๆ ที่เราจะเอาใส่เข้ามาในเปเปอร์ เปิดใช้งานก็ uncomment เช่นเคย

```tex
{% raw %}
\ifCLASSINFOpdf
  \usepackage[pdftex]{graphicx}
  % declare the path(s) where your graphic files are
  \graphicspath{{../pdf/}{../jpeg/}{images/}}
  % and their extensions so you won't have to specify these with
  % every instance of \includegraphics
  \DeclareGraphicsExtensions{.pdf,.jpeg,.png,.jpg}
\else
{% endraw %}
```

ตรงนี้จะมีส่วนช่วยให้ชีวิตสะดวกนิดนึงคือ `\graphicspath{}` ที่จะให้กำหนดที่ที่เราจะเก็บไฟล์รูปภาพไว้ ในที่นี้ให้เราไปสร้างโฟลเดอร์เพิ่มในโฟลเดอร์โปรเจคเช่น images แล้วก็เติม path เข้าไปเป็น {% raw %}`\graphicspath{{../pdf/}{../jpeg/}{images/}}`{% endraw %} อีกอย่างที่ชีวิตจะสะดวกขึ้นก็คือ `\DeclareGraphicsExtensions{.pdf,.jpeg,.png,.jpg}` ที่ประกาศฟอร์แมตภาพที่รองรับ เวลาใส่รูปก็ไม่ต้องใส่นามสกุลเลยถ้ามันอยู่ในนี้ ในที่นี้ให้เพิ่ม `.jpg` เข้าไปหน่อย ถึงแม้มันจะเหมือน `.jpeg` แต่มันเรียกแทนกันไม่ได้

## URL breaking & Table formatter packages
อันนี้ไม่มีละต้องเพิ่มมาเอง ในที่นี้เราเพิ่มไปที่บรรทัด 301 ตามนี้

```tex
% *** URL BREAKING PACKAGES ***
\usepackage{url}
\usepackage{breakurl}
\usepackage[breaklinks]{hyperref}
% break line both / and -
\def\UrlBreaks{\do\/\do-}

% *** TABLE FORMATTER PACKAGES ***
% Use to format table in case multirow needed
\usepackage{multirow}
\usepackage{booktabs}
```

ซึ่งแพคเกจกลุ่มแรกใช้ในการจัดลิงค์ที่ใส่ไว้ใน References ให้สวยงามยิ่งขึ้น โดยการตัดขึ้นบรรทัดใหม่เมื่อเจอ `/` และ `-` หรือใครจะเพิ่ม `_` ก็ตามสะดวก ขึ้นอยู่กับว่า References ที่เราอ้างนั้นมันมีลิงค์ที่มีสัญลักษณ์พวกนี้มากน้อยแค่ไหน ส่วนกลุ่มหลังช่วยในการวาดตารางบน LaTeX ให้ดูสวยงามขึ้นในระดับนึง

## การใส่สมการ
การใส่สมการเป็นหนึ่งในจุดแข็งของ LaTeX เนื่องจากมันเรนเดอร์ออกมาได้สวยมาก และเราไม่ต้องไปจัดอะไรมันให้เหนื่อยใจ นอกจากนี้เรายังสามารถ label สมการเพื่อที่จะอ้างถึงได้อีกด้วย สำหรับข้อมูลเพิ่มเติมเช่นสัญลักษณ์ต่างๆ หรือการเขียนพวกเศษส่วนตัวห้อยตัวยก ก็แนะนำ[เว็บนี้จาก Sharelatex](https://www.sharelatex.com/learn/Mathematical_expressions) ไว้ให้ไปอ่านกัน

การเขียนสมการใน LaTeX เขียนได้สองแบบหลักๆ คือแบบสร้าง environment ซึ่งมันจะนับจำนวนสมการทั้งหมดแล้วแสดงเลขกำกับสมการให้อัตโนมัติ กับอีกแบบก็คือไม่สร้าง ยกตัวอย่างด้วยการเขียนจริงเลยละกัน

```tex
% start from line 528
\section{Equation}
This section shows how we can write the equation in LaTeX. The
$y = mx + c$ is supposed to be in-line equation. Notice that we
use \$ sign to open in-line equation. We can also write full
line equation using \$\$ like this $$E = mc^2$$. Again, notice
that there is no equation number here. To write the equation
with its labelled number we do as follows:

\begin{equation}
  \label{velo1}
  S = ut + \frac{1}{2} at^2
\end{equation}

\begin{equation}
  \label{velo2}
  v = u + at
\end{equation}

\begin{equation}
  \label{velo3}
  v^2 = u^2 + 2aS
\end{equation}

Now that if we want to refer to the equation we can use
\emph{ref} command like equation \ref{velo1}, \ref{velo2} and
\ref{velo3} are the equations in classic Physics.
```

ตรงนี้ถ้าใครลงแพคเกจ `latexer` บนอะตอมจะเห็นว่าตอนพิมพ์ `\ref{}` แล้วรอสักวิสองวิมันจะขึ้น autocomplete มาให้แบบนี้

<figure><center>
  <img src="/images/post/latexieee/autocomplete_ref.png" data-action="zoom"/>
</center></figure>

และนี่คือผลการเรนเดอร์โค้ดก้อนนั้น

<figure><center>
  <img src="/images/post/latexieee/equation_example.png" data-action="zoom"/>
</center></figure>

## Floats
ใน LaTeX เราจะเรียกพวกรูปและตารางว่า floats ซึ่งก็ตามชื่อ มันจะลอยๆ อยู่ ซึ่งเค้าก็ใส่ตัวอย่างการใช้งานและข้อควรปฏิบัติมาให้ในบรรทัด 434-526 ส่วนที่ควรรู้คือ

> Note that the IEEE does not put floats in the very first column - or typically anywhere on the first page for that matter. Also, in-text middle ("here") positioning is typically not used, but it is allowed and encouraged for Computer Society conferences (but not Computer Society journals). Most IEEE journals/conferences use top floats exclusively.

แปลไทยก็คือเปเปอร์ IEEE จะไม่ให้ใส่รูปไว้ในหน้าแรก และส่วนมากจะไม่ให้รูปลอยเท้งเต้งอยู่กลางหน้า (ยกเว้น Computer Society conferences) โดยปกติแล้วเค้าจะให้อยู่ชิดบนเป็นหลัก เช่นเคย ลองใส่รูปด้วยการเขียนจริงกันเลย

```tex
% start from line 550
\section{Floats}
Here is a float demo. We can put the figure in LaTeX like this.
Note that the \emph{label} command must come after \emph{caption}
command. To refer to this image, IEEEtran provides macro
\emph{figurename} so we refer to \figurename{\ref{pluto}} like
this. For table we refer to it manually, for example you can see
multiplication results in Table \ref{demo_table}.

\begin{figure}[!t]
  \centering
  \includegraphics[width=0.9\linewidth]{pluto}
  \caption{The image of Pluto}
  \label{pluto}
\end{figure}

\begin{table}[!t]
  \caption{Multiplication table}
  \label{demo_table}
  \centering
  \begin{tabular}{*{5}{c}}
    \toprule
    \multirow{2}{*}{Factor} & \multicolumn{2}{c}{Odd} & \multicolumn{2}{c}{Even}\\
    \cmidrule(lr){2-3}
    \cmidrule(lr){4-5}
    & 1 & 3 & 2 & 4 \\
    \midrule
    1 & 1 & 3 & 2 & 4 \\
    \cmidrule{1-5}
    2 & 2 & 6 & 4 & 8 \\
    \cmidrule{1-5}
    3 & 3 & 9 & 6 & 12 \\
    \bottomrule
  \end{tabular}
\end{table}
```

เรนเดอร์มาหน้าตาจะเป็นแบบนี้

<figure><center>
  <img src="/images/post/latexieee/floats.png" data-action="zoom"/>
</center></figure>

จากตัวอย่างโค้ดข้างบนไม่ว่าจะเป็นรูปหรือตารางเราจะใช้ตัวเลือก `[!t]` ในการประกาศสร้างเสมอ ตัวเลือกตรงนี้ก็ตามที่ได้ยกมาให้ดูก่อนหน้านี้คือโดยส่วนใหญ่ IEEE จะไม่ให้ floats ลอยเคว้งอยู่กลางหน้า (`[!h]`) แต่จะให้ชิดขอบบนของหน้าเสมอ ในส่วนของรูปภาพจะสังเกตได้ว่า label จะต้องตามหลังคำสั่ง caption เสมอ และเวลาเราอ้างถึงมันก็ให้ใช้มาโครที่ IEEE เตรียมไว้ให้ซึ่งก็คือ `\figurename{}` แล้วค่อย `\ref{}` ไปที่รูป มันก็จะเรนเดอร์เป็น `Fig. N` ให้เลย ส่วนของตารางนั้นเราเลือกใช้แพคเกจ `booktabs` เพราะมันเรนเดอร์ออกมาได้สวยกว่าปกติ โดยเฉพาะถ้าตารางเราไม่จำเป็นต้องมีเส้นในแนวตั้ง `booktabs` ประกอบด้วยเส้นสี่แบบคือ `\toprule`, `\midrule`, `\cmidrule{}` และ `\bottomtule` หน้าที่ก็ตามชื่อเลย ส่วน `\cmidrule{}` จะพิเศษหน่อยคือต้องกำหนดคอลัมน์ที่จะขีดด้วย และถ้าจะให้เส้นในแถวเดียวกันขาดกลางได้ก็ต้องกำหนดคอลัมน์พร้อมทั้งใช้ตัวเลือก `(lr)` ด้วย ส่วนแพคเกจ `multirow` ก็ใช้เพื่อช่วยในการรวมมากกว่าหนึ่งแถวเข้าด้วยกัน นอกจากนี้เรายังสามารถทำให้ floats ทั้งหลายนี้มีความกว้างเท่าหน้ากระดาษได้ด้วยการประกาศ `*` เช่น `\begin{table*}[!t]` หรือ `\begin{figure*}[!t]` อันนี้จะมีประโยชน์มากในกรณีที่รูปหรือตารางมันกว้างมากจนบีบให้อยู่ในคอลัมน์เดียวไม่ได้

เริ่มรู้สึกว่าถ้ายัดทั้งหมดลงในบล็อกเดียวมันจะแออัดเกินไป ไม่คิดว่าจะยาวขนาดนี้ ขอจบพาร์ทแรกไว้ที่ตรงนี้ก่อนดีกว่า แล้วพาร์ทต่อไปจะเกี่ยวกับการอ้างอิงล้วนๆ ส่วนของบล็อกนี้ถ้ามีข้อสงสัยอะไรตรงไหนก็ลอง pm มาถามได้ฮะ

_**อัพเดท** บล็อกตอนต่อเขียนเสร็จแล้ว ตามไปได้ที่นี่เลย [บันทึกการใช้คลาส IEEEtran ตอนที่ 2](http://tupleblog.github.io/bibtex-ieeetran/)_

ปล. หลังจากใช้ `pdf-view` ไปสักพักก็พบว่ามันยังช้าอยู่เหมือนเดิม จะเขียนน้อยก็ยังช้า เลยใช้ Skim เหมือนเดิมแล้วจ้า
