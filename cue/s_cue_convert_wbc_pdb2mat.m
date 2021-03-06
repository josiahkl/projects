function s_cue_convert_wbc_pdb2mat

%script to convert wbc.pdb to wbc.mat
%

baseDir = '/media/lcne/matproc/';

subjects = {'hw161104','ph161104'};

%{
subjects = {'al151016','bb160402','bp160213','cs160214', ...
            'jc160320','jc160321','jg151121', ...
            'jv151030','jw160316', ...
            'pk160319','ps151001','rb160407','rf160313', ...
            'zl150930'
%}
        
for isubj = 1:length(subjects)
    
    subDir    = fullfile(baseDir, subjects{isubj});
    mrtrixDir = fullfile(subDir, 'dti96trilin/fibers/mrtrix');
    wbc_pdb   = dir(fullfile(mrtrixDir, ['*' 'lmax10_wmMask.nii_wmMask.nii_prob.pdb']));
    wbc       = fgRead(fullfile(mrtrixDir,wbc_pdb.name));
    saveDir   = fullfile(mrtrixDir, 'lmax10_wbc');
    fgWrite(wbc,saveDir,'mat');
    clear wbc
end