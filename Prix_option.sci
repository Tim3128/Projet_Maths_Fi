exec("Constantes.sci",-1)

// Fonction de répartition de la loi normale centrée réduite
function y=N(x)
    y=cdfnor("PQ",x,0,1)
endfunction


function y=F(t,x1,x2)
    if t==T then
        y=max(0,x1-x2)
    else
        d1=(log(x1/x2)+(T-t)*(sigma_2**2)/2)/sqrt((T-t)*(sigma_1**2+sigma_2**2))
        d2=d1-sqrt((T-t)*(sigma_1**2+sigma_2**2))
        y=x1*N(d1)-x2*N(d2)
    end
endfunction

