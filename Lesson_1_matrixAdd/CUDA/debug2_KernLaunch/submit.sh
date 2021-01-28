#!/bin/bash -l
# Batch directives
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --account NTDD0002
#SBATCH --partition=dav
#SBATCH --reservation=TDD_4xV100
#SBATCH --gres=gpu:v100:1
#SBATCH --time=00:02:00
#SBATCH --output=log.matrix_add.out
#SBATCH --job-name=GPU_matrix_add
#SBATCH --mem=50G

# Load the necessary modules (software)
module purge
module load ncarenv/1.2
module load nvhpc/20.11
module load cuda/11.0.3
module list

# Update LD_LIBRARY_PATH so that cuda libraries can be found
export LD_LIBRARY_PATH=${NCAR_ROOT_CUDA}/lib64:${LD_LIBRARY_PATH}
echo ${LD_LIBRARY_PATH}
nvidia-smi
/glade/u/apps/dav/opt/cuda/11.0.3/extras/demo_suite/deviceQuery 
# Move to the correct directory and run the executable
echo -e "\nBeginning code output:\n-------------\n"
srun nvprof ./matrix_add.exe 
