clear all
clc;

%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

I=imread('m1.bmp');
bw0 = im2bw(I);

bw = bw0;
[height,width]=size(bw);%����ͼ���С
bw_note=ones(height,width);

Flag=1;
count=0;
while(Flag)
    Flag=0;
    
    bw_note=ones(height,width);
    
    for i=3:height-2    
        for j=3:width-2
            
            n0=0;n1=0;n2=0;n3=0;
            
            if bw(i,j)==1 %���ĵ�����ֵ����Ϊ1
                % Hilditch �㷨��һ�� B(p1)
                a=bw(i-1,j-1)+bw(i-1,j)+bw(i-1,j+1)+bw(i,j-1)+bw(i,j+1)+bw(i+1,j-1)+bw(i+1,j)+bw(i+1,j+1);%�������ĵ���ΧΪ1�ĸ���
                if ( a>=2 && a<=6 ) %����2<=a<=6Ϊ1��������Ϊ0
                    n0=1; %����������
                else
                    n0=0;
                end
                
                % Hilditch�㷨�ڶ���A(p1)
                if bw(i-1,j)==0 && bw(i-1,j+1)==1
                    c1=xor(bw(i-1,j),bw(i-1,j+1))*(bw(i-1,j)-bw(i-1,j+1));
                elseif bw(i-1,j)==1
                    c1=0;
                end % (0-1)�ż���һ��
                if bw(i-1,j+1)==0
                    c2=xor(bw(i-1,j+1),bw(i,j+1))*(bw(i-1,j+1)-bw(i,j+1));
                elseif bw(i-1,j+1)==1
                    c2=0;
                 end % (0-1)�ż���һ��
                if bw(i,j+1)==0
                    c3=xor(bw(i,j+1),bw(i+1,j+1))*(bw(i,j+1)-bw(i+1,j+1));
                elseif bw(i,j+1)==1
                    c3=0;
                end % (0-1)�ż���һ��
                if bw(i+1,j+1)==0
                    c4=xor(bw(i+1,j+1),bw(i+1,j))*(bw(i+1,j+1)-bw(i+1,j));
                elseif bw(i+1,j+1)==1
                    c4=0;
                end % (0-1)�ż���һ��
                if bw(i+1,j)==0
                    c5=xor(bw(i+1,j),bw(i+1,j-1))*(bw(i+1,j)-bw(i+1,j-1));
                elseif bw(i+1,j)==1
                    c5=0;
                end % (0-1)�ż���һ��
                if bw(i+1,j-1)==0
                    c6=xor(bw(i+1,j-1),bw(i,j-1))*(bw(i+1,j-1)-bw(i,j-1));
                elseif bw(i+1,j-1)==1
                    c6=0;
                end % (0-1)�ż���һ��
                if bw(i,j-1)==0
                    c7=xor(bw(i,j-1),bw(i-1,j-1))*(bw(i,j-1)-bw(i-1,j-1));
                elseif bw(i,j-1)==1
                    c7=0;
                end % (0-1)�ż���һ��
                
                c=c1+c2+c3+c4+c5+c6+c7;  % ����0-1�ĸ�����
                %pause;
                c=-c% ����
                %pause;
                if c==1
                    n1=1;
                else
                    n1=0;
                end % 0-1����ֻ��һ�ε�ʱ��Ϊ1
                %pause;
                % Hildtch������3.1
                if bw(i-1,j)*bw(i,j+1)*bw(i,j-1)==0
                    d0=1;
                else 
                    d0=0;
                end % p2*p4*p8��ֵΪ0��d0Ϊ1
                
                % Hildtch������3.2
                if i>2&&j>2 %p2Ҫ��8����
                    if bw(i-2,j)==0
                        c1=xor(bw(i-2,j),bw(i-2,j+1))*(bw(i-2,j)-bw(i-2,j+1));
                    elseif bw(i-2,j)==1
                        c1=0;
                    end % (0-1)�ż���һ��
                     if bw(i-2,j+1)==0
                        c2=xor(bw(i-2,j+1),bw(i-1,j+1))*(bw(i-2,j+1)-bw(i-1,j+1));
                    elseif bw(i-2,j+1)==1
                        c2=0;
                    end % (0-1)�ż���һ��
                    if bw(i-1,j+1)==0
                        c3=xor(bw(i-1,j+1),bw(i,j+1))*(bw(i-1,j+1)-bw(i,j+1));
                    elseif bw(i-1,j+1)==1
                        c3=0;
                    end % (0-1)�ż���һ��
                    if bw(i,j+1)==0
                        c4=xor(bw(i,j+1),bw(i,j))*(bw(i,j+1)-bw(i,j));
                    elseif bw(i,j+1)==1
                        c4=0;
                    end % (0-1)�ż���һ��
                    if bw(i,j)==0
                        c5=xor(bw(i,j),bw(i,j-1))*(bw(i,j)-bw(i,j-1));
                    elseif bw(i,j)==1
                        c5=0;
                    end % (0-1)�ż���һ��
                    if bw(i,j-1)==0
                        c6=xor(bw(i,j-1),bw(i-1,j-1))*(bw(i,j-1)-bw(i-1,j-1));
                    elseif bw(i,j-1)==1
                        c6=0;
                    end % (0-1)�ż���һ��
                    if bw(i-1,j-1)==0
                        c7=xor(bw(i-1,j-1),bw(i-2,j-1))*(bw(i-1,j-1)-bw(i-2,j-1));
                    elseif bw(i-1,j-1)==1
                        c7=0;
                    end % (0-1)�ż���һ��
                    c=c1+c2+c3+c4+c5+c6+c7;
                    c=-c;
                    if c==1
                        d1=1;
                    else
                        d1=0; % 0-1����ֻ��һ�ε�ʱ��Ϊ1
                    end
                else
                    d1=0;
                end
                    n2=or(d0,d1); % ����p2*p4*p8=0����0-1����ֻ��һ��ʱ���Ϊ1
                    % Hildtch���Ĳ�4.1
                    if bw(i-1,j)*bw(i,j+1)*bw(i+1,j)==0
                        d0=1;
                    elseif bw(i-1,j)*bw(i,j+1)*bw(i+1,j)==1
                         d0=0;
                    end % p2*p4*p6=0ʱΪ1
                    
                % Hildtch���Ĳ�4.2
                    if ((i>2&&j>2) && (i<height-1 && j<width-1)) %p4Ҫ��8����
                        if bw(i-1,j+1)==0
                            c1=xor(bw(i-1,j+1),bw(i-1,j+2))*(bw(i-1,j+1)-bw(i-1,j+2));
                        elseif bw(i-1,j+1)==1
                            c1=0;
                        end
                        if bw(i-1,j+2)==0
                            c2=xor(bw(i-1,j+2),bw(i,j+2))*(bw(i-1,j+2)-bw(i,j+2));
                        elseif bw(i-1,j+2)==1
                            c2=0;
                        end
                        if bw(i,j+2)==0
                            c3=xor(bw(i,j+2),bw(i+1,j+2))*(bw(i,j+2)-bw(i+1,j+2));
                        elseif bw(i,j+2)==1
                             c3=0;
                        end
                        if bw(i+1,j+2)==0
                             c4=xor(bw(i+1,j+2),bw(i+1,j+1))*(bw(i+1,j+2)-bw(i+1,j+1));
                        elseif bw(i+1,j+2)==1
                            c4=0;
                        end
                        if bw(i+1,j+1)==0
                            c5=xor(bw(i+1,j+1),bw(i+1,j))*(bw(i+1,j+1)-bw(i+1,j));
                        elseif bw(i+1,j+1)==1
                            c5=0;
                        end
                        if bw(i+1,j)==0
                            c6=xor(bw(i+1,j),bw(i,j))*(bw(i+1,j)-bw(i,j));
                        elseif bw(i+1,j)==1
                             c6=0;
                        end
                        if bw(i,j)==0
                             c7=xor(bw(i,j),bw(i-1,j))*(bw(i,j)-bw(i-1,j));
                        elseif bw(i,j)==1
                             c7=0;
                        end
                         c=c1+c2+c3+c4+c5+c6+c7;
                          c=-c;
                         if c==1
                            d1=1;
                         else
                             d1=0;
                         end % p4ͬǰ����
                    else 
                        d0=0;
                    end
            n3=or(d0,d1);
            
            
            if n0*n1*n2*n3==1
                bw_note(i,j)=0;
                Flag=1;
            end
            end    
       end
    end
    
    bw = bw.*bw_note;
    count=count+1;
    figure,imshow(bw)
    %title('Hildtch�㷨ϸ�����ͼ��')
end

figure(1);
subplot(121);
imshow(bw0);
subplot(122);
imshow(bw);
figure(2);
bw2=bw0-bw;
imshow(bw2);
