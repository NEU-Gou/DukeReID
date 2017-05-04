clc
clear 
%%
folder = 'ReID';
[~,caminfo,] = folderList(folder);
imgs = {};
personID = [];
camID = [];
impath = {};
cnt = 1;


for c = 1:numel(caminfo)
    fprintf('Parsing camera %d...\n',c);
    camID_tmp = str2num(caminfo{c}(end));
    [~,persons,~] = folderList(fullfile(folder,caminfo{c}));
    for p = 1:numel(persons)
        iminfo = dir(fullfile(folder,caminfo{c},persons{p},'*.jpg'));
        for i = 1:numel(iminfo)
            impath_tmp = fullfile(folder,caminfo{c},persons{p},iminfo(i).name);
            tmpim = imread(impath_tmp);
            imgs{cnt} = tmpim;
            personID(cnt) = str2num(persons{p});
            camID(cnt) = camID_tmp;
            impath{cnt} = impath_tmp;
            cnt = cnt + 1;
        end
    end
end
           
save('DukeReID_images.mat','imgs','personID','camID','impath','-v7.3');
