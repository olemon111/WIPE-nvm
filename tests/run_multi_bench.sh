#!/bin/bash
BUILDDIR=$(dirname "$0")/../build
WorkLoad="/home/zzy/dataset/asia-latest.csv"
Loadname="longlat-400m"
function Run() {
    dbname=$1
    loadnum=$2
    opnum=$3
    scansize=$4
    thread=$5

    mkdir -p /mnt/pmem1/lbl
    rm -rf /mnt/pmem1/lbl/*
    Loadname="ycsb-400m"
    date | tee multi-${dbname}-${Loadname}-th${thread}.txt
    gdb --args \
    numactl --cpubind=1 --membind=1 ${BUILDDIR}/multi_bench --dbname ${dbname} \
    --loadstype 3 --load-size ${loadnum} --put-size ${opnum} --get-size ${opnum} \
        -t $thread | tee -a multi-${dbname}-${Loadname}-th${thread}.txt

    echo ${BUILDDIR}/multi_bench --dbname ${dbname} \
    --loadstype 3 --load-size ${loadnum} --put-size ${opnum} --get-size ${opnum} \
        -t $thread | tee -a multi-${dbname}-${Loadname}-th${thread}.txt
    # sleep 60

    # rm -rf /mnt/pmem1/lbl/*
    # Loadname="longlat-400m"
    # date | tee multi-${dbname}-${Loadname}-th${thread}.txt
    # # gdb --args \
    # LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes numactl --cpubind=0 --membind=0 ${BUILDDIR}/multi_bench --dbname ${dbname} \
    #     --loadstype 4 --load-size ${loadnum} --put-size ${opnum} --get-size ${opnum} \
    #     -t $thread | tee -a multi-${dbname}-${Loadname}-th${thread}.txt

    # sleep 60

    # rm -rf /mnt/pmem1/lbl/*
    # Loadname="longtitudes-400m"
    # loadnum=300000000
    # date | tee multi-${dbname}-${Loadname}-th${thread}.txt
    # # gdb --args \
    # LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes numactl --cpubind=0 --membind=0 ${BUILDDIR}/multi_bench --dbname ${dbname} \
    #     --loadstype 5 --load-size ${loadnum} --put-size ${opnum} --get-size ${opnum} \
    #     -t $thread | tee -a multi-${dbname}-${Loadname}-th${thread}.txt

    # sleep 60

    # rm -rf /mnt/pmem1/lbl/*
    # Loadname="lognormal-150m"
    # loadnum=120000000
    # date | tee multi-${dbname}-${Loadname}-th${thread}.txt
    # # gdb --args \
    # LD_PRELOAD=libhugetlbfs.so HUGETLB_MORECORE=yes numactl --cpubind=0 --membind=0 ${BUILDDIR}/multi_bench --dbname ${dbname} \
    #     --loadstype 6 --load-size ${loadnum} --put-size ${opnum} --get-size ${opnum} \
    #     -t $thread | tee -a multi-${dbname}-${Loadname}-th${thread}.txt

    rm -rf /mnt/pmem1/lbl
}

# DBName: combotree fastfair pgm xindex alex
function run_all() {
    dbs="combotree fastfair pgm alex xindex"
    for dbname in $dbs; do
        echo "Run: " $dbname
        Run $dbname $1 $2 $3 1
        # sleep 100
    done
}

dbname="letree"
# loadnum=168
# loadnum=11350
# loadnum=12000
# loadnum=1000000
loadnum=400000000
opnum=$loadnum
# opnum=10000000
scansize=4000000
# thread=4

# for thread in 2
# for thread in 30
for thread in 1
# for thread in 30 31 32
do
    Run $dbname $loadnum $opnum $scansize $thread
done