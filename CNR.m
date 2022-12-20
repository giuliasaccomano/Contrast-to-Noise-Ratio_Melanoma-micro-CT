%% Contrast to noise ratio computation

function res = CNR(im, xA, yA, xB, yB, dim)
% A is the signal and B is the background
    im = double(im);

    roi_A = im(yA : yA+dim -1, xA : xA+dim -1);
    roi_B = im(yB : yB+dim -1, xB : xB+dim -1);

    avg_A = mean(roi_A (:));
    avg_B = mean(roi_B (:));

    var_A = var(roi_A (:));
    var_B = var(roi_B (:));

    res = abs(avg_B - avg_A)/sqrt(( var_A + var_B)/2);
end