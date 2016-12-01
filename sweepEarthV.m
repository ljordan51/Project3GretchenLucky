firstV = 42.3e3;
lastV = 43.5e3;
step = 1;

for i = firstV:step:lastV
    value = orbitModel(i);
    if value == 0
        disp(i);
        break
    end
end