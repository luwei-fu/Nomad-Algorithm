

function ft=fitness(xn,N,pd) % Function for fitness evaluation

for i=1:N
    ft(i)=sum(xn(i,:).^2); % Sphere function
end