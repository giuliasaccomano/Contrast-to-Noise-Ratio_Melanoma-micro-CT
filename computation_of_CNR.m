%% COMPUTATION OF CNR

clear all; close all; clc;

%% Parameters:

IN_PATH = '*\MATLAB\GNB23\';

mkdir(IN_PATH);

slices_name = ["pepi_melanoma.tif"; "syrmep_melanoma_bin4.tif"];

element_names = ["ulcerations"; "lesion"; "epidermis"; "dermis"; "subcutaneous fat"];

dim = 20; % pixels

%% PEPI melanoma image - ROI coordinates
%       ctrs 1    ctrs 2    ctrs 3     ctrs 4     ctrs 5    
rois_1 = [[314,27]; [300,66]; [184,48]; [424,124];  [149,182]];
%       bkg 1 
bkg_1 = [85,20];

%% SYRMEP melanoma image - ROI coordinates
%       ctrs 1    ctrs 2    ctrs 3     ctrs 4     ctrs 5  
rois_2 = [[547,83]; [555,161]; [371,115]; [774,261];  [305,347]];
%       bkg 2
bkg_2 = [118,54];

%% LOOP for producing images with ROI labeled and computation of CNR
k = 1;
cnrs = zeros(size(rois_1,1), 2);
num_slices = length(slices_name);
for i=1:num_slices
    path_slice = strcat(IN_PATH, slices_name(i));
    im = imread(path_slice);
    if i == 1
        fprintf(slices_name(i), '\n');
        figure,
        imshow(im);
        title('Lab-based x-ray micro-CT');
        hold on;
        for j = 1:size(rois_1,1)
            xA = rois_1(j,1);
            yA = rois_1(j,2);
            xB = bkg_1(1);
            yB = bkg_1(2);
            cnrs(j, i) = CNR(im, xA, yA, xB, yB, dim);
            rectangle('Position',[xA,yA,dim,dim], 'LineWidth',2,'EdgeColor','g');
        end
        rectangle('Position',[xB,yB,dim,dim], 'LineWidth',2,'EdgeColor','r');
    elseif i == 2
        fprintf(slices_name(i), '\n');
        figure,
        imshow(im);
        title('SR micro-CT');
        hold on;
        for j = 1:size(rois_2,1)
            xA = rois_2(j,1);
            yA = rois_2(j,2);
            xB = bkg_2(1);
            yB = bkg_2(2);
            cnrs(j, i) = CNR(im, xA, yA, xB, yB, dim);
            rectangle('Position',[xA,yA,dim,dim], 'LineWidth',2,'EdgeColor','g');
        end
        rectangle('Position',[xB,yB,dim,dim], 'LineWidth',2,'EdgeColor','r');
    end
end

cnr_results = [element_names cnrs];

%% Save matrix of CNR results

save CNR_melanoma_results.mat cnr_results;
