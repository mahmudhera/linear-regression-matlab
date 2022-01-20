% Load a dataset functions
%  Choices are dataset to use (choices wine, wallpaper, taiji, face) 

function [train_featureVector, train_labels, test_featureVector, test_labels ] =  loadDataset(dataset)

switch lower(dataset)
        
    case 'wallpaper'
        %%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Load the wallpaper dataset
        %   17 classes
        %   100 images per class
        %   500 features per image.
        load('./data/Wallpaper/Wallpaper_Dataset.mat')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    case 'taiji'
        %%
        load('./data/Taiji/all_labels.mat')
        load('./data/Taiji/all_playerIdx.mat')
        load('./data/Taiji/all_quaternions.mat')
        
        % Combine repeated positions
        all_labels(all_labels==4) = 2;
        all_labels(all_labels==8) = 6;
        % Get rid of static dimensions
        feature_mask = var(all_quaternions,[],2)~=0;
        
        playerIdx = 3;
        train_mask = all_playerIdx ~= playerIdx;

        train_featureVector  = all_quaternions(feature_mask,train_mask)';
        train_labels  = categorical(all_labels(train_mask)');
        test_featureVector  = all_quaternions(feature_mask,~train_mask)';
        test_labels  =  categorical(all_labels(~train_mask)');
    otherwise
        error('Dataset not implemented.  Make sure you are spelling it right.')
end

assert(size(train_featureVector,2)==size(test_featureVector,2)...
    ,'feture vector lengths.  They are not equal between training and testing datasets.')
assert(size(train_featureVector,1)==length(train_labels)...
    ,'training features and training labels.  They have to have the same number of observations.')
assert(size(test_featureVector,1)==length(test_labels)...
    ,'testing features and training labels.  They have to have the same number of observations.')

fprintf('Dataset Loaded: %s\n', dataset);
fprintf('\t# of Classes: %d\n', length(unique(train_labels)));
fprintf('\t# of Features: %d\n', size(train_featureVector,2));
fprintf('\t# of Training Observations: %d\n', length(train_labels));
fprintf('\t# per class in train dataset:\n');
summary(train_labels)
fprintf('\t# of Testing Observations: %d\n', length(test_labels));
fprintf('\t# per class in test dataset:\n');
summary(test_labels)