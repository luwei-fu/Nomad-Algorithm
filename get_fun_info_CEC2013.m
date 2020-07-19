function [Fun_Name,dim,L,U,opt_f,err] = get_fun_info_CEC2013(fun)
% Get the dimension, lower-, upper-bound and the optimal value for the function 'fun'

% Get the global optimal value of fun
dim=30;
opt_f=0;
err=1e-8;   % Admissible error
Fun_Name='';
switch(fun) % fun from 1 to 28 are CEC2013 functions
    %% Unimodal Functions
    case {1}
        Fun_Name='Sphere Function';
        LB = -100; UB = 100;
        opt_f = -1400;
    case {2}
        Fun_Name='Rotated High Conditioned Elliptic Function';
        LB = -100; UB = 100;
        opt_f = -1300;
    case {3}
        Fun_Name='Rotated Bent Cigar Function';
        LB = -100; UB = 100;
        opt_f = -1200;
    case {4}
        Fun_Name='Rotated Discus Function';
        LB = -100; UB = 100;
        opt_f = -1100;
    case {5}
        Fun_Name='Different Powers Function';
        LB = -100; UB = 100;
        opt_f = -1000; 
    %% Basic Multimodal Functions
    case {6}
        Fun_Name='Rotated Rosenbrock¡¯s Function';
        LB = -100; UB = 100;
        opt_f = -900;
    case {7},
        Fun_Name='Rotated Schaffers F7 Function';
        LB = -100; UB = 100;
        opt_f = -800;
    case {8}
        Fun_Name='Rotated Ackley¡¯s Function';
        LB = -100; UB = 100;
        opt_f = -700;
    case {9}
        Fun_Name='Rotated Weierstrass Function';
        LB = -100; UB = 100;
        opt_f = -600;
    case {10}
        Fun_Name='Rotated Griewank¡¯s Function';
        LB = -100; UB = 100;
        opt_f = -500;
    case {11}
        Fun_Name='Rastrigin¡¯s Function';
        LB = -100; UB = 100;
        opt_f = -400;
    case {12}
        Fun_Name='Rotated Rastrigin¡¯s Function';
        LB = -100; UB = 100;
        opt_f = -300;
    case {13}
        Fun_Name='Non-Continuous Rotated Rastrigin¡¯s Function';
        LB = -100; UB = 100;
        opt_f = -200;
    case {14}
        Fun_Name='Schwefel''s Function';
        LB = -100; UB = 100;
        opt_f = -100;
    case {15}
        Fun_Name='Rotated Schwefel¡¯s Function';
        LB = -100; UB = 100;
        opt_f = 100;
     case {16}
         Fun_Name='Rotated Katsuura Function';
         LB = -100; UB = 100;
         opt_f = 200;
     case {17}
         Fun_Name='Lunacek Bi_Rastrigin Function';
        LB = -100; UB = 100;
        opt_f = 300;
     case {18}
         Fun_Name='Rotated Lunacek Bi_Rastrigin Function';
         LB = -100; UB = 100;
         opt_f = 400;
     case {19}
         Fun_Name='Expanded Griewank¡¯s plus Rosenbrock¡¯s Function';
         LB = -100; UB = 100;
         opt_f = 500;
     case {20}
         Fun_Name='Expanded Scaffer¡¯s F6 Function';
         LB = -100; UB = 100;
         opt_f = 600;
     %% Composition Functions
     case {21}
         Fun_Name='Composition Function 1 (n=5,Rotated)';
         LB = -100; UB = 100;
         opt_f = 700;
     case {22}
         Fun_Name='Composition Function 2 (n=3,Unrotated)';
         LB = -100; UB = 100;
         opt_f = 800;
     case {23}
         Fun_Name='Composition Function 3 (n=3,Rotated)';
         LB = -100; UB = 100;
         opt_f = 900;
     case {24}
         Fun_Name='Composition Function 4 (n=3,Rotated))';
         LB = -100; UB = 100;
         opt_f = 1000;
     case {25}
         Fun_Name='Composition Function 5 (n=3,Rotated)';
         LB = -100; UB = 100;
         opt_f = 1100;
    case {26}
         Fun_Name='Composition Function 6 (n=5,Rotated)';
         LB = -100; UB = 100;
         opt_f = 1200;
    case {27}
         Fun_Name='Composition Function 7 (n=5,Rotated)';
         LB = -100; UB = 100;
         opt_f = 1300;
    case {28}
         Fun_Name='Composition Function 8 (n=5,Rotated)';
         LB = -100; UB = 100;
         opt_f = 1400;
end

% If LB and UB are not vectors make them vectors
sl = size(LB);

if (sl(1)*sl(2) == 1) % LB and UB are scalers
    L = LB*ones(1,dim);
    U = UB*ones(1,dim);
else
    L = LB;
    U = UB;
end
end