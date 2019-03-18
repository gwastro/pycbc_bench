# pycbc_bench
Some benchmark singularity images for pycbc / pycbc inference

# build singularity image
sudo singularity build pycbcb.img Singularity

# run pycbc inspiral
singularity run --app inspiral pycbcb.img
