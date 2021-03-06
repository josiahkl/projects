function s_els_merge_ains_rois
% merges two mat rois, saves as single mat roi

datapath = '/media/lcne/matproc';

subjects = {'els137-Tmid','els144-Tmid','els145-Tmid','els146-Tmid','els152-Tmid','els159x-Tmid','els172-Tmid', ...
            'els214-Tmid','els302-TK1','els303-TK1','els305-TK1','els307-TK1', ...
            'els311-TK1','els312-TK1','els315-TK1','els318-TK1'};
%'els193x-Tmid','els307x-TK1'

hemis = {'lh','rh'};

for isubj = 1:length(subjects)
    roiPath = fullfile(datapath,subjects{isubj},'ROIs');
    for hemi = 1:length(hemis)
        roi1name = [hemis{hemi} '_antins_a2009s_fd.mat'];
        roi2name = [hemis{hemi} '_shortins_a2009s_fd.mat'];
        roi1    = dtiReadRoi(fullfile(roiPath, roi1name));
        roi2    = dtiReadRoi(fullfile(roiPath, roi2name));
        newRoiName = fullfile(roiPath,[hemis{hemi} '_antshortins_fd.mat']);
        newRoi     = dtiMergeROIs(roi1,roi2);
        dtiWriteRoi(newRoi, newRoiName)
    end
end