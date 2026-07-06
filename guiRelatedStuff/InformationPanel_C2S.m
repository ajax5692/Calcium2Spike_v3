function InformationPanel_C2S(fig)

data = guidata(fig);

FileLoadStatusUIGroup = uipanel(data.source, 'Title','',...
    'TitlePosition','centertop','Position',[0.03, 0.44, 0.03, 0.35],...
    'BackgroundColor','white');

stringLabels = {'Save Location Specified', 'MESc file selected'};
    % 'Layer selected','Fall file selected'};

%checkmarks
leftMargin = 0.3;
bottomMargin = 0.79;
height = 0.1;
width = 0.4;
step = 0;

for labelIndex = 1:numel(stringLabels)
    currentStringLabel = stringLabels{labelIndex};
    tag = lower(regexprep(currentStringLabel, '\s+', ''));
    
    if data.GUI.checkmarks.values.(tag) == 0
        color = 'red';
    elseif data.GUI.checkmarks.values.(tag) == 1
        color = 'green';
    else
        color = [0.9 0.9 0.9];
    end
    
    checkmarks(labelIndex) = GenericTextBox(FileLoadStatusUIGroup);
    UISet_C2S(checkmarks(labelIndex), 'Position', [leftMargin, bottomMargin-(step*height), width, height]);
    UISet_C2S(checkmarks(labelIndex), 'String',char(hex2dec('2713')));
    UISet_C2S(checkmarks(labelIndex), 'ForegroundColor',color);
    UISet_C2S(checkmarks(labelIndex), 'FontSize', 15);
    UISet_C2S(checkmarks(labelIndex), 'FontWeight','Bold');
    UISet_C2S(checkmarks(labelIndex), 'HorizontalAlignment','Center');
    UISet_C2S(checkmarks(labelIndex), 'Tag', tag);
    
    data.GUI.checkmarks.graphics.(tag) = checkmarks(labelIndex);
    
    step = step + 3.7;
end

guidata(fig, data);