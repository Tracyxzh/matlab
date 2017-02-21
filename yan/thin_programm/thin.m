clear all
clc;

I=imread('D:\workspace\MATLAB\pic\testjq.jpg');
bw0 = im2bw(I);

bw = bw0;
[height,width]=size(bw);%计算图像大小
bw_note=ones(height,width);
   
Flag=1;
count=0;
while(Flag)
    
    Flag=0; 
    bw_note=ones(height,width);
    
    for i=3:height-2    
        for j=3:width-2
            
            %初始化四个条件均为不成立
            condition1=0;
            condition2=0;
            condition3=0;
            condition4=0; 
            
            if bw(i,j)==1 %中心点像素值必须为1
            
                %*************条件1*****************************
                % 8邻域值为"1"的个数NZ，当NZ在2~6之间时，条件1成立，否则当前中心点不可标记为删除
                NZ=bw(i-1,j-1)+bw(i-1,j)+bw(i-1,j+1)+bw(i,j-1)+bw(i,j+1)+bw(i+1,j-1)+bw(i+1,j)+bw(i+1,j+1);
                if ( NZ>=2 && NZ<=6 ) 
                    condition1=1; %满足标记条件1
                end
                
                %*************条件2*****************************
                %计算Z0(p1)
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
                    condition2=1; %满足标记条件2 当前点周围只有1个0-1的跳变点
                end
                
                %*************条件3*****************************
                % 满足标记条件3 P2*P4*P8=0
                if bw(i-1,j)*bw(i,j-1)*bw(i,j+1)==0
                    condition3=1;
                % 满足条件3的另一种方式 P2*P4*P8!=0 且 Z0(P1)!=1
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
                        condition3=1; %满足标记条件2 当前点周围只有1个0-1的跳变点
                    end
                end
                
                %*************条件4*****************************
                % 满足标记条件4 P2*P4*P6=0
                if bw(i-1,j)*bw(i,j-1)*bw(i+1,j)==0
                    condition4=1;
                % 满足条件4的另一种方式 P2*P4*P6!=0 且 Z0(P4)!=1
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
                        condition4=1; %满足标记条件2 当前点周围只有1个0-1的跳变点
                    end
                end
                
                % 四个条件均满足时才可以将当前像素点予以标记为细化点
                if condition1==1 && condition2==1 && condition3==1 && condition4==1
                    bw_note(i,j)=0;  
                    Flag=1;
                end
              
            end %end of  "if bw(i,j)==1 %中心点像素值必须为1"
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
