# Laser_Box
Author: Jiyuan Hu, Xingsheng Wei
![alt text](https://github.com/XingshengWei233/Laser_Box/blob/main/image/picture.jpg)
## Discription
Use MATLAB to write a program that takes several input parameters (size, lid, etc.) and generate an SVG file that describes a box to be cut on acrylic with a laser cutter.
## Video:
https://www.youtube.com/watch?v=BHkOxt_D4hE&list=TLGG3zWp9eMiuzowMTA2MjAyMg&t=31s
## Content
### box_generator_script.m
Main script to ask the user to input the parameters and generate the SVG file.
### Laser_Box.m
A class that contains the parameters and functions that generates each feature (faces, lid, text, corresponding SVG code) of the box.
## Approach
1. Wrote a LaserBox class that contains the parameters and functions that generates each feature (faces, lid, text) of the box. /
2. Added a function to the LaserBox class to write XML text of the SVG format to an SVG file. /
3. Wrote a main script to ask the user to input the parameters and generate the SVG file. /
![alt text](https://github.com/XingshengWei233/Laser_Box/blob/main/image/generated%20SVG.PNG)
