function ParamsHandle = DrawValues_C2S()
%this function creates the Values panel which is populated as data is being
%loaded/calculated
source = findobj('Name', 'Calcium2Spike_GUI');
d = guidata(source);

ParamsHandle = uipanel('Title','Parameters',...
    'Position',[0.506300546448087,0.545,0.439111566484518,0.25],'BackgroundColor','w');

%highlight the MESc params
MESc_paramsHeader = GenericTextBox(ParamsHandle);
UISet_C2S(MESc_paramsHeader, 'Position', [0.01, 0.63, 0.98, 0.35]);
UISet_C2S(MESc_paramsHeader, 'BackGroundColor', [0.75 0.75 0.75]);

%highlight the suite2p Fall.mat params
suite2pFall_paramsHeader = GenericTextBox(ParamsHandle);
UISet_C2S(suite2pFall_paramsHeader, 'Position', [0.01, 0.05, 0.98, 0.55]);
UISet_C2S(suite2pFall_paramsHeader, 'BackGroundColor', [0.75 0.75 0.75]);

%static part
TB_leftMargin = 0.017;
bottomMargin = 0.83;

TB_width = 0.5;
TBdynamic_leftMargin = TB_leftMargin + TB_width + 0.083;

infoList = {'Current layer ROIs detected','MESc framerate','Current layer',...
        'Fall iscell variable status','ROIs passing PSNR filter',...
        'Already analyzed layers'};

height = 0.8/numel(infoList);
stepdown = height;

for infoListIndex = 1:numel(infoList)

    if infoListIndex < 3
        fromBottom = bottomMargin - stepdown*(infoListIndex - 1);


        TBStatic(infoListIndex) = GenericTextBox(ParamsHandle);
        UISet_C2S(TBStatic(infoListIndex), 'Position',[TB_leftMargin, fromBottom,...
            TB_width, height]);
        UISet_C2S(TBStatic(infoListIndex), 'String',[infoList{infoListIndex},': ']);
        UISet_C2S(TBStatic(infoListIndex), 'HorizontalAlignment','Left');
        UISet_C2S(TBStatic(infoListIndex), 'BackgroundColor',[0.75 0.75 0.75]);
        UISet_C2S(TBStatic(infoListIndex), 'FontSize',8);


        TBDynamic(infoListIndex) = GenericTextBox(ParamsHandle);
        UISet_C2S(TBDynamic(infoListIndex), 'Position',[TBdynamic_leftMargin, fromBottom,...
            TB_width-0.3, height]);
        UISet_C2S(TBDynamic(infoListIndex), 'HorizontalAlignment','Left');
        UISet_C2S(TBDynamic(infoListIndex), 'BackgroundColor',[0.75 0.75 0.75]);
        UISet_C2S(TBDynamic(infoListIndex), 'Tag', infoList{infoListIndex});
        UISet_C2S(TBDynamic(infoListIndex), 'String','--');
        UISet_C2S(TBDynamic(infoListIndex), 'FontSize',8);

    elseif infoListIndex == 3
        fromBottom = bottomMargin - stepdown*(infoListIndex - 1) - 0.1;


        TBStatic(infoListIndex) = GenericTextBox(ParamsHandle);
        UISet_C2S(TBStatic(infoListIndex), 'Position',[TB_leftMargin, fromBottom,...
            TB_width, height]);
        UISet_C2S(TBStatic(infoListIndex), 'String',[infoList{infoListIndex},': ']);
        UISet_C2S(TBStatic(infoListIndex), 'HorizontalAlignment','Left');
        UISet_C2S(TBStatic(infoListIndex), 'BackgroundColor',[0.75 0.75 0.75]);
        UISet_C2S(TBStatic(infoListIndex), 'FontSize',8);

        TBDynamic(infoListIndex) = GenericTextBox(ParamsHandle);
        UISet_C2S(TBDynamic(infoListIndex), 'Position',[TBdynamic_leftMargin, fromBottom,...
            TB_width-0.3, height]);
        UISet_C2S(TBDynamic(infoListIndex), 'HorizontalAlignment','Left');
        UISet_C2S(TBDynamic(infoListIndex), 'BackgroundColor',[0.75 0.75 0.75]);
        UISet_C2S(TBDynamic(infoListIndex), 'Tag', infoList{infoListIndex});
        UISet_C2S(TBDynamic(infoListIndex), 'String','--');
        UISet_C2S(TBDynamic(infoListIndex), 'Fontsize',8);
        

    elseif infoListIndex > 3
        fromBottom = bottomMargin - stepdown*(infoListIndex - 1) - 0.1;


        TBStatic(infoListIndex) = GenericTextBox(ParamsHandle);
        UISet_C2S(TBStatic(infoListIndex), 'Position',[TB_leftMargin, fromBottom,...
            TB_width, height]);
        UISet_C2S(TBStatic(infoListIndex), 'String',[infoList{infoListIndex},': ']);
        UISet_C2S(TBStatic(infoListIndex), 'HorizontalAlignment','Left');
        UISet_C2S(TBStatic(infoListIndex), 'BackgroundColor',[0.75 0.75 0.75]);
        UISet_C2S(TBStatic(infoListIndex), 'FontSize',8);

        TBDynamic(infoListIndex) = GenericTextBox(ParamsHandle);
        UISet_C2S(TBDynamic(infoListIndex), 'Position',[TBdynamic_leftMargin, fromBottom,...
            TB_width-0.2, height]);
        UISet_C2S(TBDynamic(infoListIndex), 'HorizontalAlignment','Left');
        UISet_C2S(TBDynamic(infoListIndex), 'BackgroundColor',[0.75 0.75 0.75]);
        UISet_C2S(TBDynamic(infoListIndex), 'Tag', infoList{infoListIndex});
        UISet_C2S(TBDynamic(infoListIndex), 'String','--');
        UISet_C2S(TBDynamic(infoListIndex), 'Fontsize',8);
        
    end
    
    
end
d.Values.tagList = infoList;
d.Values.TBDynamic = TBDynamic;

guidata(d.source, d);