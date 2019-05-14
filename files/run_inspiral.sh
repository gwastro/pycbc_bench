#!/bin/bash
export NCORES=`getconf _NPROCESSORS_ONLN`

echo "warm up phase to get conistent results"
for ((c=1; c<=$NCORES; c++ ))
do
    /usr/bin/time -f '%e' \
    pycbc_inspiral \
    --fake-strain-seed 0 \
    --fake-strain aLIGOZeroDetLowPower \
    --sample-rate 2048 \
    --sgchisq-snr-threshold 6.0 \
    --sgchisq-locations "mtotal>40:20-30,20-45,20-60,20-75,20-90,20-105,20-120" \
    --segment-end-pad 16 \
    --cluster-method window \
    --low-frequency-cutoff 30 \
    --pad-data 8 \
    --cluster-window 1 \
    --cluster-function symmetric \
    --injection-window 4.5 \
    --segment-start-pad 112 \
    --psd-segment-stride 8 \
    --psd-inverse-length 16 \
    --filter-inj-only \
    --psd-segment-length 16 \
    --processing-scheme cpu:1 \
    --fftw-measure-level 0 \
    --snr-threshold 5.5 \
    --segment-length 256 \
    --autogating-width 0.25 \
    --autogating-threshold 100 \
    --autogating-cluster 0.5 \
    --autogating-taper 0.25 \
    --newsnr-threshold 5 \
    --psd-estimation median \
    --strain-high-pass 20 \
    --order -1 \
    --chisq-bins "1.75*(get_freq('fSEOBNRv2Peak',params.mass1,params.mass2,params.spin1z,params.spin2z)-60.)**0.5" \
    --channel-name H1:LOSC-STRAIN \
    --gps-start-time 1126259078 \
    --gps-end-time 1126259846 \
    --output test.hdf \
    --approximant "SPAtmplt:mtotal<4" "IMRPhenomD:else" \
    --bank-file /tmp/benchmark/bank.hdf 2> /dev/null &
done

wait $!
sleep 30

echo "start the real run"

for ((c=1; c<=$NCORES; c++ ))
do
    /usr/bin/time -f '%e' \
    pycbc_inspiral \
    --fake-strain-seed 0 \
    --fake-strain aLIGOZeroDetLowPower \
    --sample-rate 2048 \
    --sgchisq-snr-threshold 6.0 \
    --sgchisq-locations "mtotal>40:20-30,20-45,20-60,20-75,20-90,20-105,20-120" \
    --segment-end-pad 16 \
    --cluster-method window \
    --low-frequency-cutoff 30 \
    --pad-data 8 \
    --cluster-window 1 \
    --cluster-function symmetric \
    --injection-window 4.5 \
    --segment-start-pad 112 \
    --psd-segment-stride 8 \
    --psd-inverse-length 16 \
    --filter-inj-only \
    --psd-segment-length 16 \
    --processing-scheme cpu:1 \
    --fftw-measure-level 0 \
    --snr-threshold 5.5 \
    --segment-length 256 \
    --autogating-width 0.25 \
    --autogating-threshold 100 \
    --autogating-cluster 0.5 \
    --autogating-taper 0.25 \
    --newsnr-threshold 5 \
    --psd-estimation median \
    --strain-high-pass 20 \
    --order -1 \
    --chisq-bins "1.75*(get_freq('fSEOBNRv2Peak',params.mass1,params.mass2,params.spin1z,params.spin2z)-60.)**0.5" \
    --channel-name H1:LOSC-STRAIN \
    --gps-start-time 1126259078 \
    --gps-end-time 1126259846 \
    --output test.hdf \
    --approximant "SPAtmplt:mtotal<4" "IMRPhenomD:else" \
    --bank-file /tmp/benchmark/bank.hdf 2> $c.log &
done
wait $!
sleep 30
gawk '/^[0-9]/ {sum += 1/$1} END {print sum}' [0-9]*.log
