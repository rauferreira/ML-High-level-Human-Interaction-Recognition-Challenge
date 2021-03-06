function result = BagOfFeaturesExtractor(testVideoSet) 

%% Data pre processing
% chose video input to segregate
% define the example number
% label the class

%%
directory_name = 'DB\segmented_set1\';
files = dir(directory_name);

folderName = 'dataSetup';
rmdir(folderName,'s')

fileIndex = find(~[files.isdir]);

% all calsses
classes = {'handShaking', 'hugging', 'kicking', 'pointing', 'punching', 'pushing'};

for j = 1:length(fileIndex)

    fileName = files(fileIndex(j)).name;
    
    if isempty(strcmp(fileName,testVideoSet)) == 1
    disp(fileName);

    % target video to segregate
    v = VideoReader(strcat('DB\segmented_set1\', fileName));
    if fileName(length(fileName)-7) == '_'
        exampleNumber = str2num(fileName(length(fileName)-6));
    else
        exampleNumber = str2num(fileName(length(fileName)-7:length(fileName)-6));
    end
    % define label for the video
    temp = str2num(fileName(length(fileName)-4));
    class = classes{temp+1};
    path = strcat('DB\segmented_set1\');

    % initial information irrelevant to the classification
    offset = 1.0;
    timeROI = v.Duration - offset;

    % select segregation percentage of the video
    stepPercentage = 0.10; % moment division
    step = timeROI*stepPercentage;

    %% Play Video
    i=1;
    while hasFrame(v)

        frame = readFrame(v);
        if v.CurrentTime > offset
            if (v.CurrentTime > offset + step*i) 
                disp(v.CurrentTime)
                disp(1+step*i)
                pause(1/v.FrameRate);
                savePath = strcat(path, num2str(i),'Moment\',class, '\', class, '_', num2str(exampleNumber), '_', num2str(i),'.jpg');
                imwrite(frame, savePath, 'jpg')
                i = i + 1;
            end
        end
    end

    whos video
    
    end

end

end

