%% Creating the Ybus Matrix from the CSV file

% Define the full file path to the CSV file
filepath = 'C:\Users\paula\Desktop\OPENDSS_OCHOA_CLASS\OpenDSS-4-LV\LV_EXP_Y.csv';

% Check if the file exists
if ~isfile(filepath)
    error('The file does not exist at the specified path: %s', filepath);
end

% Display the path for verification
disp(['Chemin complet du fichier : ', filepath]);

% Read the CSV file as a table
dataTable = readtable(filepath, 'ReadVariableNames', false);

% Remove the first row and first column
dataTable = dataTable(2:end, 2:end);

% Initialize the matrix to receive values of the Y Matrix
complexData = zeros(height(dataTable), width(dataTable) / 2);

% Iterate over the columns
l = 1;
for k = 1:2:(width(dataTable) - 1)
    disp(k);
    % Index of the real column and the imaginary column
    realColIdx = k;
    imagColIdx = k + 1;

    % Extract both real and imag parts of the cell
    realPart = str2double(dataTable{:, realColIdx}); % Convert to double
    imagPart = str2double(dataTable{:, imagColIdx}); % Convert to double

    % Combine real and imag part into the matrix
    complexData(:, l) = realPart + 1i * imagPart;
    l = l + 1;
end

% Display the matrix and a line to display the success of the process 
disp('CSV file generated!');
disp(complexData(1:min(5, height(dataTable)), :)); % Display the first 5 rows or fewer if the matrix has less than 5 rows
