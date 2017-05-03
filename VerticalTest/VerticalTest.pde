
import java.util.LinkedList;
PImage img;
PImage newImg;
private SeamCarving seamCarvingAlgorithm;
private LinkedList<int[]> seams = new LinkedList<int[]>();
private int seamsPerStep = 12;
private boolean showSeams = true;
private int seamCount;

void setup(){
  smooth();
  seamCount = 1;
  img = loadImage("sample.jpg");
  size(480,300);
  seamCarvingAlgorithm = new SeamCarving(img);
  removeSeams(); 
}

void draw(){
  background(255);
  image(newImg,0,0);
  if (showSeams) {
    stroke(255,0,0);
    for (int[] seam : seams) {
      for (int x = 0; x < img.width; x++) {
           int y = seam[x];
           line(x,y,x,y);
      }
    }
  }
}

void keyPressed(){
 
 if(keyCode == '1'){
   seamCount++;
   removeSeams();

  }else if(keyCode == '2'){
   seamCarvingAlgorithm = new SeamCarving(img);
   seamCount--;
   for(int i=0;i<seamCount;i++){
    removeSeams();
   }
  }else if(keyCode == '3'){
   if(showSeams) showSeams = false;
   else showSeams = true;
  }else if(key == 's') {
    int n = int(random(100000));
    save(n + ".png");
  }
}

void removeSeams() {
        newImg = seamCarvingAlgorithm.getImage();
        seams.clear();
        for (int i = 0; i < seamsPerStep; ++i)
            seams.add(seamCarvingAlgorithm.findAndRemoveSeam());
}