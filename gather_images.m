%% define root folder
clear
rootFolder = 'DB\segmented_set1\';
% # of moments
moments = 9;

for i=1:moments
    
    disp('Moment: ' + num2str(moments))
    
    % get images sets and label them
    %% 1st moment
    targetFolder = strcat(rootFolder, num2str(i), 'Moment');
    huggingImageSet{i} = imageSet(fullfile(targetFolder, 'hugging'));
    punchingImageSet{i} = imageSet(fullfile(targetFolder, 'punching'));
    pointingImageSet{i} = imageSet(fullfile(targetFolder, 'pointing'));
    pushingImageSet{i} = imageSet(fullfile(targetFolder, 'pushing'));
    handImageSet{i} = imageSet(fullfile(targetFolder, 'handShaking'));
    kikcingImageSet{i} = imageSet(fullfile(targetFolder, 'kicking'));

    % Display a few images
    helperDisplayImageMontage(huggingImageSet{i}.ImageLocation(1:1:huggingImageSet{i}.Count));
    helperDisplayImageMontage(punchingImageSet{i}.ImageLocation(1:1:punchingImageSet{i}.Count));
    
    % array of all image set
    imgSets{i} = [huggingImageSet{i}, punchingImageSet{i}, pointingImageSet{i}, pushingImageSet{i}, handImageSet{i}, kikcingImageSet{i}];
    % display labels and image counting
    disp({imgSets{i}.Description})
    disp([imgSets{i}.Count])

    %bag of features for the i-th moment
    bag_moment{i} = bagOfFeatures(imgSets{i}, ...
    'CustomExtractor', @BagOfFeaturesExtractor, ...
    'VocabularySize', 500);
    
    videoClassifier{i} = trainImageCategoryClassifier(imgSets{i}, bag_moment{i});
    
    confMatrix{i} = evaluate(videoClassifier{i}, imgSets{i});
    avgAcuuracy{i} = mean(diag(confMatrix{i}));
end
    
save videoClassificationResult.mat





