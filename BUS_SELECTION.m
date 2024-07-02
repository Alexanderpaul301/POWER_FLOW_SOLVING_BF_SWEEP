function checkboxCallback(src, ~)
    val = get(src, 'Value');
    disp(['Checkbox ' get(src, 'String') ' is now ' num2str(val)]);
end

function buttonCallback(~, ~)
    val1 = get(checkbox1, 'Value');
    val2 = get(checkbox2, 'Value');
    val3 = get(checkbox3, 'Value');
    disp(['Selections: Option 1: ' num2str(val1) ', Option 2: ' num2str(val2) ', Option 3: ' num2str(val3)]);
end



fig = figure('Position', [100, 100, 400, 300], 'Name', 'Checkbox Interface');
% Checkbox 1
checkbox1 = uicontrol('Style', 'checkbox', 'String', 'Option 1', ...
                      'Position', [50, 220, 100, 30], 'Callback', @checkboxCallback);

% Checkbox 2
checkbox2 = uicontrol('Style', 'checkbox', 'String', 'Option 2', ...
                      'Position', [50, 180, 100, 30], 'Callback', @checkboxCallback);

% Checkbox 3
checkbox3 = uicontrol('Style', 'checkbox', 'String', 'Option 3', ...
                      'Position', [50, 140, 100, 30], 'Callback', @checkboxCallback);

btn = uicontrol('Style', 'pushbutton', 'String', 'Submit', ...
                'Position', [50, 80, 100, 30], 'Callback', @buttonCallback);

