% randomWalkProblem.m
% Steve Ryan, started 3/20/2017

% Problem Description:  Starting from the origin O, a particle moves 
% randomly +/- 1 step along each axis of an N-dimensional space. The 
% probabilities of stepping +1 or -1 step along each axis are each 50% and 
% are statistically independent of each other. After a step is taken, the 
% move is repeated from the new position, and so on. If the walk continues 
% forever, what is the probability that the particle ever returns to the 
% origin O if N = 1, 2, and 3? Please solve this problem numerically and 
% send us your code and a brief summary of your solution and findings.
% Hint: The problem has an analytical solution. Please use the analytical 
% solution to verify or discuss your numerical approach. [Link to 
% analytical solution: 
% http://mathworld.wolfram.com/PolyasRandomWalkConstants.html ]

% Approach - I'm taking a simulation approach to solving this problem.
% For situations like this, large numbers of simulated trials can be used
% as an approximation for infinity.  It loses a lot of the nuance of the
% formal solution, and will consistently underestimate the probability, 
% but for a numerical solution it should work reasonably well.
% I'm going to start by generating a matrix of numbers randomly
% assigned to be either -1 or +1, representing the movements along this 
% axis.  Then I'll generate a parallel list which represents a running
% total.  If that running total ever equals zero, the particle has returned
% to O on that axis.  I will simulate this a large number of times and
% build a probability distribution of returning to the origin.

tic

trials = 10;

returnToOriginThree = zeros(1,trials);
returnToOriginXY = zeros(1,trials);
returnToOriginYZ = zeros(1,trials);
returnToOriginZX = zeros(1,trials);
    
for j=1:trials

    % generate list of movements for each dimension
    X = 2*floor(2*rand(10000,1)) - 1;
    Y = 2*floor(2*rand(10000,1)) - 1;
    Z = 2*floor(2*rand(10000,1)) - 1;
    
    % generate a running total of movements. 0 indicates a return to Origin
    for i=1:1:length(X)
        X(i,2) = sum(X(1:i,1));
        Y(i,2) = sum(Y(1:i,1));
        Z(i,2) = sum(Z(1:i,1));
    end
    
    % these matrices will be True wherever that axis has returned to origin
    xAtOrigin = X(:,2)==0;
    yAtOrigin = Y(:,2)==0;
    zAtOrigin = Z(:,2)==0;
    
    % The sum of the three Origin matrices will be 3 whenever it has
    % returned to Origin on all axes simultaneously.  We can use each of
    % the three original axes as trials for the N=1 Dimensional case, and
    % pairs of them for the N=2 Dimensional case.
    allAtOrigin = xAtOrigin + yAtOrigin + zAtOrigin;
    xyAtOrigin = xAtOrigin + yAtOrigin;
    yzAtOrigin = yAtOrigin + zAtOrigin;
    zxAtOrigin = xAtOrigin + zAtOrigin;
    
    % The sum of the logical operation will be non-zero if the particle 
    % returns to origin in all axes simultaneously, and zero if it never
    % returns.
    returnToOriginThree(j) = sum(allAtOrigin==3);
    returnToOriginXY(j) = sum(xyAtOrigin==2);
    returnToOriginYZ(j) = sum(yzAtOrigin==2);
    returnToOriginZX(j) = sum(zxAtOrigin==2);
    returnToOriginX(j) = sum(xAtOrigin==1);
    returnToOriginY(j) = sum(yAtOrigin==1);
    returnToOriginZ(j) = sum(zAtOrigin==1);
end

toc