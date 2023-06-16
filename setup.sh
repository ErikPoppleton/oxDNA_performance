for x in 32768 4096 512 64 8; do
    cp submit.sh N$x
    sed -i "s/strands/$x/g" N$x/submit.sh
    for y in 2 5 10 20 40; do
	mkdir N$x\M$y
	cp submit_mps.sh N$x\M$y
	sed -i "s/strands/$x/g" N$x\M$y\/submit_mps.sh
	sed -i "s/proc/$y/g" N$x\M$y\/submit_mps.sh
	if [[ $y -eq 20 ]] || [[ $y -eq 40 ]]; then # you may not need this.
	    sed -i "s/-c $y/-c 16/g" N$x\M$y\/submit_mps.sh
	fi
	for z in $(seq 1 $y); do
	    mkdir N$x\M$y\/r$z
	    cp N$x\/{init_conf_N$x\.dat,topology_N$x\.top,input} N$x\M$y\/r$z
	done;
    done;
done
