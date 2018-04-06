function [X, Y, Z] = splinkerMesh(width, height)
    [X, Y] = meshgrid(0:0.01:width, 0:0.01:height);
    Z = X .* Y * 0;
end
