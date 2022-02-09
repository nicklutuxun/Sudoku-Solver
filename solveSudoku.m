function output = solveSudoku(M,dim)
  output = zeros(dim^2,dim^2);
  numConstraint = 4*dim^4;
  numVariable = dim^6;
  A = zeros(numConstraint,numVariable);
  
  %Construct objective function
  f = addKnownValue(zeros(numVariable,1),M,dim);

  %Construct column vector b
  b = ones(numConstraint,1);
  
  rowIndex = 1;
  %C1: Each entry has exactly one integer
  for i = 1:dim
    for j = 1:dim
      for k = 1:dim
        for l = 1:dim
          for m = 1:dim^2
            colIndex = ijklmToIndex(i,j,k,l,m,dim);
            A(rowIndex,colIndex) = 1;
          end
          rowIndex = rowIndex + 1;
        end
      end
    end
  end

  %C2: Every integer appears exactly once in each micro square 
  for i = 1:dim
    for j = 1:dim
      for m = 1:dim^2
        for k = 1:dim
          for l = 1:dim
            colIndex = ijklmToIndex(i,j,k,l,m,dim);
            A(rowIndex,colIndex) = 1;
          end
        end
        rowIndex = rowIndex + 1;
      end
    end
  end

  %C3: Every integer appears exactly once in each row
  for i = 1:dim
    for k = 1:dim
      for m = 1:dim^2
        for j = 1:dim
          for l = 1:dim
            colIndex = ijklmToIndex(i,j,k,l,m,dim);
            A(rowIndex,colIndex) = 1;
          end
        end
        rowIndex = rowIndex + 1;
      end
    end
  end
  
  %C4: Every integer appears exactly once in each column
  for j = 1:dim
    for l = 1:dim
      for m = 1:dim^2
        for i = 1:dim
          for k = 1:dim
            colIndex = ijklmToIndex(i,j,k,l,m,dim);
            A(rowIndex, colIndex) = 1;
          end
        end
        rowIndex = rowIndex + 1;
      end
    end
  end

  % Solve Integer Linear Programming
  intcon = 1:numVariable;
  options = optimoptions('intlinprog','Display','none','IntegerTolerance',1e-5);
  [xopt, ~] = intlinprog(-f,intcon,[],[],A,b,zeros(numVariable,1),ones(numVariable,1),[],options);
  
  % Put solution into M
  for i = 1:numVariable
    if abs(1-xopt(i,1)) <= 10^(-6) 
      [row, col, value] = IndexToijm(i,dim);
      output(row, col) = value;
    end
  end
end

function f = addKnownValue(f,M,dim)
  for row=1:dim^2
    for col=1:dim^2
      if M(row,col) ~= 0
        i = fix((row+dim-1)/dim);
        j = fix((col+dim-1)/dim);
        k = rem(row+dim-1,dim)+1;
        l = rem(col+dim-1,dim)+1;
        m = M(row,col);
        index = ijklmToIndex(i,j,k,l,m,dim);
        f(index,1) = 1;
      end
    end
  end
end

% Convert i,j,k,l,m coordinate to position index in 729*1 vector
function index = ijklmToIndex(i,j,k,l,m,dim)
  index = (i-1)*dim^5 + (j-1)*dim^4 + (k-1)*dim^3 + (l-1)*dim^2 + (m-1)*dim^0 + 1;
end

% Convert position index in 729*1 vector to i,j,m macro coordinate
function [i,j,m] = IndexToijm(pos,dim)
  m = rem((pos-1),dim^2)+1;
  block = fix((pos-1)/(dim^4))+1;
  pos = pos - (block-1)*dim^4;
  i = fix((pos-1)/dim^3)+1 + fix((block-1)/dim)*dim;
  pos = fix((pos-1)/dim^2)+1;
  j = rem(pos-1,dim)+1 + rem(block-1,dim)*dim;
end

