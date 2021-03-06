% making afq subject dirs for AFQ_run
afq_dir = '/media/storg/matproc/';

subjects = {'03673/dti64trilin','07065/dti64trilin','07428/dti64trilin', ...
            '10339/dti64trilin','10981/dti64trilin','10984/dti64trilin', ...
            '11240/dti64trilin','12156/dti64trilin','12627/dti64trilin', ...
            '12671/dti64trilin','13106/dti64trilin','13733/dti64trilin', ...
            'ch101612/dti96trilin','dc050213/dti96trilin','dp092612/dti96trilin', ...
            'ec081912/dti96trilin','fg092712/dti96trilin','hg101012/dti96trilin', ...
            'jh042913/dti96trilin','jo081312/dti96trilin','jt062413/dti96trilin', ...
            'kr030113/dti96trilin','mk021913/dti96trilin','ml061013/dti96trilin', ...
            'pf020113/dti96trilin','ps022013/dti96trilin','pw060713/dti96trilin', ...
            'pw061113/dti96trilin','ra053013/dti96trilin','rb073112/dti96trilin', ...
            'rb082212/dti96trilin','sh010813/dti96trilin','sl080912/dti96trilin','tw062113/dti96trilin'};
        

subjects = {'mac03218_1/dti64trilin','mac03218_2/dti64trilin','mac12826_1/dti64trilin','mac12826_2/dti64trilin', ...
            'mac18000_1/dti64trilin','mac18000_2/dti64trilin'};        
        
afq_subs = strcat(afq_dir, subjects);

afq_group = repmat(0,1,length(subjects));         

AFQ_run(afq_subs, afq_group)