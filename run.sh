for n in 8 64 512 4096 32768; do
    cd N$n
    sbatch submit.sh
    cd ..
    for m in 2 5 10 20 40; do
	cd N$n\M$m
        sbatch submit_mps.sh
        cd ..
    done
done

    
	
