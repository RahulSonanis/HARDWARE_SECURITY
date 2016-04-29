
clear all;
clc;

%**************************************************************************
% Create a Simulated model for MUX based composition of APUFs
%**************************************************************************
chalSize = 64;         % Challege size of PUF
mu = 10;                % Mean of delay distribution
sigma = 0.05;          % Stnadard deviation of delay distribution

%**************************************************************************
% Generate Challenges and compute Responses
%**************************************************************************
nChal = 100000;          % No. of challenges
nPUF = 10;             % No. of PUF instances to be created
chalGen = 1;            % if cahlGen=1, then it generates random challenges; otherwise, read challenge from file

%**************************************************************************
% Files and challenge generation/loading
%**************************************************************************
oDir = [pwd '/dataset/output/'];
iDir = [pwd '/dataset/input/'];
chalFile = [iDir 'chal_APUF_' num2str(chalSize) '_' num2str(nChal) '_bi.mat'];
workspcaeFile = [oDir 'workspace_APUF_' num2str(chalSize) '_' num2str(nChal) '.mat'];

if chalGen
    C = randi([0,1],nChal,chalSize);  % Generate challenge randomly
    save(chalFile,'C');               % Save challenge file
else
    load(chalFile);
end

%**************************************************************************
% Create PUF instance and evaluate them
%**************************************************************************

% Instantiate PUF
%**************************************************************************
pufList = cell(nPUF,1);
for i = 1:nPUF
    pufList{i}= ArbiterPUF(chalSize,mu,sigma);  
end

% Evaluate each instances
%**************************************************************************

R = zeros(nChal,nPUF);              %  Response Matrix without the consideration of noise
    
for i=1:nPUF

    % i-th PUF instance
    puf = pufList{i};

    fprintf('\nEvaluating APUF %d...',i);

    R(:,i) = puf.getResponse(C);  
    fprintf('done');
end

% Save response matices
respFile = [oDir 'resp_APUF_' num2str(chalSize) '_'  num2str(nChal) '_' num2str(nPUF) '_inst_.mat'];
fprintf('\n\nSaving into files...');
save(respFile,'R');
fprintf('done\n');

fprintf('\nDONE !!!\n');

%exit;
