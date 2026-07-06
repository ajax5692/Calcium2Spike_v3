function callback_suite2pLayerSelection_C2S(hO, ed)

% figureCalcium2Spike_GUI = ancestor(hO,'figure');      % get figure that owns guidata
d = guidata(hO);

childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','LayerSelectionDD');
DD_value = d.source.Children(childrenArray(1)).Children(childrenArray(2)).Value;

if DD_value ~= 1
    d.layers.currentLayer = DD_value - 1;
    if isempty(d.layers.analyzedLayers) == 1 %when gui is run first time
        d = UpdateCheckmark_C2S(d,'layerselected', 1);
        d = ToError(d, " No errors");
        UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
            'ForegroundColor',[0.64 0.08 0.18]);
        d = ToLog(d, "Layer successfully selected");

        childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','FallSelection');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'on');
        d.Values.TBDynamic(3).String = num2str(d.layers.currentLayer);

    else %if gui was already running before, check if data was already analyzed
        if ismember(d.layers.analyzedLayers,d.layers.currentLayer) ~= 1 %means layer not yet analyzed
            d.layers.currentLayer = DD_value - 1;
            d = UpdateCheckmark_C2S(d,'layerselected', 1);
            d = UpdateCheckmark_C2S(d,'fallfileselected', 0);
            d = ToError(d, " No errors");
            UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
                'ForegroundColor',[0.64 0.08 0.18]);
            d = ToLog(d, "Layer successfully selected");

            childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','FallSelection');
            UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'on');
            % d.layers.analyzedLayers = [d.layers.analyzedLayers,d.layers.currentLayer];
            % d.Values.TBDynamic(6).String = num2str(d.layers.analyzedLayers);
            d.Values.TBDynamic(3).String = num2str(d.layers.currentLayer);

        else %means layer is already analyzed
            d = ToError(d, " Layer already analyzed!!");
            d = UpdateCheckmark_C2S(d,'layerselected', 0);
            d = UpdateCheckmark_C2S(d,'fallfileselected', 0);
            UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
                'ForegroundColor',[0.64 0.08 0.18]);
            childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','FallSelection');
            UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');

            childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','RunAnalysis');
            UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
            UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', [1 1 1]);
            UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', 'Finished');
            UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontWeight', 'normal');
            UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontSize', 10);

            d.Values.TBDynamic(3).String = num2str(d.layers.currentLayer);
        end
    end
else %user selected the incorrect DD option ('Select layer')
    d = ToError(d, " Please select a correct layer!");
    d = UpdateCheckmark_C2S(d,'layerselected', 0);
    d = UpdateCheckmark_C2S(d,'fallfileselected', 0);
    UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
        'ForegroundColor',[0.64 0.08 0.18]);
    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','FallSelection');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
    d.Values.TBDynamic(3).String = '--';

    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','RunAnalysis');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', [1 1 1]);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', 'Run analysis');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontWeight', 'normal');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontSize', 10);
end

guidata(d.source, d);