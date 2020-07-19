
function [best,fmin,time]=FPA(fhd,dim,SearchAgents_no,Max_iter,lb,ub,varargin)
% Default parameters
starttime=cputime;

n=SearchAgents_no;         % Population size, typically 10 to 25
p=0.8;           % probabibility switch

% Iteration parameters
N_iter=Max_iter;            % Total number of iterations

% Dimension of the search variables
d=dim;
Lb=lb*ones(1,d);
Ub=ub*ones(1,d);

% Initialize the population/solutions
for i=1:n
  Sol(i,:)=Lb+(Ub-Lb).*rand(1,d);
  Fitness(i)=feval(fhd,Sol(i,:)',varargin{:});  
end

% Find the current best
[fmin,I]=min(Fitness);
best=Sol(I,:);
S=Sol; 

% Start the iterations -- Flower Algorithm 
for t=1:N_iter
        % Loop over all bats/solutions
        for i=1:n
          % Pollens are carried by insects and thus can move in
          % large scale, large distance.
          % This L should replace by Levy flights  
          % Formula: x_i^{t+1}=x_i^t+ L (x_i^t-gbest)
          if rand>p
          %% L=rand;
          L=Levy(d);
          dS=L.*(Sol(i,:)-best);
          S(i,:)=Sol(i,:)+dS;
          
          % Check if the simple limits/bounds are OK
          S(i,:)=simplebounds(S(i,:),Lb,Ub);
          
          % If not, then local pollenation of neighbor flowers 
          else
              epsilon=rand;
              % Find random flowers in the neighbourhood
              JK=randperm(n);
              % As they are random, the first two entries also random
              % If the flower are the same or similar species, then
              % they can be pollenated, otherwise, no action.
              % Formula: x_i^{t+1}+epsilon*(x_j^t-x_k^t)
              S(i,:)=S(i,:)+epsilon*(Sol(JK(1),:)-Sol(JK(2),:));
              % Check if the simple limits/bounds are OK
              S(i,:)=simplebounds(S(i,:),Lb,Ub);
          end
          
          % Evaluate new solutions
           Fnew=feval(fhd,S(i,:)',varargin{:}); 
          % If fitness improves (better solutions found), update then
            if (Fnew<=Fitness(i))
                Sol(i,:)=S(i,:);
                Fitness(i)=Fnew;
           end
           
          % Update the current global best
          if Fnew<=fmin
                best=S(i,:)   ;
                fmin=Fnew   ;
          end
        end
        % Display results every 100 iterations
      
  Convergence_curve(t)=fmin;      
end
best_score=fmin;

time=cputime-starttime;
end


