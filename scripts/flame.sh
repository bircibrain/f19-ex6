#!/bin/bash
export FSLTCLSH=/usr/local/fsl/bin/fsltclsh
# Requirements from level 1:
#	COPE files
#	varcope files
#	dof
#	mask

#################################################### replace sub- with subject-

# Change this to reflect the input/output subdirectories
cd /output

# 1. Created directory for level2 manually:
#	/scratch/psyc5171/bso15101/f19-ex6/derivative/level2

# 2. Register first level analysis to standard space
#	use featregapply

for d in `ls -d subject-*.feat`; do
	featregapply $d
done	

# 3. Merge COPEs to a 4D file
#	use fslmerge
#	(3 contrasts, 1, 2, and 3, so the for loop is over each contrast; i = contrast)

for i in 1 2 3; do
	fslmerge -t level2/cope${i} \
	subject-*.feat/reg_standard/stats/cope${i}.nii.gz
done


# 4. Mask of subject-level masks
#	use fslmerge
#	use fslmaths

fslmerge -t level2/mask \
	subject-*.feat/reg_standard/mask.nii.gz	

fslmaths level2/mask -Tmin \
	level2/mask


# 5. Merge varcopes
#	use fslmerge

for i in 1 2 3; do
	fslmerge -t level2/varcope${i} \
	subject-*.feat/reg_standard/stats/varcope${i}.nii.gz
done


# 6. Create 4D dof file
#	Zero the 4D cope file, add the dof value, and mask:
dof=$(cat subject-02_ses-test_task-fingerfootlips.feat/stats/dof)
cd level2
fslmaths cope1 -mul 0 -add $dof -mul mask dof


# 7. Create design files
#	Design matrix
#	Contrast matrix
#	Group matrix
#	Convert to vest files

# create design/group matrix while removing previous one

rm design.txt
rm group.txt
for d in `ls -d subject-*.feat`; do
	echo '1' >> design.txt
	echo '1' >> group.txt
done

# create contrast matrix while removing prevoius one (this line is not the same as in the cluster, it's more efficient)

echo '1' > contrast.txt

# Convert to vest files:

for f in *.txt; do
	Text2Vest $f ${f%.txt}.mat
done


# 8. Run analysis

for i in 1 2 3; do
flameo --cope=cope${i} \
	--vc=varcope${i} \
	--dvc=dof \
	--mask=mask \
	--ld=cope${i}.feat \
	--dm=design.mat \
	--cs=group.mat \
	--tc=contrast.mat \
	--runmode=flame1	
done










