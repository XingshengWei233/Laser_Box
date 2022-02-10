clear
clc
close all

%slot = screw_slot(0,0,'D',3);
t = 3;
X = 90;
Y = 100;
Z = 110;
lid = true;
divider = 1/3;
%plot(slot(:,1),slot(:,2))

box1 = Laser_Box(X,Y,Z,t,lid,divider);

box1.create_svg('box1.svg');




%% plot test
base = box1.base_face();
figure(1)
plot(base(:,1),base(:,2))
hold on
title('base')
axis equal

x_face = box1.x_face();
x_face_hole = box1.x_face_hole();
pattern=box1.decoration();
figure(2)
plot(x_face(:,1),x_face(:,2))
hold on
plot(x_face_hole(:,1),x_face_hole(:,2),'o')
for i=1:5
plot(pattern(:,1,i),pattern(:,2,i))
end
title('x-face')
axis equal

y_face = box1.y_face();
y_face_hole = box1.y_face_hole();
divider_slot=box1.divider_slot("top");%topr/middle/bottom
figure(3)
plot(y_face(:,1),y_face(:,2))
hold on
plot(y_face_hole(:,1),y_face_hole(:,2),'o')
plot(divider_slot(:,1),divider_slot(:,2),'b')
title('y-face')
axis equal

divider = box1.divider_face();
figure(4)
plot(divider(:,1),divider(:,2))
title('divider')
axis equal

lid_face = box1.lid_face();
figure(5)
plot(lid_face(:,1),lid_face(:,2))
title('divider')
axis equal
