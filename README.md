# oxDNA_performance
Performance benchmarks for [oxDNA](https://github.com/lorenzo-rovigatti/oxDNA)

Test the performance of oxDNA simulations ranging in size from 128 to 524288 nucleotides using both single-run-per-GPU and [NVIDIA Multi-process Service](https://docs.nvidia.com/deploy/mps/index.html)

## Setup
1. Unzip the initial configuration file for the largest simulation (Its too big for GitHub):  
   `cd N32768/; unzip init_conf_N32768.zip`
2. Double check the two submit files to make sure that they will work with your cluster setup.
3. Use the setup script to setup MPS replicates:  
   `sh setup.sh`
4. Submit the jobs:  
   `sh run.sh`
5. Wait for all the jobs to finish
6. Open `graphs.ipynb`, edit the folder names and GPU labels, then run all cells.  
   **NOTE** The Python scripts assume that you ran this on two different clusters and copied the results from one of the clusters to the other. If you didn't do this, you will want to shrink the graphs and remove the code which reads log files in the `cobra/` directory

## Notes:

### Use rsync to copy just log files to another cluster for analysis
`rsync -zarv --relative --include="*/" --include="log*" --exclude="*" ./ DESTINATION:~/path/to/oxDNA_performance/SOURCENAME/`

### CPU limits
On the two clusters I ran these tests on, there are limits to how many CPUs you can request per-GPU.  For this reason, the a100 runs were capped at 16 CPUs and v100 runs were capped at 20 CPUs.  There is a `if` statement in `setup.sh` which handles this.  If you do not have these limitations, remove that line before running `setup.sh`.

### Failing jobs
Ocassionally, the simulations here will crash due to too many neighbors in the cell list.  You can reduce the probability of this happening by adding the [max_density_multiplier](https://lorenzo-rovigatti.github.io/oxDNA/input.html#cuda-options) argument to the input files. This increases memory usage, however and may cause the MPS runs with higher numbers of replicates to fail.

### DNA origami
Full DNA origamis are around 14000 nucleotides.  If you add an example origami to the test, I would be happy for the pull request.


