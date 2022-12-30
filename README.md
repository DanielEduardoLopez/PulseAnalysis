<p align="center">
	<img src="Images/Header.png?raw=true" width=80% height=80%>
</p>


# Pulse Analysis
#### By Daniel Eduardo López

**[Github](https://github.com/DanielEduardoLopez)**

**[LinkedIn](https://www.linkedin.com/in/daniel-eduardo-lopez)**

____
### **1. Introduction**
"The arterial pulse is the abrupt expansion of an artery resulting from the sudden ejection of blood into the aorta and its transmission throughout the arterial system." (Moran, 1990).

The importance of pulse relies in the fact that is one of the primary vital signs used as an indicator of the health status of the circulatory system (Escobar-Restrepo, Torres-Villa & Kyriacou, 2018).

In the present project, the relationship among the **pulse at rest**, **pulse in activity**, **height**, **weight**, and **body mass index** of a group of **male** and **female** patients was assessed.

____
### **2. General Objective**
Explore how pulse at rest, pulse in activity, height, weight, and body mass index relate among each other and with patients' gender.

____
### **3. Research Question**
How pulse at rest, pulse in activity, height, weight, and body mass index relate among each other and with patients' gender?

____
### **4. Abridged Methodology**
The methodology of the present study is based on Rollin’s Foundational Methodology for Data Science (Rollins, 2015).

1) **Analytical approach**: Unsupervised learning techniques were applied to infer relationships among the variables in study. 
2) **Data requirements**: Accordingly, patients' data about the variables pulse at rest (restPulse), pulse in activity (actiPulse), height (heig), weight (weig) and Body Mass Index (bmi) was needed.
3) **Data collection**: The data was provided by the **University of Zaragoza** in the course of the **Master's in Quantitative Biotechnology** 2020-2021.
4) **Data exploration and preparation**: Data then was explored and prepared with R. 
5) **Data modeling and evaluation**: A Principal Component Analysis (PCA) and a Clustering Analysis were performed in R. Moreover, hierarchical clustering and k-means techniques were used for the latter analysis.

___
### **5. Main Results**

#### **5.1 Principal Component Analysis**
As a first approach, a Principal Component Analysis (PCA) was performed in order to explore the data.

In order to explain at least 90% of variance from the data, a suitable number of principal components was selected according to the criterion of the Cumulative Percentage of Variance Explained (PVE), plotted in the following figure:

<p align="center">
	<img src="Images/Fig1_CPVE.png?raw=true" width=60% height=60%>
</p>

Thus, in view of the former figure, 3 principal components are required to explain at least 90% of variance from the data, effectively reducing the dimension of the dataset from 6 variables to only 3. 

To interpret the resulting components, it is useful to check the coefficients of each component according to the variables:

Variable | PC1 | PC2 | PC3 | PC4 | PC5
:---:|:---:|:---:|:---:|:---:|:---:
restPulse | 0.3201933 | 0.6233876 | -0.007349452 | 0.71330851 | -0.001073276
actiPulse | 0.2948346 | 0.6406360 | -0.145878518 | -0.69370784 | 0.012122048
heig | -0.4890108 | 0.1550802 | -0.708308317 | 0.07596045 | -0.478902834
weig | -0.6055892 | 0.2855428 | -0.018705245 | 0.02321703 | 0.742184681
bmi | -0.4524146 | 0.3088509 | 0.690373005 | -0.06042667 | -0.468685267

In this context, we can see that the PC1 is positively correlated to the variables restPulse (0.3201933) and actiPulse (0.2948346) and negatively correlated to the variables heig (-0.4890108), weig (-0.6055892) and bmi (-0.4524146). On the other hand, PC2 is positively correlated with all the variables and PC3 is negatively correlated with all the variables except bmi.

Thus, we may infer that the PC1 will be the most useful to look for relationships within the data in the analysis below.

Furthermore, as we have reduced the dimensions from 6 to 3, we may interpret that, indeed, the variables are somewhat correlated.

Then, the observations were represented graphically in the new reduced space, differentiating between the gender of the patients in the plots.

<p align="center">
	<img src="Images/Fig2_ScorePlotZ1vsZ2.png?raw=true" width=60% height=60%>
</p>

<p align="center">
	<img src="Images/Fig3_ScorePlotZ1vsZ3.png?raw=true" width=60% height=60%>
</p>

<p align="center">
	<img src="Images/Fig4_ScorePlotZ2vsZ3.png?raw=true" width=60% height=60%>
</p>

From the plots of Z1 vs Z2 and Z1 vs Z3, it is possible to clearly distinguish that the principal component 1 is able to capture the relationship between the gender of the patients and the data. In particular, the PC1 is positively correlated with the female gender and negatively correlated with the male gender, thus generating two distinct groups. 

Therefore, if we recall that PC1 is positively correlated with the variables restPulse (0.3201933) and actiPulse (0.2948346) and negatively correlated to the variables heig (-0.4890108), weig (-0.6055892) and bmi (-0.4524146); we may infer that the female patients tend to exhibit a higher restPulse and actiPulse but smaller values of height, weight and bmi; which is reasonable as women tend to have lowers values of height, weight and bmi in comparison to men.

In this sense, we can also interpret that male patients tend to have a smaller restPulse and actiPulse but higher values of height, weight and bmi which, again, is reasonable according to the reasoning exposed above.

On the other hand, the plot of Z2 vs Z3 fails in generating a clear pattern between the observations and the gender of the patients.

This interpretation is coherent if we take a look to the biplots of Z1 vs Z2 and Z1 vs Z3:

<p align="center">
	<img src="Images/Fig5_BiplotZ1vsZ2.png?raw=true" width=60% height=60%>
</p>

<p align="center">
	<img src="Images/Fig6_BiplotZ1vsZ3.png?raw=true" width=60% height=60%>
</p>

In view of the two previous biplots, it is possible to interpret that, indeed, the observations from the female patients are associated with higher values for  restPulse and actiPulse, while being also associated with lower values for weigth, height and bmi. On the contrary, the observations from the male patients are associated with lower values for  restPulse and actiPulse, while being also associated with higher values for weigth, height and bmi. 

With these relationships in mind, it would be possible, for instance, to design a further test of hypothesis to compare the means of the observations from male and female patients in one or several of the variables assessed in this analysis.

Thus, we may conclude that the current PCA analysis was successful in to capture some important relationships within the observations and the gender in the data, which shows the great potential that this statistical technique have as an exploratory tool for datasets with many variables.


#### **5.2 Clustering Analysis**

Afterwards, a cluster analysis was performed to the data. To do so, first, hierarchical cluster analyses using several linkages methods were applied in order to select the most suitable number of clusters.

<p align="center">
	<img src="Images/Fig7_DendrogramCompLink.png?raw=true" width=70% height=70%>
</p>

<p align="center">
	<img src="Images/Fig8_DendrogramAveLink.png?raw=true" width=70% height=70%>
</p>

<p align="center">
	<img src="Images/Fig9_DendrogramSinLink.png?raw=true" width=70% height=70%>
</p>

From the three dendrograms plotted above, the ones that generates the most distinguishable clusters were the ones constructed with the Complete Linkage and the Average Linkage methods, yielding about 8 and 7 subgroups, respectively. On the other hand, in the Single Linkage method it is not possible to easily differentiate the clusters so it will be discarded from further analysis. 

In order to evaluate the goodness of clusterings generated, it is possible to use the Dunn’s Index; which is the ratio between the minimum inter-cluster distances to the maximum intra-cluster diameter. The diameter of a cluster is the distance between its two furthermost points. In order to have well separated and compact clusters, it is necessary to aim for a higher Dunn’s index.

Linkage Method | Dunn's Index
:---: | :---:
Complete | 0.1642313
Average | 0.1548116

As shown by the Dunn function, the Dunn’s Index is higher for the Complete Linkage method. 

In this context, as the Complete Linkage method exhibited the highest Dunn’s Index value, the clusters are more distinguishable and it is the linkage technique most used in cluster analysis, this method was selected as the most suitable for the next analysis.

So, by building a table with the results using the Complete Linkage method and 8 clusters, the following characterization according to the gender of each patient was obtained:

Clusters | Female patients | Male patients
:---:|:---:|:---:
1 | 0 | 14
2 | 7 | 23
3 | 3 | 1
4 | 6 | 16
5 | 11 | 1
6 | 7 | 1
7 | 0 | 1
8 | 1 | 0

And the following labeled dendrogram according to the gender of each patient was generated:

<p align="center">
	<img src="Images/Fig10_DendrogramGender.png?raw=true" width=70% height=70%>
</p>

After selecting the number of clusters from the Hierarchical Cluster Analysis, the K-means Cluster Analysis was applied with 8 clusters. Then, the gender of the patients was examined by cluster. 

K-mean clusters | Female patients | Male patients
:---:|:---:|:---:
1 | 9 | 1
2 | 1 | 24
3 | 9 | 1
4 | 6 | 9
5 | 0 | 13
6 | 0 | 6
7 | 4 | 3
8 | 6 | 0

Then, the gender of the patients was examined by cluster.



K-meams cluster | Hierarchical cluster 1 | Hierarchical cluster 2 | Hierarchical cluster 3 | Hierarchical cluster 4 | Hierarchical cluster 5 | Hierarchical cluster 6 | Hierarchical cluster 7 | Hierarchical cluster 8
:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:
1 |0 |0 |0 |1 |9 |0 |0 |0
2 |2 |20 |0 |3 |0 |0 |0 |0
3 |0 |7 |0 |0 |3 |0 |0 |0
4 |0 |0 |0 |14 |0 |1 |0 |0
5 |9 |0 |0 |3 |0 |0 |1 |0
6 |3 |3 |0 |0 |0 |0 |0 |0
7 |0 |0 |4 |1 |0 |2 |0 |0
8 |0 |0 |0 |0 |0 |5 |0 |1

Finally, a Hierarchical Clustering Analysis was performed based on the already calculated principal components.

<p align="center">
	<img src="Images/Fig11_DendrogramPC.png?raw=true" width=70% height=70%>
</p>

From the whole cluster analysis, we can observe that the clusters generated from both the Hierarchical analysis and the K-means analysis somewhat coincide. For instance, from the former table, both methods share 20 elements in their respective cluster 2 and 14 elements in their respective cluster 4. 

It is also noteworthy that, indeed, both cluster methods were able to group the gender of the patients in mostly homogeneous subgroups. For example, in the hierarchical clustering, the clusters 1, 2 and 4 are mostly made of male patients; while the clusters 3, 5, 6 and 8 are mostly made of female patients.

Likewise, in the k-means method, the clusters 2,5 and 6 are mostly made of male patients; while the clusters 1, 3 and 8 are mostly made of female patients.

Furthermore, the Hierarchical Clustering Analysis based on the principal components also yielded a similar behavior than the previous clusters, as some clusters groups a majority of male patients whereas others groups a majority of female ones.

Thus, the clustering analysis has proved to be useful in to relate some subgroups of observations in terms of the gender of the patients, which is also consistent with the findings from the PCA.

Please refer to the **[Complete Report](https://github.com/DanielEduardoLopez/PulseAnalysis/blob/main/PulseAnalysis.pdf)** for the full results.

___
### **6. Conclusions**
Pulse at rest and pulse in activity are negatively correlated with the weight, height and body mass index in both male and female patients. 

On the other hand, female patients had a tendency to exhibit lower values of weight, height and body mass index and higher values of pulse at rest and pulse in activity. On the contrary, male patients exhibited a higher values of weight, height and body mass index and lower values of pulse at rest and pulse in activity. 

Finally, the present study showed that most of the patients tend to display a similar behavior in terms of pulse at rest, pulse in activity, weight, height and body mass index according to their gender, forming mostly distinctive groups in both PCA and clustering analysis.

___
### **7. Bibliography**
- **Escobar-Restrepo, B., Torres-Villa, R. & Kyriacou, P. A. (2018).** Evaluation of the Linear Relationship Between Pulse Arrival Time and Blood Pressure in ICU Patients: Potential and Limitations. *Frontiers in Physiology*. 9. <a href="https://www.frontiersin.org/articles/10.3389/fphys.2018.01848">DOI: 10.3389/fphys.2018.01848</a>.
- **Moran, J. F. (1990).** Pulse. In H. K. Walker, W. D. Hall, & J. W. Hurst (Eds.), *Clinical Methods* (pp. 98–100). Boston: Butterworths. <a href="https://www.ncbi.nlm.nih.gov/books/NBK278/">https://www.ncbi.nlm.nih.gov/books/NBK278/</a>.
- **Rollins, J. B. (2015).** *Metodología Fundamental para la Ciencia de Datos*. Somers: IBM Corporation. Retrieved from https://www.ibm.com/downloads/cas/WKK9DX51

___
### **8. Description of Files in Repository**
File | Description 
--- | --- 
pulse.RData | Dataset.
PulseAnalysis.R | R code for performing the unsupervised learning techniques.
PulseAnalysis.Rmd | Report in R markdown format.
PulseAnalysis.pdf | Report in pdf format.
