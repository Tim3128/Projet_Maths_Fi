sigma_1=0.2
sigma_2=0.2 //volatilité des 2 actifs
sigma=sqrt(sigma_1**2+sigma_2**2)

T=1 //échéance en année
dt=0.001 //pas de discrétisation

S1_0=100
S2_0=90 // prix des actifs à l'instant 0

r=0.05 // taux sans risque

function set_dot(my_color,my_size)
  drawlater();
  f=gcf();Dessin=f.children(1).children(1).children(1);
  Dessin.line_mode="off";Dessin.mark_mode="on";
  Dessin.mark_size_unit ="point";
  Dessin.mark_size=my_size;
  Dessin.mark_style=0;// my_type;
  Dessin.mark_foreground=my_color;
  drawnow();
endfunction
