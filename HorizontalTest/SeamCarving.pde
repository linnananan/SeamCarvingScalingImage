public class SeamCarving {
    private Pixel[][] pixel;
    //读取图像信息，存入pixel数组
    public SeamCarving(PImage img) {
        pixel = new Pixel[img.height][img.width];

        for (int y=0; y<img.height; ++y) {
            for (int x=0; x<img.width; ++x) {
                this.pixel[y][x] = new Pixel(img.get(x, y));
            }
        }
        update();//读取并存储每个图像的像素大概能量值与精确能量值
    }

    public int[] findAndRemoveSeam() {
        int[] seam = findSeam();
        removeSeam(seam);
        return seam;
    }

    private int[] findSeam() {
        int[] seam = new int[pixel.length];
        float minenergy = Float.POSITIVE_INFINITY;     
        //取出第一行精确能量值最小的像素位置（横坐标）赋给数组seam[]中的第一个
        for(int i=0; i < pixel[0].length; i++) {
            if (pixel[0][i].getAccumulatedEnergy() < minenergy) {
                minenergy = pixel[0][i].getAccumulatedEnergy();
                seam[0] = i;
            }
        }
        //由上往下，与上一行选取的点像素比较精确能量值，
        //比较的点为上一行选取像素点的左下、正下、右下三点像素的精确能量值
        //取出该行拥有最小精确能量值的像素点的横坐标，赋值给相应数组seam
        for(int y=1; y < pixel.length; y++) {
            minenergy = Float.POSITIVE_INFINITY;
            if (seam[y-1]-1 >= 0) {
                minenergy = pixel[y][seam[y-1]-1].getAccumulatedEnergy();
                seam[y] = seam[y-1]-1;
            }
            if (pixel[y][seam[y-1]].getAccumulatedEnergy() < minenergy) {
                seam[y] = seam[y-1];
            }
            if (seam[y-1]+1 < pixel[y].length-1) {
                if (pixel[y][seam[y-1]+1].getAccumulatedEnergy() < minenergy) {
                    seam[y] = seam[y-1]+1;
                }
            }
        }
        return seam;
    }

    private void removeSeam(int[] seam) {
        Pixel[][] pixeltransform;
        pixeltransform = new Pixel[pixel.length][pixel[0].length-1];
        int temp;

        for(int y=0; y < pixel.length; y++) {
            temp = 0;
            for (int x = 0; x < pixel[y].length-1; x++) {
                if(seam[y] == x) {
                    temp = 1;
                }
                pixeltransform[y][x] = pixel[y][x+temp];
            }
        }
        pixel = pixeltransform;
    }
    //读取并存储每个图像的像素大概能量值与精确能量值
    private void update() {
        for(int y=0; y < pixel.length; y++) {
            for (int x = 0; x < pixel[y].length; x++) {
                pixel[y][x].setEnergy(calculateEnergy(x,y));
                pixel[y][x].setAccumulatedEnergy(calculateAccumulatedEnergy(x,y));
            }
        }
    }

    //根据像素的上下左右的能量强度intensity相比较算出相应像素的大概能量值energy
    private float calculateEnergy(int x, int y) {
        float energy = 0.0f;
        int divisor = 0;
        if (x != 0) {
            energy += Math.abs(pixel[y][x].getIntensity()-pixel[y][x-1].getIntensity());
            divisor += 1;
        }
        if (y != 0) {
            energy += Math.abs(pixel[y][x].getIntensity()-pixel[y-1][x].getIntensity());
            divisor += 1;
        }
        if(x < pixel[y].length-1) {
            energy += Math.abs(pixel[y][x].getIntensity()-pixel[y][x+1].getIntensity());
            divisor += 1;
        }
        if(x < pixel[y].length-1 && y < pixel.length-1) {
            energy += Math.abs(pixel[y][x].getIntensity()-pixel[y+1][x].getIntensity());
            divisor += 1;
        }
        energy /= divisor;
        return energy;
    }

    //将具体像素点与上一行上左、正上、上右三点比较相应能力值，取最小值再加上自身能量值，
    //算出该像素的精确能量值
    private float calculateAccumulatedEnergy(int x, int y) {
        float accumulatedenergy = 0.0f;
        float smallestaccumulatedenergy = Float.POSITIVE_INFINITY;
        //Double.POSITIVE_INFINITY / Float.POSITIVE_INFINITY --正无穷大
        //Double.NEGATIVE_INFINITY / Float.NEGATIVE_INFINITY --负无穷大
        if (y == 0) {
            accumulatedenergy = pixel[0][x].getEnergy();
        } else {
            if (x != 0) {
                smallestaccumulatedenergy = pixel[y-1][x-1].getAccumulatedEnergy();
            }
            if (pixel[y-1][x].getAccumulatedEnergy() < smallestaccumulatedenergy) {
                smallestaccumulatedenergy = pixel[y-1][x].getAccumulatedEnergy();
            }
            if (x+1 < pixel[0].length) {
                if(pixel[y-1][x+1].getAccumulatedEnergy() < smallestaccumulatedenergy) {
                    smallestaccumulatedenergy = pixel[y-1][x+1].getAccumulatedEnergy();
                }
            }
            accumulatedenergy = pixel[y][x].getEnergy() + smallestaccumulatedenergy;
        }
        return accumulatedenergy;
    }
    //建一个模板重新赋值，组成新图片
    public PImage getImage() {
        PImage img = createImage(this.pixel[0].length, this.pixel.length, RGB);

        for (int y = 0; y < img.height; ++y)
            for (int x = 0; x < img.width; ++x)
                img.set(x, y, this.pixel[y][x].getRGB());

        return img;
    }

}