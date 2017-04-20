exec("Prix.sci",-1)

function [dx1,dx2]=F_dx(t,x1,x2)
    d1=(log(x1/x2)+(T-t)*(sigma_2**2)/2)/sqrt((T-t)*(sigma_1**2+sigma_2**2))
    d2=d1-sqrt((T-t)*(sigma_1**2+sigma_2**2))
    dx1=N(d1)+(1/sqrt(2*%pi))*(exp(-d1**2/2)-(x2/x1)*exp(-d2**2/2))
    dx2=-N(d2)+(1/sqrt(2*%pi))*(exp(-d2**2/2)-(x1/x2)*exp(-d1**2/2))
endfunction


// Quantités d'actifs à détenir à l'instant t pour couvrir l'option, en fonction du prix des actifs
function [H0,H1,H2]=Couverture(t,S1,S2)
    S1_tilde=exp(-r*t)*S1
    S2_tilde=exp(-r*t)*S2
    [H1,H2]=F_dx(t,S1_tilde,S2_tilde)
    H0=F(t,S1_tilde,S2_tilde)-H1*S1_tilde-H2*S2_tilde
endfunction