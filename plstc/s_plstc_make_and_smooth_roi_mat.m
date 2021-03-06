function s_plstc_make_and_smooth_roi_mat
%
% This script loads a NIFTI ROI, tranforms it into a mat ROI and 
% Applies some operations to it, such as smoothing, dilation and 
% removal of satellites.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

datapath = '/media/lcne/matproc';

subjects = {'ad082014_2','hm082514_2','ml082214_2', ...
            'ld080115_1','ld080115_2', ...
            'lp080215_1','lp080215_2', ...
            'lt081615_1','lt081615_2', ...
            'mm080915_1','mm080915_2', ...
            'nb081015_1','nb081015_2'};
%{
'ad082014_1','ad082014_2', ...
            'hm082514_1','hm082514_2', ...
            'ml082214_1','ml082214_2', ...
            'yw083014_1','yw083014_2'};
%}
rois = {'rh_nacc_aseg','lh_nacc_aseg', ...
        'rh_frontorb_a2009s','lh_frontorb_a2009s', ...
        'rh_frontinfang_a2009s','lh_frontinfang_a2009s', ...
        'rh_antins_a2009s','lh_antins_a2009s', ...
        'rh_shortins_a2009s','lh_shortins_a2009s', ...
        'rh_nacc_aseg','lh_nacc_aseg', ...
        'rh_latorb_a2009s','lh_latorb_a2009s', ...
        'rh_wmmask_fs','lh_wmmask_fs', ...
        'rh_supfront_a2009s','lh_supfront_a2009s', ...
        'rh_frontmidlat_a2009s','lh_frontmidlat_a2009s', ...
        'rh_ventraldc_aseg','lh_ventraldc_aseg'};
        
for isubj = 1:length(subjects)
    roiPath = fullfile(datapath, subjects{isubj}, 'ROIs');
    for iroi = 1:length(rois)
        roi = fullfile(roiPath, [rois{iroi} '.mat']);
        outRoi = fullfile(roiPath, [rois{iroi} '_fd.mat']);
        smoothKernel = 0; % size of the 3D smoothing Kernel in mm
        %operations   = ['fillholes', 'dilate', 'removesat']; 
        operations   = [1, 1, 0]; 

        % fillholes = fill any hole in the ROI. Pass '' to not apply this
        %             operation
        % dilate     = expand the ROI in 3D. Pass '' to not apply this
        %             operation
        % removesat  = remove any voxel disconnected from the rest of the voxels. 
        %              Pass '' to not apply this operation
    
        oldRoiLoad = dtiReadRoi(roi);
        newRoi = dtiRoiClean(oldRoiLoad, smoothKernel, operations);
        dtiWriteRoi(newRoi, outRoi);
    end
end