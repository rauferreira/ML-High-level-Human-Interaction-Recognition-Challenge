# ML-High-level-Human-Interaction-Recognition-Challenge
In the "High-level Human Interaction Recognition Challenge", contestants are expected to recognize ongoing human activities from continuous videos. The intention is to motivate researchers to explore the recognition of complex human activities from continuous videos, taken in realistic settings. 

As a freelancing strike i was ask to solve this problem, using ML tecnhiques to train a classifier.

Full contest description:
http://cvrc.ece.utexas.edu/SDHA2010/Human_Interaction.html

Histogram of Oriented Gradients (HOG) image descriptors and a Linear Support Vector Machines (SVMs) [1] can be combined to create highly accurate classifiers.
Therefore i chose to apply the HOG + SVM methodology due to its robustness when in classifying images (frames).

Furthermore, each video is represented as a sequence of frames, which on their hand are represented by a bag-of-visual-words (BoW) model [2]. This provides us a vocabulary over the "vocabulary" present in the frame.
Note that the vocabulary here consists of the features which are first extracted from the image. By applying this transformation we loose both time and spatil arrangement information of the video, which are shown to be irrelevant to solve the contest task.

The chosen features for extraction are the HOG, which describe each image by the distribution of intensity gradients or edge directions.
We reduce the dimensionality of he features space by applying a K-means grouping of the images, using each center as an input. the number of features defines the length of our vocabulary.

The methodology consited of dividing the action in N moments. Each moment is admited to represent a relative percentage of the action.
As an example if the action is 10 seconds long and we chose a step of 10 %, then a frame taken each 1 second represents the n-th step of the action.
Decresing the step naturally increases our action resolution.

As the step is taken as relative (to the action length) percentage value, we assure a time-invariant scheme with respect to the action.
The approach then follows simple rules:

  For a N-moment scheme train N classifiers setting up the data accordingly
  10-fold cross validation was employed

Each classifier votes for a label at each momement. The most voted class is chosen as the estimated class. More weight is given on the core (middle) moments of the action.

The results show that diving the action in N=5 steps is enought to accuratly classify a human action.

Subject to optimization, one can identify:

  the cell size used to divide  each image to extract the HOG features
  the number N of steps to divide each action
  length of the "vocuabulary" to construct a BoW model

[1] Navneet Dalal, Bill Triggs. Histograms of Oriented Gradients for Human Detection, 2005

[2] Fei-Fei Li; Perona, P. (2005). "2005 IEEE Computer Society Conference on Computer Vision and Pattern Recognition (CVPR'05)" 2: 524. doi:10.1109/CVPR.2005.16. ISBN 0-7695-2372-2. 

[3] Data Set Credit:
Ryoo, M. S. and Aggarwal, J. K. UT-Interaction Dataset, ICPR contest on Semantic Description of Human Activities (SDHA), 2010
