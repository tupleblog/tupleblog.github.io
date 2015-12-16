---
author: Titipata
layout: post
title: Gradient Descent
description: "แก่นของ Gradient Descent, Optimization พื้นฐานที่ที่คนเรียนต้องรู้"
tags: [Gradient Descent, Optimization]
image:
  feature: post/gradient/cover.png
comments: true
share: true
date: 2015-12-16 16:00:00
---

## Gradient Descent

Spoiler alert: สำหรับคนที่ชอบคณิตศาสตร์และโปรแกรมมิ่งเท่านั้น  

โพสต์นี้เราจะว่าด้วยเทคนิคสุดคลากสิกที่เป็นแก่นของการแก้สมการเกือบทุกอย่างทั้งในสายวิชา Optimization, Machine Learning ซึ่งฮิตกันมากๆในเวลานี้, Compress Sensing หรือการแก้ \\( \ell_1 \\)-regularization problem, Neural Network, Deep learning, Optimal Control, Adaptive filtering และอีกมากมาย ศาสตร์เหล่านี้ทั้งหมดล้วนต้องใช้ algorithm "Gradient Descent" เป็นแก่นของการแก้เพื่อหาค่าที่เหมาะสมที่สุดให้กับสมการหนึ่งๆ หลังจากว่าด้วยแก่นของ Gradient descent เราก็จะมาดู Pseudo Python code กันเล็กน้อยสำหรับการแก้ linear equation ง่ายๆ และลอง Stochastic Gradient Descent ในตอนท้าย

ย้อนไปสมัยเด็กๆ (สมัยเรียนแคลคูลัส ม. 6 ที่สวนกุหลาบฯ) ถ้าสมมติอยากจะหาค่าของ \\(x\\) ที่ทำให้ \\(f(x) = x^2 - 4x\\) มีค่าต่ำที่สุด เราก็จะหา first derivative ของ \\(f(x)\\) นั่นคือ \\(f'(x) = 2x - 4\\) แล้วแก้สมการ \\(f'(x) = 2x - 4 = 0\\) หรือ \\(x = 2\\) นั่นเอง

หรือยากไปกว่านั้น ถ้าจะแก้ linear equation \\(\mathbf{y} = A \mathbf{x}\\) หรือหา
\\( \lVert A\mathbf{x} - y \rVert^2 \\)

$$x_{k+1} = x_{k} - \alpha f'(x_{k}) $$

Pseudo code สำหรับ Gradient Descent

{% highlight python %}
for i in range(n_iter):
  x_new = x_old - alpha*compute_grad(x_old)
  J.append(compute_cost(x_new))
{% endhighlight %}


## แก่นของ Gradient Descent

$$ f(z) \geq f(x) + \nabla f(x)^{T} (z - x) + \frac{\ell}{2} \lVert z - x \rVert^2 $$


## ว่าด้วย Stochastic Gradient Descent
