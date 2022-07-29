function [] = left1()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
disp('Setting up serial communication...');
% Determine which COM port is for microcontroller and change
ard = serial('COM5','Parity','none','FlowControl','none','BaudRate',4800);
% Open serial COM port for communication


left1=imread('left2.png');
%set(ard,'Timeout',10);
fig2=figure('Name','VISION CONTROL SYSTEM','NumberTitle','off','color','k');
pause(1);
axis off;
% text(0.2,1,'STRAIGHT DETECTED','color','w','fontsize',50);
 mov = 'L';
 fopen(ard);    
 fprintf(ard,'%s',char(mov));
 while true
     imshow(left1);
      a = fscanf(ard,'%s');
      disp(a);
       if a == 'L'
            break;
       end     
 end
 fclose(ard);
 close(fig2);
end

