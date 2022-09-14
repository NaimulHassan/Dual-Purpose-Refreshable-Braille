function finished= train_model(TrainOrTest)

if strcmp(TrainOrTest, 'train')==1
    %% load pretrained network
    net= alexnet
    layers=net.Layers
    inputSize=[227 227];

    %% modify the network
    layers(23)= fullyConnectedLayer(9);
    layers(25)= classificationLayer;
    analyzeNetwork(net)
  

    %% set up our training data
    training_data= imageDatastore('train', 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
    %[trainingImages, testImages]= splitEachLabel(allImages, 0.8, 'randomize');

    % Retrain the network
    opts= trainingOptions('sgdm', 'InitialLearnRate', 0.001, 'MaxEpochs', 20, 'MiniBatchSize', 64);
    weight= trainNetwork(training_data, layers, opts)
    save weight
    finished=0
    
elseif strcmp(TrainOrTest, 'test')==1
    %% measure network accuracy
    
    cam = ipcam('http://192.168.0.103:8080/video');
    
    figure
    keepRolling = true;
    set(gcf,'CloseRequestFcn','keepRolling = false; closereq');
    
    while keepRolling
        im = snapshot(cam);
        im = imresize(im,[227 227]);
        image(im)
        
        test_data= im;

        
        trained_data= load('weight.mat');
        [predictedLabels score]= classify(trained_data.weight, test_data);
        if ~isempty(predictedLabels)
            label= char(predictedLabels);
            label= upper(label)
        end

    
        finished=1 
    end
end

end