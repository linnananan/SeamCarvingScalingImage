public class SeamCarving {
    private Pixel[][] pixel;
    public SeamCarving(PImage img) {
        pixel = new Pixel[img.width][img.height];

        for (int x=0; x<img.width; ++x) {
            for (int y=0; y<img.height; ++y) {
                this.pixel[x][y] = new Pixel(img.get(x, y));
            }
        }
        update();
    }


    public int[] findAndRemoveSeam() {
        int[] seam = findSeam();
        removeSeam(seam);

        return seam;
    }

    private int[] findSeam() {

        int[] seam = new int[pixel.length];
        float minenergy = Float.POSITIVE_INFINITY;     

        for(int i=0; i < pixel[0].length; i++) {
            if (pixel[i][0].getAccumulatedEnergy() < minenergy) {
                minenergy = pixel[i][0].getAccumulatedEnergy();
                seam[0] = i;
            }
        }

        for(int x=1; x < pixel.length; x++) {
            minenergy = Float.POSITIVE_INFINITY;
            if (seam[x-1]-1 >= 0) {
                minenergy = pixel[x][seam[x-1]-1].getAccumulatedEnergy();
                seam[x] = seam[x-1]-1;
            }
            if (pixel[x][seam[x-1]].getAccumulatedEnergy() < minenergy) {
                seam[x] = seam[x-1];
            }
            if (seam[x-1]+1 < pixel[x].length-1) {
                if (pixel[x][seam[x-1]+1].getAccumulatedEnergy() < minenergy) {
                    seam[x] = seam[x-1]+1;
                }
            }
        }
        return seam;
    }

    private void removeSeam(int[] seam) {
        Pixel[][] pixeltransform;
        pixeltransform = new Pixel[pixel.length][pixel[0].length-1];
        int temp;

        for(int x=0; x < pixel.length; x++) {
            temp = 0;
            for (int y = 0; y < pixel[x].length-1; y++) {
                if(seam[x] == y) {
                    temp = 1;
                }
                pixeltransform[x][y] = pixel[x][y+temp];
            }
        }
        pixel = pixeltransform;
    }

    private void update() {
        for(int x=0; x < pixel.length; x++) {
            for (int y = 0; y < pixel[x].length; y++) {
                pixel[x][y].setEnergy(calculateEnergy(x,y));
                pixel[x][y].setAccumulatedEnergy(calculateAccumulatedEnergy(x,y));
            }
        }
    }
    private float calculateEnergy(int x, int y) {
        float energy = 0.0f;
        int divisor = 0;
        if (y != 0) {
            energy += Math.abs(pixel[x][y].getIntensity()-pixel[x][y-1].getIntensity());
            divisor += 1;
        }
        if (x != 0) {
            energy += Math.abs(pixel[x][y].getIntensity()-pixel[x-1][y].getIntensity());
            divisor += 1;
        }
        if(y < pixel[x].length-1) {
            energy += Math.abs(pixel[x][y].getIntensity()-pixel[x][y+1].getIntensity());
            divisor += 1;
        }
        if(y < pixel[x].length-1 && x < pixel.length-1) {
            energy += Math.abs(pixel[x][y].getIntensity()-pixel[x+1][y].getIntensity());
            divisor += 1;
        }
        energy /= divisor;
        return energy;
    }
    private float calculateAccumulatedEnergy(int x, int y) {
        float accumulatedenergy = 0.0f;
        float smallestaccumulatedenergy = Float.POSITIVE_INFINITY;
        if (x == 0) {
            accumulatedenergy = pixel[x][0].getEnergy();
        } else {
            if (y != 0) {
                smallestaccumulatedenergy = pixel[x-1][y-1].getAccumulatedEnergy();
            }
            if (pixel[x-1][y].getAccumulatedEnergy() < smallestaccumulatedenergy) {
                smallestaccumulatedenergy = pixel[x-1][y].getAccumulatedEnergy();
            }
            if (y+1 < pixel[0].length) {
                if(pixel[x-1][y+1].getAccumulatedEnergy() < smallestaccumulatedenergy) {
                    smallestaccumulatedenergy = pixel[x-1][y+1].getAccumulatedEnergy();
                }
            }
            accumulatedenergy = pixel[x][y].getEnergy() + smallestaccumulatedenergy;
        }
        return accumulatedenergy;
    }

    public PImage getImage() {
        PImage img = createImage(this.pixel.length,this.pixel[0].length, RGB);

        for (int x = 0; x < img.width; ++x)
             for (int y = 0; y < img.height; ++y)          
                img.set(x, y, this.pixel[x][y].getRGB());
        return img;
    }

}