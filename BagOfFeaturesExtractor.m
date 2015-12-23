function [features, metrics] = BagOfFeaturesExtractor(I) 
% Example color layout feature extractor. Designed for use with bagOfFeatures.
%
% feature extraction using histogram of gradients (HOG)

% OPTIMIZE cell size
cellSize = [9 9];

[features, visualization] = extractHOGFeatures(I,'CellSize',cellSize);

features = features';
metrics = features;

