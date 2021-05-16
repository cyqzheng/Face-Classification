#!/bin/bash

# Set python path variable to the facenet src directory
export PYTHONPATH=~/mnt/c/Users/cathe/kerasenv/Project/facenet/src

# remove existing training alignment
rm -rf ~/mnt/c/Users/cathe/kerasenv/Project/facenet/data/images/train_aligned

# align training images
python ~/mnt/c/Users/cathe/kerasenv/Project/facenet/src/align/align_dataset_mtcnn.py \
~/mnt/c/Users/cathe/kerasenv/Project/facenet/data/images/train_raw \
~/mnt/c/Users/cathe/kerasenv/Project/facenet/data/images/train_aligned \
--image_size 160

# remove existing testing alignment
rm -rf ~/mnt/c/Users/cathe/kerasenv/Project/facenet/data/images/test_aligned

# align testing images
python ~/mnt/c/Users/cathe/kerasenv/Project/facenet/src/align/align_dataset_mtcnn.py \
~/mnt/c/Users/cathe/kerasenv/Project/facenet/data/images/test_raw \
~/mnt/c/Users/cathe/kerasenv/Project/facenet/data/images/test_aligned \
--image_size 160

# Train new classifier based on training images (generates pickle)
python ~/mnt/c/Users/cathe/kerasenv/Project/facenet/src/classifier.py TRAIN \
~/mnt/c/Users/cathe/kerasenv/Project/facenet/data/images/train_aligned/ \
~/mnt/c/Users/cathe/kerasenv/Project/facenet/models/20180402-114759.pb \
~/mnt/c/Users/cathe/kerasenv/Project/facenet/models/my_classifier.pkl

# Test face matches using pickle file to classify matching images
python ~/mnt/c/Users/cathe/kerasenv/Project/facenet/src/classifier.py CLASSIFY \
~/mnt/c/Users/cathe/kerasenv/Project/facenet/data/images/test_aligned/ \
~/mnt/c/Users/cathe/kerasenv/Project/facenet/models/20180402-114759.pb \
~/mnt/c/Users/cathe/kerasenv/Project/facenet/models/my_classifier.pkl
