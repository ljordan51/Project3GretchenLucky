function orbitModel()

close all

earth = 5.972e24; %mass of earth (kg)
sun = 1.989e30; %mass of sun (kg)
G = 6.67408e-11; %universal gravitational constant (m/kg*s^2)

r0 = 150e9; %initial radius of earth orbit 'distance from sun center to earth center' (m)
rtheta0 = pi/2; %initial theta of earth radius (rad) (only matters in relation to initial theta of velocity)
v0 = 20e3; %initial velocity of earth 'average earth velocity' (m/s)
vtheta0 = pi/6; %initial theta of velocity (rad) (only matters in relation to initial theta of earth radius)
z0 = v0*(cos(vtheta0) + i*sin(vtheta0)); %velocity represented as a complex number (r*cos(theta) + i*sin(theta))

initials = [r0, rtheta0, z0]; %packs initial values into vector for ode45

years = 1; %number of years of simulation (years)
t0 = 0; %initial time (s)
tFinal = years*31536000; %final time (s)

opts = odeset('RelTol',1e-7,'AbsTol',1e-7); %sets relative tolerance and absolute tolerance of ode solver to get more accurate orbit

[~,M] = ode45(@earthSimulate, [t0 tFinal], initials, opts); %ode45 calls function, sets time range, accepts initials and uses opts

    function res = earthSimulate(~,M)
        
        r = M(1); %gets radius from initials
        rtheta = M(2); %gets theta from initials
        z = M(3); %gets complex number velocity vector from initials
        
        drdt = abs(z)*cos(angle(z)-rtheta); %change in radius (v*cos(theta)) (m/s)
        drthetadt = (abs(z)*sin(angle(z)-rtheta))/r; %change in theta (v*sin(theta)/r) angular velocity (rad/s)
        gravity = (G*earth*sun)/r^2; %gravity force between earth and sun (kg*m/s^2)
        gravityAcceleration = gravity/earth; %gravitational acceleration of earth velocity (m/s^2)
        zgravity = -gravityAcceleration*(cos(rtheta)+i*sin(rtheta)); %complex number vector of gravitational acceleration
        dvdt = zgravity; %change in velocity equal to gravitational acceleration
        
        res = [drdt; drthetadt; dvdt];
        
    end

R = M(:,1);
Theta = M(:,2);
% V = M(:,3);
polar(Theta,R,'rx');
% X = R.*cos(Theta);
% Y = R.*sin(Theta);
% comet(X,Y);

% disp(R);
% disp(V);
% disp(abs(V));

disp(R(end));
disp(Theta(end));

title(['Orbital positions for ', num2str(years), ' year(s)', ' Initial Velocity = ', num2str(v0), ' m/s Initial V Theta = ', num2str(vtheta0)]);


end