# photons
'photons.m' is an object-oritented
analysis library for time-tagged single photon arrival time data. It is intended 
for facile parsing and statistical analysis of the photon-stream recorded with PicoQuant TCSPC hardware (such
as the HydraHarp, Picoharp.)


## Hardware and measurement modes supported
HydraHarp
* v2: ht2, ht3

# Overview over photons.m
.ht2 and .ht3 files can be used to create an instance of photons.m.
After reading the metadata with the constructor method (.photons), the function
.get_photon_records() parses the raw photon-arrival time data recorded with an 
absolute experimental clock (T2 data, .ht2) or a relative
experimental clock (T3 data, .ht3) into the true photon-arrival time
records. These photon-records are written to a .photons
file in uint64 representation of the form: [channel, time [ps]] for .ht2 and 
[channel,sync_pulse_number,time [ps] after the sync] for .ht3.

Subseqent analysis functions read the true photon arrival 
events from the .photons files. Functions exist to compile intensity traces, fluorescence lifetimes, linearly time-spaced
correlation functions (g(2),g(3)...), logarithmically time-spaced
correlation functions, or photon-number-resolved lifetimes. Fitting of FCS traces of diffusing emitters is possible. 

Various photon-sorting functions exist to allow subsequent analysis of only part of the photon-stream.
As such the photon-stream can be sorted according to intensity, 
detection channel, arrival after the sync pulse, lifetime etc. Detector after-pulsing
can be removed for t3 data. Each call to a sorting/cleaning function creates a new 
.photons file that contains only the photon-records meeting the specified 
requirements. This allows for facile data-cleaning and sorting prior to further analysis. 

The .photons files can be read by various analysis functions to obtain:
intensity traces, fluorescence lifetimes, linearly time-spaced
coincidence counts (g(2),g(3)...), logarithmically time-spaced
correlations functions, or photon-number-resolved lifetimes. A function
to fit FCS decay of emitters diffusing in solution exists as well. 

# PCFS.m and t3PCFS.m
Object oriented analysis library for analysis of photon-resolved photon-correlation Fourier spectroscopy as 
introduced here: https://arxiv.org/abs/physics/0604180. 

## Overview
PCFS.m reads in the interfeometer stage positions from a .pos file and the  meta-data from a .pcfslog file created with
custom labview software. The photon-stream at each stage position is parsed as a photons.m child with all the properties and
methods of the photons class. The methods of the PCFS class are then just batch-processing of photon-objects and handling of the
resulting PCFS interferograms and spectral correlations. t3PCFS allows analysis of pulsed PCFS data. 



