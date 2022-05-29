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

#soal 1
#1a
selisih1 <- c(22, 20, 3, 13, 20, 18, 11, 16, 23)
sd(selisih1)

#1b
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

#1c
t.test(datafield2, datafield1)

#dari hasil t test disimpulkan berarti:
#ada pengaruh yang signifikan secara statistika dalam hal kadar saturasi
#oksigen , sebelum dan sesudah melakukan aktivitas 𝐴


#soal 2
data2 <- list("mean" = 23500, "mean_hipo" = 20000, "sd" = 3900, "n" = 100)

tsum.test(mean.x = data2$mean, n.x = 100, sd(data2$sd), mu = data2$mean_hipo)

zScore = (data2$mean - data2$mean_hipo) / (data2$sd / sqrt(data2$n))
pnorm(-abs(zScore))

#soal 3
bandung <- list("saham" = 19, "mean" = 3.64, "sd" = 1.67)
bali <- list("saham" = 27, "mean" = 2.79, "sd" = 1.32)

#H0 = bandung bali tidak ada perbedaan rata2
#h1 = bandung bali ada perbedaan rata2


tsum.test(
  n.x = bandung$saham,
  n.y = bali$saham,
  mean.x = bandung$mean,
  mean.y = bali$mean,
  s.x = bandung$sd,
  s.y = bali$sd,
  var.equal = TRUE,
  alternative = "two.sided",
)

qt(p = 0.05, df = 2, lower.tail = FALSE)


#soal4
data4 <- read.table(url("https://rstatisticsandresearch.weebly.com/uploads/1/0/2/6/1026585/onewayanova.txt"),header = TRUE, check.names = TRUE)
byGroup <- split(data4, data4$Group)
group1 <- byGroup$`1`
group2 <- byGroup$`2`
group3 <- byGroup$`3`

hist(group1$Length, xlim = c(16, 20))
hist(group2$Length, xlim = c(16, 20))
hist(group3$Length, xlim = c(16, 20))

bartlett.test(data4$Length, data4$Group)


model1 <- lm(data4$Length~data4$Group)
summary(model1)

av <- aov(Length ~ factor(Group), data = data4)
TukeyHSD(av)

ggplot(data4, mapping = aes(x = Group, y = Length, group = 1)) +  geom_boxplot()

#soal 5
data5 <- read_csv("E:/Semester 4/Probstat/Prak/P2_Probstat_A_5025201187/GTL.csv")
qplot(Temp, Light, data = data5) + facet_wrap(~Glass)


av <- aov(Light ~ factor(Glass)*factor(Temp), data = data5)
summary.aov(av)

#tapply(data5$Temp, data5$Glass, summary)
group_by(data5, Glass, Temp)%>% 
  summarize(
    mean = mean(Light),
    standar_deviasi = sd(Light)
)

hsd <- TukeyHSD(av)
hsd

multcompLetters4(av, hsd)
