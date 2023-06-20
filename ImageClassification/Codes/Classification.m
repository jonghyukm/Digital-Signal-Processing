clear;clc;close all;

%% Data preparation
dirpath="C:\Users\DSP_Final_Project\Final_Project\image\";
imgdatas=imageDatastore(dirpath,"IncludeSubfolders",true,"FileExtensions" ...
    ,".png","LabelSource","foldernames");

%% Divide into Train Set and Validation Set
numTrainFiles=450;
[imdsTrain,imdsValidation]=splitEachLabel(imgdatas,numTrainFiles,'randomized');

%% Modeling
layers=[
    % 64 by 64 by 1 Layer
    imageInputLayer([64 64 1]);
    convolution2dLayer(3,3,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)

    % 32 by 32 by 3 Layer
    convolution2dLayer(3,6,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)

    % 16 by 16 by 6 Layer
    convolution2dLayer(3,12,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)

    % 8 by 8 by 12 Layer
    convolution2dLayer(3,24,'Padding','same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'Stride',2)

    % 4 by 4 by 24 Layer
    fullyConnectedLayer(3)
    softmaxLayer
    classificationLayer];

options=trainingOptions('sgdm','InitialLearnRate',0.01, ...
    'MaxEpochs',20,'Shuffle','every-epoch','ValidationData', ...
    imdsValidation,'ValidationFrequency', ...
    10,'Verbose',false,'Plots','training-progress');

net=trainNetwork(imdsTrain,layers,options);

YPred=classify(net,imdsValidation);
YValidation=imdsValidation.Labels;

accuracy=sum(YPred==YValidation)/numel(YValidation);
disp("Accuracy : "+num2str(accuracy*100)+"%")