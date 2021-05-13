function results = getTestResults(testParams, threshold)
%	@func   getTestResults(testParams, threshold)
%	@author @sercanaygun, @savasokyay
%	@date 	2020.06.26
%	@brief 	Performance evaluation metrics during runtime.
%	@prerq  testParams must have been run with code, and the raw results matrices should be inside it.
%	@input  testParams: struct containing specially raw prediction results
%           threshold : evaluation threshold
%	@output results:    struct containing error & performance metrics
%

actuRaw = testParams.ActualResultsofIndices;
actuThr = actuRaw;
actuThr(find(actuRaw<threshold)) = 0;  %negatives
actuThr(find(actuRaw>=threshold)) = 1; %positives

for eq = 1:length(testParams.equationParams)
    results(eq).equationName      = testParams.equationParams(eq).equationName;
    results(eq).abbreviation      = testParams.equationParams(eq).abbreviation;
    results(eq).sigWeCoRatedCount = testParams.equationParams(eq).sigWeCoRatedCount;
    for index = 1 : length(testParams.equationParams(eq).results)
        
        calcRaw = testParams.equationParams(eq).results(index).CalculatedRawResults;      
        calcInt = round(calcRaw);
        calcInt(find(calcRaw>max(max(actuRaw)))) = max(max(actuRaw));
        calcInt(find(calcRaw<min(min(actuRaw)))) = min(min(actuRaw));       
        calcThr = calcRaw;
        calcThr(find(calcRaw<threshold)) = 0;
        calcThr(find(calcRaw>=threshold)) = 1;
        
        TP = length(intersect(find(actuThr==1),find(calcThr==1)));  %True Positive
        TN = length(intersect(find(actuThr==0),find(calcThr==0)));  %True Negative
        FN = length(intersect(find(actuThr==1),find(calcThr==0)));  %False Negative
        FP = length(intersect(find(actuThr==0),find(calcThr==1)));  %False Positive
        er = (size(actuRaw,1)*size(actuRaw,2))-(TP + TN + FP + FN); %error (possibly NaNs)
        OK = length(find((actuRaw-calcInt)==0));                    %exact match
        
        resultsEq(index).BestNeighborsCount       = testParams.equationParams(eq).results(index).bestNeighborCount;
        resultsEq(index).Coverage                 = getCoverage(calcRaw);
        resultsEq(index).MAEraw                   = getMAE(actuRaw, calcRaw);
        resultsEq(index).MAEint                   = getMAE(actuRaw, calcInt);      
        resultsEq(index).MAEthr                   = getMAE(actuThr, calcThr);
        resultsEq(index).MSEraw                   = getMSE(actuRaw, calcRaw);
        resultsEq(index).MSEint                   = getMSE(actuRaw, calcInt);      
        resultsEq(index).MSEthr                   = getMSE(actuThr, calcThr);
        resultsEq(index).RMSEraw                  = sqrt(resultsEq(index).MSEraw);
        resultsEq(index).RMSEint                  = sqrt(resultsEq(index).MSEint );
        resultsEq(index).RMSEthr                  = sqrt(resultsEq(index).MSEthr);
        resultsEq(index).AccuracyExact            = OK / (TP + TN + FP + FN);        %NaNs are not included!
        resultsEq(index).AccuracyThreshold        = (TP + TN) / (TP + TN + FP + FN); %NaNs are not included!
        resultsEq(index).Precision                = TP / (TP + FP);
        resultsEq(index).InversePrecision         = TN / (TN + FN);
        resultsEq(index).SensitivityRecall        = TP / (TP + FN);
        resultsEq(index).Spesificity              = TN / (FP + TN);
        resultsEq(index).Fallout                  = FP / (FP + TN);         %FP rate
        resultsEq(index).MissRate                 = FN / (TP + FN);         %FN rate
        resultsEq(index).F1Measure                = 2 * TP / (2 * TP + FP + FN);
        resultsEq(index).FalseDiscoveryRate       = FP / (FP + TP);
        resultsEq(index).FalseOmissionRate        = FN / (FN + TN);       
        resultsEq(index).PrevalenceThreshold      = (sqrt(resultsEq(index).SensitivityRecall * (1-resultsEq(index).Spesificity)) + resultsEq(index).Spesificity - 1) / (resultsEq(index).SensitivityRecall + resultsEq(index).Spesificity - 1);
        resultsEq(index).ThreatScore              = TP / (TP + FN + FP);
        resultsEq(index).BalancedAccuracy         = (resultsEq(index).SensitivityRecall + resultsEq(index).Spesificity) / 2;
        resultsEq(index).Markedness               = resultsEq(index).Precision + resultsEq(index).InversePrecision - 1;
        resultsEq(index).Informedness             = resultsEq(index).SensitivityRecall + resultsEq(index).Spesificity -1;
        resultsEq(index).MatthewsCorrelation      = sqrt(resultsEq(index).Markedness * resultsEq(index).Informedness);
        resultsEq(index).FowlkesMallowsIndex      = sqrt((TP / (TP + FP)) * (TP / (TP + FN)));
       
        resultsEq(index).TruePositive             = TP;
        resultsEq(index).TrueNegative             = TN;
        resultsEq(index).FalsePositive            = FP;
        resultsEq(index).FalseNegative            = FN;
        resultsEq(index).Error                    = er;
        resultsEq(index).ExactPrediction          = OK;
    end %end of for bestNeighborCount
    
    results(eq).statistics = resultsEq;
    
end %end of for simEquations

end %end of function