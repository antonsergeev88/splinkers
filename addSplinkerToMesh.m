function S = addSplinkerToMesh(Z, X, Y, flowCapacity, radius, x, y, startAngle, endAngle)
    height = 3 * flowCapacity / pi / radius^2;
    
    fullCircle = height * max(1 - sqrt((X - x).^2 + (Y - y).^2)/radius, 0) * 1000;
    
    [n,m] = size(Z);
    H = ones(n,m);

    if startAngle ~= endAngle
        for c = 1:m
            for r = 1:n
                [theta, ~] = cart2pol(X(r,c) - x, Y(r,c) - y);
                if theta < 0
                    theta = theta + 2*pi;
                end
                if theta < (startAngle/180*pi) || theta > (endAngle/180*pi)
                    H(r,c) = 0;
                end
            end
        end
    end
    S = Z + fullCircle .* H;
end