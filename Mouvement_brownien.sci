exec("Constantes.sci",-1)

function t=temps(dt)
    n=floor(T/dt)
    for k=1:n+1
        t(k)=(k-1)*dt
    end
endfunction

function [y]=MB(dt,ind)
    n=floor(T/dt)
    y(1)=0
    for i=2:n+1
        y(i)=y(i-1)+sqrt(dt)*rand(1,"normal")
    end
    if ind==1 then
        t=temps(dt)
        plot2d(t,y,5)
        a=gca()
        a.x_location="origin"
        xlabel("$t$")
    end
endfunction


