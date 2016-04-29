%**************************************************************************
% Description: Arbiter PUF
% Author: Durga Prasad Sahoo
% Last update: 25th Jan. 2016
%**************************************************************************
classdef ArbiterPUF
    
    % ArbiterPUF- Class for Arbiter PUF
    
    % Properties of class
    properties (Access=public)
        
        chalSize   % Challenge Size
        mu         % Mean of distribution of process variations
        sigma      % Variance of processes variations
        parameters % Delay parameters of Arbiter PUF
    end
    
    % Public methods
    methods (Access=public)
       
        % Constructor
        function apuf = ArbiterPUF(chalSize,mu,sigma)
            apuf.chalSize = chalSize;
            apuf.mu = mu;
            apuf.sigma = sigma;
            apuf.parameters = getModelParameters(apuf,chalSize,mu,sigma);
        end
                
        function parameters = getParameters(apuf)
            parameters = apuf.parameters;
        end
        
        %{
        % Compute the response of PUF for a given challenge
        function r = getResponse(apuf,challenge)
            
            uDelay = 0; % Upper path delay
            lDelay = 0; % Lower path delay
            
            % Delay of each segments
            param = getParameters(apuf);
            paramUU =  param(1,:);
            paramLL =  param(2,:);
            paramUL =  param(3,:);
            paramLU =  param(4,:);
            
            for i=apuf.chalSize:-1:1 
                last_uDelay = uDelay;
                last_lDelay = lDelay;
                uDelay = (1-challenge(i))*(last_uDelay + paramUU(i)) + challenge(i)*(last_lDelay + paramLU(i));
                lDelay = (1-challenge(i))*(last_lDelay + paramLL(i)) + challenge(i)*(last_uDelay + paramUL(i));     
            end   
            
            r =  (lDelay > uDelay);
        end
        %}
        
         % Compute the response of PUF for a given challenge or challenge
         % matrix
        function r = getResponse(apuf,challenge)
            
            nChal = size(challenge,1);
            
            uDelay = zeros(nChal,1); % Upper path delay
            lDelay = zeros(nChal,1); % Lower path delay
            
            % Delay of each segments
            param = getParameters(apuf);
            paramUU =  param(1,:);
            paramLL =  param(2,:);
            paramUL =  param(3,:);
            paramLU =  param(4,:);
            
            % Do it for each challenge bit
            for i=apuf.chalSize:-1:1 
                last_uDelay = uDelay;
                last_lDelay = lDelay;
                uDelay = (1-challenge(:,i)).*(last_uDelay + paramUU(i)) + challenge(:,i).*(last_lDelay + paramLU(i));
                lDelay = (1-challenge(:,i)).*(last_lDelay + paramLL(i)) + challenge(:,i).*(last_uDelay + paramUL(i));     
            end   
            
            r =  (lDelay > uDelay);
        end
                
        
        % Compute the response of PUF for a given challenge or challenge
        % matrix
        function r = getResponseNoisy(apuf,challenge,sigmaNoise)
            
            noise = normrnd(0,sigmaNoise,4,apuf.chalSize);
            
            nChal = size(challenge,1);
            
            uDelay = zeros(nChal,1); % Upper path delay
            lDelay = zeros(nChal,1); % Lower path delay
            
            % Delay of each segments
            param = getParameters(apuf);
            paramUU =  param(1,:) + noise(1,:);
            paramLL =  param(2,:) + noise(2,:);
            paramUL =  param(3,:) + noise(3,:);
            paramLU =  param(4,:) + noise(4,:);
            
            % Do it for each challenge bit
            for i=apuf.chalSize:-1:1 
                last_uDelay = uDelay;
                last_lDelay = lDelay;
                uDelay = (1-challenge(:,i)).*(last_uDelay + paramUU(i)) + challenge(:,i).*(last_lDelay + paramLU(i));
                lDelay = (1-challenge(:,i)).*(last_lDelay + paramLL(i)) + challenge(:,i).*(last_uDelay + paramUL(i));     
            end   
            
            r =  (lDelay > uDelay);
        end
        
    %end % End public methods 
    
    % Private methods
   % methods %(Access=private)
        
        % Randomly generate the parameters of arbiter PUF
        function parameters = getModelParameters(~,chalSize,mu,sigma)
           parameters = normrnd(mu,sigma,4,chalSize);
        end
        
    end % End private methods 
    
end % End class