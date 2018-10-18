function [optim_params]=fit_center_quintett(tau,corr,params0)



fun = @(params) five_Lorentzian_cost(tau,corr,params);
lb=[100,100,100,100,100,-5000,-3000,0,1000,3000,600,600,600,600,600];
ub=[2000,2000,6000,2000,2000,-2000,-1000,0,4000,6000,2000,2000,2000,2000,2000];

gs = GlobalSearch;
problem = createOptimProblem('fmincon','x0',params0,...
    'objective',fun,'lb',lb,'ub',ub);

optim_params = run(gs,problem);






    function lor=Lorentz(tau,tau0,Gamma,A)
        
        lor=A*0.5*Gamma/((tau-tau0).^2+(0.5*Gamma).^2);
        
        
    end

    function [tau_select,corr_select]=get_center_quint(tau,corr)
        delta_tau=abs(tau(1)-tau(2)); % this gets the tau increment from the correlation function
        
        N=length(tau);
        center_point=floor(N/2)+1;
        N_points=floor(6000/delta_tau)+1;
        
        % selects +- 6ns from the correlation function which is the center
        % part. 
        tau_select=tau(center_point-N_points:center_point+N_points);
        corr_select=corr(center_point-N_points:center_point+N_points);

    end
end