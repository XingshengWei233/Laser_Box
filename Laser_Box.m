classdef Laser_Box
    %LASER_BOX Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        X %length
        Y %width
        Z %height
        T %material thickness
        lid %if lid exist
        divider %0 for no divider, 1/3, 1/2, 2/3
        side_text
        lid_text
    end
    
    methods
        function obj = Laser_Box(X,Y,Z,T,lid,divider,side_text,lid_text)
            %LASER_BOX Construct an instance of this class
            %   Detailed explanation goes here
            obj.X = X;
            obj.Y = Y;
            obj.Z = Z;
            obj.T = T;
            obj.lid = lid;
            obj.divider = divider;
            obj.side_text = side_text;
            obj.lid_text = lid_text;
        end
        
        function shape = screw_slot(obj,x,y,o)
            %SCREW_SLOT Summary of this function goes here
            %   o: orientation U(up),D(down),L(left),R(right)
            t=obj.T;
            shape = [1 0; 1 6-t; 2.3 6-t; 2.3 7.5-t; 1 7.5-t; 1 10.5-t;
                -1 10.5-t; -1 7.5-t; -2.3 7.5-t; -2.3 6-t; -1 6-t; -1 0];%upward
            if o == 'D'
                shape = shape*[-1 0;0 -1];
            end
            if o == 'R'
                shape = shape*[0 -1;1 0];
            end
            if o == 'L'
                shape = shape*[0 1;-1 0];
            end
            shape(:,1) = shape(:,1)+x;
            shape(:,2) = shape(:,2)+y;
        end
       
        function hole = screw_hole(~,x,y)
            %SCREW_HOLE Summary of this function goes here
            %   Detailed explanation goes here
            cx = x;
            cy = y;
            r = 1; %mm
            hole = [cx,cy,r];
        end
        
        function base = base_face(obj)
            % x is the horizontal length
            % y is the vertical length downward
            % t is the thick ness
            x = obj.X;
            y = obj.Y;
            t = obj.T;
            base=[0 0;x/4 0;x/4 t;flip(screw_slot(obj,x/2,t,'U'));3*x/4 t;3*x/4,0;x 0;x y/4;x-t y/4;flip(screw_slot(obj,x-t,y/2,'L'));x-t 3*y/4;
                x 3*y/4;x y;3*x/4 y;3*x/4 y-t;flip(screw_slot(obj,x/2,y-t,'D'));x/4 y-t;x/4 y;0 y;0 3*y/4;t 3*y/4;flip(screw_slot(obj,t,y/2,'R'));
                t y/4;0 y/4;0 0];
        end
        
        function x_face=x_face(obj)
            % x is the length of the face
            % y is the height of the face 
            % t is the thickness of the acrylic
            x = obj.X;
            z = obj.Z;
            t = obj.T;
             x_face=[t 0;x-t 0;x-t z/4;x z/4;x 3*z/4;x-t 3*z/4;x-t z-t;3*x/4 z-t;3*x/4,z;x/4 z;x/4 z-t;t z-t;t 3*z/4;0 3*z/4;
                 0 z/4;t z/4;t 0];
        end
        
        function holes = x_face_hole(obj)
            z=obj.Z;
            t=obj.T;
            x=obj.X;
            holes = [obj.screw_hole(0,z-t/2);obj.screw_hole(x/2-t/2,z/2);obj.screw_hole(-x/2+t/2,z/2)];
            holes(:,1) = holes(:,1)+x/2;
        end
        
        function holes = y_face_hole(obj)
            holes = obj.screw_hole(obj.Y/2,obj.Z-obj.T/2);
            if obj.lid == true
                holes(2,:) = [7.5,-1.5,4.5/2];
            end
        end
        
        function y_face=y_face(obj)
            % x is the length of the face
            % y is the height of the face 
            % t is the thickness of the acrylic
            % a is the answer of wether or not require a lid "Y"/"N"
            % b is the anser of wether or not require a divider "Y"/"N" ???
            % l is the location of the lid 1/3, 1/2, 2/3 ???
            y = obj.Y;
            z = obj.Z;
            t = obj.T;
            if obj.lid == true
                % lid holder dimention 
                r=7.5; %% mm
                theta=0:-pi/10:-pi;
                xc = (r * cos(theta) + r)';
                yc = (r * sin(theta) + 0)';
                circle=flip([xc yc]);
                y_face=[circle;y 0;y z/4;y-t z/4;flip(obj.screw_slot(y-t,z/2,'L'));y-t 3*z/4;y 3*z/4;y z-t;3*y/4 z-t;3*y/4,z;y/4 z;y/4 z-t;0 z-t;0 3*z/4;t 3*z/4;
                flip(obj.screw_slot(t,z/2,'R'));t z/4;0 z/4;0 0];
            else
                y_face=[0 0;y 0;y z/4;y-t z/4;flip(obj.screw_slot(y-t,z/2,'L'));y-t 3*z/4;y 3*z/4;y z-t;3*y/4 z-t;3*y/4,z;y/4 z;y/4 z-t;0 z-t;0 3*z/4;t 3*z/4;
                flip(obj.screw_slot(t,z/2,'R'));t z/4;0 z/4;0 0];
            end
        end
        
        function lid_face = lid_face(obj)
            x=obj.X;
            y=obj.Y;
            t=obj.T;
            lo=4; %mm length offset
            wo=10; %mm width offset
            lid_face=[0 0;x 0;x t;x-lo t;x-lo t+wo;x t+wo;x y;0 y;0 t+wo;lo t+wo;lo t;0 t;0 0];
        end
        
        function divider_face = divider_face(obj)
            x=obj.X;
            z=obj.Z;
            t=obj.T;
            divider_face=[t 0;x-t 0;x-t (z-t)/4;x (z-t)/4;x 3*(z-t)/4;x-t 3*(z-t)/4;x-t z-t;t z-t;t 3*(z-t)/4;0 3*(z-t)/4;0 (z-t)/4;t (z-t)/4;t 0];
        end
        
        function slot = divider_slot(obj)
            t=obj.T;
            z=obj.Z;
            y=obj.Y;
            slot=[0 0;t 0;t (z-t)/2;0 (z-t)/2;0 0];
            slot(:,2)=slot(:,2)+(z-t)/4;
            if obj.divider == 1/3
                slot(:,1)=slot(:,1)+y/3;
            elseif obj.divider == 1/2
                slot(:,1)=slot(:,1)+y/2;
            elseif obj.divider == 2/3
                slot(:,1)=slot(:,1)+2*y/3; %3/4?
            end

         end
        
        function pattern = decoration(obj)
                % center circle dimention 
                x=obj.X;
                z=obj.Z;
                r0=min(z,x)/4; %% mm
                theta=linspace(0,360,180);
                x0 = (r0 * cos(theta) + x/2)';
                y0 = (r0 * sin(theta) + z/2)';
                r1_2=r0/2;
                r3_4=r1_2/2;
                x1 = (r1_2 * cos(theta) + x/2+r0)';
                y1 = (r1_2 * sin(theta) + z/2)';
                x2 = (r1_2 * cos(theta) + x/2-r0)';
                y2 = (r1_2 * sin(theta) + z/2)';
                x3 = (r3_4 * cos(theta) + x/2+r0+r1_2)';
                y3 = (r3_4 * sin(theta) + z/2)';
                x4 = (r3_4 * cos(theta) + x/2-r0-r1_2)';
                y4 = (r3_4 * sin(theta) + z/2)';
                pattern=zeros(180,2,5);
                pattern(:,1,1)=x0;
                pattern(:,2,1)=y0;
                pattern(:,1,2)=x1;
                pattern(:,2,2)=y1;
                pattern(:,1,3)=x2;
                pattern(:,2,3)=y2;
                pattern(:,1,4)=x3;
                pattern(:,2,4)=y3;
                pattern(:,1,5)=x4;
                pattern(:,2,5)=y4;
        end
        
        function fprintf_pattern(~,file,offset,pattern)
            fprintf(file,'\n<!--pattern--> \n');
            pattern = pattern*1; %scale
            for n = 1:size(pattern,3)
                pattern(:,1,n) = pattern(:,1,n)+offset(1);
                pattern(:,2,n) = pattern(:,2,n)+offset(2);
                fprintf(file,'  <polygon points="');
                for i = 1:size(pattern,1)
                    fprintf(file,'%8.3f,%8.3f ',pattern(i,:,n));
                end
                fprintf(file,'" \n fill="none" stroke="blue" />\n');
            end
        end
        
        function fprintf_text(obj,file,offset,text)
            %xy = [obj.X/2,obj.Z/2];
            size = 6;
            fprintf(file,'\n<!--text--> \n');
            fprintf(file,'  <style>\n');
            fprintf(file,'  .small { font: bold %dpx sans-serif; fill: red;}\n',size);
            fprintf(file,'  </style>\n');
            fprintf(file,'  <text x="%d" y="%d" text-anchor="middle" class="small"> ',offset);
            fprintf(file,text);
            fprintf(file,' </text>\n');
            
        end
        
        function fprintf_image(obj,file,offset,image)
            xy = [0,0];
            size = [10 10];
            currentFolder = pwd;
            fprintf(file,'\n<!--image--> \n');
            fprintf(file,'  <image xlink:href="');
            fprintf(file,image);
            fprintf(file,'" x="%8.3f" y="%8.3f"',xy+offset);
            fprintf(file,'" width="%8.3f" height="%8.3f"',size);
            fprintf(file,' />\n');
            
        end
        
        function fprintf_face(~,file,offset,verteces,holes)
            %if no hole put [] for holes
            fprintf(file,'\n<!--face--> \n');
            fprintf(file,'  <polygon points="');
            nVert = size(verteces);
            nVert = nVert(1);
            verteces(:,1) = verteces(:,1)+offset(1);
            verteces(:,2) = verteces(:,2)+offset(2);
            for i = 1:nVert
                fprintf(file,'%8.3f,%8.3f ',verteces(i,:));
            end
            fprintf(file,'" \n fill="none" stroke="black" />\n');
            
            nHole = size(holes);
            nHole = nHole(1);
            
            if nHole>0
                holes(:,1) = holes(:,1)+offset(1);
                holes(:,2) = holes(:,2)+offset(2);
                for i = 1:nHole
                    fprintf(file,'  <circle cx="%8.3f" cy="%8.3f" r="%8.3f"  fill="none" stroke="black" />\n',holes(i,:));
                end
            end
        end
        
        function create_svg(obj,file_name)
            file = fopen(file_name,'w');
            fprintf(file,'<?xml version ="1.0" encoding="UTF-8" ?>\n');
            fprintf(file,'<svg xmlns="http://www.w3.org/2000/svg" version="1.1">\n');
            base_offset = [0,0];
            
            xf_offset1 = [0,obj.Y+obj.T];
            xf_offset2 = [0,obj.Y+2*obj.T+obj.Z];
            yf_offset1 = [obj.X+obj.T,6];
            yf_offset2 = [obj.X+obj.T,12+obj.Z];
            
            obj.fprintf_face(file,base_offset,obj.base_face(),[]);
            
            obj.fprintf_face(file,xf_offset1,obj.x_face(),obj.x_face_hole());
            obj.fprintf_text(file,xf_offset1+[obj.X/2,obj.Z/2],obj.side_text);
            %obj.fprintf_image(file,xf_offset1,'logo.png');
            
            obj.fprintf_face(file,xf_offset2,obj.x_face(),obj.x_face_hole());
            
            
            obj.fprintf_face(file,yf_offset1,obj.y_face(),obj.y_face_hole());
            obj.fprintf_face(file,yf_offset1,obj.divider_slot(),[]);
            obj.fprintf_face(file,yf_offset2,obj.y_face(),obj.y_face_hole());
            obj.fprintf_face(file,yf_offset2,obj.divider_slot(),[]);
            obj.fprintf_pattern(file,xf_offset2,obj.decoration());
            
            if obj.lid == true
                lf_offset = [obj.X+2*obj.T+obj.Y,6];
                obj.fprintf_face(file,lf_offset,obj.lid_face(),[]);
                obj.fprintf_text(file,lf_offset+[obj.X/2,obj.Y/2],obj.lid_text);
            end
            if obj.divider ~= 0
                df_offset = [obj.X+obj.T,12+2*obj.Z+obj.T];
                obj.fprintf_face(file,df_offset,obj.divider_face(),[]);
            end
            
            fprintf(file,'</svg>');
            fclose(file);
        end
        
        
    end
end

