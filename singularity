Bootstrap: docker
From: conda/miniconda3-centos7:latest

%setup

%files
    run_pe.sh
    run_inspiral.sh
    bank.hdf

%apprun inspiral
    echo "Running inspiral benchmark"
    sh /run_inspiral.sh

%apprun pe
    echo "DOING PE"

%post
yum install -y time bc
yum -y groupinstall "Development Tools" "Development Libraries"
conda config --add channels conda-forge
conda install pycbc
