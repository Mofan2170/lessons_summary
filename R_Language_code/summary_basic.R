#1.package code
#1.1.install package
install.packages(c("package1","package2"))
install.packages("package_name")
#1.2.load package
library(package_name)
#1.3.remove package
remove.packages("package_name")
#1.4.detach package
detach("package_name")
#1.5.download package from github
#install.packages("githubinstall")
#library(githubinstall)
#githubinstall("github_packages")

#2.basic code
#2.1.向量
#2.1.1.创建向量：数值/字符/逻辑值
a<-c(2,5,6,8,4)
b<-c("甲","乙","丙")
c<-c("TRUE","FALSE","TRUE")
a;b;c
#2.1.2.向量排序sort(a,decreasing=默认为升序FALSE,可改为升序TRUE)
sort(a,decreasing=TRUE)
#2.1.3.产生等差数列
v1<-1:6
#2.1.4.from,to之间,间距为by
v2<-seq(from=2,to=4,by=0.5)
v3<-seq(2,4,0.5)
#2.1.5.vector repeat
v4<-rep(1:3,times=3)
#2.1.6.elemens repeat
v5<-rep(1:3,each=3)
v1;v2;v3;v4;v5
#2.2.matrix
#创建矩阵matrix(向量,行数,列数,按行填充元素=默认为FALSE)
v<-1:6
mat<-matrix(v,nrow=2,ncol=3,byrow=TRUE)
mat
#添加行名和列名
rownames(mat)=c("甲","乙")
colnames(mat)=c("A","B","C")
mat
#转置矩阵
t(mat)
#2.3.数据框data.frame
#2.3.1.创建数据框
names<-c("张三","李四","王五","赵六","孙七")
english<-c(88,87,89,69,95)
math<-c(68,77,92,76,65)
economy<-c(87,89,96,94,88)
table1_1<-data.frame(姓名=names,英语=english,数学=math,经济学=economy)
table1_1
#2.3.2.查看数据框
head(table1_1,3)  #查看前三行
tail(table1_1,3)  #查看后三行
nrow(table1_1)    #查看行数
ncol(table1_1)    #查看列数
dim(table1_1)     #同时查看行和列
class(table1_1)   #查看数据类型
str(table1_1)     #查看数据结构
#2.3.3.特殊查看
table1_1$经济学   #同table1_1[,4],查看经济学变量
table1_1[,2:3]    #查看2-3列
table1_1[,c(1,3)] #查看第一列和第三列
table1_1[c(1,4),] #查看第一行和第四行
table1_1[3,4]     #访问3行4列的对应单元格
#2.3.4.数据框合并data1和data2
new_data<-rbind(data1,data2) #按行合并
new_data<-cbind(data1,data2) #按列合并
#2.3.5.数据框排序(dplyr包)
library(dplyr)
arrange(table1_1,姓名)
arrange(table1_1,desc(数学))  #默认升序,desc为降序
table1_1[order(table1_1$数学,decreasing=TRUE),] #注意末尾逗号,代表保留所有列
sort(table1_1$数学,decreasing=TRUE)
#2.4.因子factor
#2.4.1创建无序因子
a<-c("金融","医药","科技","科技","医药")
f1<-factor(a)
f1
as.numeric(f1) #将因子转换为数值
#无序因子转换为有序因子
b<-c("优","良","中","及格","差")
f2<-factor(b,ordered=TRUE,levels=c("优","良","中","及格","差"))
f2
as.numeric(f2)
#3.read & save
#read file.csv encoding=GBK
table1<-read.csv("file_path/file.csv",fileEncoding="GBK")
#read file.csv encoding=UTF-8
table2<-read.csv("file_path/file.csv",fileEncoding="UTF-8")
table2<-read.csv("file_path/file.csv")
#save file.csv encoding=GBK
write.csv(data1,file="file_path/data1.csv",fileEncoding="GBK")
#save file.csv encoding=UTF-8
write.csv(data1,file="file_path/data1.csv",fileEncoding="UTF-8")
write.csv(data1,file="file_path/data1.csv")
#4.deal with data(do not forget to import data1_1)
df<-read.csv("D:/code/R_data/data1_1.csv")
#4.1.data sampling :sample(数据$列名,size=抽取个数,replace=默认为FALSE不放回,可以改成TRUE放回)
n1<-sample(df$专业,size=10,replace=TRUE)
n1
#4.2.data filter/subset(need dplyr package)
library(dplyr)
filter(df,性别=="男"&专业=="金融学"&网购金额>=500)
subset(df,性别=="女"&专业=="会计学"&网购金额<=300) #subset还返回对应行号
#4.3.生成随机数
#rnorm(n=个数,mean=均值,sd=标准差);runif(n=个数,min=最小值,max=最大值)
rnorm(5,0,1)
runif(5,0,10)
#4.4.data type transform
#变量转换为向量:v1<-as.vector()
#数据框转换成矩阵:v2<-as.matrix()
#矩阵转换为数据框:v3<-as.data.frame()
#短格式(列)转换成长格式(列名单独提取):reshape2包中的melt();tidyr包中的gather
library(reshape2)
table1_1<-read.csv("D:/code/R_data/table1_1.csv")
df1<-melt(table1_1,id.vars = "姓名",variable.name = "课程",value.name = "分数")
df1
library(tidyr)
df2<-gather(table1_1,key="课程",value="分数","数学","统计学","经济学")
df2
#频数分布表
#一维列联表
tab1<-table(df$在读学位)
tab1
prop.table(tab1)*100 #转换为百分比
#二维列联表
attach(df)  #绑定数据,如果不写这句,下面要改为tab2<-table(df$性别,df$专业)
tab2<-table(性别,专业)
tab2
addmargins(tab2)   #添加边际和
addmargins(prop.table(tab2)*100)  #转换成百分比
detach(df)   #别忘了解绑
#多维列联表:stats包中的ftable;vcd包中的structable
tab3<-ftable(df,row.vars=c("性别","专业"),col.vars="在读学位")
tab3
ftable(addmargins(table(df$性别,df$专业,df$在读学位)))
library(vcd)
structable(性别+专业~在读学位,data=df)
#列联表转换为数据框:DescTools包中的Untable
library(DescTools)
df3<-Untable(tab3)
df4<-as.data.frame(tab3)
#使用dplyr包生成列联表并转为数据框
library(dplyr)
df5<-df%>%select(性别,专业,在读学位)%>%ftable()%>%as.data.frame()%>%rename(频数=Freq)%>%head(3)
df5


































