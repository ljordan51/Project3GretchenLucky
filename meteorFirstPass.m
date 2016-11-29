function meteorFirstPass()

close all

r = 150e9; %distance from center of earth to center of sun (m)
v = 30e3; %velocity of earth (m/s)
theta = pi/2; %angle of earth with respect to x-axis through sun (rad)

time0 = 0;
year = 60*60*24*365;
numYears = 10;
timeFinal = year*numYears;

% circumference = 2*pi*r;

M = [r,v,theta];

[t,K] = ode45(@derivativesEarth, [time0:86400:timeFinal], M);

function res = derivativesEarth(t,M);
    
%     dthetadt = v*(2*pi/circumference);
    dthetadt = 2*pi/year;

    res = [0;0;dthetadt];
end

Rs = K(:,1);
Vs = K(:,2);
Thetas = K(:,3);

num = length(Rs);

X = zeros(1,num);
Y = zeros(1,num);

for i = 1:num;
        X(i) = Rs(i)*cos(Thetas(i));
        Y(i) = Rs(i)*sin(Thetas(i));
end

comet(X,Y);
end
