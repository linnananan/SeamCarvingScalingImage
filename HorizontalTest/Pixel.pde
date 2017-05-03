//pixel类用于存储每个像素点的信息
public class Pixel {
    private final color c;
    private final float intensity;//颜色强度，便于算出能量值
    private float energy;//大概能量值
    private float accumulatedEnergy;//精确能量值
    public Pixel(color c) {
        this.c = c;       
        float red = red(c);
        float green = green(c);
        float blue = blue(c);
        this.intensity = (float)(0.299*red + 0.587*green + 0.114*blue) / 3.0f;//强度计算
    }
    //设置大概能量值
    public void setEnergy(float energy) {
        this.energy = energy;
    }
    //获取大概能量值
    public float getEnergy() {
        return this.energy;
    }
    //设置精确能量值
    public void setAccumulatedEnergy(float accumulatedEnergy) {
        this.accumulatedEnergy = accumulatedEnergy;
    }
    //获取精确能量值
    public float getAccumulatedEnergy() {
        return this.accumulatedEnergy;
    }
    //设置强度
    public float getIntensity() {
        return this.intensity;
    }
    //获取颜色
    public color getRGB() {
        return this.c;
    }

}