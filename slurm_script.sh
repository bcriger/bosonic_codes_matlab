#!/bin/sh

# You can control the resources and scheduling with '#SBATCH' settings
# (see 'man sbatch' for more information on setting these parameters)

# The default partition is the 'general' partition
#SBATCH --partition=general

# The default Quality of Service is the 'short' QoS (maximum run time: 4 hours)
#SBATCH --qos=short

# The default run (wall-clock) time is 1 minute
# The short queue has an upper limit of 4 hours
#SBATCH --time=3:59:59 

# The default number of parallel tasks per job is 1
#SBATCH --ntasks=1

# Request 1 CPU per active thread of your program (assume 1 unless you specifically set this)
# The default number of CPUs per task is 1 (note: CPUs are always allocated per 2)
#SBATCH --cpus-per-task=1

# The default memory per node is 1024 megabytes (1GB) (for multiple tasks, specify --mem-per-cpu instead)
#SBATCH --mem-per-cpu=4096

# Set mail type to 'END' to receive a mail when the job finishes (with usage statistics)
# Do not enable mails when submitting large numbers (>20) of jobs at once
#SBATCH --mail-type=FAIL

# Job array to divide 250 points into 4-hour batches
#SBATCH --array=1-241:10

# Your job commands go below here

# Uncomment these lines when your job requires this software
#module use /opt/insy/modulefiles
#module load cuda/10.0 cudnn/10.0-7.3.0.29
module load matlab/R2018b

# Complex or heavy commands should be started with 'srun' (see 'man srun' for more information)
# For example: srun python my_program.py
# Use this simple command to check that your sbatch settings are working (verify the resources allocated in the usage statistics)
srun matlab -nodesktop -nodisplay -nojvm -nosplash -r 'gkp_task('${SLURM_ARRAY_TASK_ID}'); exit'

