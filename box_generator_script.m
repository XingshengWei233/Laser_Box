clear
clc
close all

%% Input arguments
t = input('Please tell us the thickness of the material you wanna use(in mm): ');
while t<1 || t>10
    t = input('This thickness is not available, please try again(in mm): ');
end
X = input('Please tell us the width of the box you desire(in mm): ');
while X<30 || X>120
    X = input('This width is not available, please try again(in mm): ');
end
Y = input('Please tell us the lengh of the box you desire(in mm): ');
while Y<30 || Y>120
    Y = input('This length is not available, please try again(in mm): ');
end
Z = input('Please tell us the height of the box you desire(in mm): ');
while Z<30 || Z>120
    Z = input('This height is not available, please try again(in mm): ');
end
cover = input("Do you want a lid for the box('Y' or 'N'): ");
while cover ~= 'Y' && cover ~= 'N'
    cover = input("Please enter('Y' or 'N') with single quote：");
end
if cover == 'Y'
    lid = true;
elseif cover == 'N'
    lid = false;
end
divider = input('Where do you want the divider to be at(0(no divider), 1/3, 1/2 or 2/3): ');
while divider ~= 0 && cover ~= 1/3 && cover ~= 1/2 && cover ~= 2/3
    divider = input("Please enter 0(no divider), 1/3, 1/2 or 2/3：");
end
side_text = input('What do you want to type at front (with single quote): ');
lid_text = input('What do you want to type at the lid (with single quote): ');


%% Generating box for laser cutter
box1 = Laser_Box(X,Y,Z,t,lid,divider,side_text,lid_text);
box1.create_svg('generator_output/box2.svg');
disp('Please convert to .dxf file for laser cutting.')



