function cost=five_Lorentzian_cost(tau,corr,params,params_fixed)

a1=params(1);
a2=params(2);
a3=params(3);
a4=params(4);
a5=params(5);

tau01=params(6)-params_fixed(1);
tau02=params(6)-params_fixed(1);
tau03=params(6)-params_fixed(1);
tau04=params(6)-params_fixed(1);
tau05=params(6)-params_fixed(1);

gamma=params_fixed(2);

[lorentz]=five_Lorentzians(tau,params,params_fixed);

cost=sum((corr'-lorentz).^2);

end