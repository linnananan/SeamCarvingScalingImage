public class Pixel{
    private final color c;
    private final float intensity;
    private float energy;
    private float accumulatedEnergy;
    public Pixel(color c) {
        this.c = c;
        
        float red = red(c);
        float green = green(c);
        float blue = blue(c);
        this.intensity = (float)(0.299*red + 0.587*green + 0.114*blue) / 3.0f;
    }

    public void setEnergy(float energy) {
        this.energy = energy;
    }

    public float getEnergy() {
        return this.energy;
    }

    public void setAccumulatedEnergy(float accumulatedEnergy) {
        this.accumulatedEnergy = accumulatedEnergy;
    }

    public float getAccumulatedEnergy() {
        return this.accumulatedEnergy;
    }

    public float getIntensity() {
        return this.intensity;
    }

    public color getRGB() {
        return this.c;
    }
}