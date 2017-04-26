exec("Prix_actifs.sci",-1)

function [V_T,S1_T,S2_T]=valeurs_terminales(dt,sigma_1,sigma_2,r,S1_0,S2_0)
    n=floor(T/dt)
    t=temps(dt)
    S0=exp(r*t)
    [S1,S2]=prix_actifs(dt,sigma_1,sigma_2,r,S1_0,S2_0,0) 
    V(1)=F(0,S1(1),S2(1))
    for i=2:n+1
        [H0,H1,H2]=Couverture(t(i),S1(i),S2(i))
        V(i)=V(i-1)+H0*(S0(i)-S0(i-1))+H1*(S1(i)-S1(i-1))+H2*(S2(i)-S2(i-1))
    end
    V_T=V(n+1)
    S1_T=S1(n+1)
    S2_T=S2(n+1)
endfunction
