% Methode Num FSAB 1104
% Probleme MATLAB 2 : Des oeufs de dinosaures...
% Etudiants : Une collaboration de :
%                       - Antoine Legat 4776-1300
%                       - John de Wasseige
% Tuteur : Victor Colognesi

function egg(top,bottom,dt,mode)
% Fonction qui ne retourne rien mais affiche une ou des figures
% en fonctions des arguments fournis
%
% input - top, bottom : allongements relatifs de la partie
%                       superieure et inferieure de l'oeuf
%       - dt          : increment utilise pour parcourir 
%                       l'espace parametrique de la
%                       representation graphique
%       - mode        : (optional) 0 pour l'oeuf,
%                       1 pour des figures originales...

if ~mode 
    modeEgg(top, bottom, dt); % Dessine l'oeuf
else
    makeThing();              % Dessine le dinosaure
    makeThing2();             % Dessine Pikatchu
    makeThing3();             % Dessine Pikatchu avec le dinosaure
end
    
end



function [x y z] = makeEgg(top, bottom, dt)
% Fonction qui retourne trois matrices de memes dimensions
% afin de pouvoir représenter graphiquement (avec la fonction
% 'surf') des oeufs et formes qui en dérivent.

T = [0 0 0 1 1 2 2 3] ;
S = [0 0 0 1 1 2 2 3 3 4 4 5] ;
R = [0 1 1 1 0];
H = [-1*bottom -1*bottom 0 1*top 1*top];%allongements relatifs

% En posant les points Xc et Yc tels que ci-dessous,
% et en developpant le probleme pour u=(x(t),y(t)),
% il faut que x(t)^2+y(t)^2
% Pour t dans [0;1], on connait les b-splines de 
% degre 2 B0, B1, B2
% Sans perte de generalite on resout pour un quart de cercle.
% Il nous reste alors a trouver la relation que doivent
% satisfaire 3 poids associes aux trois points (1,0),(1,1) 
% et (0,1). On trouve que W1^2 = (W0*W2)/2
% Dans notre cas on pose W0=W2=1, donc W1=sqrt(1/2).

a= sqrt(1/2);
p = 2;
Xc = [-1 -1 0 1 1 1 0 -1 -1] ;
Yc = [0 -1 -1 -1 0 1 1 1 0] ;
Zc = ones(size(Xc));
Wc = [1 a 1 a 1 a 1 a 1];
X = Xc' * R;
Y = Yc' * R;
Z = Zc' * H;
W = Wc' * [1 a 1 a 1];


nt = length(T) - 1;
t = [T(p+1):dt:T(nt-p+1)];
for i=0:nt-p-1
  Bt(i+1,:) = b(t,T,i,p);
end

ns = length(S) - 1;
s = [S(p+1):dt:S(ns-p+1)];
for i=0:ns-p-1
  Bs(i+1,:) = b(s,S,i,p);
end

w = Bs' * W * Bt;
x = Bs' * (W .* X) * Bt ./ w;
y = Bs' * (W .* Y) * Bt ./ w;
z = Bs' * (W .* Z) * Bt ./ w;

end


% Nous savons qu'une B-spline ne peut etre
% non nulle que sur un intervalle [ T_i,T_i+p+1 [
% Dans notre cas, p=2 . Si le dernier noeud est triple , on aura donc
% Le B-spline qui passe instantanement de 1 (il est maximal juste avant
% ce triple noeud) a 0 (puisque non nul sur [T_i, T_1+3[.
% Cela resulte donc en une discontinuite que Matlab peine a representer,
% il dessine donc une large fissure. C'est pourquoi on ne met pas de
% noeud triple.
% Notons que nous n'avons pas ce probleme pour les premiers noeuds
% puisque l'intervalle est ferme au debut.








function makeThing()
% Fonction qui dessine un dinosaure a l'aide des NURBS

figure('Color',[1 1 1]); 
[x y z] = makeEgg(2,2,0.05); 

%pattes
h = surf(x,y,z,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor','g'); 
rotate(h,[0 1 0],0,[0 0 0]); hold on; 
h = surf(0.9*x-2.5,0.9*y+2,0.9*z-0.5, 'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor','b'); 
rotate(h,[0 1 0],20,[0 0 0]); hold on; 
h = surf(0.9*x+4,0.9*y,0.9*z,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor','r'); 
rotate(h,[0 1 0],-15,[0 0 0]); hold on; 
h = surf(0.8*x+2,0.8*y+2.5,0.8*z+1,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor','k'); 
rotate(h,[0 1 0],10,[0 0 0]); hold on; 

%corps
h = surf(2*x-2,2*y+1,2*z+1,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor','c'); 
rotate(h,[0 1 0],80,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);

%cou
h = surf(0.9*x+0.5,0.9*y+1,0.9*z-4.5,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor',[60/255 30/255 0]); 
rotate(h,[0 1 0],140,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);
%tete
h = surf(0.9*x-3,0.9*y+1,0.9*z-5,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor',[60/255 30/255 0]); 
rotate(h,[0 1 0],100,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);

%visage
h = surf(0.3*x-3.3,0.9*y+1,0.2*z-6,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor',[204/255 0/255 0]); 
rotate(h,[0 1 0],100,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);

%cheveux
for i =-5:5
    h = surf(0.09*x-1.3,0.07*y+1+i/10,0.6*z-4.2,'FaceLighting','none', ...
    'LineStyle','none','FaceColor',[10/255 0 0]); 
    rotate(h,[0 1 0],130,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);
    h = surf(0.09*x-3.85,0.07*y+1+i/10,0.6*z-4.8,'FaceLighting','none', ...
    'LineStyle','none','FaceColor',[10/255 0 0]); 
    rotate(h,[0 1 0],100,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);
end
    
%queue
h = surf(0.3*x-5,0.2*y+1,0.9*z+2.5,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor',[100/255 50/255 0]); 
rotate(h,[0 1 0],120,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);


light('Position',[-0.5 -0.75 0.5]); 
axis('on'); axis('equal');view([0 0]);

end




function makeThing2()
% Fonction qui dessine Pikatchu avec des oeufs

figure('Color',[1 1 1]); 
[x y z] = makeEgg(2,1,0.05);    % Oeuf
[xC yC zC] = makeEgg(1,1,0.05); % Cercle
[xS yS zS] = makeEgg(3,3,0.05); % Suppositoire

% Corps de Pikatchu
h = surf(5*x + 10,5*y + 10,5*z + 4, ...
    'FaceLighting','gouraud', 'LineStyle','none', ...
    'FaceColor',[1 1 0]); hold on;

% Head
h = surf(5*xC + 10,5*yC + 10,5*zC + 12, ...
    'FaceLighting','gouraud', 'LineStyle','none', ...
    'FaceColor',[1 1 0]);

% Pied gauche
h = surf(1.5*x+6,1.5*y+10,1.5*z+0.5,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[0 1 0],-50, [6 10 0.5]);

% Pied droit
h = surf(1.5*x+10,1.5*y+6,1.5*z+0.5,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[1 0 0],50, [10 6 0.5]);

% Oreille gauche
h = surf(1.5*xS+8.5,1.5*yS+12.5,1.5*zS+16,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[1/2 1 0],-80, [8.5 12.5 16]);

% Oreille droite
h = surf(1.5*xS+12.5,1.5*yS+8.5,1.5*zS+16,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[1 1/2 0],20, [12.5 8.5 16]);

% Oeil gauche
h = surf(1*xC + 6 , 1*yC + 8.5 , 1*zC + 13.8, ...
    'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[0 0 0]);

% Oeil droit
h = surf(1*xC + 8.5 , 1*yC + 6 , 1*zC + 13.8, ...
    'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[0 0 0]);

% Joue gauche
h = surf(1.3*xC + 6 , 1.3*yC + 9.5 , 1.3*zC + 12, ...
    'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[0.9 0.1 0.1]);

% Joue droite
h = surf(1.3*xC + 9.5 , 1.3*yC + 6 , 1.3*zC + 12, ...
    'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[0.9 0.1 0.1]);

% Langue
h = surf(0.75*x + 7 , 0.75*y + 7, 1*z + 12 , ...
    'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 182/255 193/255]);
rotate(h,[1 -1 0],120, [7 7 12]);

% Bras gauche
h = surf(1.5*x+5,1.5*y+11,1.5*z+7.5,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[0 1 0],-50, [5 11 7.5]);

% Bras droit
h = surf(1.5*x+11,1.5*y+5,1.5*z+7.5,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[1 0 0],50, [11 5 7.5]);


% Jaune
h = surf(x,y,z,'FaceLighting','gouraud', 'LineStyle',...
    'none','FaceColor',[1 1 0]); 


% Noir
h = surf(1.5*x+4,1.5*y+3,1.5*z+0.5,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[0 0 0]); 

% Rouge
h = surf(2*x+3,2*y+5,2*z, ...
    'FaceLighting','gouraud', 'LineStyle','none',...
    'FaceColor',[0.9 0.1 0.1]); 
%rotate(h,[0 1 0],-60);
light('Position',[ 0.0 -0.75 0.5]);

light('Position',[-0.5 -0.75 0.5]); 
axis('on'); axis('equal');view([0 0]);

end

function makeThing3()
% Fonction qui dessine Pikatchu avec le dinosaure

figure('Color',[1 1 1]); 
[x y z] = makeEgg(2,2,0.05); 
[xP yP zP] = makeEgg(2,1,0.05);    % Oeuf
[xC yC zC] = makeEgg(1,1,0.05); % Cercle
[xS yS zS] = makeEgg(3,3,0.05); % Suppositoire


%pattes
h = surf(x,y,z,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor','g'); 
rotate(h,[0 1 0],0,[0 0 0]); hold on; 
h = surf(0.9*x-2.5,0.9*y+2,0.9*z-0.5, 'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor','b'); 
rotate(h,[0 1 0],20,[0 0 0]); hold on; 
h = surf(0.9*x+4,0.9*y,0.9*z,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor','r'); 
rotate(h,[0 1 0],-15,[0 0 0]); hold on; 
h = surf(0.8*x+2,0.8*y+2.5,0.8*z+1,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor','k'); 
rotate(h,[0 1 0],10,[0 0 0]); hold on; 

%corps
h = surf(2*x-2,2*y+1,2*z+1,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor','c'); 
rotate(h,[0 1 0],80,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);

%cou
h = surf(0.9*x+0.5,0.9*y+1,0.9*z-4.5,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor',[60/255 30/255 0]); 
rotate(h,[0 1 0],140,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);
%tete
h = surf(0.9*x-3,0.9*y+1,0.9*z-5,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor',[60/255 30/255 0]); 
rotate(h,[0 1 0],100,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);

%visage
h = surf(0.3*x-3.3,0.9*y+1,0.2*z-6,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor',[204/255 0/255 0]); 
rotate(h,[0 1 0],100,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);

%cheveux
for i =-5:5
    h = surf(0.09*x-1.3,0.07*y+1+i/10,0.6*z-4.2,'FaceLighting','none', ...
    'LineStyle','none','FaceColor',[10/255 0 0]); 
    rotate(h,[0 1 0],130,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);
    h = surf(0.09*x-3.85,0.07*y+1+i/10,0.6*z-4.8,'FaceLighting','none', ...
    'LineStyle','none','FaceColor',[10/255 0 0]); 
    rotate(h,[0 1 0],100,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);
end
    
%queue
h = surf(0.3*x-5,0.2*y+1,0.9*z+2.5,'FaceLighting','gouraud', ...
    'LineStyle','none','FaceColor',[100/255 50/255 0]); 
rotate(h,[0 1 0],120,[0 0 0]); light('Position',[ 0.0 -0.75 0.5]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Corps de Pikatchu
h = surf(5*xP + 10,5*yP + 10,5*zP + 4,'FaceLighting','gouraud', 'LineStyle','none', ...
    'FaceColor',[1 1 0]); hold on;

% Head
h = surf(5*xC + 10,5*yC + 10,5*zC + 12, ...
    'FaceLighting','gouraud', 'LineStyle','none', ...
    'FaceColor',[1 1 0]);

% Pied gauche
h = surf(1.5*xP+6,1.5*yP+10,1.5*zP+0.5,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[0 1 0],-50, [6 10 0.5]);

% Pied droit
h = surf(1.5*xP+10,1.5*yP+6,1.5*zP+0.5,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[1 0 0],50, [10 6 0.5]);

% Oreille gauche
h = surf(1.5*xS+8.5,1.5*yS+12.5,1.5*zS+16,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[1/2 1 0],-80, [8.5 12.5 16]);

% Oreille droite
h = surf(1.5*xS+12.5,1.5*yS+8.5,1.5*zS+16,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[1 1/2 0],20, [12.5 8.5 16]);

% Oeil gauche
h = surf(1*xC + 6 , 1*yC + 8.5 , 1*zC + 13.8, ...
    'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[0 0 0]);

% Oeil droit
h = surf(1*xC + 8.5 , 1*yC + 6 , 1*zC + 13.8, ...
    'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[0 0 0]);

% Joue gauche
h = surf(1.3*xC + 6 , 1.3*yC + 9.5 , 1.3*zC + 12, ...
    'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[0.9 0.1 0.1]);

% Joue droite
h = surf(1.3*xC + 9.5 , 1.3*yC + 6 , 1.3*zC + 12, ...
    'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[0.9 0.1 0.1]);

% Langue
h = surf(0.75*x + 7 , 0.75*y + 7, 1*z + 12 , ...
    'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 182/255 193/255]);
rotate(h,[1 -1 0],120, [7 7 12]);

% Bras gauche
h = surf(1.5*xP+5,1.5*yP+11,1.5*zP+7.5,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[0 1 0],-50, [5 11 7.5]);

% Bras droit
h = surf(1.5*xP+11,1.5*yP+5,1.5*zP+7.5,'FaceLighting','gouraud',...
    'LineStyle','none','FaceColor',[1 1 0]);
rotate(h,[1 0 0],50, [11 5 7.5]);

axis('off'); axis('equal');view([0 0]);

end






function modeEgg(top, bottom, dt)
% Dessine l'oeuf

figure;
[x y z] = makeEgg(top,bottom,dt);
surf(x,y,z); axis('off'); axis('equal');

end






function u = b(t,T,j,p)
i = j+1;
if p==0
    u = (t>= T(i) & t < T(i+p+1)); return 
end

u = zeros(size(t));
if T(i) ~= T(i+p)
    u = u + ((t-T(i)) / (T(i+p) -T(i))) .* b(t,T,j,p-1);
end
if T(i+1) ~= T(i+p+1)
    u = u + ((T(i+p+1)-t) ./ (T(i+p+1) -T(i+1))) .* b(t,T,j+1,p-1);
end
end