function [] = right1()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
disp('Setting up serial communication...');
% Determine which COM port is for microcontroller and change
ard = serial('COM5','Parity','none','FlowControl','none','BaudRate',4800);
% Open serial COM port for communication


sright2=imread('right2.png');
%set(ard,'Timeout',10);
pause(1);
fig2=figure('Name','VISION CONTROL SYSTEM','NumberTitle','off','color','k');
axis off;
% text(0.2,1,'STRAIGHT DETECTED','color','w','fontsize',50);
 mov = 'R';
 fopen(ard);    
 fprintf(ard,'%s',char(mov));
 while true
     imshow(sright2);
      a = fscanf(ard,'%s');
      disp(a);
       if a == 'R'
            break;
       end     
 end
 fclose(ard);
 close(fig2);
end

