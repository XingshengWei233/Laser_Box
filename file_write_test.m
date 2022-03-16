clc;
close all;
clear;

x=input('What is your desired width of the square ? ')
y=input('What is your desired length of the sqare ? ')

square = fopen('LaserSqure.txt','w');
fprintf(square,'<?xml version ="1.0" encoding="UTF-8" ?>\n');
fprintf(square,'<svg xmlns="http://www.w3.org/2000/svg" version="1.1">\n');
fprintf(square,'<rect x="0" y="0"  width="%d" height="%d" fill="none" stroke-width="1" stroke="pink" />\n',x,y);
fprintf(square,'</svg>');
fclose(square);

