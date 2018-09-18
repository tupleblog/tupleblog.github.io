---
author: Titipata
layout: post
title: "Pytorch กับ Gradient Descent"
description: "ทำความเข้าใจกับพื้นฐานของ Gradient Descent ผ่านไลบรารี่ Pytorch (สำหรับผู้ที่เริ่มศึกษา Deep Learning)"
tags: [Gradient Descent, Optimization]
image:
  feature: post/gradient/contour.jpg
comments: true
share: true
date: 2018-09-17 18:30:00
---

## เกริ่นนำ

สำหรับใครที่ยังไม่ได้อ่านโพสต์ที่แล้วเกี่ยวกับการเคลื่อนลงตามความชัน (gradient descent) ไปตามอ่านได่้[ที่นี่เลย](https://tupleblog.github.io/gradient-descent-part1/)

อย่างที่กล่าวไว้ในโพสต์ที่แล้ว นอกจากวิธีการเคลื่อนลงตามความชัน (gradient descent) 
จะมีความสำคัญสำหรับหลายๆวิชาในทางวิศวกรรมศาสตร์แล้ว 
เทคนิคนี้ยังถูกนำมาใช้ในศาสตร์อย่างวิทยาศาสตร์คอมพิวเตอร์ (computer science) ด้วยเช่นกัน 

ไลบรารี่เกี่ยวกับ Deep learning ในปัจจุบันได้นำเทคนิค Gradient descent และ automatic differentiation (autograd) 
มาใช้สำหรับใช้อัพเดทพารามิเตอร์ของ Deep Neural Network ที่มีความซับซ้อนและพารามิเตอร์จำนวนมหาศาล 
เนื่องจากฟังก์ชันที่มีความซับซ้อนมากขึ้น เราไม่สามารถเขียนสมการความชันของฟังก์ชันด้วยมือได้ การใช้ autograd 
จึงมีประโยชน์อย่างมากในไลบรารี่ใหม่ๆเหล่านี้ฮะ

ในโพสต์นี้เราจะมาลองเขียนโค้ดของ gradient descent โดยใช้ไลบรารี่ PyTorch ในภาษา Python กัน 
หลังจากนั้นเราจะทิ้งท้ายไว้ที่ความสำคัญของ autograd (automatic differentiation) 
สำหรับการอัพเดทพารามิเตอร์ของ Deep Neural Network และมาดูกันว่า gradient descent มีความเกี่ยวเนื่องยังไงกับ
การอัพเดทพารามิเตอร์ของ Deep Neural Network


## ความเดิมในโพสต์ที่แล้ว

ใน[โพสต์ที่แล้ว](https://tupleblog.github.io/gradient-descent-part1/) 
เราได้พูดถึงแก่นของการเคลื่อนลงตามความชันหรือ Gradient Descent กันไป
โดยเราพูดถึงการหาค่า \\( x \\) (เราจะเรียก \\( x\\) ว่าพารามิเตอร์เมื่อพูดถึงโมเดล) 
ที่ทำให้กราฟพาราโบลา \\(f(x) = x^2 - 4x\\) มีค่าต่ำที่สุด 

การหาจุดค่ำสุดของฟังก์ชันได้หลายวิธี ได้แก่

1. **จัดรูปสมการ** \\(f(x) = (x^2 - 4x + 4) - 4 = (x - 2)^2 - 4\\) ซึ่งจะพบว่า \\(x = 2\\) ทำให้สมการมีค่าต่ำสุดที่ \\(f(2) = -4\\) นั่นเอง 
2. **ใช้แคลคูลัส** โดยหาดิฟของ \\(f(x)\\) ที่เท่ากับ 0 ดังนี้ \\(f'(x) = 2x - 4 = 0\\) จะเห็นว่าเราสามารถคำนวณได้ว่า \\(x = 2\\) ที่ทำให้ฟังก์ชันมีค่าต่ำที่สุด
3. **การเคลื่อนลงตามความชัน (Gradient descent)** โดยโพสต์ที่แล้วเราได้เขียนโค้ดโดยใช้ภาษา Python กันไปเพื่อหาจุดต่ำสุดกันไป 

สองอย่างแรกเราสามารถคำนวณได้โดยใช้มือ ส่วนคอมพิวเตอร์นั้นไม่สามารถแก้สมการได้โดยตรง 
ดังนั้นการใช้ gradient descent จึงมีความเหมาะสมมากกว่าในการแก้สมการนั่นเอง นอกจากนี้ gradient descent 
ยังเหมาะสำหรับการแก้หาพารามิเตอร์ของโมเดลที่มีจำนวนมากด้วยเช่นกัน เนื่อจากการแก้สมการปกติมีความซับซ้อนกว่าการหาความชัน


## ทบทวนการเคลื่อนลงตามความชัน (Gradient descent algorithm)

ถ้ายังจำกันได้ การคำนวณอัลกอริทึม gradient descent เราจะต้องหา gradient ของฟังก์ชันที่เรากำหนดกันก่อน เช่นสำหรับฟังก์ชัน \\(f(x) = x^2 - 4x\\) 
เราสามารถคำนวณ​ความชันหรือ gradient ได้ดังนี้ \\(f'(x) = 2 x - 4 \\) และสิ่งที่เราต้องทำก็คือการอัพเดทค่า \\(x\\) ให้ไปในทิศทางตรงกันข้ามกับความชัน
ของฟังก์ชันที่เรากำหนด โดยวิธีการเป็นไปดังต่อไปนี้

- \\(\text{initialize: } \{x, \alpha\} \\) 
- \\(\text{while: } \| f(x_{n + 1}) - f(x_{n}) <= 10^{-3} \|\\)
- \\(\text{do: } x \leftarrow x - \alpha f'(x)\\)

ถ้าเราเขียนโค้ดโดยใช้ Python ปกติจะเขียนได้ดังต่อไปนี้

```py
alpha = 0.02
x = 10.0

def compute_grad(x):
    grad = 2 * x - 4
    return grad

for _ in range(1000):
    x = x - alpha * compute_grad(x)
print(x) # ได้ค่า x ต่ำที่สุดที่ประมาณ​ 2
```


แต่ว่าถ้าเราต้องมาคำนวณหาความชันทุกครั้งคงลำบากสินะ... 
แล้วมีทางมั้ยที่เราจะใช้ Gradient Descent แบบไม่ต้องคำนวณหาความชันจากฟังก์ชันที่เรากำหนด? 
คำตอบคือมีครับ! เราสามารถทำได้โดยใช้ไลบรารี่ที่มีการคำนวณความชันโดยอัตโนมัติ (automatic differentiation)
ในหัวข้อถัดไปเราจะมาลองเขียน gradient descent โดยใช้ PyTorch 0.4 กัน


## Gradient Descent โดยใช้ไลบรารี่ Pytorch ร่วมกับ automatic differentiation

จะเห็นว่าถ้าฟังก์ชันเริ่มมีความซับซ้อนมากขึ้น เช่นใน Deep Neural Network ซึ่งมีพารามิเตอร์เต็มไปหมด เราไม่สามารถเขียน gradient หรือค่าดิฟของ 
cost function ที่เรากำหนดได้อีกต่อไป แต่ๆๆๆ! ความเจ๋งของการใช้ไลบรารี่ของ Deep Learning อย่างเช่น PyTorch 
นั่นก็คือมันมาพร้อมกับ [`autograd`](https://pytorch.org/tutorials/beginner/blitz/autograd_tutorial.html) 
ซึ่งย่อมาจาก automatic differentiation นั่นเอง

โดยในไลบรารี่ `torch` หรือ Pytorch เวอร์ชันหลังจาก 0.4 นั้น เราสามารถกำหนดให้เทนเซอร์ (หรือพูดง่ายๆคือ array ที่มีหลายมิติ) สามารถเก็บ gradient ได้ใน
พารามิเตอร์ `x.requires_grad=True` โดยเมื่อเรากำหนดฟังก์ชันของ \\(x\\) แล้ว เราสามารถเรียกฟังก์ชัน `.backward()` เพื่อหา gradient ของฟังก์ชันนั้นๆที่ค่า \\(x\\) ได้

สำหรับตัวอย่างฟังก์ชัน \\(f(x) = x ^ 2 - 4 x \\) เราสามารถหา gradient เมื่อ \\(x = 10\\) ได้เท่ากับ \\(f'(10) = 2 (10) - 4 = 16 \\)

ต่อไปเราจะมาลองดูคำนวณโดยใช้ `autograd` กันบ้าง

```py
x = torch.tensor(10, dtype=torch.float, requires_grad=True) # กำหนดให้ x มี gradient โดยให้ requires_grad=True
cost = torch.sum(x * x - 4 * x) # ฟังก์ชันที่เรากำหนด
cost.backward() # คำนวณ gradient ด้วย autograd
print(x.grad) # สุดท้ายเมื่อปริ้นค่า gradient ออกมาจะได้ tensor([16.]) 
```

จะพบว่าเราได้ค่า `x.grad` ที่ `x = 10` หรือ \\(f'(10) = 16\\) เท่ากับที่เราคำนวณด้วยมือเลย! 
ดังนั้นความเจ๋งของการใช้ `autograd` ก็คือเราไม่ต้องคำนวณหา gradient ของฟังก์ชันที่เรากำหนดอีกต่อไป 
เราสามารถคำนวณ gradient ได้โดยไม่ต้องเขียนฟังก์ชันหาความชันด้วยมือเลย!


ดังนั้นเราสามารถที่จะหาค่า \\(x\\) ที่ทำให้ฟังก์ชันมีค่าต่ำที่สุดได้โดยใช้เทคนิค gradient descent ร่วมกับไลบรารี่ Pytorch ได้ดังนี้


```py
import torch

alpha = 0.02 # กำหนดพารามิเตอร์สำหรับการอัพเดทค่า x
x = torch.tensor(10, dtype=torch.float, requires_grad=True)  
cost = torch.sum(x * x - 4 * x) # ฟังก์ชันสำหรับกราฟพาราโบลา x ^ 2 + 4 x 

# รัน gradient descent algorithm 1000 ครั้ง
for _ in range(1000):
    cost.backward(retain_graph=True) # คำนวณความชันหรือ gradient โดยใช้ autograd ``.backward()``
    x.data.sub_(alpha * x.grad) # เทียบเท่ากับ x = x - alpha * f'(x)
    x.grad.data.zero_() # หลังจากเราคำนวณ gradient แล้ว เราต้องตั้งค่ากลับไปที่ 0 อีกครั้งหนึ่งเพื่อคำนวณใหม่
print(x) # เราจะได้ค่า x ต่ำที่สุดที่ 2
```

ใครที่อยากลองรันโค้ดด้วยตัวเองก็สามารถเข้าไปดูตัวอย่างโค้ดเต็มๆได้[ที่นี่](https://github.com/tupleblog/tuple_code/blob/master/pytorch_gradient_descent/pytorch_gradient_descent.ipynb)เลย

## Gradient Descent สำหรับ (Deep) Neural Network

นอกจาก `autograd` จะใช้ได้สำหรับฟังก์ชันธรรมดาแล้วยังสามารถใช้กับฟังก์ชันที่ซับซ้อนได้อีกด้วย ในกรณีนี้ไลบรารี่อย่างเช่น PyTorch หรือ TensorFlow 
ก็ใช้ autograd ในการหา gradient เพื่ออัพเดทพารามิเตอร์ปริมาณมหาศาลในโมเดลนั่นเอง

ถ้าคนที่เคยเขียนโค้ด PyTorch ก็จะเห็นว่าสิ่งที่เราต้องทำคือต่อไปนี้
1. เขียนโมเดล
2. เขียน loss function และ optimizer 
3. เทรนโมเดล โดยสิ่งที่เราต้องทำคือการป้อนข้อมูลเข้าไป และใช้ `autograd` หา gradient เพื่ออัพเดทให้พารามิเตอร์ลู่เข้าสู่จุดที่ทำให้ loss มีค่าต่ำที่สุด

วิธีการของของการหาพารามิเตอร์ของ Deep Neural Network แทบจะไม่ต่างกับตอนที่เราหาค่า \\( x \\) ในตัวอย่าง Gradient descent algorithm เลย
ลองดูโค้ดด้านล่าง ([โค้ดมาจากตัวอย่างของ PyTorch](https://pytorch.org/tutorials/beginner/blitz/cifar10_tutorial.html))

```py
import torch.optim as optim

criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(net.parameters(), lr=0.001, momentum=0.9) # ใช้ stochastic gradient descent ซึ่งมี learning rate = 0.001, momentum = 0.9

for epoch in range(2): # จำนวนครั้งที่ loop ผ่านข้อมูลทั้งหมด
    for i, data in enumerate(trainloader, 0):
        inputs, labels = data
        optimizer.zero_grad() # ตั้งค่าให้พารามิเตอร์กลับไปที่ 0 ก่อน

        outputs = net(inputs) # เปลี่ยนจากการใส่ x เข้าไปเป็นการใส่ inputs เข้าไปใน deep neural network แทนและคำนวณ outputs
        loss = criterion(outputs, labels) # คำนวณหา loss เพื่อจะได้ใช้ autograd หา gradient 
        loss.backward() # หา gradient เพื่อใช้ในการอัพเดทพารามิเตอร์
        optimizer.step() # อัพเดทพารามิเตอร์ (เทียบเท่ากับ gradient descent แต่ว่าใช้คำสั่งจาก optim แทน, x = x - alpha * x.grad)
```

จะเห็นว่าเราต้องเคลียร์ gradient เช่นเดิม หลังจากนั้นก็หา loss ระหว่าง outputs และ labels เพื่อที่จะใช้คำนวณหา gradient 
เพื่อที่จะอัพเดทพารามิเตอร์ของโมเดล และอัพเดทด้วยวิธี gradient descent

ต่อไปนี้เวลาเขียนโค้ด PyTorch ถ้าเราเข้าใจพื้นฐานของ Gradient Descent และ autograd 
การหาพารามิเตอร์ของ Deep Neural Network ก็ไม่ยากอีกต่อไป :)