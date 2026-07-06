function callback_SelectMEScFile_C2S(hO, ed)

figureCalcium2Spike_GUI = ancestor(hO,'figure');      % get figure that owns guidata
d = guidata(hO);

mescFileLocationTB = GenericTextBox(figureCalcium2Spike_GUI);
UISet_C2S(mescFileLocationTB, 'Position', [0.025, 0.09, 0.945, 0.05]);
UISet_C2S(mescFileLocationTB, 'BackGroundColor', [0.6 0.6 0.6]);
UISet_C2S(mescFileLocationTB, 'HorizontalAlignment','left');
UISet_C2S(mescFileLocationTB, 'Tag','mescFileLocationTB');

[mescDataName, mescDataLocation] = uigetfile('*.mesc','Please select the MESc file','C:\Users\abhrajyoti.chakrabarti\Desktop\testNewGUI\');

if mescDataName ~= 0
    d.mescDataName = mescDataName;
    d.mescDataLocation = mescDataLocation;
    d = UpdateCheckmark_C2S(d,'mescfileselected', 1);
    d = ToError(d, " No errors");
    UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
            'ForegroundColor',[0.64 0.08 0.18]);
    d = ToLog(d, "MESc file successfully selected");
    UISet_C2S(mescFileLocationTB, 'String', strcat('Selected MESc file:',{' '},d.mescDataLocation,'\',d.mescDataName));
    UISet_C2S(mescFileLocationTB, 'FontSize', 8)

    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','LayerSelectionDD');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'on');

    tStepsInMs = h5readatt(strcat(d.mescDataLocation,d.mescDataName),'/MSession_0/MUnit_50/','TStepInMs');
    d.mescFrameRate = (1/tStepsInMs)*1000;
    d.mescFrameRate = round(d.mescFrameRate,2);
    d.Values.TBDynamic(2).String = strcat(num2str(d.mescFrameRate), {' '},'Hz');
    
else
    d = ToError(d, " MESc file selection interrupted by user");
    d = UpdateCheckmark_C2S(d,'mescfileselected', 0);
    UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
            'ForegroundColor',[0.64 0.08 0.18]);

    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','LayerSelectionDD');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
    d = UpdateCheckmark_C2S(d,'layerselected', 0);
    
    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','FallSelection');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
    d = UpdateCheckmark_C2S(d,'fallfileselected', 0);

    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','RunAnalysis');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', 'white');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontWeight', 'normal');

    UISet_C2S(mescFileLocationTB, 'String', strcat('Selected MESc file: --'));
    UISet_C2S(mescFileLocationTB, 'FontSize', 8)
    d.Values.TBDynamic(2).String = '--';
end

guidata(d.source, d);