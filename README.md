# MLCAD_Contest_ReSynthAI_Benchmark

Disclaimer: Please read the MLCAD Contest description file available in this repository, which describes the contest, before looking into the benchmarks and scripts available in this repository. The README file only helps navigate and understand the benchmarks and scripts; it does not serve as the contest description.

This GitHub repository has the public benchmarks for the 2025 MLCAD CAD Contest to perform physical-aware logic resynthesis. The hidden benchmarks will be released after the contest. This contest's primary goal is to explore the state-of-the-art algorithms for physical-aware resynthesis to drive academic research to generate scalable algorithms for gate sizing, gate cloning, buffer insertion or removal, Vt swapping, and logic restructuring using ML (supervised, unsupervised, or reinforcement learning-based techniques). The secondary goal is to allow the use of a recently developed ML EDA research infrastructure that leverages [*OpenROAD's Python API*](https://github.com/The-OpenROAD-Project/OpenROAD) and [*Nvidia's CircuitOps*](https://github.com/NVlabs/CircuitOps/) data representation format for ML-EDA or GPU-accelerated EDA research.         OpenROAD's Python APIs allow users to execute EDA tools with just a few lines of Python code and to access the EDA tool database directly through Python APIs, bypassing traditional file I/O. CircuitOps provides an ML-friendly data infrastructure that uses Labeled Property Graphs (LPGs) backed by Intermediate Representation (IR) Tables to create datasets for ML-EDA applications. The Python-compatible LPG minimizes the developmental effort required for ML-EDA research.


## Table of Content
  - [*MLCAD2025-Contest-Problem-Statement.pdf*](./MLCAD2025-Contest-Problem-Statement.pdf): Contest description.
  - [*design*](./designs): Synthesized netlist, floorplan DEF, SDC and the IR tables.
  - [*platform/ASAP7*](./platform/ASAP7): ASAP7 cell library for the designs.
  - [*src*](./src)
    - [*example*](./src/example): Example scripts showing how to use OpenROAD Python API and CircuitOps LPG to do operations.
    - [*IR_tables_generator*](./src/IR_tables_generator): Python scripts to generate the intermediate files containing the updated timing values and capacitance values using OpenROAD after gate sizing. 
    - [*evaluation*](./src/evaluation): Evaluation scripts for the contest and the evaluation method for users of the OpenROAD Python API.
    
## Materials for using OpenROAD's Python API and Nvidia's CircuitOps
  - R. Liang, A. Agnesina, G. Pradipta, V. A. Chhabria and H. Ren, "Invited Paper: CircuitOps: An ML Infrastructure Enabling Generative AI for VLSI Circuit Optimization," in ICCAD, 2023
    - [CircuitOps: An ML Infrastructure Enabling Generative AI for VLSI Circuit Optimization](https://ieeexplore.ieee.org/abstract/document/10323611)
  - V. A. Chhabria, W. Jiang, A. B. Kahng, R. Liang, H. Ren, S. S. Sapatnekar and B.-Y. Wu, "OpenROAD and CircuitOps: Infrastructure for ML EDA Research and Education," in VTS, 2024
    - [OpenROAD and CircuitOps: Infrastructure for ML EDA Research and Education](https://vlsicad.ucsd.edu/Publications/Conferences/407/c407.pdf)
  - CircuitOps and OpenROAD Python API Tutorial at ASP-DAC 2024
    - [ASU-VDA-Lab/ASP-DAC24-Tutorial](https://github.com/ASU-VDA-Lab/ASP-DAC24-Tutorial)
  - OpenROAD GitHub repository
    - [The-OpenROAD-Project/OpenROAD](https://github.com/The-OpenROAD-Project/OpenROAD)
  - CircuitOps GitHub repository
    - [NVlabs/CircuitOps](https://github.com/NVlabs/CircuitOps/)

## Build OpenROAD and CircuitOps

###  Option 1: Build using Docker 
The following technique assumes you have docker installed on your machine. You can install docker from [here](https://docs.docker.com/engine/install/). Build the docker image and run using the following commands:
```
docker build -t <image_name>.
docker run -it --name <container_name> <image_name>
```
Note: Make sure you are using the latest github repo version.

### Option 2: Build locally
The following technique assumes you have a machine with the required Ubuntu OS prerequisite of OpenROAD and CircuitOps.

Install dependencies for OpenROAD:
```
sudo ./OpenROAD/etc/DependencyInstaller.sh
```

Install dependencies for CircuitOps and ML EDA applications:
```
sudo apt-get install -y python3-matplotlib
sudo apt-get install -y nvidia-cuda-toolkit
sudo apt-get update
sudo apt-get install -y python3-graph-tool
sudo apt-get update && apt-get install -y gnupg2 ca-certificates
sudo apt-get install -y python3-pip
pip3 install --no-cache-dir torch==2.2.0
pip3 install numpy==1.24.4
pip3 install dgl==0.9.1
pip3 install pandas
pip3 install networkx==2.6.3
pip3 install scikit-learn
pip3 install tqdm==4.53.0
```

Once packages have been installed, build OpenROAD:

```
cd ./OpenROAD/
mkdir build
cd build
cmake ..
make -j
```
## Benchmark Statistics [Post global route metrics]

|Design              |Gate count|Clock period (ns)|WNS (ns)|TNS (ns)  |Total slew violation difference (ns)|Slew violation count|Total load capacitance violation difference (fF)|Capacitance violation count|Total leakge power (uW)|Total overflow|
|--------------------|----------|-----------------|--------|----------|--------------------|--------------------|-------------------|-------------------|-----------------|--------|
|ac97_top            |8029      |0.12             |-0.0676 |-17.9214 |0.5062              |15                  |0                  |0                  |82.7931          |0       |
|aes_cipher_top      |10965     |0.32             |-0.1605 |-18.8457 |9.7689              |183                 |6.5894             |5                  |29.7626          |0       |
|NV_NVDLA_partition_m|17843     |0.40             |-0.2086 |-11.9062 |54.4973             |368                 |344.9269           |9                  |161.3232         |0       |
|fpu                 |19725     |3.68             |-1.2077 |-59.3346 |23.7857             |124                 |4.5460             |1                  |19.2539          |0       |
|NV_NVDLA_partition_p|58216     |1.00             |-0.4919 |-747.1107|1386.1164           |13422               |7692.2596          |141                |579.8336         |0       |
|NV_NVDLA_partition_c|155686    |3.00             |-0.7218 |-18.8252 |20854.7798          |80297               |66908.0706         |1307               |18099.6639       |0       |
|NV_NVDLA_partition_p_mod|58026|1.20| -0.4308|-391.0072|1199.4298|12346|7483.0446|132|579.4446|0  |

(Reported by OpenSTA)

## 🏆 Leaderboard – Final Submission 
### Overall leaderboard
|Rank|Team ID|Team Name|Score |
|----|-------|---------|------|
|1   |Team23 | PhyMap  |764.04|
|2   |Team13 | CSDL    |713.96|
|3   |Team27 | ACE-DMA |482.78|

### Leaderboard per design
| Design                     | Top Team(s)       |
|----------------------------|-------------------|
| ac97_top                   | Team23            |
| aes_cipher_top             | Team13            |
| NV_NVDLA_partition_m       | Team13            |
| fpu                        | Team13            |
| NV_NVDLA_partition_p       | Team13            |
| NV_NVDLA_partition_p_mod   | Team23            |
| NV_NVDLA_partition_c       | Team23            |
| Hidden1                    | Team27            |
| Hidden2                    | Team23            |
| Hidden3                    | Team23            |
| Hidden4                    | Team3             |
| Hidden5                    | Team13            |

 
