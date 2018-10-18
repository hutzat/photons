%analyze_HOM

channels1=[0,1];
channels2=[1,0];
ps_range=95000;
num_points=800;
offset_lag=0;
SyncRate=4E7;

two_photon_PCFS=PCFS('/Users/hendrikutzat/Desktop/Green_Diode_Laser_Reflection/Two_Photon_PCFS/',1E7,3);
%two_photon_PCFS.get_photons_all();
%two_photon_PCFS.runone0.photon_g2_fromt3('runone0','corr',channels1, ps_range, num_points, offset_lag,SyncRate);
%two_photon_PCFS.runone15.photon_g2_fromt3('runone15','corr',channels1, ps_range, num_points, offset_lag,SyncRate);
two_photon_PCFS.get_int_corrs_HOM(channels1, ps_range, num_points, offset_lag,SyncRate);

two_photon_PCFS.runone0.get_intensity('runone0','int',1E6)
two_photon_PCFS.runone15.get_intensity('runone15','int',1E6)
two_photon_PCFS.runone10.get_intensity('runone10','int',1E6)
two_photon_PCFS.runone25.get_intensity('runone25','int',1E6)

two_photon_PCFS.runone25.lifetime_histo('runone25','lifet',4)
two_photon_PCFS.runone1.lifetime_histo('runone1','lifet',4)
two_photon_PCFS.runone15.lifetime_histo('runone15','lifet',4)

two_photon_PCFS.runone15.photons_2_channels('runone15','runone15_sorted',2)
two_photon_PCFS.runone15.lifetime_histo('runone15_sorted_ch_1','lifet_ch1',4)
two_photon_PCFS.runone15.lifetime_histo('runone15_sorted_ch_2','lifet_ch2',4)

two_photon_PCFS.runone1.photons_2_channels('runone1','runone1_sorted',2)
two_photon_PCFS.runone1.lifetime_histo('runone1_sorted_ch_1','lifet_ch1',4)
two_photon_PCFS.runone1.lifetime_histo('runone1_sorted_ch_2','lifet_ch2',4)


figure()
plot(two_photon_PCFS.runone15.lifet_ch1.time,two_photon_PCFS.runone15.lifet_ch1.lifetime)
hold on
plot(two_photon_PCFS.runone15.lifet_ch2.time,two_photon_PCFS.runone15.lifet_ch2.lifetime)
xlabel('\tau [ps]')
ylabel('counts')
legend('Detector1','Detector2')
set(gca, 'fontsize',16)

figure()
plot(two_photon_PCFS.runone1.lifet_ch1.time,two_photon_PCFS.runone1.lifet_ch1.lifetime)
hold on
plot(two_photon_PCFS.runone1.lifet_ch2.time,two_photon_PCFS.runone1.lifet_ch2.lifetime)












figure()
plot(two_photon_PCFS.runone25.lifet.time,two_photon_PCFS.runone25.lifet.lifetime)
hold on
plot(two_photon_PCFS.runone1.lifet.time,two_photon_PCFS.runone1.lifet.lifetime)
plot(two_photon_PCFS.runone15.lifet.time,two_photon_PCFS.runone15.lifet.lifetime)


figure()
plot(two_photon_PCFS.runone15.int.trace)
hold on
plot(two_photon_PCFS.runone10.int.trace)
%plot(two_photon_PCFS.runone25.int.trace)


%two_photon_PCFS.get_int_corrs_HOM(channels1, ps_range, num_points, offset_lag,SyncRate)

figure()
plot(two_photon_PCFS.runone10.corr)
hold on
plot(two_photon_PCFS.runone0.corr)

%%  fit all the center quintupels. 
%two_photon_PCFS.HOM_interferogram.HOM_interferogram=two_photon_PCFS.runone15.corr.corr;
%two_photon_PCFS.HOM_interferogram.lag=two_photon_PCFS.runone15.corr.lag;

params0=[100,1000,100,100,100,1662];
params_fixed=[1700,800];% these are 1) the difference between pulse in time. and 2) th width of the IRF. 

ps_range_select=30000;
Nstage=1;

[two_photon_PCFS,b]=two_photon_PCFS.fit_HOM_interferogram(params0,params_fixed,ps_range_select);
tt=five_Lorentzians(two_photon_PCFS.HOM_interferogram.lag, two_photon_PCFS.all_HOM_fit_params(13,:),params_fixed);

%% visualize the HOM interferogram. 
figure()
plot(two_photon_PCFS.stage_positions,two_photon_PCFS.all_HOM_fit_params(:,3),'-o')
hold on
plot(two_photon_PCFS.stage_positions,two_photon_PCFS.all_HOM_fit_params(:,2),'-o')
plot(two_photon_PCFS.stage_positions,two_photon_PCFS.all_HOM_fit_params(:,4),'-o')
ylim([0,500])
title('Two-Photon-Interferogram')
xlabel('Stage Position in mm')
ylabel('Coincident Count Peak Height')
legend('Peak 3', 'Peak 2', 'Peak 4')
set(gca,'fontsize',16)

tt=five_Lorentzians(two_photon_PCFS.HOM_interferogram.lag, two_photon_PCFS.all_HOM_fit_params(10,:),params_fixed);

figure()
plot(two_photon_PCFS.HOM_interferogram.lag(2:end),two_photon_PCFS.HOM_interferogram.HOM_interferogram(:,10))
hold on
plot(two_photon_PCFS.HOM_interferogram.lag,tt)
xlabel('\tau [ps]')
ylabel('counts')
title('correlation function')
set(gca,'fontsize',16)

optimized_pulse_train=five_Lorentzians(two_photon_PCFS.HOM_interferogram.lag, two_photon_PCFS.all_HOM_fit_params(10,:),[2500,800]);

figure()
plot(two_photon_PCFS.HOM_interferogram.lag,optimized_pulse_train)










figure()
plot(two_photon_PCFS.HOM_interferogram.lag,tt)
hold on
plot(two_photon_PCFS.HOM_interferogram.lag(2:end),two_photon_PCFS.HOM_interferogram.HOM_interferogram)



%% testing what the intensity traces look like.
two_photon_PCFS.runone10.get_intensity('runone10','int',1E6)
two_photon_PCFS.runone13.get_intensity('runone13','int',1E6)

two_photon_PCFS.runone1.get_intensity('runone1','int',1E6)

figure()
plot(two_photon_PCFS.runone13.int.time,two_photon_PCFS.runone13.int.trace)
hold on
plot(two_photon_PCFS.runone10.int.time,two_photon_PCFS.runone10.int.trace)
set(gca,'fontsize',16)
xlabel('time')
ylabel('intensity')
legend('Stage Position 13 Det 1','Stage Position 13 Det 2', 'Stage Position 10 Det 1', 'Stage Position 10 Det 2')
