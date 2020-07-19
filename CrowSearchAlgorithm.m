

% -------------------------------------------------
% Citation details:
% Alireza Askarzadeh, Anovel metaheuristic method for solving constrained
% engineering optimization problems: Crow search algorithm, Computers &
% Structures, Vol. 169, 1-12, 2016.

% Programmed by Alireza Askarzadeh at Kerman Graduate %
% University of Advanced Technology (KGUT) %
% Date of programming: September 2015 %
% -------------------------------------------------
% This demo only implements a standard version of CSA for minimization of
% a standard test function (Sphere) on MATLAB 7.6.0 (R2008a).
% -------------------------------------------------
% Note:
% Due to the stochastic nature of meta-heuristc algorithms, different runs
% may lead to slightly different results.
% -------------------------------------------------
function [g_best,ngbest,timecost]=CSA(fhd,pd,pop,Max_iteration,Lb,Ub,varargin)
begin=cputime;
N=50; % Flock (population) size
AP=0.1; % Awareness probability
fl=2; % Flight length (fl)
l=Lb; u=Ub;

for i=1:N % Generation of initial solutions (position of crows)
    for j=1:pd
        x(i,j)=l-(l-u)*rand; % Position of the crows in the space
    end
end

xn=x;
ft= feval(fhd,xn',varargin{:});
evalu=N;

mem=x; % Memory initialization
fit_mem=ft; % Fitness of memory positions

tmax=Max_iteration*0.6; % Maximum number of iterations (itermax)
for t=1:tmax

    num=ceil(N*rand(1,N)); % Generation of random candidate crows for following (chasing)
    for i=1:N
        if rand>AP
            xnew(i,:)= x(i,:)+fl*rand*(mem(num(i),:)-x(i,:)); % Generation of a new position for crow i (state 1)
        else
            for j=1:pd
                xnew(i,j)=l-(l-u)*rand; % Generation of a new position for crow i (state 2)
            end
        end
    end

    xn=xnew;
    ft= feval(fhd,xn',varargin{:}); % Function for fitness evaluation of new solutions

    for i=1:N % Update position and memory
        if xnew(i,:)>=l & xnew(i,:)<=u
            x(i,:)=xnew(i,:); % Update position
            if ft(i)<fit_mem(i)
                mem(i,:)=xnew(i,:); % Update memory
                fit_mem(i)=ft(i);
            end
        end
    end

    ffit(t)=min(fit_mem); % Best found value until iteration t
    min(fit_mem)
end

ngbest=find(fit_mem== min(fit_mem));
g_best=mem(ngbest(1),:); % Solutin of the problem
timecost=cputime-begin;



