# PULSE ANALYSIS: Unsupervised Learning

# By: Daniel Eduardo López Martínez
# GitHub: https://github.com/DanielEduardoLopez
# LinkedIn: https://www.linkedin.com/in/daniel-eduardo-lopez/ 
# Date: "10/10/2022"


## 1. Data loading
load("pulse.RData")

## 2. Data exploration
head(pulse)
summary(pulse)

## 3. Data wrangling
restPulse=pulse$restPulse
actiPulse=pulse$actiPulse
heig=pulse$heig
weig=pulse$weig
bmi=pulse$bmi

### Building of Datasets
pulse.data = cbind(restPulse, actiPulse, heig, weig, bmi)
pulse.gender = pulse$gender
pulse.act = pulse$acti

## 1. Principal Component Analysis (PCA)

### Data Modeling
pr.out<-prcomp(pulse.data, scale = TRUE) #First argument, data matrix; then we must decide if we scale the variables, it's safer to say TRUE to scaling; the variables are centered by default
summary(pr.out)

### Cumulative Percentage of Variance Explained (PVE)
pve <-100*pr.out$sdev^2/sum(pr.out$sdev^2)

library(ggplot2)
pve.df = as.data.frame(cbind(1:length(pve),cumsum(pve)))
ggplot(data = pve.df, aes(x = pve.df[1:length(pve),1], y =pve.df[1:length(pve),2])) + geom_point(color="navyblue") + geom_line(color="navyblue") + geom_area(fill="navyblue",alpha = 0.5) + labs(x = "Principal Component", y = "Cumulative PVE")

### Exploring of PCs coefficients according to variables
pr.out$rotation
head(pr.out$x)


### Plotting the scores

### Converting datasets into data frame for plotting
po.df = as.data.frame(pr.out$x[,1:3])
pr.df = as.data.frame(pr.out$rotation[,1:3])

### Set of colors for female and male patients
colors <- c("female" = "#4393C3", "male" = "#D6604D")

### Score Plots 
ggplot(data = po.df) + geom_point(aes(x = PC1, y = PC2, color  = pulse.gender)) + labs(x = "Z1", y = "Z2", color = "Gender") + geom_hline(aes(yintercept = 0), color = "gray") +  geom_vline(aes(xintercept = 0), color  = "gray") + theme(legend.position = "right") + scale_color_manual(values = colors)

ggplot(data = po.df) + geom_point(aes(x = PC1, y = PC3, color  = pulse.gender)) + labs(x = "Z1", y = "Z3", color = "Gender") + geom_hline(aes(yintercept = 0), color = "gray") +  geom_vline(aes(xintercept = 0), color  = "gray") + theme(legend.position = "right") + scale_color_manual(values = colors)

ggplot(data = po.df) + geom_point(aes(x = PC2, y = PC3, color  = pulse.gender)) + labs(x = "Z2", y = "Z3", color = "Gender") + geom_hline(aes(yintercept = 0), color = "gray") +  geom_vline(aes(xintercept = 0), color  = "gray") + theme(legend.position = "right") + scale_color_manual(values = colors)


### Biplots

#### Function for adjusting the position of the labels in the biplots
labeladj = function(v){
  counter = 1
  for (i in v){
  if (i >= 0){
    v[counter] = i + 0.1
  }
  if (i < 0){
    v[counter] = i - 0.1
  }
  counter = counter + 1
  }
  return(v)
}

#### Z1 vs Z2
scale = 4
ggplot() + geom_point(data = po.df, aes(x = PC1, y = PC2, color  = pulse.gender)) + labs(x = "Z1", y = "Z2", color = "Gender") + geom_hline(aes(yintercept = 0), color = "#2e2d2d") +  geom_vline(aes(xintercept = 0), color  = "#2e2d2d") + theme(legend.position = "right") + scale_color_manual(values = colors) + geom_segment(data = pr.df, aes(x = 0, y = 0, xend = PC1*scale, yend = PC2*scale), arrow = arrow(length = unit(0.5, "cm")), color = "navyblue", size = 1) + geom_label(data = pr.df, aes(label=as.character(rownames(pr.df)), x=labeladj(PC1*scale), y = labeladj(PC2*scale)), label.size = NA, size=4, fill = NA)

#### Z1 vs Z3
scale = 2.5
ggplot() + geom_point(data = po.df, aes(x = PC1, y = PC3, color  = pulse.gender)) + labs(x = "Z1", y = "Z3", color = "Gender") + geom_hline(aes(yintercept = 0), color = "#2e2d2d") +  geom_vline(aes(xintercept = 0), color  = "#2e2d2d") + theme(legend.position = "right") + scale_color_manual(values = colors) + geom_segment(data = pr.df, aes(x = 0, y = 0, xend = PC1*scale, yend = PC3*scale), arrow = arrow(length = unit(0.5, "cm")), color = "navyblue", size = 1) + geom_label(data = pr.df, aes(label=as.character(rownames(pr.df)), x=labeladj(PC1*scale), y = labeladj(PC3*scale)), label.size = NA, size=4, fill = NA)


## 2. Cluster analysis

### Data Scaling
sd.data<-scale(pulse.data, center = FALSE , scale = TRUE) #The variables have been scaled

### Computation of distances matrix
data.dist<-dist(sd.data) 

### Hierarchical Clustering with the Complete Linkage Method (The most used)
clustcomp <- hclust(data.dist, method = "complete")
plot(clustcomp,  main ="Complete Linkage", xlab ="", sub ="", ylab ="", cex = 0.75)

#install.packages("ggdendro")
library("ggdendro")

# Building of dendrogram object from hclust results
dend <- as.dendrogram(clustcomp)
# Data extraction for rectangular lines
dend_data <- dendro_data(dend, type = "rectangle")

ggplot(dend_data$segments) + 
  geom_segment(aes(x = x, y = y, xend = xend, yend = yend), color = "navyblue")+
  geom_text(data = dend_data$labels, aes(x, y, label = label),
            hjust = 1, angle = 90, size = 3) + labs(title="Complete Linkage", x="", y="" ) + 
  theme(plot.title = element_text(hjust = 0.5))

### Hierarchical Clustering with the Average Linkage Method 
clustav <- hclust(data.dist, method = "average")
plot(clustav, main ="Average Linkage", xlab ="", sub ="", ylab ="", cex = 0.75)

### Hierarchical Clustering with the Single Linkage Method 
clustsin <- hclust(data.dist, method = "single")
plot(clustsin, main ="Single Linkage", xlab ="", sub ="", ylab ="", cex = 0.75)

# Dunn's Index
library(clValid)

clustc <- cutree(clustcomp, 8)
dunn(data.dist, clustc)

clusta <- cutree(clustav, 7)
dunn(data.dist, clusta)


#Complete linkage
hc.out<-hclust(dist(sd.data))
hc.clusters<-cutree(hc.out,8)
table(hc.clusters, pulse.gender)

par(mfrow =c(1,1))
plot(hc.out, labels = pulse.gender, main ="Hierarchical Cluster Dendogram", cex = 0.75)
abline(h=0.5, col ="red")

#K-means

set.seed(2) #We need to fix the seed
km.out<-kmeans(sd.data, 8, nstart = 20)  # 4 is the  desired number of clusters, 20 is the number of iterations
km.out
km.clusters<-km.out$cluster
table(km.clusters, pulse.gender)

table(km.clusters, hc.clusters)


# k-means with PC

hc.out<-hclust(dist(pr.out$x [,1:3]))
plot(hc.out, labels = pulse.gender, main ="Hier. Clust. on 3 Score Vectors")
abline(h=3.9, col ="red")
table(cutree(hc.out,8), pulse.gender)



