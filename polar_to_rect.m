function [z] = polar_to_rect(r, theta)
    % polarToRectangular Converts polar coordinates to rectangular coordinates.
    %
    % [x, y] = polarToRectangular(r, theta) returns the Cartesian coordinates
    % (x, y) corresponding to the polar coordinates (r, theta).
    %
    % Inputs:
    %   r - Magnitude (can be a scalar or a vector)
    %   theta - Angle in radians (can be a scalar or a vector)
    %
    % Outputs:
    %   x - x-coordinate (or real part)
    %   y - y-coordinate (or imaginary part)

    % Validate inputs
    if ~isnumeric(r) || ~isnumeric(theta)
        error('Inputs must be numeric.');
    end
    if ~isequal(size(r), size(theta))
        error('Inputs r and theta must have the same size.');
    end

    % Convert from polar to rectangular coordinates
    x = r .* cos(theta);
    y = r .* sin(theta);
    z=x+1i.*y;
end
