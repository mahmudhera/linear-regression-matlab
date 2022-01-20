%   Description: 
%   Visualization of decision boundaries
%   
%   classifier is a linear classifier struct trained on 2 features
%   featureVector is the features to show
%   labels are the feature vector labels as a categorical array
%   featureA and FeatureB are the index of the features to visualize

function h = visuBoundFill(classifier,featureVector,labels,idxA,idxB)
%%
clf
nPoints = 1000;

cats = categories(labels);
numGroups = length(cats);
lim_info =  [min(featureVector(:,idxA)),max(featureVector(:,idxA)),...
    min(featureVector(:,idxB)),max(featureVector(:,idxB))  ];

x = linspace(lim_info(1),lim_info(2),nPoints);
y = linspace(lim_info(3),lim_info(4),nPoints);
[X,Y] = meshgrid(x,y);
xx=X(:);
yy=Y(:);
P = -inf*ones(nPoints,nPoints);
G = ones(nPoints,nPoints);
colors = jet(numGroups*10);
colors = colors(round(linspace(1,numGroups*10,numGroups)),:);

featureVector_for_prediction = zeros(length(xx),size(featureVector,2));
featureVector_for_prediction(:,idxA) = xx;
featureVector_for_prediction(:,idxB) = yy;

pred = predict(classifier,featureVector_for_prediction);

G = reshape(pred,nPoints,nPoints);


hold on;
for i = 1:numGroups
    cc = bwconncomp(G==cats(i));
    for rp = regionprops(cc,'ConvexHull')'
        xx = x(min(round(rp.ConvexHull(:,1)),nPoints));
        yy = y(min(round(rp.ConvexHull(:,2)),nPoints));
        patch(xx,yy,colors(i,:),'FaceAlpha',.2)
    end
    
end

h = gscatter(featureVector(:,idxA),featureVector(:,idxB),labels,'','+o*v^');
for i = 1:numGroups
    h(i).LineWidth = 2;
    h(i).MarkerEdgeColor = colors(i,:);
    h(i).MarkerFaceColor = colors(i,:);
end
axis(lim_info)
hold off
grid on;
set(gca,'FontWeight','bold','LineWidth',2)