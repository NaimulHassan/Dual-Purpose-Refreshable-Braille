function finished= test_model()

%% measure network accuracy
cam = ipcam('http://172.29.180.120:8080/video'); %% update the ip of your ipcamera
    
figure
keepRolling = true;
set(gcf,'CloseRequestFcn','keepRolling = false; closereq');

a = arduino();
clear a;
a = arduino('COM3', 'Uno');
s_time=5;
e_time=7;
    
while keepRolling
    im = snapshot(cam);
    %im= imread('test\image_00257.jpg');
    im = imresize(im,[227 227]);
    image(im)
        
    test_data= im;

        
    trained_data= load('weight.mat');
    [predictedLabels score]= classify(trained_data.weight, test_data);
    if ~isempty(predictedLabels)
        label= char(predictedLabels);
        label= upper(label)
    end
    
    arduino_test(a, s_time, e_time, label);
    
    finished=1 
end
end