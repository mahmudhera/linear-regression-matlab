% Start code for Project 1-Part 2: Classification
% CSE583/EE552 PRML
% TA: Shimian Zhang, Jan 2022
% TA: Addison Petro, Jan 2022

%Your Details: (The below details should be included in every matlab script
%file that you create)
%{
    Name:
    PSU Email ID:
    Description: (A short description of what this script does).
%}

close all;
clear all;
addpath visualization;
mkdir result;

%%  An example of Linear Discriminant Classification

%   Choose which dataset to use (choices: wallpaper, taiji)
dataset = 'wallpaper';
[train_featureVector, train_labels, test_featureVector, test_labels] = loadDataset(dataset);
K = length(countcats(test_labels));


%%  Classify the data and show statistics
%   This example is using Matlab's inbuilt Classifier. You will need first
%   implement Fisher Project on the data, and then do the classification.
%   Fit discriminant analysis classifier
%   https://www.mathworks.com/help/stats/fitcdiscr.html
MdlLinear = fitcdiscr(train_featureVector,train_labels);

%   Find the training accurracy 
train_pred = predict(MdlLinear,train_featureVector);

%   Create confusion matrix
train_ConfMat = confusionmat(train_labels,train_pred);
train_ConfMat = train_ConfMat./(meshgrid(countcats(train_labels))')
%   mean group accuracy and std
train_acc = mean(diag(train_ConfMat))
train_std = std(diag(train_ConfMat))

%   Find the testing accurracy 
test_pred = predict(MdlLinear,test_featureVector);

%   Create confusion matrix
test_ConfMat = confusionmat(test_labels,test_pred);
test_ConfMat = test_ConfMat./(meshgrid(countcats(test_labels))')
%   mean group accuracy and std
test_acc = mean(diag(test_ConfMat))
test_std = std(diag(test_ConfMat))

%%  Display the confusion matrix
figure()
draw_cm(train_ConfMat,categories(train_labels),K);
title('{\bf Train Confusion Matrix}')
exportgraphics(gcf, sprintf('result/%s_train_conf.png', dataset));

%%  Display the classified regions of two of the feature dimensions  
%   To display the classified regions, you will need to project the
%   features to 2-Dimensions.
%   Here is a visualization example of selecting 2 features to retrain a
%   Classifier. (Notice that we are not projecting the features in this
%   example)

featureA = 1;
featureB = 7;
feature_idx = [featureA,featureB];
visu_train_featureVector = train_featureVector(:,feature_idx);
visu_test_featureVector = test_featureVector(:,feature_idx);
MdlLinear2 = fitcdiscr(visu_train_featureVector,train_labels);
figure()
h = visuBoundFill(MdlLinear2,visu_test_featureVector,test_labels,1,2);
title('{\bf Classification Area}')
exportgraphics(gcf, sprintf('result/%s_classification.png', dataset));


