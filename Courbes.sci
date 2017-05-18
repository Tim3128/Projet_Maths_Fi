exec("Prix_actifs.sci",-1)
exec("Couverture.sci",-1)
exec("Evolution_portefeuille.sci",-1)

function evol_prix(dt,sigma_1,sigma_2,r,S1_0,S2_0)
    n=floor(T/dt)
    t=temps(dt)
    [S1,S2]=prix_actifs(dt,sigma_1,sigma_2,r,S1_0,S2_0,0) 
    for i=1:n+1
        P(i)=F(t(i),S1(i),S2(i)) // prix de l'option
    end
    //plot2d(t,[S1,S2,V],[11,15,5])
    //legends(["$\textrm{Prix de l''actif 1}$","$\textrm{Prix de l''actif 2}$","$\textrm{Prix de l''option}$"],[11,15,5])
    a=gca()
    a.x_location="origin"
    plot2d(t,[S1-S2,P],[15,11])
    legends(["$S_t^1-S_t^2$","$\textrm{Prix de l''option}$"],[15,11])
    xlabel("$t$")
endfunction

function couverture(dt,sigma_1,sigma_2,r,S1_0,S2_0)
    sigma=sqrt(sigma_1**2+sigma_2**2)
    n=floor(T/dt)
    t=temps(dt)
    [S1,S2]=prix_actifs(dt,sigma_1,sigma_2,r,S1_0,S2_0,0)
    V(1)=F(0,S1(1),S2(1))
    P(1)=V(1)
    for i=2:n+1
        [H1(i),H2(i)]=Couverture(t(i),S1(i),S2(i),sigma)
        V(i)=V(i-1)+exp(r*t(i))*(H1(i)*(S1(i)-S1(i-1))+H2(i)*(S2(i)-S2(i-1)))
        H0(i)=exp(-r*t(i))*(V(i)-H1(i)*S1(i)-H2(i)*S2(i))
        P(i)=F(t(i),S1(i),S2(i),sigma)
    end
    a=gca()
    a.x_location="origin"
    //plot2d(t,[H0,H1,H2],[5,11,15])
    //legends(["$H_t^0$","$H_t^1$","$H_t^2$"],[5,11,15])
    plot2d(t,[V,P],[5,15])
    legends(["$\textrm{Valeur du portefeuille de couverture}$","$\textrm{Prix de l''option}$"],[5,15])
    xlabel("$t$")
endfunction


function exercice_couverture(dt,sigma_1,sigma_2,r,S1_0,S2_0)
    for k=1:100 // 1000 trajectoires indépendantes
        [V_T,S1_T,S2_T]=valeurs_terminales(dt,sigma_1,sigma_2,r,S1_0,S2_0)
        dS(k)=S1_T-S2_T
        V(k)=V_T
        
    end
    a=gca()
    a.x_location="origin"
    plot2d(dS,V)
    set_dot(5,3)
    plot2d(dS,max(dS,0))
    set_dot(11,3)
    xlabel("$S_T^1-S_T^2$")
    legends(["$V_T$","$\textrm{Payoff } (S_T^1-S_T^2)_+$"],[5,11])
endfunction

