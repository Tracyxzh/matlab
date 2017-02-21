clear all
clc;

I=imread('D:\workspace\MATLAB\pic\testjq.jpg');
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
            
            %��ʼ���ĸ�������Ϊ������
            condition1=0;
            condition2=0;
            condition3=0;
            condition4=0; 
            
            if bw(i,j)==1 %���ĵ�����ֵ����Ϊ1
            
                %*************����1*****************************
                % 8����ֵΪ"1"�ĸ���NZ����NZ��2~6֮��ʱ������1����������ǰ���ĵ㲻�ɱ��Ϊɾ��
                NZ=bw(i-1,j-1)+bw(i-1,j)+bw(i-1,j+1)+bw(i,j-1)+bw(i,j+1)+bw(i+1,j-1)+bw(i+1,j)+bw(i+1,j+1);
                if ( NZ>=2 && NZ<=6 ) 
                    condition1=1; %����������1
                end
                
                %*************����2*****************************
                %����Z0(p1)
                nCount = 0;
                if bw(i-1,j)==0 && bw(i-1,j-1)==1 nCount=nCount+1; end
                if bw(i-1,j-1)==0 && bw(i,j-1)==1 nCount=nCount+1; end
                if bw(i,j-1)==0 && bw(i+1,j-1)==1 nCount=nCount+1; end
                if bw(i+1,j-1)==0 && bw(i+1,j)==1 nCount=nCount+1; end
                if bw(i+1,j)==0 && bw(i+1,j+1)==1 nCount=nCount+1; end
                if bw(i+1,j+1)==0 && bw(i,j+1)==1 nCount=nCount+1; end
                if bw(i,j+1)==0 && bw(i-1,j+1)==1 nCount=nCount+1; end
                if bw(i-1,j+1)==0 && bw(i-1,j)==1 nCount=nCount+1; end
                Z0P1=nCount;
                
                if Z0P1==1 
                    condition2=1; %����������2 ��ǰ����Χֻ��1��0-1�������
                end
                
                %*************����3*****************************
                % ����������3 P2*P4*P8=0
                if bw(i-1,j)*bw(i,j-1)*bw(i,j+1)==0
                    condition3=1;
                % ��������3����һ�ַ�ʽ P2*P4*P8!=0 �� Z0(P1)!=1
                else 
                    nCount = 0;
                    if bw(i-1,j)==0 && bw(i-1,j-1)==1 nCount=nCount+1; end
                    if bw(i-1,j-1)==0 && bw(i,j-1)==1 nCount=nCount+1; end
                    if bw(i,j-1)==0 && bw(i+1,j-1)==1 nCount=nCount+1; end
                    if bw(i+1,j-1)==0 && bw(i+1,j)==1 nCount=nCount+1; end
                    if bw(i+1,j)==0 && bw(i+1,j+1)==1 nCount=nCount+1; end
                    if bw(i+1,j+1)==0 && bw(i,j+1)==1 nCount=nCount+1; end
                    if bw(i,j+1)==0 && bw(i-1,j+1)==1 nCount=nCount+1; end
                    if bw(i-1,j+1)==0 && bw(i-1,j)==1 nCount=nCount+1; end
                    Z0P1=nCount;
                    if Z0P1~=1 
                        condition3=1; %����������2 ��ǰ����Χֻ��1��0-1�������
                    end
                end
                
                %*************����4*****************************
                % ����������4 P2*P4*P6=0
                if bw(i-1,j)*bw(i,j-1)*bw(i+1,j)==0
                    condition4=1;
                % ��������4����һ�ַ�ʽ P2*P4*P6!=0 �� Z0(P4)!=1
                else 
                    nCount = 0;
                    if bw(i-1,j-1)==0 && bw(i-1,j-2)==1 nCount=nCount+1; end
                    if bw(i-1,j-2)==0 && bw(i,j-2)==1 nCount=nCount+1; end
                    if bw(i,j-2)==0 && bw(i+1,j-2)==1 nCount=nCount+1; end
                    if bw(i+1,j-2)==0 && bw(i+1,j-1)==1 nCount=nCount+1; end
                    if bw(i+1,j-1)==0 && bw(i+1,j)==1 nCount=nCount+1; end
                    if bw(i+1,j)==0 && bw(i,j)==1 nCount=nCount+1; end
                    if bw(i,j)==0 && bw(i-1,j)==1 nCount=nCount+1; end
                    if bw(i-1,j)==0 && bw(i-1,j-1)==1 nCount=nCount+1; end
                    Z0P4=nCount;
                    if Z0P4~=1 
                        condition4=1; %����������2 ��ǰ����Χֻ��1��0-1�������
                    end
                end
                
                % �ĸ�����������ʱ�ſ��Խ���ǰ���ص����Ա��Ϊϸ����
                if condition1==1 && condition2==1 && condition3==1 && condition4==1
                    bw_note(i,j)=0;  
                    Flag=1;
                end
              
            end %end of  "if bw(i,j)==1 %���ĵ�����ֵ����Ϊ1"
        end %end of "for j=2:width-1"
    end %end of "for i=2:height-1"
    
    bw = bw.*bw_note;
    count=count+1;
%     figure,imshow(bw)
        
end %end of while

figure(1);
subplot(121);
imshow(bw0);
subplot(122);
imshow(bw);
figure(2);
bw2=bw0-bw;
imshow(bw2);
