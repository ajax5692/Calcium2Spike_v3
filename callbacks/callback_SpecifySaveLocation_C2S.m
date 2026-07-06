function callback_SpecifySaveLocation_C2S(hO, ed)

figureCalcium2Spike_GUI = ancestor(hO,'figure');      % get figure that owns guidata
d = guidata(hO);

saveLocationTB = GenericTextBox(figureCalcium2Spike_GUI);
UISet_C2S(saveLocationTB, 'Position', [0.025, 0.15, 0.945, 0.05]);
UISet_C2S(saveLocationTB, 'BackGroundColor', [0.6 0.6 0.6]);
UISet_C2S(saveLocationTB, 'HorizontalAlignment','left');
UISet_C2S(saveLocationTB, 'Tag','saveLocationTB');

saveDirectory = uigetdir('C:\Users\abhrajyoti.chakrabarti\Desktop\testNewGUI\','Please specify location where to save the results');

try
    if saveDirectory ~= 0
        d.saveAnalyzedData = saveDirectory;
        d = UpdateCheckmark_C2S(d,'savelocationspecified', 1);
        d = ToError(d, " No errors");
        UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
            'ForegroundColor',[0.64 0.08 0.18]);
        d = ToLog(d, "Save location successfully specified");
        UISet_C2S(saveLocationTB, 'String', strcat('Data will be saved at:',{' '},d.saveAnalyzedData));
        UISet_C2S(saveLocationTB, 'FontSize',8);
        childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','SelectMEScFile');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'on');
        cd(d.saveAnalyzedData)
        mkdir('AnalyzedCalciumToSpikeData')
        cd(d.originalCodePath)

    else
        d = ToError(d, " Save location not specified by user");
        d = UpdateCheckmark_C2S(d,'savelocationspecified', 0);
        UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
            'ForegroundColor',[0.64 0.08 0.18]);
        UISet_C2S(saveLocationTB, 'String', 'Data will be saved at: --');
        UISet_C2S(saveLocationTB, 'FontSize',8);
        
        childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','SelectMEScFile');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
        d = UpdateCheckmark_C2S(d,'mescfileselected', 0);

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

        childrenArray = GUI_childrenFinder_C2S(d,'','mescFileLocationTB')
        UISet_C2S(d.source.Children(childrenArray), 'String', 'Selected MESc file: --');
    end
catch
end


guidata(d.source, d);