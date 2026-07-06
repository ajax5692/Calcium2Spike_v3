function callback_PoolDataCheckBox_C2S(hO, ed)

figureCalcium2Spike_GUI = ancestor(hO,'figure');      % get figure that owns guidata
d = guidata(hO);

childrenArray = GUI_childrenFinder_C2S(d,'Layer-wise analysis','ReadyToPool');

if d.source.Children(childrenArray(1)).Children(childrenArray(2)).Value == 1
    childrenArray2 = GUI_childrenFinder_C2S(d,'Layer-wise analysis','PoolData');
    UISet_C2S(d.source.Children(childrenArray2(1)).Children(childrenArray2(2)), 'Enable', 'on');
    UISet_C2S(d.source.Children(childrenArray2(1)).Children(childrenArray2(2)), 'BackgroundColor', [0 0 1]);
    UISet_C2S(d.source.Children(childrenArray2(1)).Children(childrenArray2(2)), 'ForegroundColor', [1 1 1]);
    UISet_C2S(d.source.Children(childrenArray2(1)).Children(childrenArray2(2)), 'FontWeight', 'bold');
    UISet_C2S(d.source.Children(childrenArray2(1)).Children(childrenArray2(2)), 'String', 'Pool Data');
else
    childrenArray2 = GUI_childrenFinder_C2S(d,'Layer-wise analysis','PoolData');
    UISet_C2S(d.source.Children(childrenArray2(1)).Children(childrenArray2(2)), 'Enable', 'off');
    UISet_C2S(d.source.Children(childrenArray2(1)).Children(childrenArray2(2)), 'BackgroundColor', [1 1 1]);
    UISet_C2S(d.source.Children(childrenArray2(1)).Children(childrenArray2(2)), 'ForegroundColor', [0 0 0]);
    UISet_C2S(d.source.Children(childrenArray2(1)).Children(childrenArray2(2)), 'FontWeight', 'normal');
    UISet_C2S(d.source.Children(childrenArray2(1)).Children(childrenArray2(2)), 'String', 'Pool Data');
end