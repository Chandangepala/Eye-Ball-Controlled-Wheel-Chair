function [] = straight()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
disp('Setting up serial communication...');
% Determine which COM port is for microcontroller and change
ard = serial('COM5','Parity','none','FlowControl','none','BaudRate',4800);
% Open serial COM port for communication


straight2=imread('straight2.png');
%set(ard,'Timeout',10);
pause(1);
fig2=figure('Name','VISION CONTROL SYSTEM','NumberTitle','off','color','k');
axis off;
 %subplot(2,1,1);
  %text(0.2,1,'STRAIGHT DETECTED','color','w','fontsize',20);
 mov = 'F';
 fopen(ard);    
 fprintf(ard,'%s',char(mov));
 while true
      %subplot(2,1,2);
     imshow(straight2);
      a = fscanf(ard,'%s');
      disp(a);
       if a == 'F'
            break;
       end     
 end
 fclose(ard);
 close(fig2);
end

