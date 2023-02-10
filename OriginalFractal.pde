double zoom = 1;
int max = 5;
int verts = 5;
boolean spin = true;
public void setup()
{
    size(500,500);
}
public void keyPressed() {
    if (keyCode == UP) max++;
    if (keyCode == DOWN) max--;
    if (keyCode == LEFT) verts--;
    if (keyCode == RIGHT) verts++;
    if (key == 's') spin = !spin;
}
public void draw() {
    background(0,0,0);
    stroke(0,255,0);
    strokeWeight(5);
    int[] bbox = {(int)(width/2-width/2/zoom), (int)(height/2-height/2/zoom), (int)(width/2+width/2/zoom), (int)(height/2-height/2/zoom)};
    //rect(bbox[0], bbox[1], bbox[2], bbox[3]);
    stroke(255,255,255);
    noFill();
    strokeWeight(1);
    pushMatrix();
    translate(width/2, height/2);
    if (spin) rotate(2*PI/500*frameCount%500);
    recursiveShape(0, 0, 250, verts, 0, 1, max, bbox);
    popMatrix();
    //zoom += 0.01;
    //if (frameCount%(60*2)==0&&max<=10)
    //max += 1;
}
public void recursiveShape(double x, double y, int radius, int sides, double angle, int depth, int maxdepth, int[] realbbox) {
    if (sides < 3) {return;}
    if (depth > maxdepth) {return;}
    stroke(255,0,255,255/maxdepth*(maxdepth-depth));
    beginShape();
    double[][] vertarr = new double[sides+1][2];
    for (int i=0;i<sides+1;i++) {
        vertarr[i][0] = x+radius*cos(2*PI/sides*i);
        vertarr[i][1] = y+radius*sin(2*PI/sides*i);
        vertex((int)(x+radius*cos((2*PI)/sides*i)), (int)(y+radius*sin(2*PI/sides*i)));
    }
    endShape();
    for (int i=0;i<sides+1;i++) {
        if (true||!(
            realbbox[0]>width/2+vertarr[i][0]+radius || width/2+vertarr[i][0]-radius>realbbox[0]+realbbox[2] ||
            realbbox[1]>height/2+vertarr[i][1]+radius || height/2+vertarr[i][1]-radius>realbbox[1]+realbbox[3]
            )){
            recursiveShape(x+(radius/2)*cos((2*PI)/sides*i), y+(radius/2)*sin(2*PI/sides*i), radius/2, sides, angle+(2*PI/sides*i), depth+1, maxdepth, realbbox);
        } else {
            //System.out.println("skip depth "+depth);
        }
    }
}
