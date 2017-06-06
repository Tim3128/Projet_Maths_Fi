exec("Prix_actifs.sci",-1)
exec("Couverture.sci",-1)
exec("Evolution_portefeuille.sci",-1)

function prime_2D()
    S1=[0:100]
    S2=50
    for i=S1+1
        V(i)=F(0,S1(i),S2)
        S(i)=max(0,S1(i)-S2)
    end
    plot2d(S1,[S,V],[5,15])
    plot2d(S1,S1,11)
    xlabel("$S_0^1$")
    legends(["$(S_0^1-S_0^2)_+$","$F_0 =\textrm{prime de l''option}$","$S_0^1$"],[5,15,11])
endfunction

function prime_3D()
    S1=[0:100]
    S2=[0:100]
    for i=S1+1
        for j=S2+1
            V(i,j)=F(0,S1(i),S2(j))
            S(i,j)=max(0,S1(i)-S2(j))
        end
    end
    plot3d(S1,S2,V,flag=[10,2,4])
    plot3d(S1,S2,S,15)
endfunction

function evol_prix(dt,sigma_1,sigma_2,r,S1_0,S2_0)
    n=floor(T/dt)
    t=temps(dt)
    [S1,S2]=prix_actifs(dt,sigma_1,sigma_2,r,S1_0,S2_0,0) 
    for i=1:n+1
        P(i)=F(t(i),S1(i),S2(i)) // prix de l'option
    end
    //plot2d(t,[S1,S2,V],[11,15,5])
    //legends(["$\textrm{Prix de l''actif 1}$","$\textrm{Prix de l''actif 2}$","\textrm{Prix de l''option}$"],[11,15,5])
    a=gca()
    a.x_location="origin"
    plot2d(t,[max(S1-S2,0),P],[15,11])
    legends(["$S_t^1-S_t^2$","$F(t,S_t^1,S_t^2)=\textrm{prix de l''option}$"],[15,11])
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
    for k=1:500 // 1000 trajectoires indépendantes
        [V_T,S1_T,S2_T]=valeurs_terminales(dt,sigma_1,sigma_2,r,S1_0,S2_0)
        dS(k)=S1_T-S2_T
        V(k)=V_T
        
    end
    a=gca()
    a.x_location="origin"
    plot2d(dS,V)
    set_dot(5,2)
    plot2d(dS,max(dS,0))
    set_dot(11,2)
    xtitle("$dt=0.001$")
    xlabel("$S_T^1-S_T^2$")
    legends(["$V_T$","$\textrm{Payoff } (S_T^1-S_T^2)_+$"],[5,11])
endfunction

function E=monte_carlo(dt,sigma_1,sigma_2,r,S1_0,S2_0,n)
    E=0 //espérance du carré de la différence entre valeur terminale du portefeuille et payoff de l'option
    for i=1:n
        [V_T,S1_T,S2_T]=valeurs_terminales(dt,sigma_1,sigma_2,r,S1_0,S2_0)
        E=E+(V_T-max(S1_T-S2_T,0))**2
    end
    E=E/n
endfunction

function erreur_couverture(sigma_1,sigma_2,r,S1_0,S2_0,n)
    dt=linspace(0.001,0.1,50)
    for i=1:50
        E(i)=monte_carlo(dt(i),sigma_1,sigma_2,r,S1_0,S2_0,n)
    end
    plot2d(dt,E)
    set_dot(5,2)
    xlabel("$dt$")
    ylabel("$\mathbb{E}^{\ast}[(V_T-(S_T^1-S_T^2))^2]$")
endfunction


