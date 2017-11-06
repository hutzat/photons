%% first run. 
test=t3PCFS('/Users/hendrikutzat/Dropbox (MIT)/Version_5_working/PCFS_new_class/',1E6)
test.get_photons_all()
test.get_sum_signal_all()
test.get_all_lifetimes(256)
test.fit_all_lifetimes();

% plotting one of the fits.
figure()
semilogy(test.DotA_run_one6.life.exp2.time,test.DotA_run_one6.life.exp2.fit(test.DotA_run_one6.life.exp2.time))
hold on
semilogy(test.DotA_run_one6.life.exp2.time,test.DotA_run_one6.life.exp2.lifetime);



% plotting all of the lifetime fits.
figure()
n=numel(test.stage_positions);
for i=1:n
dot=strcat('DotA_run_one',num2str(i));
subplot((floor(sqrt(n))+1),(floor(sqrt(n))+1),i)    
semilogy(test.(dot).life.exp2.time,test.(dot).life.exp2.fit(test.(dot).life.exp2.time))
hold on
semilogy(test.(dot).life.exp2.time,test.(dot).life.exp2.lifetime);
end



% make a plot of the fit parameters as a function of the stage position. 
figure()
subplot(2,2,1)
plot(test.stage_positions,test.lifetime_fits.a)
subplot(2,2,2)
plot(test.stage_positions,test.lifetime_fits.b)
subplot(2,2,3)
plot(test.stage_positions,test.lifetime_fits.c)
subplot(2,2,4)
plot(test.stage_positions,test.lifetime_fits.d)




%% analysis of one of the photon_streams. 
test.DotA_run_one0.get_intensity('sum_signal_DotA_run_one0','high_intensity',1000000,350,600)
test.DotA_run_one0.get_intensity('sum_signal_DotA_run_one0','low_intensity',1000000,10,150)

figure()
plot(test.DotA_run_one0.high_intensity.trace)

%get_high intensity lifetimes. 
test.DotA_run_one0.lifetime_histo('high_intensity','high_I_lifetime',128)
test.DotA_run_one0.lifetime_histo('low_intensity','low_I_lifetime',128)

figure()
semilogy(test.DotA_run_one0.high_I_lifetime.time,test.DotA_run_one0.high_I_lifetime.lifetime)
hold on
semilogy(test.DotA_run_one0.low_I_lifetime.time,test.DotA_run_one0.low_I_lifetime.lifetime)

%% playing with the biexciton quantum yield. 
test.DotA_run_one0.get_g2('DotA_run_one0','g2',3,10,5E6)

%% do intensity sorted PCFS!
test.get_all_intensity_traces(10000000)

% plot all intensity traces
figure()
n=numel(test.stage_positions);
for i=1:n
dot=strcat('DotA_run_one',num2str(i-1));
subplot((floor(sqrt(n))),(floor(sqrt(n))+1),i)    
plot(test.(dot).intensity.time,test.(dot).intensity.trace)
end

figure()
dot='DotA_run_one25';
plot(test.(dot).intensity.time,test.(dot).intensity.trace)

test.(dot).get_intensity('sum_signal_DotA_run_one25','high_inten',10000000,2000,3000)
test.(dot).get_intensity('sum_signal_DotA_run_one25','low_inten',10000000,0,700)

test.(dot).lifetime_histo('high_inten','high_int_lifetime',128)
test.(dot).lifetime_histo('low_inten','low_int_lifetime',128)


figure()
semilogy(test.(dot).high_int_lifetime.time,test.(dot).high_int_lifetime.lifetime)
hold on
semilogy(test.(dot).low_int_lifetime.time,test.(dot).low_int_lifetime.lifetime)

test.(dot).photon_corr('high_inten','high_auto_corr',[0,0],[10,1E12],10,0,0)
test.(dot).photon_corr('low_inten','low_auto_corr',[0,0],[10,1E12],10,0,0)

figure()
semilogx(test.(dot).high_auto_corr.lags*1488874/5E6,test.(dot).high_auto_corr.corr_norm)
hold on
semilogx(test.(dot).low_auto_corr.lags*1488874/5E6,test.(dot).low_auto_corr.corr_norm)
