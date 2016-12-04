firstV = 42.483e3;
lastV = 43e3;
step = .0001;

for i = firstV:step:lastV
    value = orbitModel(i);
    if value == 0
        disp(i);
        break
    end
end