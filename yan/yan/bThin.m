function inputImg = bThin( inputImg )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

% ��ȡͼ��
[row, column] = size(inputImg);

%ǰ��Ϊ1������Ϊ0
inputImg = ~inputImg;

modified = 1;

%% step 1
while modified
    modified = 0;
    %ÿ�θ��µ�ͼ��
    updateImg = ones(row, column);
    
    for r = 3 : row - 2
        for c = 3 : column - 2
            if inputImg == 1 %ǰ����
                % 4����
                sum4 = inputImg(r - 1, c) + inputImg(r, c - 1) + inputImg(r + 1, c) + inputImg(r, c + 1);
                
                % 8����
                sum8 = inputImg(r - 1, c) + inputImg(r - 1, c - 1) + inputImg(r, c - 1) + inputImg(r + 1, c - 1) ...
                    + inputImg(r + 1, c ) + inputImg(r + 1, c + 1) + inputImg(r, c + 1) + inputImg(r - 1, c + 1); 
                % 16����
                sum16 = inputImg(r - 2, c) + inputImg(r - 2, c - 1) + inputImg(r - 2, c - 2) + inputImg(r - 1, c - 2) ...
                    + inputImg(r, c - 2) + inputImg(r + 1, c - 2) + inputImg(r + 2, c - 2) + inputImg(r + 2, c - 1) ...
                     + inputImg(r + 2, c) + inputImg(r + 2, c + 1) + inputImg(r + 2, c + 2) + inputImg(r + 1, c + 2) ...
                      + inputImg(r, c + 2) + inputImg(r - 1, c + 2) + inputImg(r - 2, c + 2) + inputImg(r - 2, c + 1); 
                % ����N
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
            %% sum4 = 4, ģ��1��2��һ��Ϊ��
                if sum4 == 4
                    if (inputImg(r, c - 1) == 0 && inputImg(r, c) == 0 && inputImg(r, c + 1) == 0 && inputImg(r, c + 2) == 0 ...
                            || inputImg(r - 1, c) == 0 && inputImg(r, c) == 0 && inputImg(r + 1, c) == 0 && inputImg(r + 2, c) == 0 )
                        updateImg(r, c) = 1;
                    else
                        updateImg(r, c) = 0;
                        modified = 1;
                    end
                end
            %% N > 1, ģ��1��2��һ��Ϊ��
                if N > 1
                    if (inputImg(r, c - 1) == 0 && inputImg(r, c) == 0 && inputImg(r, c + 1) == 0 && inputImg(r, c + 2) == 0 ...
                            || inputImg(r - 1, c) == 0 && inputImg(r, c) == 0 && inputImg(r + 1, c) == 0 && inputImg(r + 2, c) == 0 )
                        updateImg(r, c) = 1;
                    else
                        updateImg(r, c) = 0;
                        modified = 1;
                    end
                end
            %% sum4 = 1, sum8 =1, sum8>=sum16 ģ��1��2��һ��Ϊ��
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
%             %% �ĸ�ָ��
%                 % 4����
%                 sum4 = inputImg(r - 1, c) + inputImg(r, c - 1) + inputImg(r + 1, c) + inputImg(r, c + 1);
%                 
%                 % 8����
%                 sum8 = inputImg(r - 1, c) + inputImg(r - 1, c - 1) + inputImg(r, c - 1) + inputImg(r + 1, c - 1) ...
%                     + inputImg(r + 1, c ) + inputImg(r + 1, c + 1) + inputImg(r, c + 1) + inputImg(r - 1, c + 1); 
%                 % 16����
%                 sum16 = inputImg(r - 2, c) + inputImg(r - 2, c - 1) + inputImg(r - 2, c - 2) + inputImg(r - 1, c - 2) ...
%                     + inputImg(r, c - 2) + inputImg(r + 1, c - 2) + inputImg(r + 2, c - 2) + inputImg(r + 2, c - 1) ...
%                      + inputImg(r + 2, c) + inputImg(r + 2, c + 1) + inputImg(r + 2, c + 2) + inputImg(r + 1, c + 2) ...
%                       + inputImg(r, c + 2) + inputImg(r - 1, c + 2) + inputImg(r - 2, c + 2) + inputImg(r - 2, c + 1); 
%                 % ����N
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