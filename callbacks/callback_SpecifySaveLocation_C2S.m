function callback_SpecifySaveLocation_C2S(hO, ed)

figureCalcium2Spike_GUI = ancestor(hO,'figure');      % get figure that owns guidata
d = guidata(hO);

saveDirectory = uigetdir('C:\Users\abhrajyoti.chakrabarti\Desktop\testNewGUI\','Please specify location where to save the results');

try
    if saveDirectory ~= 0
        d.saveAnalyzedData = saveDirectory;
        d = ToError(d, " No errors");
        UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
            'ForegroundColor',[0.64 0.08 0.18]);
        d = ToLog(d, "Save location successfully specified");
        %update save location path text
        childrenArray = GUI_childrenFinder_C2S(d,'Save location','SaveLocationPathTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            strcat('Data saved at:', {' '}, d.saveAnalyzedData));
        %enable open save folder button
        childrenArray = GUI_childrenFinder_C2S(d,'Save location','OpenSaveLocationPathPB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'on');
        %update checkmark color
        childrenArray = GUI_childrenFinder_C2S(d,'Save location','SaveLocationPathCheckmark');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'ForegroundColor',[0.21 0.70 0.21]);
        %change directory and create folder to store analyzed data
        cd(d.saveAnalyzedData)
        mkdir('AnalyzedCalciumToSpikeData')
        cd(d.originalCodePath)

    else %disable buttons and update GUI accordingly
        d = ToError(d, " Save location not specified by user");
        UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
            'ForegroundColor',[0.64 0.08 0.18]);
        % - savelocation space card
        %reset save location path text
        childrenArray = GUI_childrenFinder_C2S(d,'Save location','SaveLocationPathTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'No location specified');
        %disable open save folder PB
        childrenArray = GUI_childrenFinder_C2S(d,'Save location','OpenSaveLocationPathPB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
        %update checkmark color
        childrenArray = GUI_childrenFinder_C2S(d,'Save location','SaveLocationPathCheckmark');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'ForegroundColor',[0.9 0.3 0.3]);
        % - mesc space card
        %disable MESc browse PB
        childrenArray = GUI_childrenFinder_C2S(d,'MESc file','SelectMEScFile');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
        %reset MESc filepath text
        childrenArray = GUI_childrenFinder_C2S(d,'MESc file','MEScFileLocationPathTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'No MESc file selected');
        %update checkmark color
        childrenArray = GUI_childrenFinder_C2S(d,'MESc file','MEScFileSelectionCheckmark');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'ForegroundColor',[0.9 0.3 0.3]);
        % - update MESc params space card
        %framerate TB
        childrenArray = GUI_childrenFinder_C2S(d,'MESc Params','MEScFramerateTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'FrameRate:');
        %timeSteps TB
        childrenArray = GUI_childrenFinder_C2S(d,'MESc Params','MEScTimeStepsTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'TimeSteps in ms:');
        %no. of planes TB
        childrenArray = GUI_childrenFinder_C2S(d,'MESc Params','MEScMultiplaneTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'No. of planes detected:');
        % - layer selection space card
        %disable dropdown menu
        childrenArray = GUI_childrenFinder_C2S(d,'Layer selection','LayerSelectionDD');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable','off');
        %reset current layer TB
        childrenArray = GUI_childrenFinder_C2S(d,'Layer selection','CurrentLayerTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'Current layer: --');
        %reset analyzed layer TB
        childrenArray = GUI_childrenFinder_C2S(d,'Layer selection','AnalyzedLayerTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'No layers analyzed yet');
        %update checkmark color
        childrenArray = GUI_childrenFinder_C2S(d,'Layer selection','LayerSelectionCheckmark');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'ForegroundColor',[0.9 0.3 0.3]);
        % - suite2p Fall space card
        %disable pushbutton
        childrenArray = GUI_childrenFinder_C2S(d,'Suite2p Fall.mat file','FallSelectionPB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable','off');
        %reset filepath TB
        childrenArray = GUI_childrenFinder_C2S(d,'Suite2p Fall.mat file','FallFilepathTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'No file selected');
        %update checkmark color
        childrenArray = GUI_childrenFinder_C2S(d,'Suite2p Fall.mat file','FallCheckmark');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'ForegroundColor',[0.9 0.3 0.3]);
        % - update Fall params space card
        %no. of ROIs
        childrenArray = GUI_childrenFinder_C2S(d,'Fall.mat Params','FallROInumTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'No. of ROIs detected:');
        % - update analysis space card
        %disable OASIS EB
        childrenArray = GUI_childrenFinder_C2S(d,'Analysis','SetOASISthresholdEB');
        % UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
        %     'No. of ROIs detected:');
        %disable OASIS TB
        childrenArray = GUI_childrenFinder_C2S(d,'Analysis','SetOASISthresholdTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable','off');
        % - update core analysis space card
        %disable run analysis PB
        childrenArray = GUI_childrenFinder_C2S(d,'AnalysisResultUIGroup','RunAnalysisPB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off',...
            'BackgroundColor', 'w', 'ForegroundColor', 'k', 'FontWeight', 'normal', 'FontWeight',...
            'normal', 'FontSize', 10);
        % - reset the analysis output space card
        %df/f count
        childrenArray = GUI_childrenFinder_C2S(d,'AnalysisResultUIGroup','DffCountTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'ΔF/F units (should match with no. of ROIs detected):');
        %PSNR filtered units
        childrenArray = GUI_childrenFinder_C2S(d,'AnalysisResultUIGroup','PSNRfilterTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'Units filtered due to low PSNR:');
        %saved df/f units
        childrenArray = GUI_childrenFinder_C2S(d,'AnalysisResultUIGroup','DffSavedUnitsTB');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', ...
            'Final ΔF/F units saved:');
    end
catch
end


guidata(d.source, d);