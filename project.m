
clear all   
clf('reset');
fig=figure('Name','VISION CONTROL SYSTEM','NumberTitle','off','color','k');
axis off;
 text(0.2,1,'EYE-BALL','color','w','fontsize',50);
 text(0.2,0.8,'CONTROL','color','w','fontsize',50);
 text(0.2,0.6,'SYSTEM','color','w','fontsize',50);
 text(0.2,0.2,'Developed by:','color','w','fontsize',20);
 text(0.2,0.1,'Anurag,Banne singh,Chandan,Deepanshu','color','w','fontsize',10);

pause(5);
close(fig);
% disp('Setting up serial communication...');
% % Determine which COM port is for microcontroller and change
% s = serial('COM3','Parity','none','FlowControl','none','BaudRate',4800);
% % Open serial COM port for communication
% fopen(s);
% set(s,'Timeout',10);
% F= 'F' ;
   %create webcam object


right=imread('right2.png');
left=imread('left2.png');
noface=imread('noface1.png');
straight1=imread('straight2.png');

detector = vision.CascadeObjectDetector(); % Create a det

%ector for face using Viola-Jones
detector1 = vision.CascadeObjectDetector('EyePairSmall'); %create detector for eyepair

 fig1=figure('Name','VISION CONTROL SYSTEM','NumberTitle','off','color','k');
  cam=webcam(1);  
      axis off;
while true % Infinite loop to continuously detect the face
    
   
%       text(0,1,'GETING READY FOR EYE DETECTION IN: ','color','w','fontsize',20);
%       con=3;
%       for a= 3:0
%       text(0.5,0.5,a,'color','w','fontsize',15);
%       pause(1);
%       end
    
    vid=snapshot(cam);  %get a snapshot of webcam
    vid = rgb2gray(vid);    %convert to grayscale
    img = flip(vid, 2); % Flips the image horizontally
    
     bbox = step(detector, img); % Creating bounding box using detector  
      
     if ~ isempty(bbox)  %if face exists 
         biggest_box=1;     
         for i=1:rank(bbox) %find the biggest face
             if bbox(i,3)>bbox(biggest_box,3)
                 biggest_box=i;
             end
         end
         faceImage = imcrop(img,bbox(biggest_box,:)); % extract the face from the image
         bboxeyes = step(detector1, faceImage); % locations of the eyepair using detector
         
         subplot(2,2,1),subimage(img); hold on; % Displays full image
         for i=1:size(bbox,1)    %draw all the regions that contain face
             rectangle('position', bbox(i, :), 'lineWidth', 2, 'edgeColor', 'y');
         end
         
         subplot(2,2,2),subimage(faceImage);     %display face image
                 
         if ~ isempty(bboxeyes)  %check it eyepair is available
             
             biggest_box_eyes=1;     
             for i=1:rank(bboxeyes) %find the biggest eyepair
                 if bboxeyes(i,3)>bboxeyes(biggest_box_eyes,3)
                     biggest_box_eyes=i;
                 end
             end
             
              for i=1:size(bboxeyes,1)    %draw all the regions that contain eyes
             rectangle('position', bboxeyes(i, :), 'lineWidth', 1, 'edgeColor', 'g');
             end
             
             bboxeyeshalf=[bboxeyes(biggest_box_eyes,1),bboxeyes(biggest_box_eyes,2),bboxeyes(biggest_box_eyes,3)/3,bboxeyes(biggest_box_eyes,4)];   %resize the eyepair width in half
             
             eyesImage = imcrop(faceImage,bboxeyeshalf(1,:));    %extract the half eyepair from the face image
             eyesImage = imadjust(eyesImage);    %adjust contrast

             r = bboxeyeshalf(1,4)/4;
             [centers, radii, metric] = imfindcircles(eyesImage, [floor(r-r/4) floor(r+r/2)], 'ObjectPolarity','dark', 'Sensitivity', 0.93); % Hough Transform
             [M,I] = sort(radii, 'descend');
                 
             eyesPositions = centers;
                 
             subplot(2,2,3),subimage(eyesImage); hold on;
              
             viscircles(centers, radii,'EdgeColor','b');
                  
             if ~isempty(centers)
                pupil_x=centers(1);
                disL=abs(0-pupil_x);    %distance from left edge to center point
                disR=abs(bboxeyes(1,3)/3-pupil_x);%distance from right edge to center point
                subplot(2,2,4);
                if disL>disR+16
                   imshow(right);
                   right1;
                    display('right');
                   % fprintf(s,'%s',char(R));
                else if disR>disL
                    subimage(left);
                    left1;
                    display('Left');
                    % fprintf(s,'%s',char(L));
                    else
                       subimage(straight1); 
                       display('Straight');
                       straight;
                      %fprintf(s,'%s',char(F));
                    end
                end
     
             end          
         end
     else
        subplot(2,2,4);
        subimage(noface);
       % fprintf(s,'%s',char(mov0));
     end
     set(gca,'XtickLabel',[],'YtickLabel',[]);
  
   hold off;
end
