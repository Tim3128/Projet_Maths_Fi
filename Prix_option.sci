exec("Constantes.sci",-1)

// Fonction de répartition de la loi normale centrée réduite
function y=N(x)
    y=cdfnor("PQ",x,0,1)
endfunction


function y=F(t,x1,x2,sigma)
    if t==T then
        y=max(0,x1-x2)
    else
        d1=(log(x1/x2)+(T-t)*(sigma**2)/2)/sigma/sqrt(T-t)
        d2=d1-sigma*sqrt(T-t)
        y=x1*N(d1)-x2*N(d2)
    end
endfunction

