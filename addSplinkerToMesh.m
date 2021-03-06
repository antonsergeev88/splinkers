function S = addSplinkerToMesh(Z, X, Y, flowCapacity, radius, x, y, startAngle, endAngle, trees)
    height = 3 * flowCapacity / pi / radius^2;
    
    fullCircle = height * max(1 - sqrt((X - x).^2 + (Y - y).^2)/radius, 0) * 1000;
    
    [n,m] = size(Z);
    H = ones(n,m);

    if startAngle ~= endAngle
        if endAngle < startAngle
            endAngle = endAngle + 360;
        end
        for c = 1:m
            for r = 1:n
                [theta, ~] = cart2pol(X(r,c) - x, Y(r,c) - y);
                if theta < startAngle/180*pi
                    theta = theta + 2*pi;
                end
                if theta < (startAngle/180*pi) || theta > (endAngle/180*pi)
                    H(r,c) = 0;
                end
            end
        end
    end
    
    S = fullCircle .* H;
    
    treesCount = length(trees(:,1));
    for i = 1:treesCount
        treeX = trees(i,1);
        treeY = trees(i,2);
        treeRadius = trees(i,3);
        [treeTheta, treeRo] = cart2pol(treeX - x, treeY - y);
        alpha = asin(treeRadius/treeRo);
        treeStartAngle = treeTheta - alpha;
        treeEndAngle = treeTheta + alpha;
        TH = ones(n,m);
        for c = 1:m
            for r = 1:n
                [theta, ro] = cart2pol(X(r,c) - x, Y(r,c) - y);
                if (theta > treeStartAngle && theta < treeEndAngle) && ro > treeRo
                    TH(r,c) = 0;
                end
                [~, roInTree] = cart2pol(X(r,c) - treeX, Y(r,c) - treeY);
                if roInTree < treeRadius
                    TH(r,c) = 0;
                end
            end
        end
        S = S .* TH;
    end
    
    
    
    S = S + Z;
end