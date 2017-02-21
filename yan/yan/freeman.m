function spePot = freeman( inputImg )
%freeman ͨ��freeman����ȡ����ë��
%   �˴���ʾ��ϸ˵��

% ��ȡͼ��
[row, column]= size(inputImg);

% ǰ��ɫΪ1�� ����ɫΪ0
inputImg = ~inputImg;
outputImg = ones(row, column);
% special point ��¼
spePot = [];

% ����
maxSteps = 1000;
step = 0;

%����
maxLen = 1000;
length = 0;


% step 1 find special point
for r = 2 : row - 1
    for c = 2 : column - 1
        if inputImg(r, c) == 1
            if (inputImg(r - 1, c) + inputImg(r - 1, c - 1) + inputImg(r, c - 1) + inputImg(r + 1, c - 1) ...
                 + inputImg(r + 1, c) + inputImg(r + 1, c + 1) + inputImg(r, c + 1) + inputImg(r - 1, c + 1) > 2)
                spePot = cat(1, spePot, [r, c]);
                outputImg(r, c) = 0;
            end
        end
    end % end of row
end % end of column

% ��ȡ special point ����
N = size(spePot, 1);

for i = 1 : N
    r = spePot(i, 1);
    c = spePot(i, 2);
    
    % �����֧·��
    saveRoot = [r, c];
    
    while step < maxSteps
        while length < maxLen
            while (r > 0 && c > 0)
                if inputImg(r, c + 1) && ~isequal([r, c + 1], saveRoot(size(saveRoot, 1) - 1, :))
                    c = c + 1;
                    saveRoot = cat(1, saveRoot, [r, c]);
                end
                if (inputImg(r - 1, c + 1)) && ~isequal([r - 1, c + 1], saveRoot(size(saveRoot, 1) - 1, :))
                    r = r - 1;
                    c = c + 1;
                    saveRoot = cat(1, saveRoot, [r, c]);
                end
                if (inputImg(r - 1, c)) && ~isequal([r - 1, c], saveRoot(size(saveRoot, 1) - 1, :))
                    r = r - 1;
                    saveRoot = cat(1, saveRoot, [r, c]);
                end
                if (inputImg(r - 1, c - 1)) && ~isequal([r - 1, c - 1], saveRoot(size(saveRoot, 1) - 1, :))
                    r = r - 1;
                    c = c - 1;
                    saveRoot = cat(1, saveRoot, [r, c]);
                end
                if (inputImg(r, c - 1)) && ~isequal([r, c - 1], saveRoot(size(saveRoot, 1) - 1, :))
                    c = c - 1;
                    saveRoot = cat(1, saveRoot, [r, c]);
                end
                if (inputImg(r + 1, c - 1)) && ~isequal([r + 1, c - 1], saveRoot(size(saveRoot, 1) - 1, :))
                    r = r + 1;
                    c = c - 1;
                    saveRoot = cat(1, saveRoot, [r, c]);
                end
                if (inputImg(r + 1, c)) && ~isequal([r + 1, c], saveRoot(size(saveRoot, 1) - 1, :))
                    r = r + 1;
                    saveRoot = cat(1, saveRoot, [r, c]);
                end
                if (inputImg(r + 1, c + 1)) && ~isequal([r + 1, c + 1], saveRoot(size(saveRoot, 1) - 1, :))
                    r = r + 1;
                    c = c + 1;
                    saveRoot = cat(1, saveRoot, [r, c]);
                end
                step = step + 1;
            end % end of img
        end % end of maxLen
    end % end of while maxSteps
end % end of N
end

