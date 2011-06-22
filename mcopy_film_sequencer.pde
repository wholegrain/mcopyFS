import processing.serial.*;
Serial mcopy;

int dpi = 112;
int dlay = 1300;

int[] w = new int[15000];
String[] wS = new String[15000];
int rCount = 0;
int[] film = new int[15000];
String[] filmS = new String[15000];

int place = 0;
int[] counter = new int[5];
int mX = 0;
int mX2 = 0;
int mstore = 0;
int mstore2 = 0;
int printCAM = 0;
int printPRO = 0;

int lng = 24;

float mm = float(dpi) / 25.4;
float a = 16.0 * mm;
float b = 10.7 * mm;
float c = 7.57 * mm;
float d = 0.8 * mm;
float e = 1.2 * mm;
float f = 1.7 * mm;

PFont font;

void setup() {
  size(int(26*c), int(148*mm));
  smooth();
  background(40);
  font = createFont("HiraKakuStdN-W8-48.vlw", 48);
  for (int z=0;z<w.length;z++) {
    w[z] = 4;
    wS[z]=" ";
    film[z] = 4;
    filmS[z]=" ";
  }
  for (int p=0;p<4;p++) {
    counter[p] = 0;
  }
  String loader[] = loadStrings("save.txt");
  int loadcount = 0;
  for (int t=0;t<loader.length;t++) {
    w[t] = int(loader[t]);
    counter[w[t]]++;
    if (w[t]==2) {
      printPRO++;
    }
    if (w[t]==3) {
      printPRO--;
    }    
    if (w[t]==0) {
      rCount++;
    }
    if (w[t]==1) {
      rCount++;
    }
    if (w[t]==4) {
      place = t;
      t=loader.length;
    }
  }
}


void draw() {
  for (int t=0;t<lng;t++) {
    int intguy = w[t];    
    if (w[t]!=0) {
      intguy = 4;
    }
    frame(c+(t*c), a/2, intguy, " "); 

    intguy = w[t];
    if (w[t]!=1) {
      intguy = 4;
    }
    frame(c+(t*c), a+a/2+a/7, intguy, " "); 

    intguy = w[t];
    if (w[t]!=2) {
      intguy = 4;
    }
    frame(c+(t*c), 2*a+a/2+(2*a)/7, intguy, " "); 

    intguy = w[t];
    if (w[t]!=3) {
      intguy = 4;
    }
    frame(c+(t*c), 3*a+a/2+(3*a)/7, intguy, " ");
    //all
    frame(c+(t*c), 5*a+(4*a)/7, w[t], switcher(w[t]));
  }
  for(int g=0;g<w.length;g++){
   if(w[g]==4){
    place = g;
    g = w.length;
   } 
  }
  if(place%24==0){
   lng+=24; 
  }
  
  int[] r = new int[15000];
  String[] rS = new String[15000];
  for (int z=0;z<r.length;z++) {
    r[z] = 4;
    rS[z] = " ";
  }
  rCount=0;
  for (int v=0;v<lng;v++) {   
    if (w[v]==0) {
      r[rCount]=0;
      rS[rCount]="x";
      rCount++;
    }
    if (w[v]==1) {
      r[rCount]=1;
      rS[rCount]=wS[v];
      rCount++;
    }
  }    

  for (int t=0;t<lng;t++) {
    frame(c+(t*c), 6*a+a/2+a/7, r[t], rS[t]);
    frame(c+(t*c), 7*a+a/2+(2*a)/7, film[t], filmS[t]);
  }
  fill(220);
  textFont(font, 32);
  text("X",5,a/2+(10*mm));
  text("C",5,a/2+(26*mm)+a/7);
  text("F",5,a/2+(42*mm)+(2*a)/7);
  text("B",5,a/2+(58*mm)+(3*a)/7);
  String[ ] shorter = "X","C","F","B";
}



void mousePressed() {
  mstore = mouseX - mX;
  if (mouseY>220) {
    mstore2 = mouseX - mX2;
  }

  int X = mouseX - mX;
  int Y = mouseY;
  if (Y<(a/2)+71*mm) {
    if (Y>a/2) {
      int placerY = int((Y-(a/2))/(a+(a/7)));
      int placerX = int((X-c)/c);
      //UNCLICK
      if (w[placerX]==placerY) {
        if (w[placerX]==2) {
          printPRO--;
        }
        if (w[placerX]==3) {
          printPRO++;
        }
        if (w[placerX]==0) {
          wS[placerX]= " ";
        }
        if (w[placerX]==1) { 
          wS[placerX]= " ";
        }
        w[placerX]=4;
        counter[placerY]--;
      }
      else if (w[placerX]!=placerY) {
        if (w[placerX]==0) {
          wS[placerX] = "x";
        }
        if (w[placerX]==1) {
          wS[placerX] = Integer.toString(printPRO);
        }      
        counter[placerY]++;
        counter[w[placerX]]--;
        w[placerX]=placerY;
      }
      if (w[placerX]==2) {
        printPRO++;
      }
      if (w[placerX]==3) {
        printPRO--;
      } 
      if (w[placerX]==0) {
        wS[placerX]="x";
        rCount++;
      }
      if (w[placerX]==1) {
        wS[placerX]=Integer.toString(printPRO);
        rCount++;
      }
    }
  }
}

void keyPressed() {
  if (key == 'c') {
    counter[1]++;
    w[place] = 1;  
    wS[place]=Integer.toString(printPRO);
    rCount++;
    place++;
  }
  if (key == 'f') {
    counter[2]++;
    printPRO++; 
    w[place]=2;
    place++;
  } 
  if (key == 'b') {
    counter[3]++;
    printPRO--; 
    w[place]=3;
    place++;
  }
  if (key == 'x') {
    counter[0]++;
    w[place] = 0;
    wS[place]="x";  
    place++;
  }
  if (keyCode == 46) {
    wS[place-1] = " ";
    w[place-1] = 4;

    
  }      
  if (keyCode == LEFT) {
    //   mcopy.write("b");
    printPRO--;
    delay(dlay);
  }
  if (keyCode == RIGHT) {
    // mcopy.write("f");
    printPRO++;
    delay(dlay);
  }
  if (keyCode == UP) {
    // mcopy.write("c");
    film[printCAM]=1;
    filmS[printCAM] = Integer.toString(printPRO);
    printCAM++;
    delay(dlay);
  }
  if (keyCode == DOWN) {
    // mcopy.write("x");
    film[printCAM]=0;
    filmS[printCAM] = "x";
    printCAM++;
    delay(dlay);
  }
  if (key == 's') {
    String[] saver = new String[w.length];
    for (int y = 0;y<w.length;y++) {
      saver[y]=Integer.toString(w[y]);
    }
    saveStrings("save.txt", saver);
    delay(400);
  }
}



void frame(float Xf, float Yf, int col, String txt) {
  noStroke();
  fill(50);
  rect(Xf, Yf, c, a);
  stroke(0);
  line(Xf, Yf, Xf+c, Yf);
  line(Xf, Yf+a, Xf+c, Yf+a); 
  noFill(); 
  //frame
  if (col==0) {
    fill(0);
  }
  if (col==1) {
    fill(234, 255, 118, 100);
  }
  if (col==2) {
    fill(255, 118, 239, 100);
  }
  if (col==3) {
    fill(118, 255, 142, 100);
  }
  if (col==4) {
  }
  rect(Xf, Yf+d+f, c, b);  
  //perf
  fill(220);
  textFont(font, 12);
  text(txt, Xf+c/6, Yf+a/1.3);
  fill(40);
  rect(Xf-d, Yf+d, e, f);
  noStroke();
  rect(0, 0, 30, (128*mm));
  noFill();
}

String switcher(int in) {
  String fine = " ";
  if (in==0) {
    fine = "x";
  } 
  if (in==1) {
    fine = "c";
  } 
  if (in==2) {
    fine = "f";
  } 
  if (in==3) {
    fine = "b";
  } 
  if (in==4) {
    fine = " ";
  } 
  return fine;
}

//Copyleft sixteenmillimeter.com 2011
//M.C.O.P.Y. Film Controller version 0.8

