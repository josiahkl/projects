function s_cue_make_wmmask_fsseg
%
% This script makes the white-matter mask from freesurfer segmentation
% used to track the connectomes in Pestilli et al., LIFE paper.
%
% Copyright Franco Pestilli (c) Stanford University, 2014

% Get the base directory for the data
%baseDir    = '/media/storg/fsproc/acpc';
matProcDir = '/media/lcne/matproc';

subjects = {'ds170915','ts170927'};
%{
'ac160415','cm160510','ja160416','jr160507','mp160511','ps160508','rt160420','yl160507'
'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','tm161017','vm151031', ...
            'wr151127','zl150930','as160129','bp160213','cs160214','kl160122', ...
            'nb160221','rp160205','ss160205','wh160130'};
'rb160407','jn160403','bb160402','jc160321','jc160320','pk160319','jw160316', ...
            'rf160313'
'as160129','bp160213','cs160214','kl160122', ...
            'nb160221','rp160205','ss160205','wh160130', ...
'aa151010','ag151024','al151016','dw151003','ie151020','ja151218','jg151121', ...
            'jv151030','ps151001','si151120','sr151031','tf151127','vm151031', ...
            'wr151127','zl150930'
%}
        
for isubj = 1:length(subjects)
    %subjectFolder = fullfile(baseDir, subjects{isubj});
    %fsMriFolder = fullfile(subjectFolder, 'mri');
    matRoiFolder = fullfile(matProcDir,subjects{isubj},'ROIs');
     
    wmMaskFile = fullfile(matRoiFolder,'lh_wmmask_fs.nii.gz'); 
    [~,wmMaskFileName,~] = fileparts(wmMaskFile);
    wmMaskFileName = wmMaskFileName(1:end-4); %strip .nii after .gz
    
    fs_wm = matchfiles(fullfile(matRoiFolder,'a2009seg2acpc.nii.gz'));
        
    eval(sprintf('!mri_convert  --out_orientation RAS %s %s', fs_wm{1}, wmMaskFile));
    wm = niftiRead(wmMaskFile);
    invals = [16 2 10 11 12 13 26 28 11106 11107 11108 11109 11110 11113 11115 11116 11117 11118 11124 11139 11148 11149 11154 11155 11163 11164 11165];
    %lh 16 2 10 11 12 13 26 28 11106 11107 11108 11109 11110 11113 11115 11116 11117 11118 11124 11139 11148 11149 11154 11155 11163 11164 11165
    %rh 16 41 49 50 51 52 58 60 12106 12107 12108 12109 12110 12113 12115 12116 12117 12118 12124 12139 12148 12149 11154 12155 12163 12164 12165
    origvals = unique(wm.data(:));
    fprintf('\n[%s] Converting voxels... ',mfilename);
    wmCounter=0;noWMCounter=0;
    for ii = 1:length(origvals);
        if any(origvals(ii) == invals)
            wm.data( wm.data == origvals(ii) ) = 1;
            wmCounter=wmCounter+1;
        else            
            wm.data( wm.data == origvals(ii) ) = 0;
            noWMCounter = noWMCounter + 1;
        end
    end
    fprintf('converted %i regions to White-matter (%i regions left outside of WM)\n\n',wmCounter,noWMCounter);
    niftiWrite(wm);
    
    %convert nifti to mat    
    im=niftiRead(wmMaskFile);
    wmMaskRoiMat = fullfile(matRoiFolder,[wmMaskFileName, '.mat']);
    
    %now we want to convert the image to a list of coordinates in acpc space
    %find roi index locations
    ndx=find(im.data);
    
    %convert to ijk coords 
    [I J K]=ind2sub(size(im.data),ndx);
    
    %convert to acpc coords
    acpcCoords=mrAnatXformCoords(im.qto_xyz, [I J K]);
    
    %now put these coordinates into the mrDiffusion roi structure
    roi=dtiNewRoi(wmMaskRoiMat,'r',acpcCoords);
    
    %save out the roi 
    dtiWriteRoi(roi,wmMaskRoiMat);
    fprintf('\nwriting file %s\n',fullfile(wmMaskRoiMat));
end
end