
%% Creating the Ybus Matrix from the CSV file

% Opening a dialog window to select the CSV file
[filename, pathname] = uigetfile({'*.csv', 'Fichiers CSV (*.csv)'; '*.*', 'Tous les fichiers (*.*)'}, 'Sélectionnez un fichier CSV');

% Check if the user has not cancelled the selection
if isequal(filename, 0) || isequal(pathname, 0)
    disp('Selection cancelled');
    return;
end

% Build the path towards the file
filepath = fullfile(pathname, filename);

% Display the path for verification
disp(['Chemin complet du fichier : ', filepath]);

% Read the CSV file as a table
dataTable = readtable(filepath, 'ReadVariableNames', false);
dataTable=dataTable(1:end,1:2);


% Initialize the table to receive values of the Y Matrix
complexData = zeros(height(dataTable), width(dataTable)/2);

% Iterrate on the number of columns
l=1;
for k = 1:2:(width(dataTable)-1)
    % disp(k);
    % Index of the real column and the imaginary column
    realColIdx = k;
    imagColIdx = k+1;

    % Extract both real and imag parts of the cell
    realPart = dataTable{:, realColIdx}; 
    imagPart = dataTable{:, imagColIdx};

    % Combine real and imag part into the matrix
    complexData(:,l) = realPart + 1i*imagPart;
    l=l+1;
end

% Display the matrix and a line to display the success of the process 
disp('CSV file generated!');
disp(complexData(1:min(5, height(dataTable)), :)); % Affiche les 5 premières lignes ou moins si la matrice a moins de 5 lignes


