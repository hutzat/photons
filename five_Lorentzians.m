function Lorentzians=five_Lorentzians(tau,params,params_fixed)

a1=params(1);
a2=params(2);
a3=params(3);
a4=params(4);
a5=params(5);

tau01=params(6)-2*params_fixed(1);
tau02=params(6)-params_fixed(1);
tau03=params(6);
tau04=params(6)+params_fixed(1);
tau05=params(6)+2*params_fixed(1);

gamma=params_fixed(2);

Lorentz1=1./((tau-tau01).^2+(0.5*gamma).^2);
Lorentz2=1./((tau-tau02).^2+(0.5*gamma).^2);
Lorentz3=1./((tau-tau03).^2+(0.5*gamma).^2);
Lorentz4=1./((tau-tau04).^2+(0.5*gamma).^2);
Lorentz5=1./((tau-tau05).^2+(0.5*gamma).^2);

Lorentz1=Lorentz1/max(Lorentz1);
Lorentz2=Lorentz2/max(Lorentz2);
Lorentz3=Lorentz3/max(Lorentz3);
Lorentz4=Lorentz4/max(Lorentz4);
Lorentz5=Lorentz5/max(Lorentz5);

Lorentzians=a1*Lorentz1+a2*Lorentz2+a3*Lorentz3+a4*Lorentz4+a5*Lorentz5;

end




