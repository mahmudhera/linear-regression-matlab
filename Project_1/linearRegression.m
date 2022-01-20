% Start code for Project 1-Part 1: linear regression
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

addpath visualization
mkdir result;

%% Generate noisy observations from the ground true curve
% load the data points
load data/noisy_data.mat

%% Plot the ground truth curve of generated data
figure()
hold on;
% plot curve with red shaded region spans one standard deviation
shadedErrorBar(x,y,sigma.*ones(1,length(x)),{'b-','color','b','LineWidth',2},0); 
% plot the noisy observations
plot(x,t,'ro','MarkerSize',8,'LineWidth',1.5);

hold off; 
% Make it look good
grid on;
set(gca,'FontWeight','bold','LineWidth',2)
xlabel('x')
ylabel('t')

% Save the image
%exportgraphics(gcf, 'result/sample_curve.png');


%% Start your linear regression here
p = polyfit(x, y, 6);

figure()
hold on;
plot(x, polyval(p, x));
plot(x,t,'ro','MarkerSize',8,'LineWidth',1.5);
hold off;
grid on;
set(gca,'FontWeight','bold','LineWidth',2)
xlabel('x')
ylabel('t')




