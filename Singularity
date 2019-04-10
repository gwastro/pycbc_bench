Bootstrap: docker
From: conda/miniconda3-centos7:latest

%setup

%files
    files/ /opt/benchmark

%apprun inspiral
    echo "Running inspiral benchmark"
    sh /opt/benchmark/run_inspiral.sh

%apprun pe
    echo "Running BBH pe"
    sh /opt/benchmark/run_bbh_pe.sh

%post
yum install -y time bc
yum -y groupinstall "Development Tools" "Development Libraries"
conda config --add channels conda-forge
conda install pycbc
