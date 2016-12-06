close all

n = 601;
earthV = 3.03e4;
earthM = 5.972e24;
meteorVsmall = 4.3e4;
meteorVbig = 5.8e5;
meteorMsmall = 1e21;
meteorMbig = 7e24;
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
pcolor((meteorMs/earthM)*100, meteorVs, E);
shading flat
colorbar
c = colorbar;
c.Location = 'southoutside';
c.Ticks = [.25 .75];
c.TickLabels = {'Earth Assumes Larger Orbit','Earth Reaches Escape Velocity'};


set(gca,'FontSize',15);
ylabel('Velocity of Comet (m/s)')
xlabel('Mass of Comet (% of Earth mass)')

title('Does Earth Reach Escape Velocity?')
% text(meteorMs(26),meteorVs(n-50),'Upper velocity is equal to that of the fastest comet recorded', 'Color', 'white', 'FontSize', 15)
% text(meteorMs(26),meteorVs(n-100),'Lower velocity is equal to the escape velocity of the Earth from the Sun', 'Color', 'white', 'FontSize', 15)
% hold on
% plot([earthM/10 earthM/10],[0 meteorVs(75)],'w-','LineWidth', 2);
% text(earthM/10,meteorVs(85),'0.1 x Earth Mass', 'Color', 'white', 'FontSize', 15)
% plot([earthM/2 earthM/2],[0 meteorVs(75)],'w-','LineWidth', 2);
% text(earthM/2,meteorVs(85),'0.5 x Earth Mass', 'Color', 'white', 'FontSize', 15)
% plot([earthM earthM],[0 meteorVs(75)],'w-','LineWidth', 2);
% text(earthM,meteorVs(85),'1 x Earth Mass', 'Color', 'white', 'FontSize', 15)
% plot([earthM*2 earthM*2],[0 meteorVs(75)],'w-','LineWidth', 2);
% text(earthM*2,meteorVs(85),'2 x Earth Mass', 'Color', 'white', 'FontSize', 15)

s = sqrt(602^2+602^2);

for i = 1:n
    for j = 1:n
        this = E(i,j);
        if this == 1
            h = sqrt(i^2+j^2);
            if h < s
                velocityIndex = i;
                massIndex = j;
                s=h;
            end
            break
        end
    end
end

hold on
plot((meteorMs(massIndex)/earthM)*100,meteorVs(velocityIndex),'r.', 'MarkerSize', 40);

% disp(h);
% disp(velocityIndex);
% disp(massIndex);
% disp(meteorVs(velocityIndex));
% disp(meteorMs(massIndex));