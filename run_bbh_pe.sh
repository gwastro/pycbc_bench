#!/bin/sh
export NCORES=`getconf _NPROCESSORS_ONLN`
echo "Using cores: ${NCORES}"

CONFIG_PATH=bbh_pe.ini
OUTPUT_PATH=bbh_pe.hdf
INJECTION_FILE=bbh_injection.hdf

TRIGGER_TIME=1126259462.42

SEARCH_BEFORE=6
SEARCH_AFTER=2
SAMPLE_RATE=2048
F_MIN=20

PSD_INVLENG=4
IFOS="H1 L1"
STRAIN="H1:aLIGOZeroDetHighPower L1:aLIGOZeroDetHighPower"

# scale the number of walkers to use by the number of cores available
NWALKERS=$((10*NCORES))

# start and end time of data to read in
# get coalescence time as an integer
TRIGGER_TIME_INT=${TRIGGER_TIME%.*}

# start and end time of data to read in
GPS_START_TIME=$((TRIGGER_TIME_INT - SEARCH_BEFORE - PSD_INVLEN))
GPS_END_TIME=$((TRIGGER_TIME_INT + SEARCH_AFTER + PSD_INVLEN))

export OMP_NUM_THREADS=1

/usr/bin/time -f '%e'
pycbc_inference --verbose \
    --seed 12 \
    --instruments ${IFOS} \
    --gps-start-time ${GPS_START_TIME} \
    --gps-end-time ${GPS_END_TIME} \
    --psd-model ${STRAIN} \
    --psd-inverse-length ${PSD_INVLEN} \
    --fake-strain ${STRAIN} \
    --fake-strain-seed 44 \
    --strain-high-pass ${F_MIN} \
    --sample-rate ${SAMPLE_RATE} \
    --low-frequency-cutoff ${F_MIN} \
    --channel-name H1:FOOBAR L1:FOOBAR \
    --injection-file ${INJECTION_FILE} \
    --config-file ${CONFIG_PATH} \
    --output-file ${OUTPUT_PATH} \
    --processing-scheme cpu \
    --nprocesses ${NCORES} \
    --config-overrides sampler:nwalkers:${NWALKERS} \
    --force \
2> bbh_pe.log &

RUNTIME=`cat bbh_pe.log`
bc <<< "$RUNTIME / $NWALKERS"
