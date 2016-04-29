load('chal_64_100000_bi.mat');
% 100000 * 64
lol = C;
challenge_set = C;
challenge_set(1:100000,65) = ones(100000,1);
% making bipolar
for i = 1:100000
    for j = 1:64
        if lol(i,j) == 0
            lol(i,j) = 1;
        else
            lol(i,j) = -1;
        end
    end
end
%  calculating parity vectors
for i = 1:100000
    for j = 1:64
        hi = 1;
%         if j == 64
%             challenge_set(i,j) = 1;
%         else
            for k = j:64
                hi = hi * lol(i,k);
            end
            challenge_set(i,j) = hi;
%         end
    end
end
clear C;
clear lol;
% %
load('respGolden_10_APUF_64_100000_Br_5.mat');
response_set = G;
for i = 1:100000
    for j = 1:10
        if response_set(i,j) == 0   
            response_set(i,j) = 1;
        else
            response_set(i,j) = -1;
        end
    end
end
clear G;

% setting training and classifying data
training_set_features = challenge_set(1:7000,:);
training_set_groups0 = response_set(1:7000,1).*response_set(1:7000,7);
training_set_groups1 = response_set(1:7000,1).*response_set(1:7000,2);
training_set_groups2 = response_set(1:7000,2).*response_set(1:7000,3);
training_set_groups3 = response_set(1:7000,3).*response_set(1:7000,4);
training_set_groups4 = response_set(1:7000,4).*response_set(1:7000,5);
training_set_groups5 = response_set(1:7000,5).*response_set(1:7000,6);

classify_set_features = challenge_set(7001:10000,:);
classify_set_groups0 = response_set(7001:10000,1).*response_set(7001:10000,7);
classify_set_groups1 = response_set(7001:10000,1).*response_set(7001:10000,2);
classify_set_groups2 = response_set(7001:10000,2).*response_set(7001:10000,3);
classify_set_groups3 = response_set(7001:10000,3).*response_set(7001:10000,4);
classify_set_groups4 = response_set(7001:10000,4).*response_set(7001:10000,5);
classify_set_groups5 = response_set(7001:10000,5).*response_set(7001:10000,6);

diary('first_part_exp.txt');
diary on;

% % radial kernel
% % training_set_features from first
S=sprintf('<========================Radial Kernel==============================>');
disp(S);
    training_set_groups_1 = training_set_groups0(1:7000);     % actual training data
    model = svmtrain(training_set_groups_1, training_set_features, '-t 2'); % radial

    S=sprintf('Accuracy for v[o] ===>');
    disp(S);

    classify_set_groups_1 = classify_set_groups0(1:3000,1);      % actual classifying data
    [predicted_label, accuracy, decision_values] = svmpredict(classify_set_groups_1, classify_set_features, model);
    v0=predicted_label;
    %----------------------------
  training_set_groups_1 = training_set_groups1(1:7000);     % actual training data
    model = svmtrain(training_set_groups_1, training_set_features, '-t 2'); % radial

    S=sprintf('Accuracy for v[1] ===>');
    disp(S);

    classify_set_groups_1 = classify_set_groups1(1:3000,1);      % actual classifying data
    [predicted_label, accuracy, decision_values] = svmpredict(classify_set_groups_1, classify_set_features, model);
    v1=predicted_label;
    %--------------------
    training_set_groups_1 = training_set_groups2(1:7000);     % actual training data
    model = svmtrain(training_set_groups_1, training_set_features, '-t 2'); % radial

    S=sprintf('Accuracy for v[2] ===>');
    disp(S);

    classify_set_groups_1 = classify_set_groups2(1:3000,1);      % actual classifying data
    [predicted_label, accuracy, decision_values] = svmpredict(classify_set_groups_1, classify_set_features, model);
    v2=predicted_label;
    %---------------------------
    training_set_groups_1 = training_set_groups3(1:7000);     % actual training data
    model = svmtrain(training_set_groups_1, training_set_features, '-t 2'); % radial

    S=sprintf('Accuracy for v[3] ===>');
    disp(S);

    classify_set_groups_1 = classify_set_groups3(1:3000,1);      % actual classifying data
    [predicted_label, accuracy, decision_values] = svmpredict(classify_set_groups_1, classify_set_features, model);
v3=predicted_label;
%----------------------------------------
    training_set_groups_1 = training_set_groups4(1:7000);     % actual training data
    model = svmtrain(training_set_groups_1, training_set_features, '-t 2'); % radial

    S=sprintf('Accuracy for v[4] ===>');
    disp(S);

    classify_set_groups_1 = classify_set_groups4(1:3000,1);      % actual classifying data
    [predicted_label, accuracy, decision_values] = svmpredict(classify_set_groups_1, classify_set_features, model);
    v4=predicted_label;
    %------------------------------------
    training_set_groups_1 = training_set_groups5(1:7000);     % actual training data
    model = svmtrain(training_set_groups_1, training_set_features, '-t 2'); % radial

    S=sprintf('Accuracy for v[5] ===>');
    disp(S);

    classify_set_groups_1 = classify_set_groups5(1:3000,1);      % actual classifying data
    [predicted_label, accuracy, decision_values] = svmpredict(classify_set_groups_1, classify_set_features, model);
    v5=predicted_label;
    %now % of o[0], o[1]....
    %first original values of o[i]
    o0 = response_set(7001:10000,1).*response_set(7001:10000,2).*response_set(7001:10000,3).*response_set(7001:10000,4).*response_set(7001:10000,5).*response_set(7001:10000,6);
    o1=response_set(7001:10000,7).*response_set(7001:10000,2).*response_set(7001:10000,3).*response_set(7001:10000,4).*response_set(7001:10000,5).*response_set(7001:10000,6);
    o2=response_set(7001:10000,1).*response_set(7001:10000,7).*response_set(7001:10000,3).*response_set(7001:10000,4).*response_set(7001:10000,5).*response_set(7001:10000,6);
    o3=response_set(7001:10000,1).*response_set(7001:10000,2).*response_set(7001:10000,7).*response_set(7001:10000,4).*response_set(7001:10000,5).*response_set(7001:10000,6);
    o4=response_set(7001:10000,1).*response_set(7001:10000,2).*response_set(7001:10000,3) .*response_set(7001:10000,7).*response_set(7001:10000,5).*response_set(7001:10000,6);
    o5=response_set(7001:10000,1).*response_set(7001:10000,2).*response_set(7001:10000,3).*response_set(7001:10000,4).*response_set(7001:10000,7).*response_set(7001:10000,6);
    %obtained response
    O0=v1.*v3.*v5;
    O1=v0.*v1.*v3.*v5;
    O2=v0.*v3.*v5;
    O3=v0.*v2.*v3.*v5;
    O4=v0.*v2.*v5;
    O5=v0.*v2.*v4.*v5;
    % %accuracy now
    disp(sum(o0==O0)/3000);
    disp(sum(o1==O1)/3000);
    disp(sum(o2==O2)/3000);
    disp(sum(o3==O3)/3000);
    disp(sum(o4==O4)/3000);
    disp(sum(o5==O5)/3000);
    diary off;


