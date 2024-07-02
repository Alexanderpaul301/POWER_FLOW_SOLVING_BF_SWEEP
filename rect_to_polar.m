function [magnitude, angle_deg] = rect_to_polar(z)
    % This function converts complex numbers from rectangular to polar form.
    % Input:
    %   z - A complex number or an array of complex numbers
    % Output:
    %   magnitude - Magnitude of the complex number(s)
    %   angle_deg - Angle of the complex number(s) in degrees

    % Compute the magnitude
    magnitude = abs(z);

    % Compute the angle in degrees using atan2
    angle_deg = atan2(imag(z), real(z)) * 180 / pi;

    % Adjust angles to be within [0, 360) degrees
    angle_deg = mod(angle_deg, 360);

    % Ensure angles are within [-180, 180] degrees
    angle_deg(angle_deg > 180) = angle_deg(angle_deg > 180) - 360;

    % Optionally, display results (for debugging or informative purposes)
    % for i = 1:numel(z)
    %     fprintf('Complex number: %s\n', num2str(z(i)));
    %     fprintf('Magnitude: %.4f\n', magnitude(i));
    %     fprintf('Angle (degrees): %.4f\n', angle_deg(i));
    % end
end
