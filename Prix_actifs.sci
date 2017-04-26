exec("Mouvement_brownien.sci",-1)

function S=prix_actif(dt,sigma,r,S0,t)
    W=MB(dt,0)
    S=S0*exp((r-sigma**2/2)*t+sigma*W)
endfunction

function [S1,S2]=prix_actifs(dt,sigma_1,sigma_2,r,S1_0,S2_0,ind)
    W1=MB(dt,0)
    W2=MB(dt,0)
    t=temps(dt)
    S1=S1_0*exp((r-sigma_1**2/2)*t+sigma_1*W1)
    S2=S2_0*exp((r-sigma_2**2/2)*t+sigma_2*W2)
    if ind==1 then
        plot2d(t,[S1,S2],[11,15])
        legends(["$\textrm{Prix de l''actif 1}$","$\textrm{Prix de l''actif 2}$"],[11,15])
        a=gca()
        a.x_location="origin"
        xlabel("$t$")
    end
endfunction
