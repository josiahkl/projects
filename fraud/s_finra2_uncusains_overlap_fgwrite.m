function s_finra2_uncusains_overlap_fgwrite
%script to cleaning fiber group outliers (posterior insula - nacc)

baseDir = '/media/storg/matproc/';

subjects = {'ab071412','bc050913','ch101612','cs050813', ...
            'dc050213','dp092612','ds080712','ec081912','en062813','fg092712', ...
            'gr051513','hg101012','hm062513','jh042913','jl071912','jo081312', ...
            'jt062413','jw072512','kr030113','lc052213','lf052813','lw061713', ...
            'md072512','mk021913','ml061013','mn052313','ms082112','na060213', ...
            'np072412','pf020113','pl061413','ps022013','pw060713','pw061113', ...
            'ra053013','rb073112','rb082212','sd040313','sh010813','sl080912', ...
            'sn061213','sp061313','tr101312','tw062113','vv060313','wb071812'};
        
for isubj = 1:length(subjects)
    afq_wd = ['/media/storg/matproc/' subjects{isubj} '/dti96trilin/fibers/afq'];
    mrtrix_wd = ['/media/storg/matproc/' subjects{isubj} '/dti96trilin/fibers/mrtrix'];
    
    %left hemisphere
    %load tracts
    lh_uncus = fullfile(afq_wd, 'l_uncinate_lmax10.mat');
    lhuncus = fgRead(lh_uncus);
    lh_insula = fullfile(mrtrix_wd,'clean_lh_antshortins_nacc.mat');
    lhinsula = fgRead(lh_insula);
    lcoordsTract = fgGet(lhinsula, 'unique image coords');
    lcoordsUncinate = fgGet(lhuncus, 'unique image coords');
   
    %make uncus ROI
    luncusroi = dtiNewRoi('luncusroi');
    luncusroi.coords = lcoordsUncinate;
    [lainsnotuncus, indicesLainsnacc] = feSegmentFascicleFromConnectome(lhinsula, {luncusroi}, {'not'}, 'lainsnacc not in luncus');
    %lwrite fiber
    fgWrite(lainsnotuncus, [mrtrix_wd '/notuncus_lh_ains_nacc'],'mat');
    
    %right hemisphere
    %load tracts
    rh_uncus = fullfile(afq_wd, 'r_uncinate_lmax10.mat');
    rhuncus = fgRead(rh_uncus);
    rh_insula = fullfile(mrtrix_wd,'clean_rh_antshortins_nacc.mat');
    rhinsula = fgRead(rh_insula);
    rcoordsTract = fgGet(rhinsula, 'unique image coords');
    rcoordsUncinate = fgGet(rhuncus, 'unique image coords');
        
    %make uncus ROI
    runcusroi = dtiNewRoi('runcusroi');
    runcusroi.coords = rcoordsUncinate;
    [rainsnotuncus, indicesRainsnacc] = feSegmentFascicleFromConnectome(rhinsula, {runcusroi}, {'not'}, 'rainsnacc not in runcus');
    %lwrite fiber
    fgWrite(rainsnotuncus, [mrtrix_wd '/notuncus_rh_ains_nacc'],'mat');
end