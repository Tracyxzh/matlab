function inputImg = bThin( inputImg )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

% 读取图像
[row, column] = size(inputImg);

%前景为1，背景为0
inputImg = ~inputImg;

modified = 1;

%% step 1
while modified
    modified = 0;
    %每次更新的图像
    updateImg = ones(row, column);
    
    for r = 3 : row - 2
        for c = 3 : column - 2
            if inputImg == 1 %前景点
                % 4领域
                sum4 = inputImg(r - 1, c) + inputImg(r, c - 1) + inputImg(r + 1, c) + inputImg(r, c + 1);
                
                % 8领域
                sum8 = inputImg(r - 1, c) + inputImg(r - 1, c - 1) + inputImg(r, c - 1) + inputImg(r + 1, c - 1) ...
                    + inputImg(r + 1, c ) + inputImg(r + 1, c + 1) + inputImg(r, c + 1) + inputImg(r - 1, c + 1); 
                % 16领域
                sum16 = inputImg(r - 2, c) + inputImg(r - 2, c - 1) + inputImg(r - 2, c - 2) + inputImg(r - 1, c - 2) ...
                    + inputImg(r, c - 2) + inputImg(r + 1, c - 2) + inputImg(r + 2, c - 2) + inputImg(r + 2, c - 1) ...
                     + inputImg(r + 2, c) + inputImg(r + 2, c + 1) + inputImg(r + 2, c + 2) + inputImg(r + 1, c + 2) ...
                      + inputImg(r, c + 2) + inputImg(r - 1, c + 2) + inputImg(r - 2, c + 2) + inputImg(r - 2, c + 1); 
                % 计算N
                N = 0;
                if inputImg(r - 1, c) == 0 && inputImg(r - 1, c - 1) == 1
                    N = N + 1;
                end
                if inputImg(r - 1, c - 1) == 0 && inputImg(r, c - 1) == 1
                    N = N + 1;
                end
                if inputImg(r, c - 1) == 0 && inputImg(r + 1, c - 1) == 1
                    N = N + 1;
                end
                if inputImg(r + 1, c - 1) == 0 && inputImg(r + 1, c) == 1
                    N = N + 1;
                end
                if inputImg(r + 1, c) == 0 && inputImg(r + 1, c + 1) == 1
                    N = N + 1;
                end
                if inputImg(r + 1, c + 1) == 0 && inputImg(r, c + 1) == 1
                    N = N + 1;
                end
                if inputImg(r, c + 1) == 0 && inputImg(r - 1, c + 1) == 1
                    N = N + 1;
                end
                if inputImg(r - 1, c + 1) == 0 && inputImg(r - 1, c) == 1
                    N = N + 1;
                end
            %% sum4 = 4, 模板1，2有一个为真
                if sum4 == 4
                    if (inputImg(r, c - 1) == 0 && inputImg(r, c) == 0 && inputImg(r, c + 1) == 0 && inputImg(r, c + 2) == 0 ...
                            || inputImg(r - 1, c) == 0 && inputImg(r, c) == 0 && inputImg(r + 1, c) == 0 && inputImg(r + 2, c) == 0 )
                        updateImg(r, c) = 1;
                    else
                        updateImg(r, c) = 0;
                        modified = 1;
                    end
                end
            %% N > 1, 模板1，2有一个为真
                if N > 1
                    if (inputImg(r, c - 1) == 0 && inputImg(r, c) == 0 && inputImg(r, c + 1) == 0 && inputImg(r, c + 2) == 0 ...
                            || inputImg(r - 1, c) == 0 && inputImg(r, c) == 0 && inputImg(r + 1, c) == 0 && inputImg(r + 2, c) == 0 )
                        updateImg(r, c) = 1;
                    else
                        updateImg(r, c) = 0;
                        modified = 1;
                    end
                end
            %% sum4 = 1, sum8 =1, sum8>=sum16 模板1，2有一个为真
                if (sum4 == 1 && sum8 == 1 && sum8 >= sum16)
                    if (inputImg(r, c - 1) == 0 && inputImg(r, c) == 0 && inputImg(r, c + 1) == 0 && inputImg(r, c + 2) == 0 ...
                            || inputImg(r - 1, c) == 0 && inputImg(r, c) == 0 && inputImg(r + 1, c) == 0 && inputImg(r + 2, c) == 0 )
                        updateImg(r, c) = 1;
                    else
                        updateImg(r, c) = 0;
                        modified = 1;
                    end
                end
            end
        end % end of column
    end % end of row
    inputImg = inputImg.*updateImg;
end

% %% step 2
% for r = 3 : row - 2
%         for c = 3 : column - 2
%             if inputImg == 1
%             %% 四个指标
%                 % 4领域
%                 sum4 = inputImg(r - 1, c) + inputImg(r, c - 1) + inputImg(r + 1, c) + inputImg(r, c + 1);
%                 
%                 % 8领域
%                 sum8 = inputImg(r - 1, c) + inputImg(r - 1, c - 1) + inputImg(r, c - 1) + inputImg(r + 1, c - 1) ...
%                     + inputImg(r + 1, c ) + inputImg(r + 1, c + 1) + inputImg(r, c + 1) + inputImg(r - 1, c + 1); 
%                 % 16领域
%                 sum16 = inputImg(r - 2, c) + inputImg(r - 2, c - 1) + inputImg(r - 2, c - 2) + inputImg(r - 1, c - 2) ...
%                     + inputImg(r, c - 2) + inputImg(r + 1, c - 2) + inputImg(r + 2, c - 2) + inputImg(r + 2, c - 1) ...
%                      + inputImg(r + 2, c) + inputImg(r + 2, c + 1) + inputImg(r + 2, c + 2) + inputImg(r + 1, c + 2) ...
%                       + inputImg(r, c + 2) + inputImg(r - 1, c + 2) + inputImg(r - 2, c + 2) + inputImg(r - 2, c + 1); 
%                 % 计算N
%                 N = 0;
%                 if inputImg(r - 1, c) == 0 && inputImg(r - 1, c - 1) == 1
%                     N = N + 1;
%                 end
%                 if inputImg(r - 1, c - 1) == 0 && inputImg(r, c - 1) == 1
%                     N = N + 1;
%                 end
%                 if inputImg(r, c - 1) == 0 && inputImg(r + 1, c - 1) == 1
%                     N = N + 1;
%                 end
%                 if inputImg(r + 1, c - 1) == 0 && inputImg(r + 1, c) == 1
%                     N = N + 1;
%                 end
%                 if inputImg(r + 1, c) == 0 && inputImg(r + 1, c + 1) == 1
%                     N = N + 1;
%                 end
%                 if inputImg(r + 1, c + 1) == 0 && inputImg(r, c + 1) == 1
%                     N = N + 1;
%                 end
%                 if inputImg(r, c + 1) == 0 && inputImg(r - 1, c + 1) == 1
%                     N = N + 1;
%                 end
%                 if inputImg(r - 1, c + 1) == 0 && inputImg(r - 1, c) == 1
%                     N = N + 1;
%                 end
%             end
%             if ( ((sum4 == 3 || N ==3) && sum8 > 3 && sum16 > 3) || (sum8 == 3 && sum16 == 3) )
%             end
%         end
% end