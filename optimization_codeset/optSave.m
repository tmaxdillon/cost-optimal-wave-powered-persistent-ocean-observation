function [] = optSave(prepath,name,batchtype,batchscen, ...
    batchloc,batchc)

optScript

if exist('s1','var') %save multiple structures
    save([prepath name '.mat'],'wiv','wcm','whl','ild','osv', ...
        'sdr','utp','bhc','dep','dtc','lft','spv', ...
        'tmt','bcc','bbt','eol','s0','-v7.3')
else %save single structure
    if exist('multStruct','var')
        stru.(name) = multStruct;
    elseif exist('allLocUses','var')
        stru.(name) = allLocUses;
    elseif exist('allScenUses','var')
        stru.(name) = allScenUses;
    else
        stru.(name) = optStruct;
    end
    save([prepath name '.mat'], '-struct','stru','-v7.3')
end

end

