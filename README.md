# The Source Code of the Article "Experimental interpretation of adequate weight-metric combination for dynamic user-based collaborative filtering", *PeerJ Computer Science*
|name|value|
|--:|:--|
|short name|**AdequateWeightMetricDynamicCF**|
|title|Experimental interpretation of adequate weight-metric combination for dynamic user-based collaborative filtering|
|authors|[Savas Okyay](https://orcid.org/0000-0003-3955-6324) and [Sercan Aygun](https://orcid.org/0000-0002-4615-7914)|
|doi|[10.7717/peerj-cs.784](https://doi.org/10.7717/peerj-cs.784)|
|journal|[PeerJ Computer Science](https://peerj.com/computer-science/) (ISSN: 2376-5992)|
|_submitted on_|May 17, 2021|
|_accepted on_|October 26, 2021 (5 months and 9 days)|
|_published on_|December 9, 2021 (6 months and 22 days since the first submission; 1 month and 13 days since the acceptance)|
|CodeOcean|[10.24433/CO.8358536.v1](https://doi.org/10.24433/CO.8358536.v1) ([Version 1.0](https://codeocean.com/capsule/1427708/tree/v1))|

## How to cite this article?
Okyay S, Aygun S. 2021. Experimental interpretation of adequate weight-metric combination for dynamic user-based collaborative filtering. **PeerJ Comput. Sci. 7:e784 DOI 10.7717/peerj-cs.784**
|more styles||
|--:|:--|
|IEEE|S. Okyay and S. Aygun, "Experimental interpretation of adequate weight-metric combination for dynamic user-based collaborative filtering," *PeerJ Computer Science*, 7:e784, 2021, doi: 10.7717/peerj-cs.784.|
|APA6|Okyay, S., & Aygun, S. (2021). Experimental interpretation of adequate weight-metric combination for dynamic user-based collaborative filtering. *PeerJ Computer Science*, 7:e784. doi:10.7717/peerj-cs.784|

## General Info
This repository contains the source code of the [PeerJ Computer Science](https://peerj.com/computer-science/) (ISSN: 2376-5992) article "_Experimental interpretation of adequate weight-metric combination for dynamic user-based collaborative filtering_" by [_Savas Okyay_](https://orcid.org/0000-0003-3955-6324) and [_Sercan Aygun_](https://orcid.org/0000-0002-4615-7914). If you edit or use this collection of Matlab modules, please read and cite the article. Only academic usage for scientific purposes is allowed, but not the commercial.

Any dataset can be analyzed as long as it meets the requirement pre-defined user×item format. See ```mainAutoTest.m``` and ```_sample-DummyDataset.mat``` files for further details.

|Author|_e_-mail|Affiliation|
|:----:|:----:|:----------|
|Savas Okyay|osavas@ogu.edu.tr|Eskisehir Osmangazi University, Computer Engineering Dept., Eskisehir, 26040, Turkey|
|Sercan Aygun|ayguns@yildiz.edu.tr|Yildiz Technical University, Computer Engineering Dept., Istanbul, 34220, Turkey|

---
manuscript source code version: **v2.2.15** (plus, some non-technical and textual enhancements from the current version)

the current version: **v3.3** (as of February 2021)

---

##### Abstract
Recommender systems include a broad scope of applications and are associated with subjective preferences, indicating variations in recommendations. As a field of data science and machine learning, recommender systems require both statistical perspectives and sufficient performance monitoring. In this paper, we propose diversified similarity measurements by observing recommendation performance using generic metrics. Considering _user-based_ collaborative filtering, the probability of an item being preferred by any user is measured. Having examined the best neighbor counts, we verified the test item bias phenomenon for similarity equations. Because of the statistical parameters used for computing in a global scope, there is implicit information in the literature, whether those parameters comprise the focal point user data statically. Regarding each dynamic prediction, user-wise parameters are expected to be generated at runtime by excluding the item of interest. This yields reliable results and is more compatible with real-time systems. Furthermore, we underline the effect of significance weighting by examining the similarities between a user of interest and its neighbors. Overall, this study uniquely combines significance weighting and test-item bias mitigation by inspecting the fine-tuned neighborhood. Consequently, the results reveal adequate _similarity weight_ and _performance metric_ combinations. The source code of our architecture is available at https://codeocean.com/capsule/1427708/tree/v1.

##### Keywords
Collaborative filtering, dynamicity, MovieLens dataset, recommender systems, significance weighting, test item bias, user-based neighborhood.

## Installation and Usage

The program package consists of several Matlab m-files. To run the test procedure, download the package into a directory accessible by Matlab and see ```main*.m``` files for details. Run the ```mainAutoTest.m``` and see how it works. The results file will be saved at the end of the test into the ```../testResultsAll``` folder.

See Matlab's help function by typing: 
```
help filename
```

