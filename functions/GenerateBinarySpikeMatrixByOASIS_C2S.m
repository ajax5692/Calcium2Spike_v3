function populationSpikeMatrix = GenerateBinarySpikeMatrixByOASIS_C2S(d,deltaff)

%GenerateSpikeProbabilityAndBinaryMatrixByOASIS
%This function takes in the df/f values and evaluates the spike
%probabilities based on the OASIS module and the generates a binary 1/0
%matrix corresponding to the spikes.

childrenArray = GUI_childrenFinder_C2S(d,'','secondaryPBconsole');
totalCells = size(deltaff,1);
oasis_setup

for cellIndex = 1:totalCells

    d.source.Children(childrenArray).String = 'Step 3/3: OASIS';
    UpdateProgressbar(d,'progressbar_secondary', [1 0 0], cellIndex/totalCells);
    pause(0.05)
    
    [c, s, options] = deconvolveCa(deltaff(cellIndex,:), 'thresholded', 'ar1', 'smin', -3, 'optimize_pars', true, 'optimize_b', true);
    
    populationSpikeProbability(cellIndex,:) = s;
    
    clear c s options
                
end


%Generate 1/0 spike matrix for the population

for cellIndex = 1:size(populationSpikeProbability,1)
    
    for frameIndex = 1:size(populationSpikeProbability,2)
        
        if populationSpikeProbability(cellIndex,frameIndex) > 0
            
            populationSpikeMatrix(cellIndex,frameIndex) = 1;
                
        else
                
            populationSpikeMatrix(cellIndex,frameIndex) = 0;
                
        end
    end
end