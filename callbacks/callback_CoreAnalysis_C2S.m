function callback_CoreAnalysis_C2S(hO, ed)

figureCalcium2Spike_GUI = ancestor(hO,'figure');      % get figure that owns guidata
d = guidata(hO);

totalAnalysisSteps = 3;

if isempty(d.layers.analyzedLayers) == 1 %when gui is run first time
    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','RunAnalysis');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', [1 1 1]);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontWeight', 'bold');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'ForegroundColor', [1 0 0]);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontSize', 12);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', 'Analyzing');

    gif = sprintf(['<html><img src="file:/%s\\Spinner@1x-1.0s-50px-50px.gif" ' 'width="40" height="40"></html>'], pwd);
    loadingGraphics = uicontrol('style','push', 'pos',[540 168 40 40], 'String',gif,'enable','inactive','CData',uint8(153*ones(40,40,3))); % Use an inactive (not disabled) pushbutton to display the gif. Use CData instead of background color to flatten.

    pause(0.5);
    UpdateProgressbar(d,'progressbar_primary', [0 0 1], 1/totalAnalysisSteps);

    d.PSNR = CalculatePSNR_C2S(d);
    d.Values.TBDynamic(1).String = num2str(size(d.PSNR,2));


    deltaff = RunDff_C2S(d);
    d.Values.TBDynamic(5).String = num2str(size(deltaff,1));
    UpdateProgressbar(d,'progressbar_primary', [0 0 1], 2/totalAnalysisSteps);

    populationSpikeMatrix = GenerateBinarySpikeMatrixByOASIS_C2S(d,deltaff);
    [xCoord,yCoord] = Suite2pRoiCoordinateExporter_C2S(d);
    UpdateProgressbar(d,'progressbar_primary', [0 0 1], 3/totalAnalysisSteps);

    cd(d.saveAnalyzedData)
    cd('AnalyzedCalciumToSpikeData')
    dateTimeStamp = datetime('now');
    save(strcat('C2S_AnalyzedData_L',num2str(d.layers.currentLayer),'.mat'),'deltaff','populationSpikeMatrix','xCoord','yCoord','dateTimeStamp')

    pause(0.5)
    delete(loadingGraphics)

    cd(d.originalCodePath)
    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','RunAnalysis');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', [1 1 1]);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontWeight', 'bold');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontSize', 12);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', 'Finished');
    d = ToLog(d, "Analysis successful! Data Saved.");

    d.layers.analyzedLayers = [d.layers.analyzedLayers,d.layers.currentLayer];
    d.Values.TBDynamic(6).String = num2str(d.layers.analyzedLayers);

elseif ismember(d.layers.analyzedLayers,d.layers.currentLayer) ~= 1 %means gui already run but layer not yet analyzed
    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','RunAnalysis');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', [1 1 1]);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontWeight', 'bold');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'ForegroundColor', [1 0 0]);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontSize', 12);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', 'Analyzing');

    gif = sprintf(['<html><img src="file:/%s\\Spinner@1x-1.0s-50px-50px.gif" ' 'width="40" height="40"></html>'], pwd);
    loadingGraphics = uicontrol('style','push', 'pos',[540 168 40 40], 'String',gif,'enable','inactive','CData',uint8(153*ones(40,40,3))); % Use an inactive (not disabled) pushbutton to display the gif. Use CData instead of background color to flatten.

    pause(0.5);
    UpdateProgressbar(d,'progressbar_primary', [0 0 1], 1/totalAnalysisSteps);

    d.PSNR = CalculatePSNR_C2S(d);
    d.Values.TBDynamic(1).String = num2str(size(d.PSNR,2));


    deltaff = RunDff_C2S(d);
    d.Values.TBDynamic(5).String = num2str(size(deltaff,1));
    UpdateProgressbar(d,'progressbar_primary', [0 0 1], 2/totalAnalysisSteps);

    populationSpikeMatrix = GenerateBinarySpikeMatrixByOASIS_C2S(d,deltaff);
    [xCoord,yCoord] = Suite2pRoiCoordinateExporter_C2S(d);
    UpdateProgressbar(d,'progressbar_primary', [0 0 1], 3/totalAnalysisSteps);

    cd(d.saveAnalyzedData)
    cd('AnalyzedCalciumToSpikeData')
    dateTimeStamp = datetime('now');
    save(strcat('C2S_AnalyzedData_L',num2str(d.layers.currentLayer),'.mat'),'deltaff','populationSpikeMatrix','xCoord','yCoord','dateTimeStamp')

    pause(0.5)
    delete(loadingGraphics)

    cd(d.originalCodePath)
    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','RunAnalysis');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', [1 1 1]);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontWeight', 'bold');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontSize', 12);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', 'Finished');
    d = ToLog(d, "Analysis successful! Data Saved.");

    d.layers.analyzedLayers = [d.layers.analyzedLayers,d.layers.currentLayer];
    d.Values.TBDynamic(6).String = num2str(d.layers.analyzedLayers);
    
else %means layer is already analyzed
    d = ToError(d, " Layer already analyzed!!");
    d = UpdateCheckmark_C2S(d,'layerselected', 0);
    UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
        'ForegroundColor',[0.64 0.08 0.18]);
    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','FallSelection');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
    d.Values.TBDynamic(3).String = num2str(d.layers.currentLayer);

end


guidata(d.source, d);