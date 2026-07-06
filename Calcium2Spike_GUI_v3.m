function Calcium2Spike_GUI_v3

p = mfilename('fullpath');
[coreProcessorfileLocation,nameOfFile] = fileparts(p);

alreadyDrawn = findobj('Name', 'Calcium2Spike_GUI');
if ~isempty(alreadyDrawn)
    msgbox('Calcium2Spike_GUI is already open! Please close older instances.');
    return;
end

figureCalcium2Spike_GUI = figure;
set(figureCalcium2Spike_GUI,'units', 'normalized',...
    'position', [0.292 0.278 0.366 0.497], 'Color', [0.6 0.6 0.6],...
    'NumberTitle', 'off', 'Name', 'Calcium2Spike_GUI');


%initializing data that will be embedded in the figure
data = InitializeEmptyDataStructure_C2S_GUI(coreProcessorfileLocation);
data.source = figureCalcium2Spike_GUI;
guidata(figureCalcium2Spike_GUI, data); 

%GUI header
GUIheader = GenericTextBox(figureCalcium2Spike_GUI);
UISet_C2S(GUIheader, 'Position', [0, 0.85, 1, 0.1]);
UISet_C2S(GUIheader, 'String', 'Calcium2Spike');
UISet_C2S(GUIheader, 'ForegroundColor', [0 1 0]);
UISet_C2S(GUIheader, 'BackGroundColor', [0 0 0]);
UISet_C2S(GUIheader, 'FontWeight', 'Bold'); fontsize(20,'points');
UISet_C2S(GUIheader, 'HorizontalAlignment','center');

%error "console"
errorConsole = GenericTextBox(figureCalcium2Spike_GUI);
UISet_C2S(errorConsole, 'Position', [0.03, 0.03, 0.5, 0.05]);
UISet_C2S(errorConsole, 'String', 'No errors');
UISet_C2S(errorConsole, 'ForegroundColor', [0.64 0.08 0.18]);
UISet_C2S(errorConsole, 'BackGroundColor', [0.85 0.85 0.85]);
UISet_C2S(errorConsole, 'FontWeight', 'Bold');
UISet_C2S(errorConsole, 'HorizontalAlignment','center');

data.GUI.errorConsole = errorConsole;
guidata(figureCalcium2Spike_GUI, data);

%logging "console"
loggingConsole = GenericTextBox(figureCalcium2Spike_GUI);
UISet_C2S(loggingConsole, 'Position', [0.55,0.03,0.42,0.047]);
UISet_C2S(loggingConsole, 'String', data.logging.latestReturned);
UISet_C2S(loggingConsole, 'ForegroundColor',[0.4667 0.6745 0.1882]);
UISet_C2S(loggingConsole, 'BackGroundColor',[0.9 0.9 0.9]);
UISet_C2S(loggingConsole, 'FontWeight','Bold');
UISet_C2S(loggingConsole, 'HorizontalAlignment','Left');

data.GUI.loggingConsole = loggingConsole;
guidata(figureCalcium2Spike_GUI, data);

%%% - Layer-wise analysis "console"
ExperimentFilesUIGroup = uipanel('Title','Layer-wise analysis',...
    'Position',[0.025, 0.42, 0.945, 0.4],'BackgroundColor','White');

%%% - Specify save location button
PB(1) = GenericPushButton(ExperimentFilesUIGroup);
UISet_C2S(PB(1), 'String', 'Specify save location for analyzed data');
UISet_C2S(PB(1), 'Position', [0.02, 0.81, 0.38, 0.1]);
UISet_C2S(PB(1), 'Callback', @callback_SpecifySaveLocation_C2S);

%%% - Specify MESc file selection button
PB(2) = GenericPushButton(ExperimentFilesUIGroup);
UISet_C2S(PB(2), 'String', 'Select MESc file to analyze');
UISet_C2S(PB(2), 'Position', [0.02, 0.6, 0.38, 0.1]);
UISet_C2S(PB(2), 'Enable', 'off');
UISet_C2S(PB(2), 'Callback', @callback_SelectMEScFile_C2S);
UISet_C2S(PB(2), 'Tag', 'SelectMEScFile');

%%% - Specify Fall.mat file selection button
PB(3) = GenericPushButton(ExperimentFilesUIGroup);
UISet_C2S(PB(3), 'String', 'Select Fall.mat file');
UISet_C2S(PB(3), 'Position', [0.02, 0.18, 0.38, 0.1]);
UISet_C2S(PB(3), 'Enable', 'off');
UISet_C2S(PB(3), 'Callback', @callback_suite2pFallSelection_C2S);
UISet_C2S(PB(3), 'Tag', 'FallSelection');

%%% - Specify which layer data is being analyzed
DD_currentLayer = uicontrol(ExperimentFilesUIGroup);
UISet_C2S(DD_currentLayer,'Style','popupmenu')
UISet_C2S(DD_currentLayer,'String', {'Select Layer', 'Layer 1', 'Layer 2','Layer 3', 'Layer 4','Layer 5'});
UISet_C2S(DD_currentLayer, 'Position',[90,80,100,20]);
UISet_C2S(DD_currentLayer, 'FontSize',10);
UISet_C2S(DD_currentLayer, 'Enable', 'off');
UISet_C2S(DD_currentLayer, 'Tag', 'LayerSelectionDD');
UISet_C2S(DD_currentLayer, 'Callback', @callback_suite2pLayerSelection_C2S);

%%% - Run analysis button
PB(4) = GenericPushButton(ExperimentFilesUIGroup);
UISet_C2S(PB(4), 'String', 'Run analysis');
UISet_C2S(PB(4), 'Position', [0.51,0.05,0.2,0.2]);
UISet_C2S(PB(4), 'Enable', 'off');
UISet_C2S(PB(4), 'Tag', 'RunAnalysis');
UISet_C2S(PB(4), 'Callback', @callback_CoreAnalysis_C2S);


%%% - Pool data checkbox
CB(1) = GenericCheckBox(ExperimentFilesUIGroup);
UISet_C2S(CB(1), 'String', 'Ready to pool?');
UISet_C2S(CB(1), 'Position', [0.8,0.2,0.2,0.1]);
UISet_C2S(CB(1), 'Tag', 'ReadyToPool');
UISet_C2S(CB(1), 'FontSize', 8);
UISet_C2S(CB(1), 'Callback', @callback_PoolDataCheckBox_C2S);

%%% - Pool data pushbutton
PB(5) = GenericPushButton(ExperimentFilesUIGroup);
UISet_C2S(PB(5), 'String', 'Pool Data');
UISet_C2S(PB(5), 'Position', [0.8,0.05,0.15,0.12]);
UISet_C2S(PB(5), 'Tag', 'PoolData');
UISet_C2S(PB(5), 'Backgroundcolor', [1 1 1]);
UISet_C2S(PB(5), 'Foregroundcolor', [0 0 0]);
UISet_C2S(PB(5), 'FontWeight', 'normal');
UISet_C2S(PB(5), 'Enable', 'off');
UISet_C2S(PB(5), 'Callback', @callback_PoolData_C2S);

%%% - Create the primary progress bar
pbAxes1 = axes('Units', 'normalized', ...
    'Position', [0.25 0.37 0.5 0.015], ...
    'XLim', [0 1], ...
    'YLim', [0 1], ...
    'XTick', [], ...
    'YTick', [], ...
    'Box', 'on', ...
    'Tag', 'progressbar_primary');

pbPatch1 = patch( ...
    'Parent', pbAxes1, ...
    'XData', [0 0 0 0], ...
    'YData', [0 1 1 0], ...
    'FaceColor', [0 0.6 0.9]);

guidata(figureCalcium2Spike_GUI, data);

%primary progessbar "console"
primaryPBconsole = GenericTextBox(figureCalcium2Spike_GUI);
UISet_C2S(primaryPBconsole, 'Position', [0.05 0.365 0.2 0.03]);
UISet_C2S(primaryPBconsole, 'String', 'Overall progress');
UISet_C2S(primaryPBconsole, 'ForegroundColor',[0 0 0]);
UISet_C2S(primaryPBconsole, 'BackGroundColor',[0.6 0.6 0.6]);
UISet_C2S(primaryPBconsole, 'FontWeight','Bold');
UISet_C2S(primaryPBconsole, 'HorizontalAlignment','Center');
UISet_C2S(primaryPBconsole, 'Tag','primaryPBconsole');

data.GUI.primaryPBconsole = primaryPBconsole;
guidata(figureCalcium2Spike_GUI, data);

%%% - Create the secondary progress bar
pbAxes2 = axes('Units', 'normalized', ...
    'Position', [0.25 0.32 0.5 0.015], ...
    'XLim', [0 1], ...
    'YLim', [0 1], ...
    'XTick', [], ...
    'YTick', [], ...
    'Box', 'on', ...
    'Tag', 'progressbar_secondary');

pbPatch2 = patch( ...
    'Parent', pbAxes2, ...
    'XData', [0 0 0 0], ...
    'YData', [0 1 1 0], ...
    'FaceColor', [0 0.6 0.9]);

guidata(figureCalcium2Spike_GUI, data);

%secondary progessbar "console"
secondaryPBconsole = GenericTextBox(figureCalcium2Spike_GUI);
UISet_C2S(secondaryPBconsole, 'Position', [0.05 0.31 0.2 0.03]);
UISet_C2S(secondaryPBconsole, 'String', 'Running Step: --');
UISet_C2S(secondaryPBconsole, 'ForegroundColor',[0 0 0]);
UISet_C2S(secondaryPBconsole, 'BackGroundColor',[0.6 0.6 0.6]);
UISet_C2S(secondaryPBconsole, 'FontWeight','Bold');
UISet_C2S(secondaryPBconsole, 'HorizontalAlignment','Center');
UISet_C2S(secondaryPBconsole, 'Tag','secondaryPBconsole');

data.GUI.primaryPBconsole = primaryPBconsole;
guidata(figureCalcium2Spike_GUI, data);

InformationPanel_C2S(figureCalcium2Spike_GUI);
ValuesHandle = DrawValues_C2S();