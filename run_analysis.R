> getwd()
[1] "D:/R/coursera/3 Getting and cleaning data/Week4"
> library(data.table)
data.table 1.9.6  For help type ?data.table or https://github.com/Rdatatable/data.table/wiki
The fastest way to learn (by data.table authors): https://www.datacamp.com/courses/data-analysis-the-data-table-way
Warning message:
package ‘data.table’ was built under R version 3.2.5 
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:data.table’:

    between, last

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

Warning message:
package ‘dplyr’ was built under R version 3.2.5 
> featureNames <- read.table("UCI HAR Dataset/features.txt")
> activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
> subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
> activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
> featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
> subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
> activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
> featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
> subject <- rbind(subjectTrain, subjectTest)
> activity <- rbind(activityTrain, activityTest)
> features <- rbind(featuresTrain, featuresTest)
> colnames(features) <- t(featureNames[2])
> colnames(activity) <- "Activity"
> colnames(subject) <- "Subject"
> completeData <- cbind(features,activity,subject)
> columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
> requiredColumns <- c(columnsWithMeanSTD, 562, 563)
> dim(completeData)
[1] 10299   563
> extractedData <- completeData[,requiredColumns]
> dim(extractedData)
[1] 10299    88
> extractedData <- completeData[,requiredColumns]
> dim(extractedData)
[1] 10299    88
> names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
> names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
> names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
> names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
> names(extractedData)<-gsub("^t", "Time", names(extractedData))
> names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
> names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
> names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
> names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
> names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
> names(extractedData)<-gsub("angle", "Angle", names(extractedData))
> names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))
> head(extractedData)
  TimeBodyAccelerometerMean()-X TimeBodyAccelerometerMean()-Y TimeBodyAccelerometerMean()-Z TimeBodyAccelerometerSTD()-X TimeBodyAccelerometerSTD()-Y TimeBodyAccelerometerSTD()-Z
1                     0.2885845                   -0.02029417                    -0.1329051                   -0.9952786                   -0.9831106                   -0.9135264
2                     0.2784188                   -0.01641057                    -0.1235202                   -0.9982453                   -0.9753002                   -0.9603220
3                     0.2796531                   -0.01946716                    -0.1134617                   -0.9953796                   -0.9671870                   -0.9789440
4                     0.2791739                   -0.02620065                    -0.1232826                   -0.9960915                   -0.9834027                   -0.9906751
5                     0.2766288                   -0.01656965                    -0.1153619                   -0.9981386                   -0.9808173                   -0.9904816
6                     0.2771988                   -0.01009785                    -0.1051373                   -0.9973350                   -0.9904868                   -0.9954200
  TimeGravityAccelerometerMean()-X TimeGravityAccelerometerMean()-Y TimeGravityAccelerometerMean()-Z TimeGravityAccelerometerSTD()-X TimeGravityAccelerometerSTD()-Y
1                        0.9633961                       -0.1408397                       0.11537494                      -0.9852497                      -0.9817084
2                        0.9665611                       -0.1415513                       0.10937881                      -0.9974113                      -0.9894474
3                        0.9668781                       -0.1420098                       0.10188392                      -0.9995740                      -0.9928658
4                        0.9676152                       -0.1439765                       0.09985014                      -0.9966456                      -0.9813928
5                        0.9682244                       -0.1487502                       0.09448590                      -0.9984293                      -0.9880982
6                        0.9679482                       -0.1482100                       0.09190972                      -0.9989793                      -0.9867539
  TimeGravityAccelerometerSTD()-Z TimeBodyAccelerometerJerkMean()-X TimeBodyAccelerometerJerkMean()-Y TimeBodyAccelerometerJerkMean()-Z TimeBodyAccelerometerJerkSTD()-X
1                      -0.8776250                        0.07799634                       0.005000803                      -0.067830808                       -0.9935191
2                      -0.9316387                        0.07400671                       0.005771104                       0.029376633                       -0.9955481
3                      -0.9929172                        0.07363596                       0.003104037                      -0.009045631                       -0.9907428
4                      -0.9784764                        0.07732061                       0.020057642                      -0.009864772                       -0.9926974
5                      -0.9787449                        0.07344436                       0.019121574                       0.016779979                       -0.9964202
6                      -0.9973064                        0.07793244                       0.018684046                       0.009344434                       -0.9948136
  TimeBodyAccelerometerJerkSTD()-Y TimeBodyAccelerometerJerkSTD()-Z TimeBodyGyroscopeMean()-X TimeBodyGyroscopeMean()-Y TimeBodyGyroscopeMean()-Z TimeBodyGyroscopeSTD()-X
1                       -0.9883600                       -0.9935750              -0.006100849               -0.03136479                0.10772540               -0.9853103
2                       -0.9810636                       -0.9918457              -0.016111620               -0.08389378                0.10058429               -0.9831200
3                       -0.9809556                       -0.9896866              -0.031698294               -0.10233542                0.09612688               -0.9762921
4                       -0.9875527                       -0.9934976              -0.043409983               -0.09138618                0.08553770               -0.9913848
5                       -0.9883587                       -0.9924549              -0.033960416               -0.07470803                0.07739203               -0.9851836
6                       -0.9887145                       -0.9922663              -0.028775508               -0.07039311                0.07901214               -0.9851808
  TimeBodyGyroscopeSTD()-Y TimeBodyGyroscopeSTD()-Z TimeBodyGyroscopeJerkMean()-X TimeBodyGyroscopeJerkMean()-Y TimeBodyGyroscopeJerkMean()-Z TimeBodyGyroscopeJerkSTD()-X
1               -0.9766234               -0.9922053                   -0.09916740                   -0.05551737                   -0.06198580                   -0.9921107
2               -0.9890458               -0.9891212                   -0.11050283                   -0.04481873                   -0.05924282                   -0.9898726
3               -0.9935518               -0.9863787                   -0.10848567                   -0.04241031                   -0.05582883                   -0.9884618
4               -0.9924073               -0.9875542                   -0.09116989                   -0.03633262                   -0.06046466                   -0.9911194
5               -0.9923781               -0.9874019                   -0.09077010                   -0.03763253                   -0.05828932                   -0.9913545
6               -0.9921175               -0.9830768                   -0.09424758                   -0.04335526                   -0.04193600                   -0.9916216
  TimeBodyGyroscopeJerkSTD()-Y TimeBodyGyroscopeJerkSTD()-Z TimeBodyAccelerometerMagnitudeMean() TimeBodyAccelerometerMagnitudeSTD() TimeGravityAccelerometerMagnitudeMean()
1                   -0.9925193                   -0.9920553                           -0.9594339                          -0.9505515                              -0.9594339
2                   -0.9972926                   -0.9938510                           -0.9792892                          -0.9760571                              -0.9792892
3                   -0.9956321                   -0.9915318                           -0.9837031                          -0.9880196                              -0.9837031
4                   -0.9966410                   -0.9933289                           -0.9865418                          -0.9864213                              -0.9865418
5                   -0.9964730                   -0.9945110                           -0.9928271                          -0.9912754                              -0.9928271
6                   -0.9960147                   -0.9930906                           -0.9942950                          -0.9952490                              -0.9942950
  TimeGravityAccelerometerMagnitudeSTD() TimeBodyAccelerometerJerkMagnitudeMean() TimeBodyAccelerometerJerkMagnitudeSTD() TimeBodyGyroscopeMagnitudeMean() TimeBodyGyroscopeMagnitudeSTD()
1                             -0.9505515                               -0.9933059                              -0.9943364                       -0.9689591                      -0.9643352
2                             -0.9760571                               -0.9912535                              -0.9916944                       -0.9806831                      -0.9837542
3                             -0.9880196                               -0.9885313                              -0.9903969                       -0.9763171                      -0.9860515
4                             -0.9864213                               -0.9930780                              -0.9933808                       -0.9820599                      -0.9873511
5                             -0.9912754                               -0.9934800                              -0.9958537                       -0.9852037                      -0.9890626
6                             -0.9952490                               -0.9930177                              -0.9954243                       -0.9858944                      -0.9864403
  TimeBodyGyroscopeJerkMagnitudeMean() TimeBodyGyroscopeJerkMagnitudeSTD() FrequencyBodyAccelerometerMean()-X FrequencyBodyAccelerometerMean()-Y FrequencyBodyAccelerometerMean()-Z
1                           -0.9942478                          -0.9913676                         -0.9947832                         -0.9829841                         -0.9392687
2                           -0.9951232                          -0.9961016                         -0.9974507                         -0.9768517                         -0.9735227
3                           -0.9934032                          -0.9950910                         -0.9935941                         -0.9725115                         -0.9833040
4                           -0.9955022                          -0.9952666                         -0.9954906                         -0.9835697                         -0.9910798
5                           -0.9958076                          -0.9952580                         -0.9972859                         -0.9823010                         -0.9883694
6                           -0.9952748                          -0.9952050                         -0.9966567                         -0.9869395                         -0.9927386
  FrequencyBodyAccelerometerSTD()-X FrequencyBodyAccelerometerSTD()-Y FrequencyBodyAccelerometerSTD()-Z FrequencyBodyAccelerometerMeanFreq()-X FrequencyBodyAccelerometerMeanFreq()-Y
1                        -0.9954217                        -0.9831330                        -0.9061650                             0.25248290                             0.13183575
2                        -0.9986803                        -0.9749298                        -0.9554381                             0.27130855                             0.04286364
3                        -0.9963128                        -0.9655059                        -0.9770493                             0.12453124                            -0.06461056
4                        -0.9963121                        -0.9832444                        -0.9902291                             0.02904438                             0.08030227
5                        -0.9986065                        -0.9801295                        -0.9919150                             0.18108977                             0.05798789
6                        -0.9976438                        -0.9922637                        -0.9970459                             0.15738377                             0.31883523
  FrequencyBodyAccelerometerMeanFreq()-Z FrequencyBodyAccelerometerJerkMean()-X FrequencyBodyAccelerometerJerkMean()-Y FrequencyBodyAccelerometerJerkMean()-Z
1                            -0.05205025                             -0.9923325                             -0.9871699                             -0.9896961
2                            -0.01430976                             -0.9950322                             -0.9813115                             -0.9897398
3                             0.08267692                             -0.9909937                             -0.9816423                             -0.9875663
4                             0.18569468                             -0.9944466                             -0.9887272                             -0.9913542
5                             0.55978632                             -0.9962920                             -0.9887900                             -0.9906244
6                             0.60559943                             -0.9948507                             -0.9882443                             -0.9901575
  FrequencyBodyAccelerometerJerkSTD()-X FrequencyBodyAccelerometerJerkSTD()-Y FrequencyBodyAccelerometerJerkSTD()-Z FrequencyBodyAccelerometerJerkMeanFreq()-X
1                            -0.9958207                            -0.9909363                            -0.9970517                                 0.87038451
2                            -0.9966523                            -0.9820839                            -0.9926268                                 0.60851352
3                            -0.9912488                            -0.9814148                            -0.9904159                                 0.11543400
4                            -0.9913783                            -0.9869269                            -0.9943908                                 0.03579805
5                            -0.9969025                            -0.9886067                            -0.9929065                                 0.27335020
6                            -0.9952180                            -0.9901788                            -0.9930667                                 0.32883589
  FrequencyBodyAccelerometerJerkMeanFreq()-Y FrequencyBodyAccelerometerJerkMeanFreq()-Z FrequencyBodyGyroscopeMean()-X FrequencyBodyGyroscopeMean()-Y FrequencyBodyGyroscopeMean()-Z
1                                 0.21069700                                 0.26370789                     -0.9865744                     -0.9817615                     -0.9895148
2                                -0.05367561                                 0.06314827                     -0.9773867                     -0.9925300                     -0.9896058
3                                -0.19343634                                 0.03825433                     -0.9754332                     -0.9937147                     -0.9867557
4                                -0.09303585                                 0.16809523                     -0.9871096                     -0.9936015                     -0.9871913
5                                 0.07913538                                 0.29238418                     -0.9824465                     -0.9929838                     -0.9886664
6                                 0.05477140                                 0.32094497                     -0.9848902                     -0.9927862                     -0.9807784
  FrequencyBodyGyroscopeSTD()-X FrequencyBodyGyroscopeSTD()-Y FrequencyBodyGyroscopeSTD()-Z FrequencyBodyGyroscopeMeanFreq()-X FrequencyBodyGyroscopeMeanFreq()-Y
1                    -0.9850326                    -0.9738861                    -0.9940349                        -0.25754888                         0.09794711
2                    -0.9849043                    -0.9871681                    -0.9897847                        -0.04816744                        -0.40160791
3                    -0.9766422                    -0.9933990                    -0.9873282                        -0.21668507                        -0.01726417
4                    -0.9928104                    -0.9916460                    -0.9886776                         0.21686246                        -0.13524536
5                    -0.9859818                    -0.9919558                    -0.9879443                        -0.15334258                        -0.08840273
6                    -0.9852871                    -0.9916595                    -0.9853661                        -0.36303968                        -0.13323831
  FrequencyBodyGyroscopeMeanFreq()-Z FrequencyBodyAccelerometerMagnitudeMean() FrequencyBodyAccelerometerMagnitudeSTD() FrequencyBodyAccelerometerMagnitudeMeanFreq()
1                         0.54715105                                -0.9521547                               -0.9561340                                   -0.08843612
2                        -0.06817833                                -0.9808566                               -0.9758658                                   -0.04414989
3                        -0.11072029                                -0.9877948                               -0.9890155                                    0.25789914
4                        -0.04972798                                -0.9875187                               -0.9867420                                    0.07358150
5                        -0.16223039                                -0.9935909                               -0.9900635                                    0.39431033
6                         0.19483324                                -0.9948360                               -0.9952833                                    0.43796212
  FrequencyBodyAccelerometerJerkMagnitudeMean() FrequencyBodyAccelerometerJerkMagnitudeSTD() FrequencyBodyAccelerometerJerkMagnitudeMeanFreq() FrequencyBodyGyroscopeMagnitudeMean()
1                                    -0.9937257                                   -0.9937550                                         0.3469885                            -0.9801349
2                                    -0.9903355                                   -0.9919603                                         0.5320605                            -0.9882956
3                                    -0.9892801                                   -0.9908667                                         0.6607950                            -0.9892548
4                                    -0.9927689                                   -0.9916998                                         0.6789213                            -0.9894128
5                                    -0.9955228                                   -0.9943890                                         0.5590577                            -0.9914330
6                                    -0.9947329                                   -0.9951562                                         0.2469096                            -0.9905000
  FrequencyBodyGyroscopeMagnitudeSTD() FrequencyBodyGyroscopeMagnitudeMeanFreq() FrequencyBodyGyroscopeJerkMagnitudeMean() FrequencyBodyGyroscopeJerkMagnitudeSTD()
1                           -0.9613094                                -0.1289889                                -0.9919904                               -0.9906975
2                           -0.9833219                                -0.2719585                                -0.9958539                               -0.9963995
3                           -0.9860277                                -0.2127279                                -0.9950305                               -0.9951274
4                           -0.9878358                                -0.0356842                                -0.9952207                               -0.9952369
5                           -0.9890594                                -0.2735820                                -0.9950928                               -0.9954648
6                           -0.9858609                                -0.2973291                                -0.9951433                               -0.9952387
  FrequencyBodyGyroscopeJerkMagnitudeMeanFreq() Angle(TimeBodyAccelerometerMean,Gravity) Angle(TimeBodyAccelerometerJerkMean),GravityMean) Angle(TimeBodyGyroscopeMean,GravityMean)
1                                   -0.07432303                              -0.11275434                                       0.030400372                               -0.4647614
2                                    0.15807454                               0.05347695                                      -0.007434566                               -0.7326262
3                                    0.41450281                              -0.11855926                                       0.177899480                                0.1006992
4                                    0.40457253                              -0.03678797                                      -0.012892494                                0.6400110
5                                    0.08775301                               0.12332005                                       0.122541960                                0.6935783
6                                    0.01995331                               0.08263215                                      -0.143439010                                0.2750408
  Angle(TimeBodyGyroscopeJerkMean,GravityMean) Angle(X,GravityMean) Angle(Y,GravityMean) Angle(Z,GravityMean) Activity Subject
1                                  -0.01844588           -0.8412468            0.1799406          -0.05862692        5       1
2                                   0.70351059           -0.8447876            0.1802889          -0.05431672        5       1
3                                   0.80852908           -0.8489335            0.1806373          -0.04911782        5       1
4                                  -0.48536645           -0.8486494            0.1819348          -0.04766318        5       1
5                                  -0.61597061           -0.8478653            0.1851512          -0.04389225        5       1
6                                  -0.36822404           -0.8496316            0.1848225          -0.04212638        5       1
> extractedData$Subject <- as.factor(extractedData$Subject)
> extractedData <- data.table(extractedData)
> tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
> tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
> write.table(tidyData, file = "Tidy.txt", row.names = FALSE)