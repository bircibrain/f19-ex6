#!/bin/bash

export FSLTCLSH=/usr/local/fsl/bin/fsltclsh

cd /input/derivatives

for d in `ls -d sub-*+.feat`; do
featregapply $d
done

for i in 1 2 3; do
fslmerge -t level2/cope${i} sub-*+.feat/reg_standard/stats/cope${i}.nii.gz
done

fslmerge -t level2/mask sub-*+.feat/reg_standard/mask.nii.gz

fslmaths level2/mask -Tmin level2/mask

for i in 1 2 3; do
fslmerge -t level2/varcope${i} sub-*+.feat/reg_standard/stats/varcope${i}.nii.gz
done


dof=$(cat sub-02_ses-test_task-fingerfootlips+.feat/stats/dof)


cd level2

fslmaths cope1 -mul 0 -add $dof -mul mask dof

# create design files, group indicator, and contrast files here

rm groupindicator.txt
# can't have space in your file name
rm design.txt
for d in `ls -d ../sub-*+.feat`; do
echo '1' >> groupindicator.txt
echo '1' >> design.txt
done

echo '1' > contrast.txt

# convert .txt design files to mat file
for f in *.txt; do 
Text2Vest $f ${f%.txt}.mat
done


for i in 1 2 3; do
flameo --cope=cope${i} --vc=varcope${i} --dvc=dof --mask=mask --ld=cope${i}.feat --dm=design.mat --cs=groupindicator.mat --tc=contrast.mat --runmode=flame1
done