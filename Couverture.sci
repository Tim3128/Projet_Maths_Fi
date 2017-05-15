exec("Prix_option.sci",-1)

function [dx1,dx2]=F_dx(t,x1,x2,sigma)
    d1=(log(x1/x2)+(T-t)*(sigma**2)/2)/sigma/sqrt(T-t)
    d2=d1-sigma*sqrt(T-t)
    dx1=N(d1)+(1/sqrt(2*%pi))*(exp(-d1**2/2)-(x2/x1)*exp(-d2**2/2))
    dx2=-N(d2)+(1/sqrt(2*%pi))*(exp(-d2**2/2)-(x1/x2)*exp(-d1**2/2))
endfunction


// Quantités d'actifs à détenir à l'instant t pour couvrir l'option, en fonction du prix des actifs
function [H1,H2]=Couverture(t,S1,S2,sigma)
    S1_tilde=exp(-r*t)*S1
    S2_tilde=exp(-r*t)*S2
    if t==T then
        H1=(S1>S2)*1+(S1==S2)*0.5
        H2=-H1
    else
        [H1,H2]=F_dx(t,S1_tilde,S2_tilde,sigma)
    end

    //H0=F(t,S1_tilde,S2_tilde)-H1*S1_tilde-H2*S2_tilde
endfunction
