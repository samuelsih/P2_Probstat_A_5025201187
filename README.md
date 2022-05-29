
# Penjelasan 

## Starter Pack
Masukkan dan install seluruh library yang akan digunakan
```
library(BSDA)
library(tidyverse)
library(ggplot2)
library(MASS)
library(readr)
library(car)
library(dplyr)
library(broom)
library(ggpubr)
library(multcompView)
```

## Nomor 1
#### 1a
Setelah menghitung selisih dari 2 data, hitung standar deviasinya
```
selisih1 <- c(22, 20, 3, 13, 20, 18, 11, 16, 23)
sd(selisih1)
```

Hasil
![1a](https://user-images.githubusercontent.com/89601859/170873077-c101bde6-6b5a-488d-88b0-aae1dacc136f.png)



#### 1b
Dapatkan 2 data sebelumnya, dan hitung nilai t nya dengan rumus

```
datafield1 <- c(78,75,67,77,70,72,78,74,77)
datafield2 <- c(100,95,70,90,90,90,89,90,100)

mean1 <- mean(datafield1)
mean2 <- mean(datafield2)

sd1 <- sd(datafield1)
sd2 <- sd(datafield2)

varians1 <- sd1 ^ 2
varians2 <- sd2 ^ 2

t_value1<- abs(mean2 - mean1) / sqrt((varians1/9) + (varians2/9))
t_value1
```

Hasil
![1b](https://user-images.githubusercontent.com/89601859/170873081-d6f94f83-62bc-4e24-a938-4cba60c8db8a.png)



#### 1c
Untuk menguji hipotesis, dapat menggunakan `t.test` sebagai berikut

```
t.test(datafield2, datafield1)
```

Hasil
![1c](https://user-images.githubusercontent.com/89601859/170873082-d3f98a40-8626-4704-92cf-bc9cda5489c0.png)



Dari hasil p maka H0 ditolak. Jadi ada
pengaruh yang signifikan secara statistika dalam hal kadar saturasi
oksigen , sebelum dan sesudah melakukan aktivitas 𝐴.


## Nomor 2
#### 2a
Setuju

#### 2b
Pertama memasukkan data yang dibutuhkan, lalu karena yang diketahui bukan data mentah seperti nomor 1, maka bisa menggunakan `tsum.test`

```
data2 <- list("mean" = 23500, "mean_hipo" = 20000, "sd" = 3900, "n" = 100)
tsum.test(mean.x = data2$mean, n.x = 100, sd(data2$sd), mu = data2$mean_hipo)
```

Hasil
![2b](https://user-images.githubusercontent.com/89601859/170873085-5a75906e-3277-4d7c-ab1a-33c2ad533096.png)



Dari hasil yang didapat, didapat
```
H0 : mean = 20000
```
```
H0 : mean > 20000
```


#### 2c
Pertama hitung p value 
```
zScore = (data2$mean - data2$mean_hipo) / (data2$sd / sqrt(data2$n))
pnorm(-abs(zScore))
```

Hasil
![2c](https://user-images.githubusercontent.com/89601859/170873155-b6b5c44f-1add-4ecd-82a2-3f38b2eeb7e9.png)



Dari p value yang hasilnya mendekati 0, didapatkan H0 ditolak dan disimpulkan mobil dikemudikan rata-rata lebih dari 20.000 kilometer per tahun

## Nomor 3
#### 3a
```
H0 : "Tidak ada perbedaan rata - rata antara Bandung dan Bali"
```
```
H1 : "Ada perbedaan rata - rata antara Bandung dan Bali"
```

#### 3b
Hitung dengan menggunakan `tsum.test`
```
tsum.test(
  n.x = bandung$saham,
  n.y = bali$saham,
  mean.x = bandung$mean,
  mean.y = bali$mean,
  s.x = bandung$sd,
  s.y = bali$sd,
  var.equal = TRUE,
  alternative = "greater",
)
```

Hasil
![3b](https://user-images.githubusercontent.com/89601859/170873150-b68ced31-99b9-439e-8905-4894ee1afafd.png)



#### 3c
`qt` digunakan untuk mencari t distribution dengan df tertentu
```
qt(p = 0.05, df = 2, lower.tail = FALSE)
```

Hasil
![3c](https://user-images.githubusercontent.com/89601859/170873153-ff0e5c3b-99a2-4ed3-9498-0b372c8b44a6.png)



#### 3d
H0 diterima

#### 3e
Tidak ada perbedaan rata - rata antara Bandung dan Bali


## Nomor 4
#### 4a
Ambil data dari url, lalu split by group dan masukkan masing masing ke variable terpisah
```
data4 <- read.table(url("https://rstatisticsandresearch.weebly.com/uploads/1/0/2/6/1026585/onewayanova.txt"),header = TRUE, check.names = TRUE)
byGroup <- split(data4, data4$Group)
group1 <- byGroup$`1`
group2 <- byGroup$`2`
group3 <- byGroup$`3`
```

Lalu lihat grafik datanya
```
hist(group1$Length, xlim = c(16, 20))
hist(group2$Length, xlim = c(16, 20))
hist(group3$Length, xlim = c(16, 20))
```

Hasil
![4a_1](https://user-images.githubusercontent.com/89601859/170873203-41dd25e5-574c-4e91-bef0-65ecdd2dca15.png)

![4a_2](https://user-images.githubusercontent.com/89601859/170873205-aa85f36d-d7dc-45f0-88ca-37881244b0fa.png)

![4a_3](https://user-images.githubusercontent.com/89601859/170873207-9926cd1e-bfcf-459a-9123-8482d3575b24.png)



#### 4b
Karena bentuk nya seperti distribusi normal maka gunakan `bartlett.test`
```
bartlett.test(data4$Length, data4$Group)
```

Hasil
![4b](https://user-images.githubusercontent.com/89601859/170873295-9f791ad1-4c8e-43cc-8dac-d0a2278f927f.png)



#### 4c
Gunakan `lm()` dan masukkan ke variable `model1`
```
model1 <- lm(data4$Length, data4$Group)
```

Hasil
![4c](https://user-images.githubusercontent.com/89601859/170873277-503bca24-0f17-4405-a84d-787d2f82e08b.png)



#### 4d
Hasilnya 0.6401, berarti H0 diterima

#### 4e
Gunakan `TuckeyHSD` untuk mendapatkan nilai Tuckey
```
av <- aov(Length ~ factor(Group), data = data4)
TukeyHSD(av)
```

Hasil
![4e](https://user-images.githubusercontent.com/89601859/170873279-d8969d95-068a-4063-be01-170f095ff9f7.png)



#### 4f
Gunakan `ggplot` dan `geom_boxplot`
```
ggplot(data4, mapping = aes(x = Group, y = Length, group = 1)) +  geom_boxplot()
```

Hasil
![4f](https://user-images.githubusercontent.com/89601859/170873282-db50de3f-ab9a-4358-a1ec-260bc5cce52e.png)



## Nomor 5
#### 5a
Baca data csv dan lihat dengan `qplot` + `facet_wrap`
```
data5 <- read_csv("E:/Semester 4/Probstat/Prak/P2_Probstat_A_5025201187/GTL.csv")
qplot(Temp, Light, data = data5) + facet_wrap(~Glass)
```

Hasil
![5a](https://user-images.githubusercontent.com/89601859/170873285-1f737cd4-0587-4e5b-b24b-e3e44e275475.png)


#### 5b
Gunakan `aov` dan lihat `summary` nya
```
av <- aov(Light ~ factor(Glass)*factor(Temp), data = data5)
summary.aov(av)
```

Hasil
![5b](https://user-images.githubusercontent.com/89601859/170873575-24ca1695-7f5f-4264-93a7-c7a747c026ce.png)



#### 5c
Gunakan `group by` Glass dan Temp dulu baru `summarize`
```
group_by(data5, Glass, Temp)%>% 
  summarize(
    mean = mean(Light),
    standar_deviasi = sd(Light)
)
```

Hasil
![5c](https://user-images.githubusercontent.com/89601859/170873579-0c8e29cf-25c6-4d65-8d2b-edc4d8d52c69.png)



#### 5d
Uji Tukey digunakan dengan TuckeyHSD
```
hsd <- TukeyHSD(av)
hsd
```

Hasil
![5d](https://user-images.githubusercontent.com/89601859/170873583-9c11129d-6646-48a1-a8f4-4a9d9e7bafb8.png)


#### 5e
compact letter display dapat dicari dengan `multcompLetters4` 
```
multcompLetters4(av, hsd)
```

Hasil
![5e](https://user-images.githubusercontent.com/89601859/170873586-a21203ce-5f65-48e9-809c-086cbc567466.png)
