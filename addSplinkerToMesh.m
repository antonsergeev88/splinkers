function S = addSplinkerToMesh(Z, X, Y, flowCapacity, radius, x, y)
    height = 3 * flowCapacity / pi / radius^2;
    
    S = Z + height * max(1 - sqrt((X - x).^2 + (Y - y).^2)/radius, 0) * 1000;
end