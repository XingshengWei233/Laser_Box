clear
clc
close all

%slot = screw_slot(0,0,'D',3);
t = input('Please tell us the thickness of the material you wanna use(in mm): ')%3
while t<1 || t>10
    t=input('This thickness is not available, please try again(in mm): ')
end
X = input('Please tell us the width of the box you desire(in mm): ')%90;
while X<30 || X>120
    X=input('This width is not available, please try again(in mm): ')
end
Y = input('Please tell us the lengh of the box you desire(in mm): ')%100;
while Y<30 || Y>120
    Y=input('This length is not available, please try again(in mm): ')
end
Z = input('Please tell us the height of the box you desire(in mm): ')%110;
while Z<30 || Z>120
    Z=input('This height is not available, please try again(in mm): ')
end
cover=input("Do you want a lid for the box('Y' or 'N'): ")
    while cover~='Y' & cover~='N'
        cover=input("Please use authentic language('Y' or 'Y')：")
    end
    if cover == 'Y'
        lid = true;
    else
        lid = false;
    end
divider=input('Where do you want the divider to be at(0(no divider), 1/3, 1/2 or 2/3): ')
side_text = input('What do you want to type at front: ');
lid_text = input('What do you want to type at the lid: ');
%plot(slot(:,1),slot(:,2))

box1 = Laser_Box(X,Y,Z,t,lid,divider,side_text,lid_text);

box1.create_svg('box1.svg');


