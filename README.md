# The Manuscript* "Experimental Interpretation of Adequate Weight-Metric Combination for Dynamic User-Based Collaborative Filtering" Source Code (AdequateWeightMetricDynamicCF)
*submitted and under review

## General Info

This repository contains the source code for the manuscript _Experimental Interpretation of Adequate Weight-Metric Combination for Dynamic User-Based Collaborative Filtering_ tests by _Savas Okyay_ and _Sercan Aygun_. If you edit or use this collection of Matlab modules, please read and cite the article. Only academic usage for scientific purposes is allowed, but not the commercial.

Any dataset can be analyzed as long as it meets the requirement pre-defined user×item format. See ```mainAutoTest.m``` and ```_sample-DummyDataset.mat``` files for further details.

|Author|_e_-mail|Affiliation|
|------|------|-----------|
|Savas Okyay|osavas@ogu.edu.tr|Eskisehir Osmangazi University, Computer Engineering Dept., Eskisehir, 26040, Turkey|
|Sercan Aygun|ayguns@yildiz.edu.tr|Yildiz Technical University, Computer Engineering Dept., Istanbul, 34220, Turkey|

---
manuscript source code version: **v2.2.15** (plus, some non-technical and textual enhancements from the current version)

the current version: **v3.3** (as of February 2021)

---

##### Abstract
Recommender systems include a broad scope of applications as an appealing research area. A recommender system is associated with subjective preferences. Therefore, proper recommendations that pose a compelling problem vary for each individual. As a field of data science and machine learning, recommender systems require both statistical perspective and sufficient performance monitoring. In this study, we propose diversified similarity measurements by observing performances with generic metrics. In the sense of user-based collaborative filtering, it is measured how likely an item is preferred by any user. Having examined the best neighbor counts, we do unveil the test item bias phenomenon for similarity equations. Due to the statistical parameters used to be computed in a global scope beforehand, there is implicit information in the literature, whether those parameters comprise the focal point user data statically. For each dynamic prediction, user-wise parameters are expected to be generated in runtime by leaving the item-of-interest out. This both gives reliable results and is more compatible with real-time systems. Furthermore, we underline the effect of significance weighting by boosting the similarities between a user-of-interest and its neighbors. All in all, this work uniquely combines significance weighting and test item bias mitigation by inspecting the fine-tuned neighborhood. As a consequence, considering the visual comparison of results and elaborated heat-map tables at the end, concluding remarks of adequate similarity weight and performance metric combinations are interpreted.

##### Keywords
Collaborative filtering, dynamicity, MovieLens dataset, recommender systems, significance weighting, test item bias, user-based neighborhood.

## Installation and Usage

The program package consists of several Matlab m-files. To run the test procedure, download the package into a directory accessible by Matlab and see ```main*.m``` files for details. Run the ```mainAutoTest.m``` and see how it works. The results file will be saved at the end of the test into the ```../testResultsAll``` folder.

See Matlab's help function by typing: 
```
help filename
```

