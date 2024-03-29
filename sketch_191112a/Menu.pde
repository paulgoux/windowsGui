class Menu {
  PApplet applet;
  BMScontrols Bms;
  int id, item, t, toggle, toggle2, type = 0, index =-1, subindex = -1, t2, sindex=-1, counter, slcount,nindex = -1;
  public float x, y, bx = x, by = y, w, h, xoff, yoff, window = 0, htotal, Yoff, xpos, ypos, tsize = 12, bsize, spacing, twidth,r1,r2,r3,r4;
  PVector mouse,mousePos =new PVector(0,0);
  public String label, blabel,itemLabel;
  float dx,dy;
  boolean drag = false, resize = false, slide = false, border = false, menu, menuhover = false, highlightable = true, animate, vertical, horizontal = false, dmenu;
  boolean mdown, mup, smdown, smup, listbox, open_menu, sltoggle, free,parentRight,draggable,parentCanvas,m2down,m3down,getIndex,m4down,m5down,m6down,subMenuPos;
  public boolean visible = true,show = true,localTheme;
  ArrayList<Button> items = new ArrayList<Button>();
  ArrayList<Slider> sliders = new ArrayList<Slider>();
  ArrayList<Dropdown> dMenus = new ArrayList<Dropdown>();
  ArrayList<Boolean> child = new ArrayList<Boolean>();
  ArrayList<String> labels = new ArrayList<String>();
  HashMap<String, Boolean> values ;
  Window mWindow = null;
  Button parent;
  tab tab;
  PGraphics localCanvas;
  tab parentTab;
  //Menu dmenu;
  Dropdown dMenu;

  Menu link;
  //color col = color(0,150), bcol, tcol = color(255), fcol = color(255, 80), hcol = color(255, 50),toggleCol = color(50,0);
  int col = color(0, 255, 73), bcol = color(0, 255, 73), tcol = color(255), fcol = color(0, 255, 73), hcol = color(0, 255, 73),toggleCol = color(55, 84, 63);

  public Menu() {
  };

  Menu(float xx, float yy, float ww, float hh, String Label) {
    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;
    h = hh;
    label = Label;
    xoff = 0;
    yoff = 0;
    toggle =0;
    bcol = col;
    bsize = tsize;
  }

  Menu(float xx, float yy, float ww, float hh) {
    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;
    h = hh;
    xoff = 0;
    yoff = 0;
    toggle =0;
    bcol = col;
    bsize = tsize;
  }

  

  Menu(float xx, float yy, float ww, float hh, String Label, String [] list) {

    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;
    h = hh;
    xoff = 0;
    yoff = 0;
    label = Label;
    toggle =0;
    bcol = col;
    bsize = tsize;
    slide = true;
    float bwidth = 0;

    for (int i =0; i<list.length; i++) {
      String l = list[i];

      if (textWidth(l)+hh>bwidth)bwidth = textWidth(l)+20;
      Button a = new Button( x, y + hh *(i+1), bwidth, h, l);
      a.border = false;
      a.parent = this;
      items.add(a);
    }
    twidth = bwidth*items.size();
  };

  Menu(float xx, float yy, float ww, float hh, String Label, String [] list, int n) {
    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;
    h = hh;
    xoff = 0;
    yoff = 0;
    label = Label;
    toggle =0;
    bcol = col;
    bsize = tsize;
    slide = true;
    float bwidth = 0;
    spacing = 0;
    //println(y)
    for (int i =0; i<list.length; i++) {
      String l = list[i];

      if (textWidth(l)+20>bwidth)bwidth = textWidth(l)+20;
    }
    
    if(w>bwidth)bwidth = w;

    for (int i =0; i<list.length; i++) {
      String l = list[i];

      Button a = new Button( x, y + hh *(i+1), bwidth, hh, l);
      //println("b",y+40*(i+1));
      a.border = false;
      a.parent = this;
      a.togglebox = true;
      items.add(a);
    }
    //h = hh * items.size();
    twidth = bwidth*items.size();
  };

  Menu(float xx, float yy, float ww, String [] list) {
    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;

    h = list.length*20;
    xoff = 0;
    yoff = 0;
    toggle =0;
    bcol = col;
    bsize = tsize;
    //slide = true;

    float bwidth = 0;

    for (int i =0; i<list.length; i++) {
      String l = list[i];

      if (textWidth(l)+20>bwidth)bwidth = textWidth(l)+20;
    }

    for (int i =0; i<list.length; i++) {
      String l = list[i];
      Button a = new Button( x, y + 20 *(i+1), bwidth, 20, l);
      a.border = false;
      a.parent = this;
      a.togglebox = true;
      items.add(a);
    }

    twidth = bwidth*items.size();
    w = bwidth;
  };



  Menu(float xx, float yy, float ww, ArrayList<String> list) {
    x = xx;
    y = yy;
    w = ww;

    h = list.size()*20;
    xoff = 0;
    yoff = 0;
    toggle =0;
    bcol = col;
    bsize = tsize;
    //slide = true;

    float bwidth = 0;

    for (int i =0; i<list.size(); i++) {
      String l = list.get(i);

      if (textWidth(l)+20>bwidth)bwidth = textWidth(l)+20;
    }

    for (int i =0; i<list.size(); i++) {
      String l = list.get(i);

      Button a = new Button( x, y + 20 *(i+1), bwidth, 20, l);
      a.border = false;
      a.parent = this;
      a.togglebox = true;
      items.add(a);
    }

    twidth = bwidth*items.size();
    w = bwidth;
  };
  
  Menu(float xx, float yy, float ww, String []list,boolean b1) {
    x = xx;
    y = yy;
    w = ww;
    spacing = 5;
    
    h = list.length*20;
    xoff = 0;
    yoff = 0;
    toggle =0;
    bcol = col;
    bsize = tsize;
    //slide = true;

    float bwidth = 0;
    float maxW = 0;
    for (int i =0; i<list.length; i++) {
      String l = list[i];

      if (textWidth(l)+20>bwidth)bwidth = textWidth(l)+20;
      //if(
    }
    
    if(b1==true)
    for (int i =0; i<list.length; i++) {
      String l = list[i];

      Button a = new Button( x+bwidth, y + (30)*(i+1), ww, 20, l);
      a.rx = bwidth;
      a.border = false;
      a.parent = this;
      a.radio = true;
      items.add(a);
    }
    else 
    for (int i =0; i<list.length; i++) {
      String l = list[i];

      Button a = new Button( x+bwidth, y + (30)*(i+1), ww, 20, l);
      a.rx = bwidth;
      a.border = false;
      a.parent = this;
      a.togglebar = true;
      items.add(a);
      //println("button",a);
    }
    
    //twidth = bwidth*items.size();
    w = bwidth+w;
    twidth = w;
  };
  
  Menu(float xx, float yy, float ww,float H, String []list,boolean b1) {
    x = xx;
    y = yy;
    w = ww;
    spacing = 5;
    
    h = list.length*H;
    xoff = 0;
    yoff = 0;
    toggle =0;
    bcol = col;
    bsize = tsize;
    //slide = true;

    float bwidth = 0;
    float maxW = 0;
    for (int i =0; i<list.length; i++) {
      String l = list[i];

      if (textWidth(l)+20>bwidth)bwidth = textWidth(l)+20;
      //if(
    }
    
    if(b1==true)
    for (int i =0; i<list.length; i++) {
      String l = list[i];

      Button a = new Button( x+bwidth, y + (H+5)*(i+1), ww, H, l);
      a.rx = bwidth;
      a.border = false;
      a.parent = this;
      a.radio = true;
      items.add(a);
    }
    else 
    for (int i =0; i<list.length; i++) {
      String l = list[i];

      Button a = new Button( x+bwidth, y + (H+5)*(i+1), ww, H, l);
      a.rx = bwidth;
      a.border = false;
      a.parent = this;
      a.togglebar = true;
      items.add(a);
      //println("button",a);
    }
    
    //twidth = bwidth*items.size();
    w = bwidth+w;
    twidth = w;
  };
  
  Menu(float xx, float yy, float ww,float H,float s, String []list,boolean b1) {
    x = xx;
    y = yy;
    w = ww;
    spacing = s;
    
    h = list.length*(H+s);
    xoff = 0;
    yoff = 0;
    toggle =0;
    bcol = col;
    bsize = tsize;
    //slide = true;

    float bwidth = 0;
    float maxW = 0;
    for (int i =0; i<list.length; i++) {
      String l = list[i];

      if (textWidth(l)+20>bwidth)bwidth = textWidth(l)+20;
      //if(
    }
    
    if(b1==true)
    for (int i =0; i<list.length; i++) {
      String l = list[i];

      Button a = new Button( x+bwidth, y + (H+s)*(i+1), ww, H, l);
      a.rx = bwidth;
      a.border = false;
      a.parent = this;
      a.radio = true;
      items.add(a);
    }
    else 
    for (int i =0; i<list.length; i++) {
      String l = list[i];

      Button a = new Button( x+bwidth, y + (H+s)*(i+1), ww, H, l);
      a.rx = bwidth;
      a.border = false;
      a.parent = this;
      a.togglebar = true;
      items.add(a);
      //println("button",a);
    }
    
    //twidth = bwidth*items.size();
    w = bwidth+w;
    twidth = w;
  };

  Menu(float xx, float yy, float ww, String [] list, float k) {

    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;
    h = list.length*(20+k) - k;
    xoff = 0;
    yoff = 0;
    toggle =0;
    bcol = col;
    bsize = tsize;
    spacing = k;

    float bwidth = 0;

    for (int i =0; i<list.length; i++) {
      String l = list[i];

      if (textWidth(l)+20>bwidth)bwidth = textWidth(l)+20;
    }

    for (int i =0; i<list.length; i++) {
      String l = list[i];
      Button a = new Button( x, y + (20+k) *(i+1), bwidth, 20, l);
      a.border = false;
      a.parent = this;
      a.togglebox = true;
      items.add(a);
    }

    twidth = bwidth*items.size();
    w = bwidth;
  };
  
  Menu(float xx, float yy, float ww, String [] list, float k,float h) {

    x = xx;
    y = yy;
    bx = x;
    by = y;
    w = ww;
    h = list.length*(h+k) - k;
    xoff = 0;
    yoff = 0;
    toggle =0;
    bcol = col;
    bsize = tsize;
    spacing = k;

    float bwidth = 0;

    for (int i =0; i<list.length; i++) {
      String l = list[i];

      if (textWidth(l)+20>bwidth)bwidth = textWidth(l)+20;
    }

    for (int i =0; i<list.length; i++) {
      String l = list[i];
      Button a = new Button( x, y + (h+k) *(i+1+k), bwidth, 20, l);
      a.border = false;
      a.parent = this;
      a.togglebox = true;
      items.add(a);
    }

    twidth = bwidth*items.size();
    w = bwidth;
  };

  Menu(float xx, float yy, String [] list) {
    
    x = xx;
    y = yy;
    bx = x;
    by = y;
    h = list.length*(20);
    xoff = 0;
    yoff = 0;
    toggle =0;
    bcol = col;
    bsize = tsize;

    float bwidth = 0;

    for (int i =0; i<list.length; i++) {
      String l = list[i];

      if (textWidth(l)+20>bwidth)bwidth = textWidth(l)+20;
    }

    for (int i =0; i<list.length; i++) {
      String l = list[i];
      Button a = new Button( x, y + (20) *(i), bwidth, 20, l);
      a.border = false;
      a.parent = this;
      a.togglebox = true;
      items.add(a);
    }

    twidth = bwidth*items.size();
    w = bwidth;
  };

  Menu(String k, float xx, float yy, float ww, String dir) {
    if (k=="dir"|| k=="DIR"||k=="Dir") {
      x = xx;
      y = yy;
      bx = x;
      by = y;
      w = ww;

      xoff = 0;
      yoff = 0;
      toggle =0;
      bcol = col;
      bsize = tsize;

      String []list = listFileNames(dir);

      for (int i =0; i<list.length; i++) {

        String l = list[i];
        for (int j=0; j<list[i].length(); j++) {
          Button a = new Button( x, y + 20 *(i), w, 20, l);
          a.border = false;
          a.togglebox = true;
          a.parent = this;
          items.add(a);
        }
      }
    }

    h = items.size()*20;
    Slider s = new Slider(x, y, 20, 20);
    s.vertical = true;
    sliders.add(s);
  };

  void save(){
    
  };
  
  void load(){
    
  };
  
  void setParentCanvas(PGraphics canvas){
    parentCanvas = true;
    localCanvas = canvas;
    
  };

  void draw() {
    logic();
    if(show)trace();
    if (draggable) {
      if(!parentCanvas){
        stroke(0);
        fill(col);
        if(localTheme)
        fill(fcol);
        rect(x,y-5, w, 5,r1,r2,r3,r4);
      }else{
        localCanvas.stroke(0);
        localCanvas.fill(col);
        if(localTheme)
        localCanvas.fill(fcol);
        localCanvas.rect(x,y-5, w, 5,r1,r2,r3,r4);
      }
    }
  };
  
  void draw2() {
    if(mousePressed)click();
    logic();
    if(show)trace();
    if (draggable) {
      if(!parentCanvas){
        stroke(0);
        fill(0,266,0,150);
        rect(x,y-5, w, 5);
      }else{
        localCanvas.stroke(0);
        localCanvas.fill(0,150);
        localCanvas.rect(x,y-5, w, 5);
      }
    }
  };
  
  void draw(PGraphics canvas) {
    if(mouse!=null)logic(mouse);
    //if(show)
    trace(canvas);
    
  };

  void drawWindow() {
  }

  void trace() {
    t2 = 0;
    slcount = 0;
    
    getState();
    drawButtons();
    //if(pos()&&toggle==1)println(label);
    drawDmenu();
    drawsliders();
  };

  void trace(PGraphics canvas) {
    t2 = 0;
    slcount = 0;

    getState(canvas);
    drawButtons(canvas);
    //drawDmenu();
    drawsliders();
  };

  void getState() {

    stroke(0);
    if(highlightable)highlight();
    if (!border)noStroke();

      fill(255);
      if (visible&&label!=null)rect(x, y, w, h,r1,r2,r3,r4);
      fill(col);
      if(localTheme)
      fill(fcol);
      
      if (visible&&label!=null)rect(x, y, w, h,r1,r2,r3,r4);
      fill(0);

    if(label!=null) {
      fill(BMS.tcol);
      if(localTheme)
      fill(tcol);
      textSize(bsize);
      text(label, x+xoff, y+yoff + 18);
      textSize(12);
      //fill(col);
    } else {
      toggle = 1;
    }

    
  };
  
  void getState(PGraphics canvas) {
    //if(highlightable)highlight(canvas);
    while (items.size()!=child.size()) {
      child.add(false);
    }
    canvas.stroke(0);
    if (!border)canvas.noStroke();

    canvas.fill(col);
    if(localTheme)
    canvas.fill(fcol);
    if (visible&&label!=null)canvas.rect(x, y, w, h,r1,r2,r3,r4);
    canvas.fill(col);
    if(localTheme)
    canvas.fill(fcol);
    if (visible&&label!=null)canvas.rect(x, y, w, h,r1,r2,r3,r4);
    canvas.fill(0);

    if(label!=null) {
      canvas.fill(BMS.tcol);
      if(localTheme)
      canvas.fill(tcol);
      canvas.textSize(bsize);
      canvas.text(label, x+xoff, y+yoff + 18);
      canvas.textSize(12);
      //fill(col);
    } else {
      toggle = 1;
    }
  };

  void drawButtons() {
    
    float speed = h/5;
    if (items.size()>0) {
      // if(pos()&&mousePressed){
      //   println("hello");
      //   toggle = 1;
      // }
      for (int i=0; i<items.size(); i++) {

        Button a = items.get(i);
        a.id = i;

        if (a.parent!=null&&label==null&&!horizontal){
          a.y = a.parent.y + i * (a.h + spacing);
          a.x = a.parent.x;
        }
        
        if (a.parent!=null&&label!=null&&!horizontal&&!free){
          a.y = a.parent.y + a.h + i * (a.h + spacing);
          a.x = a.parent.x;
        }
        
        if (a.parent!=null&&label==null&&horizontal) {
          a.x = a.parent.x + (a.parent.w + spacing) + i * a.w;
          a.y = y+a.h;
        }
        if(a.submenu!=null){
          if(!a.submenu.parentRight){
            a.submenu.x = a.x + a.w;
            a.submenu.y = a.y;
          }else{
            a.submenu.x = a.x - a.submenu.w;
            a.submenu.y = a.y;
          }
        }

        if(a.dMenu!=null){
          a.dMenu.x = a.x + a.w;
          a.dMenu.y = a.y;
        }

        if (toggle==1) {
          if (a.pos(mousePos)&&i>=0) {
            t2 ++;
            index = i;
          }
          if (a.subpos(mousePos)&&i>=0) {
            t2 ++;
            subindex = a.id;
          }}

        if (!slide) {
          if (toggle==1)window = y+h*(items.size()+1);
          else window = 0;
        } else {
          if (toggle==1) {
            window += speed;

            if (!horizontal) {
              if (window>y + h*items.size()) window = y+h*items.size();
            } else {
              if (window>x + a.w*items.size())window = x+a.w*items.size();
            }} else {
            window -= speed;
            if (window<0)window = 0;
          }}

        if (!horizontal) {
          if (y + window >= a.y) {
            if (a.visible){
            if(!parentCanvas)a.draw();
            else {
              a.mouse = mouse;
              a.draw(localCanvas);
            }}
            a.highlight();
          }
        } else {
          if (x + window >= a.x) {
            if (a.visible){
            if(!parentCanvas)a.draw();
            else {
              a.mouse = mouse;
              a.draw(localCanvas);
            }
            }
            a.highlight();
          }}}}
    
  };

  void drawButtons(PGraphics canvas) {
    
    float speed = 2;
    if (items.size()>0) {
      for (int i=0; i<items.size(); i++) {

        Button a = items.get(i);
        a.id = i;

        a.mouse = mouse;
        
        if (a.parent!=null&&label==null&&!horizontal){
          a.y = a.parent.y + i * (a.h + spacing);
          a.x = a.parent.x;
        }
        
        if (a.parent!=null&&label!=null&&!horizontal&&!free){
          a.y = a.parent.y + 20 + i * (a.h + spacing);
          a.x = a.parent.x;
        }
        
        if (a.parent!=null&&label==null&&horizontal) {
          a.x = a.parent.x + (a.parent.w + spacing) + i * a.w;
          a.y = y;
        }
        if(a.submenu!=null){
          if(!a.submenu.parentRight){
            a.submenu.x = a.x + a.w;
            a.submenu.y = a.y;
          }else{
            a.submenu.x = a.x - a.submenu.w;
            a.submenu.y = a.y;
          }
        }

        if(a.dMenu!=null){
          a.dMenu.x = a.x + a.w;
          a.dMenu.y = a.y;
        }

        if (toggle==1) {
          if (a.pos(mouse)&&i>=0) {
            t2 ++;
            index = i;
          }
          if (a.subpos(mouse)&&i>=0) {
            t2 ++;
            subindex = a.id;
          }}

        if (!slide) {
          if (toggle==1)window = y+20*(items.size()+1);
          else window = 0;
        } else {
          if (toggle==1) {
            window += speed;

            if (!horizontal) {
              if (window>y + 20*items.size()) window = y+20*items.size();
            } else {
              if (window>x + a.w*items.size())window = x+a.w*items.size();
            }} else {
            window -= speed;
            if (window<0)window = 0;
          }}

        if (!horizontal) {
          if (y + window >= a.y) {
            if (a.visible)a.draw(canvas);
            a.highlight(mouse);
            
          }
        } else {
          if (x + window >= a.x) {
            if (a.visible)a.draw(canvas);
            a.highlight(mouse);
            
          }}}}
    
  };

  void drawDmenu() {
    float speed = 2;
    if (dMenus.size()>0) {
      
      }
  };
  
  void add(Slider s,float spacing){
    s.Bms = Bms;
    s.applet = this.applet;
    sliders.add(s);
    
    if(items.size()==0)h = (s.h+spacing)*sliders.size();
    else h = (items.get(0).h+spacing)*items.size()+(s.h+spacing)*sliders.size();
  };
  
  void add(Slider s){
    s.Bms = Bms;
    s.applet = this.applet;
    sliders.add(s);
    
    if(items.size()==0)h = (s.h+spacing)*sliders.size();
    else h = (items.get(0).h+spacing)*items.size()+(s.h+spacing)*sliders.size();
  };
  
  void add(Button b){
    b.Bms = Bms;
    b.applet = this.applet;
    items.add(b);
    
    if(sliders.size()==0)h = (b.h+spacing)*items.size();
    else h = (sliders.get(0).h+spacing)*sliders.size()+(b.h+spacing)*items.size();
  };

  void drawsliders() {
    float speed = 2;
    
    if (sliders.size()>0&&show) {

      if (pos4()) {
        //toggle=1;
        //menuhover = true;
      } else menuhover = false;
      
      for (int i=0; i<sliders.size(); i++) {

        Slider a = sliders.get(i);
        if(parentCanvas)a.mouse = mouse;
        if(parentTab!=null)a.parentTab = parentTab;
        //else a.mouse = new PVector(mouseX,mouseY);
        if (a.toggle||a.mdown) slcount ++;
        a.parent = this;
        if (a.id==-1)a.id = i;
        if (horizontal) { 
          a.vertical = true; 
          a.y = y; 
          a.x = x + a.w + spacing * i;
        }else{
          a.y = y + (a.h + spacing) * i; 
          if(a.pie)a.y = a.h/2+y + (a.h + spacing+20) * i; 
          a.x = x;
          if(a.pie)a.x = x+a.w/2; 
        }
        if(!parentCanvas){
        if ((a.pos()||a.btnpos())&&!smdown) {
          smdown = true;
          sindex = i;
          a.mdown = true;
        }}else if ((a.pos(mouse)||a.btnpos(mouse))&&!smdown) {
          smdown = true;
          sindex = i;
          a.mdown = true;
        }
        if(sindex!=i)a.mdown = false;
        if (!mousePressed&&smdown) { 
          smdown = false;
          a.mdown = false;
        }
        if (!slide) {
          if (toggle==1) {
            if (vertical)window = y + (spacing +a.h)*(sliders.size());
            else window = x + (spacing +a.w)*(sliders.size());
          }} else {
          if (toggle==1) {
            window += speed;
            if (vertical) {
              if (window>y + a.h * sliders.size()) {
                window = y + a.h * sliders.size();
              }} else {
              if (window>x + a.w * sliders.size()) {
                window = x + a.w * sliders.size();
              }}} else {
            window -= speed;
            if (window<=0) window = 0;
            
          }}
          if(mousePressed){
            //if(vertical)println("vert");
            //else println("nvert");
          }
        if (vertical) {
          
          if (y + window >= a.y){
            
            if (a.visible){
            if(!parentCanvas)a.draw();
            else a.draw(localCanvas);
            }}} else {
          if (x + window >= a.x){

            if (a.visible){
            if(!parentCanvas)a.draw();
            else a.draw(localCanvas);
            }}}}
    }
    if (slcount>0) sltoggle = true;
    else sltoggle = false;
    
  };

  void borders(Boolean k) {
    for (int i=0; i<items.size(); i++) {
      Button b = items.get(i);

      b.border = k;
    }
  };

  void update() {
    counter = 0;
    for (int i=0; i<items.size(); i++) {

      Button a = items.get(i);
      if (a.pos()) counter++;
    }
  };
  
  void draw4(){
    
    fill(255);
    println("hishe",mouseX,mouseY);
    for (int i=0; i<sliders.size(); i++) {

        Slider a = sliders.get(i);
        if(parentCanvas)a.mouse = mouse;
        a.draw();
    }
  };
  
  void draw5(){
    fill(0);
    rect(x,y,20,20);
  };

  void setBorders(Boolean a) {
    for (int i=0; i<items.size(); i++) {
      Button b = items.get(i);

      b.border = a;
    }
  };

  void logic() {

    mousePos = new PVector(mouseX,mouseY);
    if(mousePressed&&pos()&&!dpos()&&!drag)m5down = true;
    if(mouse!=null) mousePos = mouse;
    //if(index>-1&&subindex==-1&&!pos()&&mousePressed)index = -1;
    if (mWindow!=null)y = sliders.get(0).valuey;
    if (highlightable) {
      if(!localTheme){
        if (pos(mousePos)) col = BMS.hcol;
        else col = BMS.fcol;
      }else{
        if (pos(mousePos)) col = hcol;
        else col = fcol;
      }
    }
    if(!localTheme){
      if (toggle==1)col = BMS.toggleCol;
      else col = BMS.fcol;
    }else{
      if (toggle==1)col = toggleCol;
      else col = fcol;
    }
    
    if ((pos()||toggle==1)) open_menu = true;
    else open_menu = false;
    if (draggable&&dpos()&&mousePressed&&!drag&&!mdown&&!m5down) {
      mdown = true;
      drag = true;
      dx = mouseX - x;
      dy = mouseY - y;
    }
    
    if(drag){
      x = mouseX - dx;
      y = mouseY - dy;
      
      for (int i=0;i<items.size();i++){
        Button b = items.get(i);
        b.x = x;
      }}
    
    Float X = float(mouseX - pmouseX);
    Float Y = float(mouseY - pmouseY);

    if (!mousePressed) {
      mdown = false;
      mup = true;
      drag = false;
      m5down = false;

    }

    if (t2>0)menuhover = true;
    else menuhover = false;
    
    if (!pos()) {
      if(toggle==1)
        if (mousePressed&&!menu&&!menuhover&&sliders.size()==0&&index>0&&!m3down) {
          m3down = true;
        }
        
        if(m3down&&!mousePressed){
          m3down = false;
          getIndex = true;
        }
    
    }

    if(index>-1&&subindex>-1&&items.get(subindex).submenu!=null&&items.get(subindex).submenu.parentRight){
          //if( index>-1&&subindex>-1&&items.get(subindex).pos()&&!items.get(subindex).subpos())subindex = -1;
        }else if(index>-1&&subindex>-1&&items.get(subindex).submenu!=null){
          if( index>-1&&subindex>-1&&items.get(subindex).pos()&&!items.get(subindex).subpos())subindex = -1;
        }
    if (subindex!=index&&subindex!=-1&&items.size()>0&&sliders.size()==0)index = -1;
    

    if (items.size()>0&&index>=0&&toggle==1) {
      Button a = items.get(index);
      a.highlight2();
    }

    if (type==2) {
      toggle=1;
      if (sliders.size()>0&&sindex>=0&&smdown) {

        Slider b = sliders.get(sindex);
        
          b.mouseFunctions();
          if (b.btnpos()||b.pos()||b.mdown)b.btnh = b.h+5;
          if (!b.mdown) b.btnh = b.h;
          //if (b.btnpos()||b.pos()||b.mdown)b.mouseFunctions();
        }
        
      if (sliders.size()>0&&sindex>=0&&!smdown) {
        Slider b = sliders.get(sindex); 
        b.btnh = b.h+2;
      }}

    if (items.size()>0&&subindex>=0&&subindex==index&&toggle==1&&sliders.size()==0) {
      Button a = items.get(subindex);

      if (a.submenu!=null&&a.id==subindex) {

        if (a.submenu.pos2()||a.submenu.menu)menu = true;
        else menu = false; 

        a.submenu.draw();
      }
      if (a.dMenu!=null&&a.id==subindex) {

        if (a.dMenu.menu)menu = true;
        else menu = false; 

        
        if(a.pos()&&!a.subpos()){}
        else a.dMenu.displayDropdown();
        
      }
    }
    if (!animate) {
      if (pos()||toggle==1) {
        if (bsize<tsize+2) bsize += 0.5;
      } else if (bsize>tsize&&bsize>2)bsize -= 0.5;
    }
    if(!mousePressed){
     m5down = false; 
    }
  };
  
  void logic(PVector m) {

    mousePos = new PVector(mouseX,mouseY);
    if(mouse!=null) mousePos = mouse;

    if (mWindow!=null)y = sliders.get(0).valuey;
    if (highlightable) {
      if (pos(m))col = hcol;
       else col = fcol;
      }

    if (toggle==1)col = hcol;
    else col = fcol;

    if ((pos(m)||toggle==1)) open_menu = true;
    else open_menu = false;
    if (draggable&&dpos(m)&&mousePressed&&!drag&&!mdown) {
      mdown = true;
      drag = true;
      dx = m.x - x;
      dy = m.y - y;
      //mup = false;
    }
    
    if(drag){
      x = m.x - dx;
      y = m.y - dy;
      
      for (int i=0;i<items.size();i++){
        Button b = items.get(i);
        b.x = x;
      }}
      
    if (!mousePressed) {
      mdown = false;
      mup = true;
      drag = false;
    }

    if (t2>0)menuhover = true;
    else menuhover = false;
    
    if (!pos(mouse)) {
      if (mousePressed&&!menu&&!menuhover&&sliders.size()==0) {
        toggle=0;
        subindex = -1;
        index = -1;
      }}
    if (subindex!=index&&subindex!=-1&&items.size()>0&&sliders.size()==0)index = -1;
    

    if (items.size()>0&&index>=0&&toggle==1) {
      Button a = items.get(index);
      a.highlight2();
    }

    if (type==2) {
      toggle=1;
      if (sliders.size()>0&&sindex>=0&&smdown) {

        Slider b = sliders.get(sindex);
        b.mouseFunctions(m);
        if (b.btnpos(m)||b.pos(m)||b.mdown)b.btnh = b.h+5;
        if (!b.mdown) b.btnh = b.h;
        if (b.btnpos(m)||b.pos(m)||b.mdown)b.mouseFunctions(m);
      }
      if (sliders.size()>0&&sindex>=0&&!smdown) {
        Slider b = sliders.get(sindex); 
        b.btnh = b.h+2;
      }
    }

    if (items.size()>0&&subindex>=0&&subindex==index&&toggle==1&&sliders.size()==0) {
      Button a = items.get(subindex);

      if (a.submenu!=null&&a.id==subindex) {

        if (a.submenu.pos2(m))menu = true;
        else menu = false; 

        a.submenu.draw();
      }
    }
    if (!animate) {
      if (pos(m)||toggle==1) {
        if (bsize<tsize+2)bsize += 0.5;
      } else if (bsize>tsize&&bsize>0)bsize -= 0.5;
    }
  };

  void setLink(Menu a) {

    link = a;
  };

  boolean pos() {

    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h+1;
  };
  
  boolean pos(PVector m) {

    return m.x>x&&m.x<x+w&&m.y>y&&m.y<y+h+1;
  };
  
  boolean pos2() {

    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+20*(items.size());
  };
  boolean pos2(PVector m) {

    return m.x>x&&m.x<x+w&&m.y>y&&m.y<y+20*(items.size());
  };
  boolean pos3() {

    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+20*(items.size());
  };
  boolean pos4() {

    return mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+20*(sliders.size());
  };

  void drag() {
  };

  boolean dpos() {
    return mouseX>x&&mouseX<x+w&&mouseY>y-10&&mouseY<y;
  };
  
  boolean dpos(PVector m) {
    return m.x>x&&m.x<x+w&&m.y>y-10&&m.y<y;
  };

  boolean outpos() {
    float X = mouseX;
    float Y = mouseY;
    return (X < x || X > x + w+10) || (Y < y || Y > y + h * (items.size()+1));
  };

  boolean click(int a){
    boolean k = false;
    if(items.size()>a&&items.get(a).click()) k = true;
    return k;
  };

  void click(int i, Object a, String b) {
    Button k = items.get(i);
    //k.click(a, b);
    if(k.click()){
      if (link==null)k.toggle(a, b);
    else if (link.toggle==1)k.toggle(a, b);
    }

  };
  
  void click(int i, PApplet a, String b) {
    Button k = items.get(i);
    k.click(a, b);
    k.toggle=0;
    if(!mousePressed)k.mdown=false;
  };

  boolean pos(int i){
    return items.get(i).pos(mousePos);

  };

  // boolean click(int a, Object b, String c){
  //   boolean k = false;
  //   if(click(a)) k = true;

  //   Field field = null;
    
  //   try{
  //        field = b.getClass().getField(c); 
        
  //        if((click(a))){
  //          field.set(c, true); 
  //        }else {
  //          field.set(c, false);
  //        }
  //   }catch (NullPointerException e) {
  //   }catch (NoSuchFieldException e) {
  //   }catch (IllegalAccessException e) {
  //   }
    
  //   return k;
  // };
  
  boolean itemSelected(){
    boolean k = false;
    //if(mousePressed)
    for(int i=0;i<items.size();i++){
      Button b = items.get(i);
      
      if(b.pos()){
        k = true;
        index = i;
        if(mousePressed){
          m4down = true;
          //println("m4down");
        }
        //println("button",i);
        //break;
      }
    }
    //if(index>-1&&items.get(index).submenu!=null){
    //  for(int i=0;i<items.get(index).submenu.items.size();i++){
    //    Button b = items.get(index).submenu.items.get(i);
        
    //    if(b.pos()){
    //      k = true;
    //      //index = i;
    //      //b.draw2();
    //      if(mousePressed){
    //        m4down = true;
    //        //println("m4down");
    //      }
    //    }
    //  }
    //}
    //if(k){
    // fill(0);
    // rect(0,0,200,200);
    //}
    if(!mousePressed)m4down = false;
    return k;
  };

  void click() {
    if (parent==null) {
      boolean k = itemSelected();
      if(k&&mousePressed)m4down = true;
      if(index>-1&&items.get(index).submenu!=null&&items.get(index).submenu.pos())subMenuPos = true;
      else subMenuPos = false;
      
      if (pos() && mousePressed&&BMS.menuObject==null&&!m3down) {
        toggle++;
        BMS.menuObject = this;
        m3down = true;
        //println("l1");
      }
      if (!m3down&&pos() && mousePressed&&BMS.menuObject==this&&toggle==1) {
        m3down = true;
        toggle = 0;
        BMS.menuObject.toggle = 0;
        BMS.menuObject.index = -1;
        BMS.menuObject=null;
        //println("l2");
      }
      if(mousePressed&&k){
        m3down = true;
      }
      
      if (!pos() && mousePressed&&!k&&!m4down&&!subMenuPos&&!m3down) {
        m3down = true;
        toggle = 0;
        if(BMS.menuObject!=null){
        BMS.menuObject.toggle = 0;
        BMS.menuObject.index = -1;
        BMS.menuObject=null;
      }
        //println("l3");
      }
      //if(!m3down&&index==-1&&mousePressed&&BMS.menuObject==this){
      //    m3down = true;
      //    toggle = 0;
      //    BMS.menuObject.toggle = 0;
      //    //BMS.menuObject.index = -1;
      //    BMS.menuObject=null;
      //    println("l4");
      //  }
    }
    
    if(!mousePressed){
      m3down = false;
      m4down = false;
    }
  };

  void click(boolean m){
    
    if(pos()&&mousePressed&&!m2down){
      toggle ++;
      m2down = true;
    }
    
    if(toggle>1)toggle=0;
    if(!mousePressed)m2down = false;
  };
  
  // void selfClick(int i) {
  //   Button k = items.get(i);
    
  //   return k.click(mouse);
    
  // };

  boolean selfClick(int i) {
    Button k = items.get(i);
    
    return k.click(mouse);
    
  };

  void selfClick(int i, Object o, String b) {
    //Button k = items.get(i);
    //if (link==null)k.selfClick(o, b);
    //else if (link.toggle==1)k.toggle(o, b);
    
  };
  
  void toggle(int i, String b) {
    Button k = items.get(i);
    
    //k.toggle(o, b);
    ;
  };

  void toggle(int i, PApplet o, String b) {
    Button k = items.get(i);
    if (link==null)k.toggle(o, b);
    else if (link.toggle==1)k.toggle(o, b);
    ;
  };
  
  void toggle(int i, Object o, String b) {
    Button k = items.get(i);
    if(show){
    if (link==null)k.toggle(o, b);
    else if (link.toggle==1)k.toggle(o, b);
    }
    //k.toggle(o, b);
    ;
  };

  void toggle_(int i, Object o, String b) {
    Button k = items.get(i);
    if(show){
    if (link==null&&mousePressed&&!mdown)k.toggle(o, b);
    else if (link!=null&&link.toggle==1&&mousePressed&&!mdown)k.toggle(o, b);
    }
    //k.toggle(o, b);
    ;
  };
  
  
  void toggle2(int i, Object o, String b) {
    Button k = items.get(i);
    if (link==null)k.toggle2(o, b);
    else if (link.toggle==1)k.toggle2(o, b);
    ;
  };

  void toggle(Menu m, int i, Object o, String b) {
    Button k = items.get(i);
    //if(parent!=null&&parent.toggle==1)
    if (m.toggle==1)k.toggle(o, b);
  };
  
  

  void self_toggle(int i) {
    Button k = items.get(i);
    if (k.parent.toggle==1)k.self_toggle();
    //else if(
  };
  
  void self_toggle(int i,PVector m) {
    Button k = items.get(i);
    if (k.parent.toggle==1)k.self_toggle(m);
    //else if(
  };

  void sptoggle(int n, Object a, String b, String [] c) {

    Button k = items.get(n);

    k.sptoggle(a, b, c);

  };

  void sptoggle(int n, Object a, String b, String [] c,Menu m) {

    Button k = items.get(n);

    k.sptoggle(a, b, c);
  };

  void sptoggle( Object a, String [] c) {


    for(int i=0;i<c.length;i++){
      BMS.shapes.sptoggle(i,a,c[i],c);
      if(mousePressed)
      if(!items.get(i).pos()){
        items.get(i).toggle=0;
      }
      println("item toggle = ",items.get(i).toggle);
    }
  };

  void sptoggle2( Object a, String [] c,Menu m) {


    for(int i=0;i<c.length;i++){
      Bms.shapes.sptoggle(i,a,c[i],c,m);
    }
  };

  void slide(float start, float end) {
    sliders.get(0).set(start, end);
  }

  void set(int a, int b) {
    items.get(a).toggle=b;
  };

  void set_parent(Button b) {

    parent = b;

    //for(int i=0;i<m.items.size();i++){
    //  Button k = m.items.get(i);

    //}
  };

  void setLink(int k) {
    Menu m = items.get(k).submenu;

    m.link = this;
  };

  String[] getItems(){
    String[] s = new String[items.size()];
    for(int i=0;i<items.size();i++){
      s[i] = items.get(i).label;
    }
    return s;
  };
  
  void setRadius(float a){
    r1 = a;
    r2 = a;
    r3 = a;
    r4 = a;
    for(int i=0;i<items.size();i++){
      Button b = items.get(i);
      b.r1 = a;
      b.r2 = a;
      b.r3 = a;
      b.r4 = a;
      //println(b.r1);
      if(b.submenu!=null){
        for(int j=0;j<b.submenu.items.size();j++){
          Button b1 = b.submenu.items.get(j);
          b1.r1 = a;
          b1.r2 = a;
          b1.r3 = a;
          b1.r4 = a;
        }
      }
    }
    
    for(int i=0;i<sliders.size();i++){
      Slider b = sliders.get(i);
      b.r1 = a;
      b.r2 = a;
      b.r3 = a;
      b.r4 = a;
    }
  };
  
  void setRadius(float a,float b,float c,float d){
    r1 = a;
    r2 = b;
    r3 = c;
    r4 = d;
    
    for(int i=0;i<items.size();i++){
      Button b1 = items.get(i);
      b1.r1 = a;
      b1.r2 = b;
      b1.r3 = c;
      b1.r4 = d;
      if(b1.submenu!=null){
        for(int j=0;j<b1.submenu.items.size();j++){
          Button b2 = b1.submenu.items.get(j);
          b2.r1 = a;
          b2.r2 = b;
          b2.r3 = c;
          b2.r4 = d;
        }
      }
    }
    
    for(int i=0;i<sliders.size();i++){
      Slider b1 = sliders.get(i);
      b1.r1 = a;
      b1.r2 = b;
      b1.r3 = c;
      b1.r4 = d;
    }
  };
  
  void setButtonRadius(float a){
    
    for(int i=0;i<items.size();i++){
      Button b1 = items.get(i);
      b1.r1 = a;
      b1.r2 = a;
      b1.r3 = a;
      b1.r4 = a;
      if(b1.submenu!=null){
        for(int j=0;j<b1.submenu.items.size();j++){
          Button b2 = b1.submenu.items.get(j);
          b2.r1 = a;
          b2.r2 = a;
          b2.r3 = a;
          b2.r4 = a;
        }
      }
    }
  };
  
  void setSliderRadius(float a){
    
    for(int i=0;i<sliders.size();i++){
      Slider b1 = sliders.get(i);
      b1.r1 = a;
      b1.r2 = a;
      b1.r3 = a;
      b1.r4 = a;
    }
  };
  
  void setButtonRadius(float a,float b,float c,float d){
    
    for(int i=0;i<items.size();i++){
      Button b1 = items.get(i);
      b1.r1 = a;
      b1.r2 = b;
      b1.r3 = c;
      b1.r4 = d;
      if(b1.submenu!=null){
        for(int j=0;j<b1.submenu.items.size();j++){
          Button b2 = b1.submenu.items.get(j);
          b2.r1 = a;
          b2.r2 = b;
          b2.r3 = c;
          b2.r4 = d;
        }
      }
    }
  };
  
  void setSliderRadius(float a,float b,float c,float d){
    
    for(int i=0;i<sliders.size();i++){
      Slider b1 = sliders.get(i);
      b1.r1 = a;
      b1.r2 = b;
      b1.r3 = c;
      b1.r4 = d;
    }
  };
  
  void setAlignment(String s){
    
    if(s=="CENTER"||s=="center"||s=="Center"){
      
      xoff = (w-textWidth(label))/2;
      yoff = h/3;
      
      for(int i=0;i<items.size();i++){
        Button b = items.get(i);
        b.tyoff = b.h/3;
        b.txoff = (b.w-textWidth(b.label))/2-((b.w-textWidth(b.label))/2)/2;
        if(b.submenu!=null){
          for(int j=0;j<b.submenu.items.size();j++){
            Button b2 = b.submenu.items.get(j);
            if(b2.h>20)b2.tyoff = b2.h/3;
            b2.txoff = (b2.w-textWidth(b2.label))/2-((b2.w-textWidth(b2.label))/2)/2;
            //b2.txoff = b2.w-textWidth(b2.label)/2;
          }
        }
      }
      
      for(int i=0;i<sliders.size();i++){
        Slider b = sliders.get(i);
      }
    }
    
    if(s=="RIGHT"||s=="right"||s=="Right"){
      
      xoff = (w-textWidth(label))-((w-textWidth(label)))/4;
      yoff = h/3;
      
      for(int i=0;i<items.size();i++){
        Button b = items.get(i);
        b.tyoff = b.h/3;
        b.txoff = (b.w-textWidth(b.label))-((b.w-textWidth(b.label)))/4;
        if(b.submenu!=null){
          for(int j=0;j<b.submenu.items.size();j++){
            Button b2 = b.submenu.items.get(j);
            b2.tyoff = b2.h/3;
            b2.txoff = (b2.w-textWidth(b2.label))-((b2.w-textWidth(b2.label)))/4;
          }
        }
      }
      
      for(int i=0;i<sliders.size();i++){
        Slider b = sliders.get(i);
      }
    }
    
    if(s=="LEFT"||s=="left"||s=="Left"){
      
      xoff = 5;
      yoff = h/3;
      
      for(int i=0;i<items.size();i++){
        Button b = items.get(i);
        b.tyoff = b.h/3;
        b.txoff = 0;
        if(b.submenu!=null){
          for(int j=0;j<b.submenu.items.size();j++){
            Button b2 = b.submenu.items.get(j);
            b2.tyoff = b2.h/3;
            b2.txoff = 0;
          }
        }
      }
      
      for(int i=0;i<sliders.size();i++){
        Slider b = sliders.get(i);
      }
    }
  };
  
  void highlight(){
    
    if(!pos()){
      col = BMS.fcol;
      if(localTheme)col = fcol;
    }
    else{
      col = BMS.hcol;
      if(localTheme)col = fcol;
    }
    if(toggle==1){
      col = BMS.toggleCol;
      if(localTheme)col = toggleCol;
    }
    if(toggle==1&&pos()){
      col = color(BMS.fcol,100);
      if(localTheme)col = color(fcol,100);
    }
  };
  
  void highlight(PGraphics canvas){
    //if(toggle==1||pos(mouse)){
    //  col = BMS.hcol;
    //  if(localTheme)col = hcol;
    //}
    //else if(!pos(mouse)){
    //  col = BMS.fcol;
    //  if(localTheme)col = fcol;
    //}
    if(!pos(mouse)){
      col = BMS.fcol;
      if(localTheme)col = fcol;
    }
    else{
      col = BMS.hcol;
      if(localTheme)col = fcol;
    }
    if(toggle==1){
      col = BMS.toggleCol;
      if(localTheme)col = toggleCol;
    }
    if(toggle==1&&pos(mouse)){
      col = color(BMS.fcol,100);
      if(localTheme)col = color(fcol,100);
    }
  };
};
