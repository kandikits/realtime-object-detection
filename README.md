# realtime-object-detection
Detects objects in images/streaming video

### Quickstart guide

Refer kits from the link below to jumpstart the app
* https://kandi.openweaver.com/collections/vision/object-detection-kit

### Installation Guide

Once python3 is installed, install all the dependencies by running the below command.

pip3 install -r requirements.txt

### Object Detection with pretrained models

Run Jupyter notebook **Realtime Object Detection.ipynb** to detect objects on images or live streaming videos using webcam

### To train on your custom dataset

  1. Create your dataset yaml file containing details of train and validation directories
  2. Annotate images
  3. Select a pretrained model to apply transfer learning
  4. Kickoff training process by configuring hyperparameters
  5. Analyse performance of the model
  6. Predict trained objects
