function spePot = freeman( inputImg )
%freeman 通过freeman编码取出短毛刺
%   此处显示详细说明

% 读取图像
[row, column]= size(inputImg);

% 前景色为1， 背景色为0
inputImg = ~inputImg;
outputImg = ones(row, column);
% special point 记录
spePot = [];

% 步数
maxSteps = 1000;
step = 0;

%长度
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

% 获取 special point 个数
N = size(spePot, 1);

for i = 1 : N
    r = spePot(i, 1);
    c = spePot(i, 2);
    
    % 保存分支路径
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

