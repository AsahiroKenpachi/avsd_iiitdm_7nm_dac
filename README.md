# Inverter Simulation using Ngspice and ASAP-7nm </br>
### What is Ngspice ?
<p>Ngspice is an open-source mixed-level/mixed-signal electronic circuit simulator based on SPICE3f5, a program originally developed at the University of California, Berkeley. It allows for the simulation of analog and digital electronic circuits at the transistor and system levels. Ngspice is widely used for circuit design and verification in both academic and commercial environments due to its flexibility and extensive feature set. </p>
<p>Ngspice offers various features that make it a powerful tool for circuit simulation. It can simulate a wide variety of electronic circuits, from simple resistor-capacitor networks to complex mixed-signal integrated circuits. The simulator supports various types of analyses, including DC, AC, transient, and noise analysis, among others. It includes a comprehensive library of device models, such as diodes, transistors (BJT, MOSFET), and operational amplifiers. One of the strengths of ngspice is its compatibility with other SPICE simulators, allowing it to read and simulate netlists created for other SPICE-based tools.</p><p> Typical use cases for ngspice include analog circuit design, where engineers and hobbyists use it to design and test analog circuits before building physical prototypes. In education, it is widely used to teach electronic circuit design and simulation, providing students with hands-on experience in a virtual environment. Researchers also use ngspice to model and analyze new types of circuits and devices, aiding in the development of innovative technologies.Additionally, users can extend Ngspice with custom scripts and models, enhancing its functionality for specific needs.Ngspice is compatible with many existing SPICE models and netlists, allowing for easy migration from other SPICE-based tools. It is also frequently updated and maintained by a community of developers, ensuring ongoing improvements and support.</p>
<p> For further information the Ngspice documentation is available at https://ngspice.sourceforge.io/docs/ngspice-manual.pdf</p>

### Ngspice Installation for Ubuntu 22.04
<p> Open Your Terminal using ctrl+alt+t in your ubuntu workstation and execute the following command one by one or copy them into a script and run the script using the terminal. </p>

```
## clone the source repository into a local ngspice_git directory
git clone https://git.code.sf.net/p/ngspice/ngspice ngspice_git
cd ngspice_git
mkdir release
./autogen.sh
cd release
## by default if no --prefix is provided ngspice will install under /usr/local/{bin,share,man,lib}
## you can add a --prefix=/home/username to install into your home directory.
../configure --with-x --enable-xspice --disable-debug --enable-cider --with-readline=yes --enable-openmp --enable-osdi
## build the program
make
## install the program and needed files.
sudo make install

```

<p>For Windows and MAC users , installation procedure is available at https://ngspice.sourceforge.io/docs/ngspice-manual.pdf </p>

### What is ASAP-7nm?
<p>ASAP7nm is a process design kit (PDK) developed by the Academia and Semiconductor Industrial Partnership (ASIP) consortium, providing access to advanced semiconductor manufacturing technologies at the 7-nanometer (nm) node. It includes essential files and documentation for designing integrated circuits (ICs) with increased transistor density, improved performance, and reduced power consumption. Aimed at researchers, educators, and industry partners, ASAP7nm facilitates experimentation, education, and collaboration in semiconductor engineering, enabling innovative IC designs, hands-on learning, and prototyping before commercial production.</p>
<p>Installation of the above PDK can be done by cloning the git repo at https://github.com/The-OpenROAD-Project/asap7</p>

### Integration of ASAP-7nm and Ngspice
<p>To proceed further read the readme of the git repo https://github.com/The-OpenROAD-Project/asap </br> Now Navigate inside the main PDK folder that you previously cloned. And there you will find model folder which contains the hspice folder which has .pm files. At this point refer this repo and observe how to change .pm to .sp.  
</p>
<p> For example

```
.model pmos_slvt pmos level = 72
```
  is changed to
  
  ```
  .model BSIMCMG_osdi_P BSIMCMG_va (
+ TYPE = 0
  ```
When converting the slvt pmos and nmos models from that file, what needed is to specify TYPE=0/1 in Ngspice, otherwise it does not work.
Also if we have extra parameters in .pm that is not in modelcard for nmos/pmos given by BSIM-CMG , no need to alter them as it will be ignored by Ngspice. Finally rename the file from .pm to .sp and save it in the directory you desire.
</p>

### BSIM - CMG
<p>BSIM-CMG, or Berkeley Short-channel IGFET Model for the Common Multi-Gate Structure, is a compact model for simulating multi-gate transistors, such as FinFETs and nanowire FETs, developed by the Device Model Working Group (DMWG) at the University of California, Berkeley. BSIM-CMG extends the capabilities of traditional BSIM models to accurately model the behavior of advanced multi-gate transistor structures, taking into account complex physical phenomena such as short-channel effects, quantum mechanical effects, and gate coupling. It is widely used in the semiconductor industry and academia for the design and optimization of nanoscale integrated circuits, enabling accurate prediction of device characteristics and performance.</p>

<p>By changing the .pm to .sp as foretold we are trying to use BSIM-CMG model for simulating our inverter. If you wnat to use the latest finfet model use the website https://www.bsim.berkeley.edu/models/bsimcmg/ </p>

<p> These models are written using Verilog-A [extension .va] and are compiled using OpenVAF compiler. Upon Compilation , we will ger .osdi files from .va files . Add it to your working directory where .sp is present. The latest version of Ngspice has the support for .osdi files which may not be true fur older versions. You can get OpenVAF from https://openvaf.semimod.de/docs/getting-started/introduction/  </p>
<p>Make sure that the executable of OpenVAF is in the path of your system so that .va files can be compiled </p>

### Compiling Our inverter
<p> Open the terminal, navigate to the working directory and paste the command

```
ngspice inverter.sp

```
Refer the Sample outputs for clarity and crosschecking. The Screenshots are included below for your reference.

</p>

![Screenshot from 2024-05-26 17-35-33](https://github.com/AsahiroKenpachi/avsd_iiitdm_7nm_dac/assets/137492506/55cefe47-7bb6-444c-b0de-6f204ad02e7a)
![Screenshot from 2024-05-26 17-18-23](https://github.com/AsahiroKenpachi/avsd_iiitdm_7nm_dac/assets/137492506/5d5d24dc-536e-424e-909d-7f6366bf2333)
![Screenshot from 2024-05-26 16-29-51 (copy)](https://github.com/AsahiroKenpachi/avsd_iiitdm_7nm_dac/assets/137492506/1a4aca48-4756-4c7b-9236-626d5da83937)






