function callback_PoolData_C2S(hO, ed)

figureCalcium2Spike_GUI = ancestor(hO,'figure');      % get figure that owns guidata
d = guidata(hO);

cd(strcat(d.saveAnalyzedData,'\AnalyzedCalciumToSpikeData'))

analyzedFiles = dir('*.mat');


for layerIndex = 1:size(analyzedFiles,1)
        
    load(analyzedFiles(layerIndex).name)
    
    spikeData(layerIndex).layer = populationSpikeMatrix;
    dffData(layerIndex).layer = deltaff;

    roiCoordData(layerIndex,1).layer = xCoord;
    roiCoordData(layerIndex,2).layer = yCoord;

    clear populationSpikeMatrix deltaff xCoord yCoord
    
end

dateTimeStamp = datetime('now');

layerWiseData.dff = dffData;
layerWiseData.spike = spikeData;
layerWiseData.roi = roiCoordData;

stackedLayerData.dff = vertcat(dffData(:).layer);
stackedLayerData.spike = vertcat(spikeData(:).layer);
stackedLayerData.roi = [horzcat(roiCoordData(:,1).layer); horzcat(roiCoordData(:,2).layer);];


save('layerWiseData.mat','layerWiseData','dateTimeStamp')
save('stackedlayerData.mat','stackedLayerData','dateTimeStamp')
cd(d.originalCodePath)

childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','PoolData');
UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', [0 1 1]);
UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'ForegroundColor', [0 0 0]);
UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', 'Data Pooled');
UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
