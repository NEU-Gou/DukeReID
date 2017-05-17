![alt text](https://github.com/NEU-Gou/DukeReID/blob/master/DukeReID.jpg "DukeReID")
# DukeMTMC4ReID
DukeMTMC4ReID dataset is new large-scale real-world person re-id dataset based on [DukeMTMC](http://vision.cs.duke.edu/DukeMTMC/). We use a fast state-of-the-art [person detector](https://bitbucket.org/rodrigob/doppia) for accurate detections. After verified by the ground truth, for each identity, we uniformly sample 5 "good" bounding boxes in each available camera, while retaining all the "FP" bounding boxes in the corresponding frames. To summarize, the relevant statistics of the proposed DukeMTMC4ReID dataset are provided below:
* Images corresponding to 1,852 people existing across all the 8 cameras
* 1,413 unique identities with 22,515 bounding boxes that appear in more than one camera (valid identities)
* 439 distractor identities with 2,195 bounding boxes that appear in only one camera, in addition to 21,551 ?FP? bounding boxes from the person detector
* The size of the bounding box varies from 72×34 pixels to 415×188 pixels

|                 |  Total |  cam1  |  cam2 |  cam3 |  cam4 |  cam5 |  cam6  |  cam7 |  cam8 |
|:---------------:|:------:|:------:|:-----:|:-----:|:-----:|:-----:|:------:|:-----:|:-----:|
|     # bboxes    | 46,261 | 10,048 | 4,469 | 5,117 | 2,040 | 2,400 | 10,632 | 4,335 | 7,220 |
| # person bboxes | 24,710 |  4,220 | 4,030 | 1,975 | 1,640 | 2,195 |  3,635 | 2,285 | 4,730 |
| # ``FP'' bboxes | 21,551 |  5,828 |  439  | 3,142 |  400  |  205  |  6,997 | 2,050 | 2,490 |
|    # persons    |  1,852 |   844  |  806  |  395  |  328  |  439  |   727  |  457  |  946  |
|   # valid ids   |  1,413 |   828  |  778  |  394  |  322  |  439  |   718  |  457  |  567  |
|  # distractors  |   439  |   16   |   28  |   1   |   6   |   0   |    9   |   0   |  379  |
|   # probe ids   |   706  |   403  |  373  |  200  |  168  |  209  |   358  |  243  |  284  |

More details and benchmark results can be found in this [paper](http://robustsystems.coe.neu.edu/sites/robustsystems.coe.neu.edu/files/systems/papers/MengranGou_CVPRW17.pdf)
### How to use
1. Clone or download this repo
2. Download the dataset from [here](http://robustsystems.coe.neu.edu/sites/robustsystems.coe.neu.edu/files/systems/dataset/DukeReID.zip) and extract it within the same folder of the code
    - p0001_c5_f0000051246_1.jpg
    bounding box of person 0001 in camera 5 at frame 51246
    - partition.
    idx_train   - index of train samples
    idx_test    - index of test samples
    idx_probe   - index of probe samples in test 
    idx_gallery - index of gallery samples in test
    ix_pos_pair - index of pre-generated positive pairs
    ix_neg_pair - index of pre-generated negtive pairs
    cam_pairs   - [probe camera, gallery camera] (0 means all the other cameras)

3. Download the pre-computed [feature](http://robustsystems.coe.neu.edu/sites/robustsystems.coe.neu.edu/files/systems/dataset/feature/feature_DukeReID_LOMO_6patch.mat) 
4. run script_test.m to parsing the data and evaluate it with pre-computed feature

### References
```
@InProceedings{gou2017dukemtmc4reid,
  author = {Gou, Mengran and Karanam, Srikrishna and Liu, Wenqian and Camps, Octavia and Radke, Richard J.},
  title = {DukeMTMC4ReID: A Large-Scale Multi-Camera Person Re-Identification Dataset},
  booktitle = {The IEEE Conference on Computer Vision and Pattern Recognition (CVPR) Workshops},
  month = {July},
  year = {2017}
}
```
If you use this dataset, please also cite the original DukeMTMC dataset accordingly:
```
@inproceedings{ristani2016MTMC,
  title = {Performance Measures and a Data Set for Multi-Target, Multi-Camera Tracking},
  author = {Ristani, Ergys and Solera, Francesco and Zou, Roger and Cucchiara, Rita and Tomasi, Carlo},
  booktitle = {European Conference on Computer Vision workshop on Benchmarking Multi-Target Tracking},
  year = {2016}
}
```
### License
The DukeMTMC4ReID dataset is made available under the Open Data Commons Attribution [License](https://opendatacommons.org/licenses/by/1.0/) and for academic use only.

READABLE SUMMARY OF Open Data Commons Attribution License 
```
You are free:

    To Share: To copy, distribute and use the database.
    To Create: To produce works from the database.
    To Adapt: To modify, transform and build upon the database.

As long as you:

    Attribute: You must attribute any public use of the database, or works produced from the database, in the manner specified in the license. For any use or redistribution of the database, or works produced from it, you must make clear to others the license of the database and keep intact any notices on the original database.
```
