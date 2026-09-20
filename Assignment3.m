%% READING IMAGES %%
I1 = imread('C:\Users\gh\OneDrive\Desktop\GROUP 6 MATLAB ASSIGNMENT 3\Jackfruit leaf.jpg');
I2 = imread('C:\Users\gh\OneDrive\Desktop\GROUP 6 MATLAB ASSIGNMENT 3\Coffee leaf.jpg');
I3 = imread('C:\Users\gh\OneDrive\Desktop\GROUP 6 MATLAB ASSIGNMENT 3\Banana leaf.jpg');
I4 = imread('C:\Users\gh\OneDrive\Desktop\GROUP 6 MATLAB ASSIGNMENT 3\Acasia leaf.jpg');
I5 = imread('C:\Users\gh\OneDrive\Desktop\GROUP 6 MATLAB ASSIGNMENT 3\Cassava leaf.jpg');
I6 = imread('C:\Users\gh\OneDrive\Desktop\GROUP 6 MATLAB ASSIGNMENT 3\Guava leaf.jpg');
I7 = imread('C:\Users\gh\OneDrive\Desktop\GROUP 6 MATLAB ASSIGNMENT 3\Maize leaf.jpg');
I8 = imread('C:\Users\gh\OneDrive\Desktop\GROUP 6 MATLAB ASSIGNMENT 3\Mango leaf.jpg');
I9 = imread('C:\Users\gh\OneDrive\Desktop\GROUP 6 MATLAB ASSIGNMENT 3\Pawpaw leaf.jpg');
I10 = imread('C:\Users\gh\OneDrive\Desktop\GROUP 6 MATLAB ASSIGNMENT 3\Pumpkin leaf.jpg');

%% showing images %%
imshow(I1);
imshow(I2);
imshow(I3);
imshow(I4);
imshow(I5);
imshow(I6);
imshow(I7);
imshow(I8);
imshow(I9);
imshow(I10);

%% showing imagepairs %%
imshowpair(I1,I2,'montage');
imshowpair(I3,I4,'montage');
imshowpair(I5,I6,'montage');
imshowpair(I7,I8,'montage');
imshowpair(I9,I10,'montage');

 %% converting to grayscale %% 
I1gs = im2gray(I1);imshow(I1gs);
I2gs = im2gray(I2);imshow(I2gs);
I3gs = im2gray(I3);imshow(I3gs);
I4gs = im2gray(I4);imshow(I4gs);
I5gs = im2gray(I5);imshow(I5gs);
I6gs = im2gray(I6);imshow(I6gs);
I7gs = im2gray(I7);imshow(I7gs);
I8gs = im2gray(I8);imshow(I8gs);
I9gs = im2gray(I9);imshow(I9gs);
I10gs = im2gray(I10);imshow(I10gs);

%%  CREATE THE BIOLOGICAL STRUCTURAL ARRAY %%
leaf = struct('Name',{},'Type',{},'Arrangement',{},'Venation',{},'Shape',{},'Margin',{},'Apex',{},'Petiole',{})
leaf(1).Name = 'Jackfruit';
leaf(1).Type = 'Simple';
leaf(1).Arrangement = 'Alternate';
leaf(1).Venation = 'Reticulate';
leaf(1).Shape = 'Oblong';
leaf(1).Margin = 'Entire';
leaf(1).Apex = 'Acute';
leaf(1).Petiole = 'Present';

leaf(2).Name = 'Coffee';
leaf(2).Type = 'Simple';
leaf(2).Arrangement = 'Opposite';
leaf(2).Venation = 'Reticulate';
leaf(2).Shape = 'Ovate';
leaf(2).Margin = 'Entire/Wavy';
leaf(2).Apex = 'Pointed';
leaf(2).Petiole = 'Present';

leaf(3).Name = 'Banana';
leaf(3).Type = 'Simple';
leaf(3).Arrangement = 'Spiral';
leaf(3).Venation = 'Parallel';
leaf(3).Shape = 'Oblong';
leaf(3).Margin = 'Entire';
leaf(3).Apex = 'Acute';
leaf(3).Petiole = 'Present';

leaf(4).Name = 'Acacia';
leaf(4).Type = 'Compound';
leaf(4).Arrangement = 'Alternate';
leaf(4).Venation = 'Reticulate';
leaf(4).Shape = 'Bipinnate';
leaf(4).Margin = 'Entire';
leaf(4).Apex = 'Variable';
leaf(4).Petiole = 'Present';

leaf(5).Name = 'Cassava';
leaf(5).Type = 'Simple';
leaf(5).Arrangement = 'Alternate';
leaf(5).Venation = 'Reticulate';
leaf(5).Shape = 'Palmately Lobed';
leaf(5).Margin = 'Lobed';
leaf(5).Apex = 'Pointed';
leaf(5).Petiole = 'Present';

leaf(6).Name = 'Guava';
leaf(6).Type = 'Simple';
leaf(6).Arrangement = 'Opposite';
leaf(6).Venation = 'Reticulate';
leaf(6).Shape = 'Oval';
leaf(6).Margin = 'Entire';
leaf(6).Apex = 'Acute';
leaf(6).Petiole = 'Present';

leaf(7).Name = 'Maize';
leaf(7).Type = 'Simple';
leaf(7).Arrangement = 'Alternate';
leaf(7).Venation = 'Parallel';
leaf(7).Shape = 'Linear';
leaf(7).Margin = 'Entire';
leaf(7).Apex = 'Acuminate';
leaf(7).Petiole = 'Absent';

leaf(8).Name = 'Mango';
leaf(8).Type = 'Simple';
leaf(8).Arrangement = 'Alternate';
leaf(8).Venation = 'Reticulate';
leaf(8).Shape = 'Lanceolate';
leaf(8).Margin = 'Entire';
leaf(8).Apex = 'Acuminate';
leaf(8).Petiole = 'Present';

leaf(9).Name = 'Pawpaw';
leaf(9).Type = 'Simple';
leaf(9).Arrangement = 'Alternate/Spiral';
leaf(9).Venation = 'Reticulate';
leaf(9).Shape = 'Palmately Lobed';
leaf(9).Margin = 'Lobed';
leaf(9).Apex = 'Pointed';
leaf(9).Petiole = 'Present';


leaf(10).Name = 'Pumpkin';
leaf(10).Type = 'Simple';
leaf(10).Arrangement = 'Alternate';
leaf(10).Venation = 'Reticulate';
leaf(10).Shape = 'Lobed';
leaf(10).Margin = 'Lobed';
leaf(10).Apex = 'Acute';
leaf(10).Petiole = 'Present';
%% table
leaftable = struct2table(leaf);
disp('leaftable');


%% CREATE A BINARY IMAGE %%
BW1 = imbinarize(I1gs);
imshow(BW1);

BW2 = imbinarize(I2gs);
imshow(BW2);

BW3 = imbinarize(I3gs);
imshow(BW3);

BW4 = imbinarize(I4gs);
imshow(BW4);

BW5 = imbinarize(I5gs);
imshow(BW5);

BW6 = imbinarize(I6gs);
imshow(BW6);

BW7 = imbinarize(I7gs);
imshow(BW7);

BW8 = imbinarize(I8gs);
imshow(BW8);

BW9 = imbinarize(I9gs);
imshow(BW9);

BW10 = imbinarize(I10gs);
imshow(BW10);



    %% Store image information in the structural array
    allimages = {I1,I2,I3,I4,I5,I6,I7,I8,I9,I10};
    allgray = {I1gs,I2gs,I3gs,I4gs,I5gs,I6gs,I7gs,I8gs,I9gs,I10gs};
for i = 1:10
    I(i).OriginalImage = allimages{i};

   I(i).GrayscaleImage = allgray{i};
   
end
