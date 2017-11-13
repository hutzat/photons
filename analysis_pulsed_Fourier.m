%% Analysis of pulsed Fourier spectroscopy to get the lineshapes of the charged vs neutral state. 

% Read in .pos file
% create photon objects for all streams. 
% get intensity traces
% sort according to total intensity
% get time-integration of the difference between the two detectors divided
% by the total integral. 
clear

addpath('/Users/hendrikutzat/Dropbox (MIT)/nanocluster/data/kick-ass-2017/171112_pulsed_Fourier_spectroscopy/sandbox')
yy=t3PCFS('/Users/hendrikutzat/Dropbox (MIT)/nanocluster/data/kick-ass-2017/171112_pulsed_Fourier_spectroscopy/DotA_fourier/',1E6)
yy.get_photons_all()
yy.get_sum_signal_all()
yy.get_all_intensity_traces_for_Fourier('exciton',1000000)


yy.get_Fourier_spectrum_from_stream('DotA_')
figure()
subplot(2,1,1)
plot(yy.Fourier.Fourier)
subplot(2,1,2)
plot(yy.Fourier.intensity)


%% look at individual intensity trace. 

bounds_trion=ones(numel(yy.stage_positions),2);
bounds_exciton=ones(numel(yy.stage_positions),2);

bounds_trion(:,1)=bounds_trion(:,1)*0;
bounds_trion(:,2)=bounds_trion(:,2)*60;

bounds_exciton(:,1)=bounds_exciton(:,1)*80;
bounds_exciton(:,2)=bounds_exciton(:,2)*1000;

yy.sort_intensity_traces('exciton',1000000,bounds_exciton)
yy.sort_intensity_traces('trion',1000000,bounds_trion)


yy.get_all_intensity_traces_for_Fourier('exciton',1000000)
yy.get_all_intensity_traces_for_Fourier('trion',1000000)

yy.get_Fourier_spectrum_from_stream('exciton')
yy.get_Fourier_spectrum_from_stream('trion')

figure()
plot(yy.exciton_Fourier.Fourier)
hold on
plot(yy.trion_Fourier.Fourier)

% make a figure of the lifetimes.
yy.DotA_Fourier0.lifetime_histo('DotA_Fourier0','exciton_lifetime',128)
yy.DotA_Fourier0.lifetime_histo('trionDotA_Fourier0','trion_lifetime',128)

figure()
semilogy(yy.DotA_Fourier0.exciton_lifetime.lifetime)
hold on
semilogy(yy.DotA_Fourier0.trion_lifetime.lifetime)

