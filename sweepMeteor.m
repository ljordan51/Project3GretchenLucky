close all

n = 101;
earthV = 30.3e3;
earthM = 5.972e24;
meteorVsmall = 5e8;
meteorVbig = 100.3e7;
meteorMsmall = 4e19;
meteorMbig = 1e20;
meteorVs = linspace(meteorVsmall,meteorVbig,n);
meteorMs = linspace(meteorMsmall,meteorMbig,n);
meteorVstep = (meteorVbig - meteorVsmall)/(n-1);
meteorMstep = (meteorMbig - meteorMsmall)/(n-1);
numM = n;
numV = n;
Z = zeros(numV,numM);
l = 1;
k = 1;

for i = meteorVsmall:meteorVstep:meteorVbig
    for j = meteorMsmall:meteorMstep:meteorMbig
        newV = (earthM*earthV + i*j)/(earthM + j);
        Z(k,l) = newV;
        l = l+1;
    end
    k = k+1;
    l = 1;
end

E = zeros(n,n);

for i = 1:n
    for j = 1:n
        this = Z(i,j);
        if this >= 42484
            E(i,j) = 1;
        else
            E(i,j) = 0;
        end
    end
end

b = [0 0 0; 0 1 0];
colormap(b);
pcolor(meteorMs, meteorVs, E);
shading flat

ylabel('Speed of Meteor (m/s)')
xlabel('Mass of Meteor (kg)')

title('Earth Speed After Inelastic Collision vs. Meteor Speed and Mass')
