// ****** 情報ウィンドウに関するクラス ******

class InfoWindow extends JFrame{
  Information info;
  
  InfoWindow(String title){
    super(title);
    setBounds(0, 0, 400, 600);
    setResizable(false);
    // サブウィンドウだけ終了できないようにする
    setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
    // サブウィンドウにアプレットを追加・初期化
    info = new Information();
    info.init();
    add(info);
    
    setVisible(true);
  }
}

class Information extends PApplet{
  InfoPanel ipanel;
  
  void setup(){
    size(400, 600, P3D);
    noStroke();
    ipanel = new InfoPanel(0, 400, 200, 100);
  }
  
  void draw(){
    background(204);
    
    perspective();
    //camera(400, 0, 400, 0, 0, 0, 0, 0, -1);
    
    println(mouseX + ", " + mouseY);
    
    pushMatrix();
      translate(200, 200, 0);
      directionalLight(25, 255, 255, cos(radians(frameCount)), sin(radians(frameCount)), sin(radians(frameCount/2)));
      fill(0, 0, 255);
      sphere(100);
    popMatrix();
    
    noLights();
    ortho();
    
    //fill(255);
    //println(mouseX  + ", " + mouseY);
    //rect(0, 400, 200, 100);
    //fill(0);
    //textSize(24);
    //text("Neptune", 10, 450);
    ipanel.draw();
    //ellipse(mouseX, mouseY, 40, 40);
  }
}

class InfoPanel extends Rectangle{
  String msg;
  
  InfoPanel(int x, int y, int w,int h){
    super(x, y, w, h);
    textFont(createFont("Meiryo", 16));
    textAlign(CENTER, CENTER);
    msg = "Neptune";
  }
  
  void draw(){
    fill(255);
    rect(x, y, width, height);
    fill(0);
    text(msg, x + width/2, y + height/2);
  }
} 
