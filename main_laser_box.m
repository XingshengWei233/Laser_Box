clc;
close all;
clear;

x=input('What is your desired width of the box ? ')
y=input('What is your desired length of the box ? ')
z=input('What is your desired height of the box ? ')
d=input('Where do you want the divider to be ? (center, front 1/3, back 1/3)')
t=input('How thick is the material ? ')

square = fopen('LaserSqure.txt','w');
fprintf(square,'<?xml version ="1.0" encoding="UTF-8" ?>\n');
fprintf(square,'<svg xmlns="http://www.w3.org/2000/svg" version="1.1">\n');
fprintf(square,'<rect x="0" y="0"  width="%d" height="%d" fill="none" stroke-width="1" stroke="pink" />\n',x,y);
fprintf(square,'</svg>');
fclose(square);

