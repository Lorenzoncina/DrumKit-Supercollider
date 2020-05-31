void paintSquares(int alpha) {
  noStroke();
  // list of sound {\bd,\hh,\sn,\cb,\kc,\fm}
  color[] s_clr = {#4B6886,#61606D,#CC6600,#25A162,#C5272E,#22B8E7,#C5272E,#22B8E7 };
  for(int i = 0; i<8;i++){
    fill(s_clr[i], alpha);
    rect(i % 3 * (width/4), i % 2 * (height/2) , width/4, height/2);
  }
}

// A function to check which region is the square
int checkSquareNum(int Mx, int My){
    int click_stype= -1;
    if (Mx <= width/4 && My <= height/2) {
      click_stype = 0;
    }   
    else if (Mx > width/4 && Mx <= width*2/4 && My <=height/2) {
      click_stype= 1;
    } 
    else if (Mx > width * 2/4 && Mx <= width *3/4 && My <=height/2) {
      click_stype = 2;
    }
    else if (Mx > width * 3/4 && Mx <= width && My <=height/2) {
      click_stype = 3;
    }
    else if (Mx <= width/4 && My >height/2) {
      click_stype = 4;
    }
    else if(Mx > width /4 && Mx <= width *2/4 && My > height/2){
      click_stype = 5;
    }
    else if(Mx > width * 2/4 && Mx <= width *3/4 && My > height/2){
      click_stype = 6;
    }
    else {
      click_stype = 7;
    }
  return click_stype;
}


// show the pressed pad after mouseclick
void showPressShadow(int x, int y) {
  int linewidth = width/4;
  int lineheight = height/2;
  stroke(10);
  strokeWeight(2);
  line(x, y+lineheight, x+linewidth-2/2, y+lineheight);
  strokeWeight(2);
  stroke(10);
  line(x+linewidth-2/2, y, x+linewidth-2/2, y+lineheight-2/2);
  strokeWeight(1);
  line(x, y, x, y+lineheight-2/2);
}

// change square color
void changeSquareColor(int n, int color1,int color2,int color3){
   int[] x = { 0, width/4, width*2/4,width *3/4, 0, width/4, width*2/4,width*3/4};
   int[] y = { 0, 0, 0,0, height/2, height/2, height/2, height/2};
   fill(color1,color2,color3,100);
   rect(x[n],y[n],width/4,height/2);
}
