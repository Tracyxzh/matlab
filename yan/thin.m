function inputImg = thin( inputImg )
%thin �˴���ʾ�йش˺�����ժҪ
%   Hilditch
    
% ��ȡͼ��
[row, column] = size(inputImg);
count = 0;
%ǰ��Ϊ1������Ϊ0
for i = 1:row
    for j = 1:column
        if inputImg(i, j) == 1
            inputImg(i, j) = 0;
        else
            inputImg(i, j) = 1;
        end
    end
end

modified = 1;

while(modified == 1) 
    modified = 0;
    %ÿ�θ��µ�ͼ��
    updateImg = ones(row, column); 
    for r = 3 : row - 2
        for c = 3 : column - 2
            
            
            % �ĸ�����
            condition1 = 0;
            condition2 = 0;
            condition3 = 0;
            condition4 = 0;
            if inputImg(r, c) == 1                
                %����ж�����
                %�ж�2<=NZ[P1]<=6
                nCount =  inputImg(r - 1, c - 1) + inputImg(r - 1, c) + inputImg(r - 1, c + 1) ...
                     + inputImg(r, c - 1) + inputImg(r, c + 1) ...
                      + inputImg(r + 1, c + 1) + inputImg(r + 1, c) + inputImg(r + 1, c + 1);
                if 2 <= nCount && nCount <= 6
                    condition1 = 1;
                end

                %�ж�Z0(p1) = 1
                nCount = 0;
                if inputImg(r - 1, c) == 0 && inputImg(r - 1, c - 1) == 1
                    nCount = nCount + 1;
                end
                if inputImg(r - 1, c - 1) == 0 && inputImg(r, c - 1) == 1
                    nCount = nCount + 1;
                end
                if inputImg(r, c - 1) == 0 && inputImg(r + 1, c - 1) == 1
                    nCount = nCount + 1;
                end
                if inputImg(r + 1, c - 1) == 0 && inputImg(r + 1, c) == 1
                    nCount = nCount + 1;
                end
                if inputImg(r + 1, c) == 0 && inputImg(r + 1, c + 1) == 1
                    nCount = nCount + 1;
                end
                if inputImg(r + 1, c + 1) == 0 && inputImg(r, c + 1) == 1
                    nCount = nCount + 1;
                end
                if inputImg(r, c + 1) == 0 && inputImg(r - 1, c + 1) == 1
                    nCount = nCount + 1;
                end
                if inputImg(r - 1, c + 1) == 0 && inputImg(r - 1, c) == 1
                    nCount = nCount + 1;
                end
                if nCount == 1
                    condition2 = 1;
                end

                %�ж�p2*p4*p8 = 0 or Z(p2) != 1
                if inputImg(r - 1, c) * inputImg(r, c - 1) * inputImg(r, c + 1) == 0
                    condition3 = 1;
                else 
                    nCount = 0;
                    if inputImg(r - 2, c) == 0 && inputImg(r - 2, c - 1) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r - 2, c - 1) == 0 && inputImg(r - 1, c - 1) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r - 1, c - 1) == 0 && inputImg(r, c - 1) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r, c - 1) == 0 && inputImg(r, c) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r, c) == 0 && inputImg(r, c + 1) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r, c + 1) == 0 && inputImg(r - 1, c + 1) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r - 1, c + 1) == 0 && inputImg(r - 2, c + 1) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r - 2, c + 1) == 0 && inputImg(r - 2, c) == 1
                        nCount = nCount + 1;
                    end
                    if nCount ~= 1
                        condition3 = 1;
                    end
                end

                %�ж�p2*p4*p6 = 0 or Z(p4) != 1
                if inputImg(r - 1, c) * inputImg(r, c - 1) * inputImg(r + 1, c) == 0
                    condition4 = 1;
                else 
                    nCount = 0;
                    if inputImg(r - 1, c - 1) == 0 && inputImg(r - 1, c - 2) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r - 1, c - 2) == 0 && inputImg(r, c - 2) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r, c - 2) == 0 && inputImg(r + 1, c - 2) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r + 1, c - 2) == 0 && inputImg(r + 1, c - 1) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r + 1, c - 1) == 0 && inputImg(r + 1, c) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r + 1, c) == 0 && inputImg(r, c) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r, c) == 0 && inputImg(r - 1, c) == 1
                        nCount = nCount + 1;
                    end
                    if inputImg(r - 1, c) == 0 && inputImg(r - 1, c - 1) == 1
                        nCount = nCount + 1;
                    end
                    if nCount ~= 1
                        condition4 = 1;
                    end
                end

                if (condition1 == 1 && condition2 == 1 && condition3 == 1 && condition4 == 1)
                    updateImg(r, c) = 0;
                    modified = 1;
                end
            end 
        end % end of row
    end % end of column
    inputImg = inputImg.*updateImg;
    count = count + 1;
end
%step 2 ϸ���Ľ� ���޵㲻�ǵ����ص�
for i = 2 : row - 1
    for j = 2 : column - 1
        if inputImg(i, j) == 1 && inputImg(i - 1, j) == 1 && inputImg(i, j - 1) == 1
            inputImg(i, j) = 0;
        end
        if inputImg(i, j) == 1 && inputImg(i - 1, j) == 1 && inputImg(i, j + 1) == 1
            inputImg(i, j) = 0;
        end
        if inputImg(i, j) == 1 && inputImg(i + 1, j) == 1 && inputImg(i, j - 1) == 1
            inputImg(i, j) = 0;
        end
        if inputImg(i, j) == 1 && inputImg(i + 1, j) == 1 && inputImg(i, j + 1) == 1
            inputImg(i, j) = 0;
        end
    end
end
inputImg = ~inputImg;


