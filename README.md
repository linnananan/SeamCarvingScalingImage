# SeamCarvingScalingImage
**Using the SeamCarving algorithm to achieve non-uniform image scaling.**<br />
Press 1 to remove the red seams that would be cut to make the picture larger.
Press 2 to recover the picture after pressing 1 to make it smaller.
Press 3 to show red seam.
Press s to save the picture.

The base of the SeamCarving algorithm is dynamic programming algorithm which is usually used to solve a problem with some optimal properties.<br />
**In this demo,I use processing and the OpenCV library to achieve the seamcarving algorithm .**<br />
First of all, the whole image is viewed as a two-dimensional array to find the optimal seam . 
And than the image energy is calculated to evaluate the importance of all pixels in the image.
At last ,the minimum energy of the seam is removed.<br /><br />
It includes the Vertical dynamic detection like:<br />
![](https://github.com/linnananan/SeamCarvingScalingImage/raw/master/VerticalTest/36163.png)<br />
![](https://github.com/linnananan/SeamCarvingScalingImage/raw/master/VerticalTest/58098.png)<br />
![](https://github.com/linnananan/SeamCarvingScalingImage/raw/master/VerticalTest/99817.png)<br />
and the Horizontal dynamic detection like:<br />
![](https://github.com/linnananan/SeamCarvingScalingImage/raw/master/HorizontalTest/72036.png)<br />
![](https://github.com/linnananan/SeamCarvingScalingImage/raw/master/HorizontalTest/46638.png)<br />
![](https://github.com/linnananan/SeamCarvingScalingImage/raw/master/HorizontalTest/60657.png)<br />



