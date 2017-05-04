% Experiment demo for DukeReID dataset
% Write by Mengran Gou @ RSL, Northeastern U

%% data parsing
if ~exist('DukeReID_images.mat','file')
    run script_loadimage.m
end

%% setting
% load feature and partition
load('feature_DukeReID_LOMO_6patch.mat');
load('Partition_DukeReID.mat');
% set parameter for kLFDA
AlgoOption.dataname = 'DukeReID';
AlgoOption.epsilon =1e-4;
AlgoOption.npratio =0; % npratio is not required.
AlgoOption.beta =0.01;
AlgoOption.d =40;
AlgoOption.LocalScalingNeighbor =6; % local scaling affinity matrix parameter.
AlgoOption.kernel = 'linear'; 
% experiment setting
par = 'mixgal'; %'pairwise';'mixgal'
%% experiments
mAP = [];
szGal = [];
szProb = [];
rank = [];
switch par
    case 'mixgal'
        parset = 57:64;
    case 'pairwise'
        parset = 1:56;
    otherwise
        warning('Invalid partition setting, will run all experiments...')
        parset = 1:64;
end
for s = 1:numel(partition)
    idx_train = partition(s).idx_train;
    idx_test = partition(s).idx_test;
    idx_probe = partition(s).idx_probe;
    idx_gallery = partition(s).idx_gallery;
    idx_pos_pair = partition(s).ix_pos_pair;
    idx_neg_pair = partition(s).ix_neg_pair;    
    
    trainFeat = features(idx_train,:);
    ID_train = personID(idx_train);
    
    testFeat = features(idx_test,:);
    ID_test = personID(idx_test);
        
    % training
    [algo, ~]= LFDA(trainFeat,ID_train',AlgoOption);
    
    % testing
    K.kernel = algo.kernel;
    K.rbf_sigma = algo.rbf_sigma;
    testFeat = single(testFeat);
    % compute kernel
    [Ktest] = ComputeKernelTest(trainFeat, testFeat, K);
    testFeatProj = (algo.P*Ktest)'; % projection
    for pr = parset % loop over different partitions
        dis = [];
        probeFeat = testFeatProj(idx_probe(pr,:),:);
        probeID = ID_test(idx_probe(pr,:));                
        galleryFeat = testFeatProj(idx_gallery(pr,:),:);
        galleryID = ID_test(idx_gallery(pr,:));                
        dis = pdist2(probeFeat,galleryFeat,'euclidean');                
        [disSort,idxSort] = sort(dis,2,'ascend');
        IDsort = galleryID(idxSort);
        tmpRank = bsxfun(@eq, IDsort, probeID');
        Res_match{s,pr} = tmpRank;
        % compute AP (average precision)
        firstOcc = [];
        AP = [];
        for p = 1:size(tmpRank,1)
            tmpR = tmpRank(p,:);
            firstOcc(p) = min(find(tmpR));
            AP(p) = compute_AP(find(tmpR),1:numel(tmpR));
        end
        tmpRank = hist(firstOcc,1:max(sum(idx_gallery,2)));
        mAP = [mAP; mean(AP)];
        szGal = [szGal;numel(galleryID)];
        szProb = [szProb;numel(probeID)];
        tmpRank = cumsum(tmpRank)./sum(idx_probe(pr,:));
        disp(tmpRank([1 5 10 20])*100);
        rank = [rank; tmpRank];
    end
end

metric.mAP = mAP;
metric.szGal = szGal;
metric.szProb = szProb;
metric.rank = rank;
metric.cam_pair = partition.cam_pairs;
rank = bsxfun(@times,rank,szProb);
rank = sum(rank,1)./sum(szProb)*100;
mAP = sum(mAP.*szProb)/sum(szProb)*100;
fprintf('Average accuarcy for all partitions are:\nr1---%.1f\tr5---%.1f\tr10---%.1f\tr20---%.1f\n',...
        rank(1),rank(5),rank(10),rank(20));
fprintf('mAP:%.1f\n',mAP)


