function callback_suite2pFallSelection_C2S(hO, ed)

figureCalcium2Spike_GUI = ancestor(hO,'figure');      % get figure that owns guidata
d = guidata(hO);

try

    gif = sprintf('<html><img src="file:/%s\\spinner.gif"/></html>',pwd); % Path to the animation file (must be the same size or smaller than the next uicontrol), hmtl code to display image.
    loadingGraphics = uicontrol('style','push', 'pos',[300 10 35 35], 'String',gif,'enable','inactive','CData',uint8(255*ones(35,35,3))); % Use an inactive (not disabled) pushbutton to display the gif. Use CData instead of background color to flatten.
    loadingGraphics.Position = [290 258 30 30];
    pause(0.5)

    [fileName, FallDataLocation] = uigetfile('*.mat','Please select the correct Fall.mat file','C:\Users\abhrajyoti.chakrabarti\Desktop\testNewGUI\');
    d.FallFilename = fileName;

    tempVar= load(strcat(FallDataLocation,fileName));

    if isfield(tempVar, 'isCell') == 1
        d.Values.TBDynamic(4).String = 'isCell, OK';
    else
        % gif = sprintf('<html><img src="file:/%s\\spinner.gif"/></html>',pwd); % Path to the animation file (must be the same size or smaller than the next uicontrol), hmtl code to display image.
        % loadingGraphics = uicontrol('style','push', 'pos',[300 10 35 35], 'String',gif,'enable','inactive','CData',uint8(255*ones(35,35,3))); % Use an inactive (not disabled) pushbutton to display the gif. Use CData instead of background color to flatten.
        % loadingGraphics.Position = [290 258 30 30];
        % pause(0.5)
        RENAMEiscellTOisCell_C2S(fileName, FallDataLocation);
        pause(0.5)
        % delete(loadingGraphics)
        d.Values.TBDynamic(4).String = 'iscell -> isCell, OK';
        cd(d.originalCodePath)
    end

    if fileName ~= 0
        d.FallDataPath = FallDataLocation;
        d = UpdateCheckmark_C2S(d,'fallfileselected', 1);
        d = ToError(d, " No errors");
        UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
            'ForegroundColor',[0.64 0.08 0.18]);
        d = ToLog(d, "Fall.mat successfully selected");

        childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','RunAnalysis');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'on');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', [0.5 1 0.5]);
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'ForegroundColor', [0 0 0]);
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontWeight', 'bold');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontSize', 12);
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', 'Run analysis');

    else
        d = ToError(d, " Fall.mat selection interrupted");
        d = UpdateCheckmark_C2S(d,'fallfileselected', 0);
        UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
            'ForegroundColor',[0.64 0.08 0.18]);
        childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','RunAnalysis');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', 'white');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontWeight', 'normal');
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontSize', 10);
        UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', 'Run analysis');
    end

    delete(loadingGraphics)

catch
    delete(loadingGraphics)
    d = ToError(d, " Fall.mat selection interrupted");
    d = UpdateCheckmark_C2S(d,'fallfileselected', 0);
    UISet_C2S(d.GUI.errorConsole, 'String', d.errors.latestReturned,...
        'ForegroundColor',[0.64 0.08 0.18]);
    childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','RunAnalysis');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'Enable', 'off');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'BackgroundColor', 'white');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontWeight', 'normal');
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'FontSize', 10);
    UISet_C2S(d.source.Children(childrenArray(1)).Children(childrenArray(2)), 'String', 'Run analysis');
end

guidata(d.source, d);