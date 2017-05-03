import java.util.LinkedList;//引入包
//声明相应变量
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
  img = loadImage("sample.jpg");//传入图像
  size(480,300);
  seamCarvingAlgorithm = new SeamCarving(img);//初始新图
  removeSeams(); //进行处理，除去一个能量线
  
}

void draw(){
  background(255);
  image(newImg,0,0);//原图
  if (showSeams) {//是否显示能量线
    stroke(255,0,0);
    for (int[] seam : seams) {
      for (int y = 0; y < img.height; y++) {
           int x = seam[y];
           line(x,y,x,y);
      }
    }
  }
}

void keyPressed(){
 
 if(keyCode == '1'){//按键1，除去能量线
   seamCount++;
   removeSeams();
  }else if(keyCode == '2'){//按键2.恢复除去能量线前的图片
   seamCarvingAlgorithm = new SeamCarving(img);
   seamCount--;
   for(int i=0;i<seamCount;i++){
    removeSeams();
   }
  }else if(keyCode == '3'){//按键3，是否显示能量线
   if(showSeams) showSeams = false;
   else showSeams = true;
  }else if(key == 's') {//按键4，存储图片
    int n = int(random(100000));
    save(n + ".png");
  }
}
//除去能量线方法
void removeSeams() {
        newImg = seamCarvingAlgorithm.getImage();
        seams.clear();
        for (int i = 0; i < seamsPerStep; ++i)
            seams.add(seamCarvingAlgorithm.findAndRemoveSeam());
}