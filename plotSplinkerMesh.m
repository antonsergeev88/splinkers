function plotSplinkerMesh(width, height, splinkers, trees)
    [X, Y, Z] = splinkerMesh(width, height);
    splinkerCount = length(splinkers(:,1));
    for i = 1:splinkerCount
        splinker = splinkers(i,:);
        flowCapacity = splinker(1);
        radius = splinker(2);
        x = splinker(3);
        y = splinker(4);
        startAngle = splinker(5);
        endAngle = splinker(6);
        Z = addSplinkerToMesh(Z, X, Y, flowCapacity, radius, x, y, startAngle, endAngle, trees);
    end
    surf(X, Y, Z, 'EdgeColor', 'none');
end