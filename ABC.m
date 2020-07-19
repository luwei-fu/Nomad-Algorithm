function [Xbest,Fbest,time] = ABC(fhd,dim,NP,NGen,Lb,Ub,varargin)
format short e
% make copies of parameters
starttime=cputime;
NP = NP;                 % Population Size
nOnlooker =NP;   % Number of Onlooker Bees
L =round(0.6*dim*NP);                   % Abandonment Limit Parameter (Trial Limit)
a = 1;                   % Acceleration Coefficient Upper Bound

% Abandonment Counter
C=zeros(NP,1);

pop = Lb+(Ub-Lb).*rand(NP,dim);

for j = 1:NP
    fitness(j,1) =feval(fhd,pop(j,:)',varargin{:}); 
end
evalu = NP;
[best , bestX]=min(fitness);      % minimization
Fbest=best;Xbest=pop(bestX,:);
BestChart = [];
BestChart=[BestChart; Fbest];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for it =1:NGen    
    % Recruited Bees
    for j=1:NP        
        % Choose k randomly, not equal to i
        K=[1:j-1 j+1:NP];
        k=K(randi([1 numel(K)]));        
        % Define Acceleration Coeff.
        phi=a*unifrnd(-1,+1,1,dim);        
        % New Bee Position
        newbee = pop(j,:)+phi.*(pop(j,:)-pop(k,:));
%         Tp=newbee>Ub;
%         Tm=newbee<Lb;
%         newbee=(newbee.*(~(Tp+Tm)))+((rand(1,dim).*(Ub-Lb)+Lb).*(Tp+Tm));       
        % Evaluation
        newbee_cost=  feval(fhd,newbee',varargin{:}); 
        evalu=evalu+1;
        % Comparision
        if newbee_cost<=fitness(j)
            pop(j,:)=newbee;
            fitness(j) = newbee_cost;
        else
            C(j)=C(j)+1;
        end       
    end
    
    % Calculate Fitness Values and Selection Probabilities
    F=zeros(NP,1);
    MeanCost = mean(fitness);
    for j=1:NP
        F(j) = exp(-fitness(j)/MeanCost); % Convert Cost to Fitness
    end
    F;
    P=F/sum(F);
    
    % Onlooker Bees
    for m=1:nOnlooker        
        % Select Source Site
        j=RouletteWheelSelection(P);    
        % Choose k randomly, not equal to i
        K=[1:j-1 j+1:NP];
        k=K(randi([1 NP-1]));       
        % Define Acceleration Coeff.
        phi=a*unifrnd(-1,+1,1,dim);        
        % New Bee Position
        newbee=pop(j,:)+phi.*(pop(j,:)-pop(k,:));
%         Tp=newbee>Ub;
%         Tm=newbee<Lb;
%         newbee=(newbee.*(~(Tp+Tm)))+((rand(1,dim).*(Ub-Lb)+Lb).*(Tp+Tm));       
        % Evaluation
        newbee_cost=  feval(fhd,newbee',varargin{:});    
        evalu=evalu+1;
      
        % Comparision
        if newbee_cost<=fitness(j)
            pop(j,:) = newbee;
            fitness(j) = newbee_cost;
        else
            C(j)=C(j)+1;
        end           
    end
    
    % Scout Bees
    for j=1:NP
        if C(j)>=L
            pop(j,:)=unifrnd(Lb,Ub,1,dim);
            fitness(j)= feval(fhd,pop(j,:)',varargin{:}); 
            evalu=evalu+1;
            C(j)=0;
        end
    end    
    % Update Best Solution Ever Found
    [best,bestX]=min(fitness);      % minimization
    if best<=Fbest
       Fbest=best;
       Xbest=pop(bestX,:);
    end
    if evalu > NGen*NP
          break;
    end
end %iteration
evalu;
time=cputime-starttime;
