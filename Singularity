Bootstrap: docker
From: conda/miniconda3-centos7:latest

%setup

%files
    run_inspiral.sh
    bank.hdf
    run_bbh_pe.sh
    bbh_injection.hdf
    bbh_pe.ini

%apprun inspiral
    echo "Running inspiral benchmark"
    sh /run_inspiral.sh

%apprun pe
    echo "Running BBH pe"
    sh /run_bbh_pe.sh

%post
yum install -y time bc
yum -y groupinstall "Development Tools" "Development Libraries"
conda config --add channels conda-forge
conda install pycbc
