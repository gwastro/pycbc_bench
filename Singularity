Bootstrap: docker
From: conda/miniconda3-centos7:latest

%setup

%files
    files/ /opt/benchmark

%apprun inspiral
    mkdir -p /tmp/benchmark
    cp /opt/benchmark/* /tmp/benchmark
    echo "Running inspiral benchmark"
    sh /tmp/benchmark/run_inspiral.sh

%apprun pe
    mkdir -p /tmp/benchmark
    cp /opt/benchmark/* /tmp/benchmark
    echo "Running BBH pe"
    sh /tmp/benchmark/run_bbh_pe.sh

%post
yum install -y time bc
yum -y groupinstall "Development Tools" "Development Libraries"
conda config --add channels conda-forge
conda install pycbc
