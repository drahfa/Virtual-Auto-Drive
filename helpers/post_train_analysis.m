% Analysis
% Classify the validation images using the network.
[YPred,scores] = classify(AugSteeringNet,augimdsValidation);

% Display four sample validation images with their predicted labels.

idx = randperm(numel(imdsValidation.Files),4);
figure
for i = 1:4
    subplot(2,2,i)
    I = readimage(imdsValidation,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label));
end

% Calculate the classification accuracy on the validation set. 
% Accuracy is the fraction of labels that the network predicts correctly.

YValidation = imdsValidation.Labels;
accuracy = mean(YPred == YValidation);
disp(accuracy)