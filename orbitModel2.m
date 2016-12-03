function orbitModel2()

close all

numYears = 10; %number of years to run simulation
year = 365 * 24 * 60 * 60; % year in seconds
r = 147.1e9; % initial distance in meters at perihelion
v = 30.3e3; % initial velocity in meters per second at perihelion
sun = 1.989e30; % mass of the sun (kg)
earth = 5.972e24; % mass of earth (kg)
G = 6.67408e-11; % gravitation constant in N m^2 / kg^2
t0 = 0; %initial time (s)
tfinal = numYears * year; % final time (s)

P1 = [0;0]; % simple initial conditions
P2 = [r;0];
V1 = [0;0];
V2 = [0;v];

options = odeset('RelTol', 1e-5);

% step = 200;

[T, M] = ode45(@rate_func, [t0 tfinal], [P1; P2; V1; V2], options);

animate_func(T,M);



    function animate_func(T,M)
        X1 = M(:,1);
        Y1 = M(:,2);
        X2 = M(:,3);
        Y2 = M(:,4);
        VX1 = M(:,5);
        VY1 = M(:,6);
        VX2 = M(:,7);
        VY2 = M(:,8);
        
        plot(X1,Y1,'rx');
        figure
        plot(X2,Y2,'bx');
        figure
        
        R1 = sqrt(X1.^2 + Y1.^2);
        R2 = sqrt(X2.^2 + Y2.^2);
        V1a = sqrt(VX1.^2 + VY1.^2);
        V2a = sqrt(VX2.^2 + VY2.^2);
        fprintf('%8.2f %8.3f %8.4f %8.5f\n', [R1, V1a, R2, V2a]');
%         fprintf('%8.2f %8.3f\n', [R2, V2a]');
        
        minmax = [min([X1;X2]), max([X1;X2]), min([Y1;Y2]), max([Y1;Y2])];
        
        for i=1:length(T)
            clf;
            hold on;
            axis(minmax);
            draw_func(X1(i), Y1(i), X2(i), Y2(i));
            drawnow;
%             if i < length(T)
%                 dt = T(i+1) - T(i);
%                 speedup = 1000;
%                 pause(dt/speedup);
%             end
        end
        
        hold off
    end

    function draw_func(x1, y1, x2, y2)
        
        plot(x1, y1, 'r.', 'MarkerSize', 200);
        plot(x2, y2, 'b.', 'MarkerSize', 20);
        
    end

    function res = rate_func(t, W)

        P = W(1:4);
        V = W(5:8);

        dRdt = V;
        dVdt = acceleration_func(P);

        res = [dRdt; dVdt];

    end

    function res = acceleration_func(P)

        P1a = P(1:2);
        P2a = P(3:4);
        F12 = gravity_force_func(P1a, P2a);
        A1 = F12 / sun;
        A2 = -F12 / earth;
        res = [A1; A2];
        
    end

    function Fg = gravity_force_func(P1b, P2b)

        R = P2b - P1b;
        r1 = norm(R);
        Rhat = R/r1;
        Fg = ((G * sun * earth) / r1^2) * Rhat;
        
    end

end