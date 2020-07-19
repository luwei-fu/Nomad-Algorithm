% Nomad Algorithm
function [position,gBest,time]=NA(fhd,dim,N,Max_iteration,lb,ub,varargin)
% -----------------Initializations-----------------

starttime=cputime;
sigma=ub-lb;
radius=sigma;
w1=0.9;
w2=1.1;
vmin=0.4;
vmax=0.9;
range=vmax-vmin;
gBest=inf;
index=2;
SF=0.08;
k=0;  % how many iterations has the tribe  stayed
cg_curve=zeros(1,Max_iteration);
hersmen_curve=zeros(1,Max_iteration);
% Random initialization for agents.
sampledot=lb+(ub-lb)*rand(N,dim);
e=feval(fhd,sampledot',varargin{:});
[pBest,pindex]=min(e);
if pBest<gBest
      gBest=pBest;
      index=pindex;
end   

position=sampledot(index,:);
M_exploit=fix(N*vmax);
%hersmen_curve(1)=M_exploit;
cg_curve(1)=gBest;
% --------------------- Iteration---------------------------------
for l=2:Max_iteration   
    index=0;   
    for i=1:M_exploit
        sampledot(i,:)=position+2*(rand(1,dim)-0.5)*radius;    
        be=sampledot(i,:)<lb;
        sampledot(i,be)=lb + rand*(ub-lb);
        be=sampledot(i,:)>ub;
        sampledot(i,be)=lb + rand*(ub-lb); 
    end
 
    for i=(M_exploit+1):N
       sampledot(i,:)=position;
        j=fix(dim*rand)+1;
        sampledot(i,j)=position(j)+normrnd(0,sigma);
        if sampledot(i,j)>ub || sampledot(i,j)<lb
            sampledot(i,j)=lb + rand*(ub-lb);    
        end
    end
   
    e=feval(fhd,sampledot',varargin{:});
    [pBest,pindex]=min(e);
    if pBest<gBest
          gBest=pBest;
          index=pindex;
    end  
        
  %------------determing------------------
    if index==0
        radius=radius*w1;
        sigma=sigma*0.5;
        position_sl=position+position-mean(sampledot);
    else
        radius=radius*w2;
        position_sl=sampledot(index,:)+sampledot(index,:)-position;
        position=sampledot(index,:);
        if index > M_exploit
             sigma=ub-lb;
        end   
    end
    
    for i=1:dim
        if position_sl(i)> ub 
             position_sl(i)=position(i)+rand*(ub-position(i));
        elseif position_sl(i)< lb 
             position_sl(i)=lb+rand*(position(i)-lb);
        end
    end
    sle=feval(fhd,position_sl',varargin{:});
    if sle<gBest
        gBest =sle;
        position=position_sl;
    end

       P=1-exp(-(k^2)/(Max_iteration*SF)^2);
      if index==0
            k=k+1;
      
            if rand < P && M_exploit > N*vmin
                M_exploit=M_exploit-1;
                k=0;
                sigma=ub-lb;
            end      
        else
            k=0;
           if  rand < P && M_exploit<N*vmax
                M_exploit=M_exploit+1;
            end
      end

  cg_curve(l)=gBest;
end
time=cputime-starttime;
end