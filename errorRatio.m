function ratio = errorRatio(result, M)
    disagrees = 0;
    for i = 1:9
        for j = 1:9
            if (M(i,j) ~= 0 && M(i,j) ~= result(i,j))
                disagrees = disagrees + 1;
            end
        end
    end
    ratio = disagrees / 81;
end