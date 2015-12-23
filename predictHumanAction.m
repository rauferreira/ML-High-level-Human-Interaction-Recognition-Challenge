function label = predictHumanAction(video, classifier)

moments = length(classifier);

% all calsses
classes = {'handShaking', 'hugging', 'kicking', 'pointing', 'punching', 'pushing'};

% initial information irrelevant to the classification
offset = 1.0;
timeROI = v.Duration - offset;

% select segregation percentage of the video
stepPercentage = 0.10; % moment division
step = timeROI*stepPercentage;

tempFolder = 'temp'; mkdir(tempFolder);
%% Play Video
i=1;
while hasFrame(v)
    
    frame = readFrame(v);
    if v.CurrentTime > offset
        if (v.CurrentTime > offset + step*i) 
            disp(v.CurrentTime)
            disp(1+step*i)
            pause(1/v.FrameRate);
            savePath = strcat(tempFolder, '\', 'Moment_', num2str(i), '.jpg');
            imwrite(frame, savePath, 'jpg')
            i = i + 1;
        end
    end
end
