% % Problem 1(a)
% M1a = [8 0 0 0 0 0 0 0 0;
%        0 0 3 6 0 0 0 0 0;
%        0 7 0 0 9 0 2 0 0;
%        0 5 0 0 0 7 0 0 0;
%        0 0 0 0 4 5 7 0 0;
%        9 0 0 1 0 0 0 3 0;
%        0 0 1 0 0 0 0 6 8
%        0 0 8 5 0 0 0 1 0;
%        0 9 0 0 0 0 4 0 0];
% 
% result1a = solveSudoku(M1a,3);
% 
% % Problem 1(b)
% M1b = [8 0 0 0 0 0 0 0 3;
%        0 0 3 6 0 0 0 0 0;
%        0 7 0 0 9 0 2 0 0;
%        0 5 0 0 0 7 0 0 0;
%        0 0 0 0 4 5 7 0 0;
%        9 0 0 1 0 0 6 3 0;
%        0 0 1 0 0 0 0 6 8
%        0 0 8 5 0 0 0 1 0;
%        5 9 0 0 8 0 4 0 0];
% 
% result1b =  solveSudoku(M1b,3);
% 
%Problem 2
ratioList = [];
parfor i = 1:10
    M2 = ceil(9*rand(9,9));
    result2 = solveSudoku(M2,3);
    ratio = errorRatio(result2,M2);
    ratioList = [ratioList, ratio];
end

fprintf("mean = %f\nsd = %f", mean(ratioList), std(ratioList));

% % Problem 3
% M3 = zeros(16,16);
% result3a = solveSudoku(M3,4);
% M3(1,1) = 1;
% result3b = solveSudoku(M3,4);

% % Problem 4
% M4 = [1 2 3 6 4 5 0 0 0;
%       4 5 6 0 0 0 0 0 0;
%       7 8 9 0 0 0 0 0 0;
%       5 0 0 0 0 0 0 0 0;
%       8 0 0 0 0 0 0 0 0;
%       2 0 0 0 0 0 0 0 0;
%       0 0 0 0 0 0 0 0 0;
%       0 0 0 0 0 0 0 0 0;
%       0 0 0 0 0 0 0 0 0];
% 
% result4 = solveSudoku_more_constraints(M4,3);




