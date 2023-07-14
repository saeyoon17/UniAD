#!/bin/bash
conda init bash
exec bash
conda activate uniad
pip install torch==1.9.1+cu111 torchvision==0.10.1+cu111 torchaudio==0.9.1 -f https://download.pytorch.org/whl/torch
export PATH=/usr/bin/gcc/bin:$PATH
CUDA_HOME=/usr/local/cuda-11.1/
pip install mmcv-full==1.4.0
pip install mmdet==2.14.0
pip install mmsegmentation==0.14.1
cd ~
git clone https://github.com/open-mmlab/mmdetection3d.git
cd mmdetection3d
git checkout v0.17.1
pip install scipy==1.7.3
pip install scikit-image==0.20.0
pip install -v -e .
cd /root/examples/UniAD
pip install -r requirements.txt
mkdir ckpts && cd ckpts
wget https://github.com/zhiqi-li/storage/releases/download/v1.0/bevformer_r101_dcn_24ep.pth
wget https://github.com/OpenDriveLab/UniAD/releases/download/v1.0/uniad_base_track_map.pth
wget https://github.com/OpenDriveLab/UniAD/releases/download/v1.0/uniad_base_e2e.pth
cd ..
wget https://vessl-public-apne2.s3.ap-northeast-2.amazonaws.com/uniad/uniad.tar.gz
tar -xvf uniad.tar.gz
./tools/uniad_dist_train.sh ./projects/configs/stage1_track_map/base_track_map.py 1
cp -r ./output/* /output/
cp -r /root/UniAD/projects/work_dirs/* /output/
