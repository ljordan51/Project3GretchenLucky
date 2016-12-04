close all

n = 601;
earthV = 3.03e4;
earthM = 5.972e24;
meteorVsmall = 4.3e4;
meteorVbig = 5.8e5;
meteorMsmall = 1e21;
meteorMbig = 14e24;
meteorVs = linspace(meteorVsmall,meteorVbig,n);
meteorMs = linspace(meteorMsmall,meteorMbig,n);
meteorVstep = (meteorVbig - meteorVsmall)/(n-1);
meteorMstep = (meteorMbig - meteorMsmall)/(n-1);
numM = n;
numV = n;
Z = zeros(numV,numM);
D = zeros(numV,numM);
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
%             D(i,j) = sqrt((meteorVs(i)-meteorVsmall)^2 + (meteorMs(j)-meteorMsmall)^2);
            E(i,j) = 1;
        else
            E(i,j) = 0;
        end
    end
end

b = [0 0 0; 66/255 170/255 244/255];
colormap(b);
pcolor(meteorMs, meteorVs, E);
shading flat

set(gca,'FontSize',15);
ylabel('Velocity of Comet (m/s)')
xlabel('Mass of Comet (kg)')

title('Earth Velocity After Inelastic Collision Given Comet Velocity and Mass')
% text(meteorMs(26),meteorVs(n-50),'Upper velocity is equal to that of the fastest comet recorded', 'Color', 'white', 'FontSize', 15)
% text(meteorMs(26),meteorVs(n-100),'Lower velocity is equal to the escape velocity of the Earth from the Sun', 'Color', 'white', 'FontSize', 15)
hold on
plot([earthM/10 earthM/10],[0 meteorVs(50)],'w-','LineWidth', 2);
text(earthM/10,meteorVs(60),'0.1 x Earth Mass', 'Color', 'white', 'FontSize', 15)
plot([earthM/2 earthM/2],[0 meteorVs(50)],'w-','LineWidth', 2);
text(earthM/2,meteorVs(60),'0.5 x Earth Mass', 'Color', 'white', 'FontSize', 15)
plot([earthM earthM],[0 meteorVs(50)],'w-','LineWidth', 2);
text(earthM,meteorVs(60),'1 x Earth Mass', 'Color', 'white', 'FontSize', 15)
plot([earthM*2 earthM*2],[0 meteorVs(50)],'w-','LineWidth', 2);
text(earthM*2,meteorVs(60),'2 x Earth Mass', 'Color', 'white', 'FontSize', 15)

legend('Earth Breaks Orbit');

% h = 2e25;
% 
% for i = 1:n
%     for j = 1:n
%         this = D(i,j);
%         if this < h && this > 0
%             h = this;
%             velocityIndex = i;
%             massIndex = j;
%         end
%     end
% end
% 
% disp(h);
% disp(velocityIndex);
% disp(massIndex);
% disp(meteorVs(velocityIndex));
% disp(meteorMs(massIndex));