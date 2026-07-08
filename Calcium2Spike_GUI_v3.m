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
    'position', [0.1 0.1 0.7 0.7], 'Color', [0.6 0.6 0.6],...
    'NumberTitle', 'off', 'Name', 'Calcium2Spike_GUI');
    % 'MenuBar', 'none');


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

%%% - 1. Project management Console"
ExperimentFilesUIGroup = uipanel('Title','Project management',...
    'FontSize', 18,...
    'Position',[0.025, 0.38, 0.48, 0.45],...
    'ForegroundColor',[0.5, 0.5, 0.5],...
    'BackgroundColor','White');

% - 1a. Save location spacecard
SaveLocationUIGroup = uipanel('Title','Save location',...
    'FontSize', 15, ...
    'Position',[0.030505952380952,0.673280423280423,0.468749999999999,0.11375661375661],'BackgroundColor',[0.75 0.75 0.75]);

generalTB(1) = GenericTextBox(SaveLocationUIGroup);
UISet_C2S(generalTB(1), 'Position', [0.012006861063465,0.086956521739132,0.974271012006861,0.289855072463767]);
UISet_C2S(generalTB(1), 'String', 'No location specified');
UISet_C2S(generalTB(1), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(1), 'ForeGroundColor', [0.4 0.4 0.4]);
UISet_C2S(generalTB(1), 'BackGroundColor', [0.75 0.75 0.75]);

generalTB(2) = GenericTextBox(SaveLocationUIGroup);
UISet_C2S(generalTB(2), 'Position', [0.01,0.56,0.974271012006861,0.289855072463767]);
UISet_C2S(generalTB(2), 'String',char(hex2dec('2713')));
UISet_C2S(generalTB(2), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(2), 'ForeGroundColor', [0.4 0.4 0.4]);
UISet_C2S(generalTB(2), 'BackGroundColor', [0.75 0.75 0.75]);
UISet_C2S(generalTB(2), 'FontSize', 12);
UISet_C2S(generalTB(2), 'FontWeight', 'bold');

PB(1) = GenericPushButton(SaveLocationUIGroup);
UISet_C2S(PB(1), 'String', 'Browse');
UISet_C2S(PB(1), 'Position', [0.05,0.5,0.1,0.42]);
UISet_C2S(PB(1), 'Callback', @callback_SpecifySaveLocation_C2S);

PB(2) = GenericPushButton(SaveLocationUIGroup);
UISet_C2S(PB(2), 'String', 'Open Folder');
UISet_C2S(PB(2), 'FontSize', 7);
UISet_C2S(PB(2), 'HorizontalAlignment', 'left');
UISet_C2S(PB(2), 'Position', [0.881646655231561,0.057971014492756,0.110291595197254,0.260869565217391]);


% - 1b. MESc file selection spacecard
MEScUIGroup = uipanel('Title','MESc file',...
    'FontSize', 15, ...
    'Position',[0.030505952380952,0.402063492063488,0.468749999999999,0.255375661375661],'BackgroundColor',[0.75 0.75 0.75]);

generalTB(3) = GenericTextBox(MEScUIGroup);
UISet_C2S(generalTB(3), 'Position', [0.01,0.63,0.974271012006861,0.289855072463767]);
UISet_C2S(generalTB(3), 'String',char(hex2dec('2713')));
UISet_C2S(generalTB(3), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(3), 'ForeGroundColor', [0.4 0.4 0.4]);
UISet_C2S(generalTB(3), 'BackGroundColor', [0.75 0.75 0.75]);
UISet_C2S(generalTB(3), 'FontSize', 12);
UISet_C2S(generalTB(3), 'FontWeight', 'bold');

PB(3) = GenericPushButton(MEScUIGroup);
UISet_C2S(PB(3), 'String', 'Browse');
UISet_C2S(PB(3), 'Position', [0.05,0.736551724137952,0.10045025728988,0.213793103448275]);
UISet_C2S(PB(3), 'Enable', 'off');
UISet_C2S(PB(3), 'Callback', @callback_SelectMEScFile_C2S);
UISet_C2S(PB(3), 'Tag', 'SelectMEScFile');

generalTB(4) = GenericTextBox(MEScUIGroup);
UISet_C2S(generalTB(4), 'Position', [0.18,0.75,0.974271012006861,0.143708145927016]);
UISet_C2S(generalTB(4), 'String', 'No MESc file selected');
UISet_C2S(generalTB(4), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(4), 'ForeGroundColor', [0.4 0.4 0.4]);
UISet_C2S(generalTB(4), 'BackGroundColor', [0.75 0.75 0.75]);

MEScParamsUIGroup = uipanel('Title','MESc Params',...
    'FontSize', 10, ...
    'Position',[0.035,0.412380952380952,0.457,0.13],...
    'ForegroundColor',[0.3 0.3 0.3],...
    'BackgroundColor',[0.75 0.75 0.75]);

generalTB(13) = GenericTextBox(MEScParamsUIGroup);
UISet_C2S(generalTB(13), 'Position', [0.012006861063465,0.550344827586227,0.974271012006861,0.3]);
UISet_C2S(generalTB(13), 'String', 'FrameRate: ');
UISet_C2S(generalTB(13), 'FontSize', 8);
UISet_C2S(generalTB(13), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(13), 'ForeGroundColor', [0.4 0.4 0.4]);
UISet_C2S(generalTB(13), 'BackGroundColor', [0.75 0.75 0.75]);

generalTB(14) = GenericTextBox(MEScParamsUIGroup);
UISet_C2S(generalTB(14), 'Position', [0.012006861063465,0.060344827586227,0.974271012006861,0.3]);
UISet_C2S(generalTB(14), 'String', 'TimeSteps in ms:');
UISet_C2S(generalTB(14), 'FontSize', 8);
UISet_C2S(generalTB(14), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(14), 'ForeGroundColor', [0.4 0.4 0.4]);
UISet_C2S(generalTB(14), 'BackGroundColor', [0.75 0.75 0.75]);

generalTB(15) = GenericTextBox(MEScParamsUIGroup);
UISet_C2S(generalTB(15), 'Position', [0.412006861063465,0.550344827586227,0.974271012006861,0.3]);
UISet_C2S(generalTB(15), 'String', 'No. of planes detected:');
UISet_C2S(generalTB(15), 'FontSize', 8);
UISet_C2S(generalTB(15), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(15), 'ForeGroundColor', [0.4 0.4 0.4]);
UISet_C2S(generalTB(15), 'BackGroundColor', [0.75 0.75 0.75]);


%%% - 2. Analysis Console
AnalysisUIGroup = uipanel('Title','Suite2p output management',...
    'FontSize', 18, ...
    'Position',[0.525, 0.38, 0.45, 0.45],...
    'ForegroundColor',[0.5 0.5 0.5],...
    'BackgroundColor','white');

% - 2a. Layer selection spacecard
LayerUIGroup = uipanel('Title','Layer selction',...
    'FontSize', 15, ...
    'Position',[0.53, 0.675, 0.44, 0.11],'BackgroundColor',[0.75 0.75 0.75]);

% - 2a.i. Dropdown menu for layers
DD_currentLayer = uicontrol(LayerUIGroup);
UISet_C2S(DD_currentLayer,'Style','popupmenu')
UISet_C2S(DD_currentLayer,'String', {'Select Layer', 'Layer 1', 'Layer 2','Layer 3', 'Layer 4','Layer 5'});
UISet_C2S(DD_currentLayer, 'Position',[30,30,100,20]);
UISet_C2S(DD_currentLayer, 'FontSize',10);
UISet_C2S(DD_currentLayer, 'Enable', 'off');
UISet_C2S(DD_currentLayer, 'Tag', 'LayerSelectionDD');
UISet_C2S(DD_currentLayer, 'Callback', @callback_suite2pLayerSelection_C2S);

generalTB(10) = GenericTextBox(LayerUIGroup);
UISet_C2S(generalTB(10), 'Position', [0.02,0.05,0.974271012006861,0.3]);
UISet_C2S(generalTB(10), 'String', 'Current layer: --');
UISet_C2S(generalTB(10), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(10), 'ForeGroundColor', [0.3 0.3 0.3]);
UISet_C2S(generalTB(10), 'BackGroundColor', [0.75 0.75 0.75]);

generalTB(11) = GenericTextBox(LayerUIGroup);
UISet_C2S(generalTB(11), 'Position', [0.015,0.53,0.03,0.3]);
UISet_C2S(generalTB(11), 'String',char(hex2dec('2713')));
UISet_C2S(generalTB(11), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(11), 'ForeGroundColor', [0.4 0.4 0.4]);
UISet_C2S(generalTB(11), 'BackGroundColor', [0.75 0.75 0.75]);
UISet_C2S(generalTB(11), 'FontSize', 12);
UISet_C2S(generalTB(11), 'FontWeight', 'bold');

generalTB(12) = GenericTextBox(LayerUIGroup);
UISet_C2S(generalTB(12), 'Position', [0.32,0.05,0.8,0.3]);
UISet_C2S(generalTB(12), 'String', 'No layers analyzed yet');
UISet_C2S(generalTB(12), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(12), 'ForeGroundColor', [0.3 0.3 0.3]);
UISet_C2S(generalTB(12), 'BackGroundColor', [0.75 0.75 0.75]);


% - 2b. Fall.mat file selection spacecard
FallSelectionUIGroup = uipanel('Title','Suite2p Fall.mat file',...
    'FontSize', 15, ...
    'Position',[0.53,0.404,0.44,0.25375661375661],'BackgroundColor',[0.75 0.75 0.75]);

PB(4) = GenericPushButton(FallSelectionUIGroup);
UISet_C2S(PB(4), 'String', 'Browse');
UISet_C2S(PB(4), 'Position', [0.05, 0.75, 0.12, 0.18]);
UISet_C2S(PB(4), 'Enable', 'off');
UISet_C2S(PB(4), 'Callback', @callback_suite2pFallSelection_C2S);
UISet_C2S(PB(4), 'Tag', 'FallSelection');

generalTB(5) = GenericTextBox(FallSelectionUIGroup);
UISet_C2S(generalTB(5), 'Position', [0.2,0.745,0.974271012006861,0.143708145927016]);
UISet_C2S(generalTB(5), 'String', 'No file selected');
UISet_C2S(generalTB(5), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(5), 'ForeGroundColor', [0.3 0.3 0.3]);
UISet_C2S(generalTB(5), 'BackGroundColor', [0.75 0.75 0.75]);

generalTB(6) = GenericTextBox(FallSelectionUIGroup);
UISet_C2S(generalTB(6), 'Position', [0.015,0.74,0.03,0.15]);
UISet_C2S(generalTB(6), 'String',char(hex2dec('2713')));
UISet_C2S(generalTB(6), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(6), 'ForeGroundColor', [0.4 0.4 0.4]);
UISet_C2S(generalTB(6), 'BackGroundColor', [0.75 0.75 0.75]);
UISet_C2S(generalTB(6), 'FontSize', 12);
UISet_C2S(generalTB(6), 'FontWeight', 'bold');


FallParamsUIGroup = uipanel('Title','Fall.mat Params',...
    'FontSize', 10, ...
    'ForegroundColor',[0.3 0.3 0.3],...
    'Position',[0.535,0.412380952380952,0.43,0.13],'BackgroundColor',[0.75 0.75 0.75]);

generalTB(16) = GenericTextBox(FallParamsUIGroup);
UISet_C2S(generalTB(16), 'Position', [0.01,0.75,0.974271012006861,0.143708145927016]);
UISet_C2S(generalTB(16), 'String', 'No. of ROIs detected:');
UISet_C2S(generalTB(16), 'FontSize', 8);
UISet_C2S(generalTB(16), 'HorizontalAlignment', 'left');
UISet_C2S(generalTB(16), 'ForeGroundColor', [0.4 0.4 0.4]);
UISet_C2S(generalTB(16), 'BackGroundColor', [0.75 0.75 0.75]);



% - Run analysis button
PB(98) = GenericPushButton(ExperimentFilesUIGroup);
UISet_C2S(PB(98), 'String', 'Run analysis');
UISet_C2S(PB(98), 'Position', [0.51,0.05,0.2,0.2]);
UISet_C2S(PB(98), 'Enable', 'off');
UISet_C2S(PB(98), 'Tag', 'RunAnalysis');
UISet_C2S(PB(98), 'Callback', @callback_CoreAnalysis_C2S);


%%% - Pool data checkbox
CB(1) = GenericCheckBox(ExperimentFilesUIGroup);
UISet_C2S(CB(1), 'String', 'Ready to pool?');
UISet_C2S(CB(1), 'Position', [0.8,0.2,0.2,0.1]);
UISet_C2S(CB(1), 'Tag', 'ReadyToPool');
UISet_C2S(CB(1), 'FontSize', 8);
UISet_C2S(CB(1), 'Callback', @callback_PoolDataCheckBox_C2S);

%%% - Pool data pushbutton
PB(99) = GenericPushButton(ExperimentFilesUIGroup);
UISet_C2S(PB(99), 'String', 'Pool Data');
UISet_C2S(PB(99), 'Position', [0.8,0.05,0.15,0.12]);
UISet_C2S(PB(99), 'Tag', 'PoolData');
UISet_C2S(PB(99), 'Backgroundcolor', [1 1 1]);
UISet_C2S(PB(99), 'Foregroundcolor', [0 0 0]);
UISet_C2S(PB(99), 'FontWeight', 'normal');
UISet_C2S(PB(99), 'Enable', 'off');
UISet_C2S(PB(99), 'Callback', @callback_PoolData_C2S);

% %%% - Create the primary progress bar
% pbAxes1 = axes('Units', 'normalized', ...
%     'Position', [0.25 0.37 0.5 0.015], ...
%     'XLim', [0 1], ...
%     'YLim', [0 1], ...
%     'XTick', [], ...
%     'YTick', [], ...
%     'Box', 'on', ...
%     'Tag', 'progressbar_primary');
% 
% pbPatch1 = patch( ...
%     'Parent', pbAxes1, ...
%     'XData', [0 0 0 0], ...
%     'YData', [0 1 1 0], ...
%     'FaceColor', [0 0.6 0.9]);
% 
% guidata(figureCalcium2Spike_GUI, data);
% 
% %primary progessbar "console"
% primaryPBconsole = GenericTextBox(figureCalcium2Spike_GUI);
% UISet_C2S(primaryPBconsole, 'Position', [0.05 0.365 0.2 0.03]);
% UISet_C2S(primaryPBconsole, 'String', 'Overall progress');
% UISet_C2S(primaryPBconsole, 'ForegroundColor',[0 0 0]);
% UISet_C2S(primaryPBconsole, 'BackGroundColor',[0.6 0.6 0.6]);
% UISet_C2S(primaryPBconsole, 'FontWeight','Bold');
% UISet_C2S(primaryPBconsole, 'HorizontalAlignment','Center');
% UISet_C2S(primaryPBconsole, 'Tag','primaryPBconsole');
% 
% data.GUI.primaryPBconsole = primaryPBconsole;
% guidata(figureCalcium2Spike_GUI, data);
% 
% %%% - Create the secondary progress bar
% pbAxes2 = axes('Units', 'normalized', ...
%     'Position', [0.25 0.32 0.5 0.015], ...
%     'XLim', [0 1], ...
%     'YLim', [0 1], ...
%     'XTick', [], ...
%     'YTick', [], ...
%     'Box', 'on', ...
%     'Tag', 'progressbar_secondary');
% 
% pbPatch2 = patch( ...
%     'Parent', pbAxes2, ...
%     'XData', [0 0 0 0], ...
%     'YData', [0 1 1 0], ...
%     'FaceColor', [0 0.6 0.9]);
% 
% guidata(figureCalcium2Spike_GUI, data);
% 
% %secondary progessbar "console"
% secondaryPBconsole = GenericTextBox(figureCalcium2Spike_GUI);
% UISet_C2S(secondaryPBconsole, 'Position', [0.05 0.31 0.2 0.03]);
% UISet_C2S(secondaryPBconsole, 'String', 'Running Step: --');
% UISet_C2S(secondaryPBconsole, 'ForegroundColor',[0 0 0]);
% UISet_C2S(secondaryPBconsole, 'BackGroundColor',[0.6 0.6 0.6]);
% UISet_C2S(secondaryPBconsole, 'FontWeight','Bold');
% UISet_C2S(secondaryPBconsole, 'HorizontalAlignment','Center');
% UISet_C2S(secondaryPBconsole, 'Tag','secondaryPBconsole');
% 
% data.GUI.primaryPBconsole = primaryPBconsole;
% guidata(figureCalcium2Spike_GUI, data);

% InformationPanel_C2S(figureCalcium2Spike_GUI);
% ValuesHandle = DrawValues_C2S();

aa=[];