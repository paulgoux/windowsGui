class sliderBox{
  BMScontrols Bms;
  PApplet applet;
  float x,y,bx = x,by = y,w,bw = w,h,bh = h,vspacing,hspacing;
  int id;
  Slider sliderR,sliderB,sliderG,sliderSelected;
  ArrayList<Slider> sliders = new ArrayList<Slider>();
  String type;
  PVector mouse,mouse2;
  boolean vertical, horizontal = true,draggable,saved,tdown,mdown,parentCanvas,t2down,m3down,m4down;
  public boolean visible = true,localTheme;
  Menu menu;
  Menu tooltip;
  tab parentTab;
  //fileInput load = new fileInput();
  //fileReader read = new fileReader();
  fileOutput save = new fileOutput();
  String savePath = null,itemLabel,label;
  int col = color(0, 255, 73), bcol = color(255), tcol = color(255), fcol = color(0, 255, 73), hcol = color(0, 255, 73,100),toggleCol = color(55, 84, 63);
  
  
  sliderBox(float xx, float yy,float ww,float S,String [] Labels){
    
    x = xx;
    y = yy;
    w = ww;
    h = (10 + S) * Labels.length - S;
    
    vspacing = S;
    
    menu = new Menu(x,y,w,h);
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = vspacing;
    menu.vertical = false;
    menu.slide = false;
    menu.draggable = true;
    menu.show = true;
    
    for(int i=0;i<Labels.length;i++){
      float ypos = y + (10 + S) *i;
      Slider a =  new Slider(x ,ypos,w,10,Labels[i]);
      a.id = i;
      a.bar = true;
      a.classic = true;
      a.parent = menu;
      a.valuex = a.w/2;
      sliders.add(a);
      menu.sliders.add(a);
    }
    
    createTooltip();
    
    BMS.sliderBoxes.add(this);
    
  };
  
  sliderBox(float xx, float yy,float ww,float H,float S,String [] Labels,int k){
    
    
    x = xx;
    y = yy;
    w = ww;
    h = (H+S) * Labels.length;
    
    bx = x;
    by = y;
    bw = w;
    bh = H;
    menu = new Menu(x,y,w,h);
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = vspacing;
    menu.vertical = false;
    menu.slide = false;
    menu.draggable = true;
    menu.show = true;
    
    if(k==0){
      h = (w/2+20+S) * Labels.length;
      for(int i=0;i<Labels.length;i++){
        float ypos = y+w/2 + (y+w/2 + S+80) *i;
        Slider a =  new Slider(x +w/2,ypos,w,H,Labels[i]);
        a.id = i;
        a.classic = false;
        a.pie = true;
        a.square = true;
        a.parent = menu;
        a.valuex = 2*PI;
        a.radius = w/2;
        sliders.add(a);
        menu.sliders.add(a);
      }
      println("slider",x,y,bx,by);
    }
    if(k==1){
      for(int i=0;i<Labels.length;i++){
        float ypos = y+w/2 +(y + w/2 + S) *i;
        Slider a =  new Slider(x +w/2,ypos,w,H,Labels[i]);
        a.id = i;
        a.classic = false;
        a.pie = true;
        a.radio = true;
        a.parent = menu;
        a.valuex = 2*PI;
        a.radius = w/2;
        sliders.add(a);
        menu.sliders.add(a);
      }
    }
    if(k==2){
      for(int i=0;i<Labels.length;i++){
        float ypos = y + 10 *i;
        Slider a =  new Slider(x ,ypos,w,H,Labels[i]);
        a.id = i;
        a.matrix = true;
        a.bar = true;
        a.parent = menu;
        a.valuex = a.w/2;
        sliders.add(a);
        menu.sliders.add(a);
      }
    }
    if(k==3){
      for(int i=0;i<Labels.length;i++){
        float ypos = y + 10 *i;
        Slider a =  new Slider(x ,ypos,w,H,Labels[i]);
        a.id = i;
        a.matrix = true;
        a.radio = true;
        a.parent = menu;
        a.valuex = 2*PI;
        sliders.add(a);
        menu.sliders.add(a);
      }
    }
    
    createTooltip();
    
    //BMS.sliderBoxes.add(this);
    
  };
  
  sliderBox(float xx, float yy,float ww,float H,float S,String [] Labels,float[] values,int k){
    
    
    x = xx;
    y = yy;
    w = ww;
    h = (H+S) * Labels.length;
    
    bx = x;
    by = y;
    bw = w;
    bh = H;
    
    menu = new Menu(x,y,w,h);
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = vspacing;
    menu.vertical = false;
    menu.slide = false;
    menu.draggable = true;
    menu.show = true;
    
    if(k==0){
      h = (w/2+20+S) * Labels.length;
      for(int i=0;i<Labels.length;i++){
        float ypos = y+w/2 + (y+w/2 + S+80) *i;
        Slider a =  new Slider(x +w/2,ypos,w,H,Labels[i]);
        a.id = i;
        a.classic = false;
        a.pie = true;
        a.square = true;
        a.parent = menu;
        a.valuex = 2*PI;
        a.radius = w/2;
        sliders.add(a);
        menu.sliders.add(a);
      }
    }
    if(k==1){
      for(int i=0;i<Labels.length;i++){
        float ypos = y+w/2 +(y + w/2 + S) *i;
        Slider a =  new Slider(x +w/2,ypos,w,H,Labels[i]);
        a.id = i;
        a.classic = false;
        a.pie = true;
        a.radio = true;
        a.parent = menu;
        a.valuex = 2*PI;
        a.radius = w/2;
        sliders.add(a);
        menu.sliders.add(a);
      }
    }
    if(k==2){
      for(int i=0;i<Labels.length;i++){
        float ypos = y + 10 *i;
        Slider a =  new Slider(x ,ypos,w,H,Labels[i]);
        a.id = i;
        a.matrix = true;
        a.bar = true;
        a.parent = menu;
        a.valuex = a.w/2;
        sliders.add(a);
        menu.sliders.add(a);
      }
    }
    if(k==3){
      for(int i=0;i<Labels.length;i++){
        float ypos = y + 10 *i;
        Slider a =  new Slider(x ,ypos,w,H,Labels[i]);
        a.id = i;
        a.matrix = true;
        a.radio = true;
        a.parent = menu;
        a.valuex = 2*PI;
        sliders.add(a);
        menu.sliders.add(a);
      }
    }
    if(k==0);
    for(int i=0;i<menu.sliders.size();i++){
      Slider a = menu.sliders.get(i);
      a.value = values[i];
      a.valuex = map(a.value,0,255,0,2*PI);
    }
    createTooltip();
    
    //BMS.sliderBoxes.add(this);
    
  };
  
  sliderBox(float xx, float yy,float ww,float S,String [] Labels,boolean bool){
    
    x = xx;
    y = yy;
    w = ww;
    h = (10 + S) * Labels.length - S;
    vspacing = S;
    bx = x;
    by = y;
    bw = w;
    bh = H;
    
    menu = new Menu(x,y,w,h);
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = vspacing;
    menu.vertical = false;
    menu.slide = false;
    menu.draggable = true;
    menu.show = true;
    
    for(int i=0;i<Labels.length;i++){
      float ypos = y + (10 + S) *i;
      Slider a =  new Slider(x ,ypos,w,10,Labels[i]);
      a.id = i;
      a.bar = true;
      a.classic = true;
      a.parent = menu;
      a.valuex = a.w/2;
      sliders.add(a);
      menu.sliders.add(a);
    }
    
    createTooltip();
    
  };
  
  sliderBox(float xx, float yy,float ww,float S,String [] Labels,float [] values ){
    
    x = xx;
    y = yy;
    w = ww;
    h = (10 + S) * Labels.length - S;
    vspacing = S;
    bx = x;
    by = y;
    bw = w;
    bh = H;
    
    menu = new Menu(x,y,w,h);
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = vspacing;
    menu.vertical = false;
    menu.slide = false;
    menu.draggable = true;
    menu.show = true;
    
    for(int i=0;i<Labels.length;i++){
      float ypos = y + (10 + S) *i;
      Slider a =  new Slider(x ,ypos,w,10,Labels[i]);
      a.id = i;
      a.bar = true;
      a.classic = true;
      a.parent = menu;
      a.valuex = a.w/2;
      sliders.add(a);
      menu.sliders.add(a);
    }
    
    for(int i=0;i<menu.sliders.size();i++){
      Slider a = menu.sliders.get(i);
      a.value = values[i];
      a.valuex = map(a.value,0,255,0,a.w);
    }
    
    createTooltip();
    
    BMS.sliderBoxes.add(this);
    
  };
  
  sliderBox(float xx, float yy,float ww,float S,String [] Labels,float [] values,boolean bool ){
    
    x = xx;
    y = yy;
    w = ww;
    h = (10 + S) * Labels.length - S;
    vspacing = S;
    bx = x;
    by = y;
    bw = w;
    bh = H;
    
    menu = new Menu(x,y,w,h);
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = vspacing;
    menu.vertical = false;
    menu.slide = false;
    menu.draggable = true;
    menu.show = true;
    
    for(int i=0;i<Labels.length;i++){
      float ypos = y + (10 + S) *i;
      Slider a =  new Slider(x ,ypos,w,10,Labels[i]);
      a.id = i;
      a.bar = true;
      a.classic = true;
      a.parent = menu;
      a.valuex = a.w/2;
      sliders.add(a);
      menu.sliders.add(a);
    }
    
    for(int i=0;i<menu.sliders.size();i++){
      Slider a = menu.sliders.get(i);
      a.value = values[i];
      a.valuex = map(a.value,0,255,0,a.w);
    }
    
    createTooltip();
    
    
  };
  
  sliderBox(float xx, float yy,float ww,float S,String [] Labels,tab t){
    
    parentCanvas = true;
    x = xx;
    y = yy;
    w = ww;
    h = (10 + S) * Labels.length - S;
    bx = x;
    by = y;
    bw = w;
    bh = H;
    vspacing = S;
    
    menu = new Menu(x,y,w,h);
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = vspacing;
    menu.vertical = false;
    menu.slide = false;
    menu.draggable = true;
    
    for(int i=0;i<Labels.length;i++){
      float ypos = y + (10 + S) *i;
      Slider a =  new Slider(x ,ypos,w,10,Labels[i]);
      a.id = i;
      a.tooltip.Width = int(t.w);
      a.tooltip.Height = int(t.h);
      a.bar = true;
      a.classic = true;
      a.parent = menu;
      a.valuex = a.w/2;
      sliders.add(a);
      menu.sliders.add(a);
    }
    createTooltip();
  };
  
  sliderBox(float xx, float yy,float ww,float S,String Label, String [] Labels,tab t){
    
    parentCanvas = true;
    x = xx;
    y = yy;
    w = ww;
    h = (10 + S) * Labels.length - S;
    bx = x;
    by = y;
    bw = w;
    bh = H; 
    
    vspacing = S;
    
    menu = new Menu(x,y,w,h,Label);
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = vspacing;
    menu.vertical = false;
    menu.slide = false;
    menu.draggable = true;
    
    for(int i=0;i<Labels.length;i++){
      float ypos = y + 20 + (10 + S) *i;
      Slider a =  new Slider(x ,ypos,w,10,Labels[i]);
      a.id = i;
      a.tooltip.Width = int(t.w);
      a.tooltip.Height = int(t.h);
      a.bar = true;
      a.classic = true;
      a.parent = menu;
      a.valuex = a.w/2;
      sliders.add(a);
      menu.sliders.add(a);
    }
    createTooltip();
  };
  
  sliderBox(float xx, float yy,float ww,float S,Menu m,String [] Labels){
    
    x = xx;
    y = yy;
    w = ww;
    h = (10 + S) * Labels.length - S;
    bx = x;
    by = y;
    bw = w;
    bh = H;
    
    vspacing = S;
    
    menu = m;
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = vspacing;
    menu.vertical = false;
    
    for(int i=0;i<Labels.length;i++){
      float ypos = y + (10 + S) *i;
      Slider a =  new Slider(x ,ypos,w,10,Labels[i]);
      a.id = i;
      a.bar = true;
      a.classic = true;
      a.parent = menu;
      a.valuex = a.w/2;
      sliders.add(a);
      menu.sliders.add(a);
    }
    createTooltip();
  };
  
  sliderBox(float xx, float yy,float ww,float S,tab t){
    
    parentCanvas = true;
    vspacing = S;
    x = xx;
    y = yy;
    w = ww;
    bx = x;
    by = y;
    bw = w;
    bh = H;
    
    menu = new Menu(x,y,w,h);
    menu.highlightable = false;
    menu.visible = false;
    menu.type = 2;
    menu.spacing = S;
    menu.vertical = false;
    menu.slide = false;
    menu.draggable = true;
    
    createTooltip();
  };
  
  void createTooltip(){
    String []s1 = {"Reset All","Save","Load","Minimize"};
    tooltip = new Menu(x+w,y-30,40,s1);
    tooltip.items.get(3).toggle = 1;
    tooltip.id = BMS.sliderBoxes.size()-1;
    tooltip.show = true;
    //BMS.menus.add(tooltip);
    //BMS.menus.add(menu);
    //BMS.sliderBoxes.add(this);
    //savePath = "sliderBox" + BMS.sliderBoxes.size();
    //save.location = "sliderBox" + BMS.sliderBoxes.size();
    id = BMS.sliderBoxes.size();
  };
  
  PVector getMouse(PVector m,PVector n){
    
    return new PVector (m.x-n.x,m.y-n.y);
  };
  
  void draw(){
    if(visible){
      //menu.sliderBoxP = this;
      //if(tooltip.items.get(3).toggle!=1)
      menu.draw();
      if(t2down&&tooltip!=null)
      tooltip.draw();
      logic();
      drawToolTip();
    }
  };
  
  
  void draw(PGraphics canvas){
    menu.mouse = new PVector(mouseX-parentTab.x,mouseY-parentTab.y);
    menu.parentTab = parentTab;
    menu.setParentCanvas(canvas);
    menu.draw(canvas);
    
    if(tdown&&tooltip!=null){
      tooltip.mouse = new PVector(mouseX-parentTab.x,mouseY-parentTab.y);
      tooltip.setParentCanvas(canvas);
      tooltip.draw(canvas);
    }
    mouse = new PVector(mouseX-parentTab.x,mouseY-parentTab.y);
    //logic(canvas);
    drawToolTip(canvas);
  };
  
  void drawPie(){
    if(visible){
      //menu.sliderBoxP = this;
      //if(tooltip.items.get(3).toggle!=1)
      menu.draw();
      if(t2down&&tooltip!=null)
      tooltip.draw();
      logic();
      drawToolTip();
    }
  };
  
  void logic(){
    if(mousePressed&&!m3down&&!pos()&&!tooltipPos()){
      m3down = true;
    }
    if(mousePressed&&m3down&&(pos()||tooltipPos())){
      m4down = true;
    }
    if(mousePressed&&m4down&&(!pos()&&!tooltipPos())){
      m4down = false;
    }
    if(menu.draggable&&menu.drag){
      if(tooltip!=null){
        tooltip.x = menu.x + menu.w;
        tooltip.y = menu.y - 50;
      }
      
        for(int i=0;i<sliders.size();i++){
        
        Slider b = sliders.get(i);
        
        b.x = menu.x;
        b.y = menu.y + (b.h + vspacing) * i;
        if(tooltip!=null){
          b.tooltip.x = b.x+b.w+textWidth("0.0000");
          b.tooltip.y = b.y;
        }
      }
          x = menu.x;
          y = menu.y;
    }else{
          menu.x = x;
          menu.y = y;
    }
    
    //if(!saved&&!BMS.autoControl){
    //  }
    if(frameCount%BMS.autoSaveTimeout==0)saved = false;
    else saved = true;
    if(mousePressed&&tooltip!=null&&tooltipPos()&&!t2down&&!mdown&&tooltip.visible){
      tdown = true;
      mdown = true;
    }
    if(mousePressed&&tdown&&!mdown&&tooltip!=null&&!tooltipPos()&&!t2down&&tooltip.visible){
      tdown = false;
      mdown = true;
    }
    
    if(!mousePressed)mdown = false;
    if(!tooltipPos()&&!tooltip.pos())tdown = false;
    if(tdown&&!mousePressed&&!m4down&&tooltipPos())t2down = true;
    //if(tdown&&mousePressed)t2down = true;
    
    boolean n = false;
    if(t2down){
      tdown = false;
      if(mousePressed)mdown = true;
      if(tooltip!=null&&tooltip.items.get(0).pos()&&mousePressed){
        mdown = true;
        for(int i=0;i<menu.sliders.size();i++){
          Slider s = menu.sliders.get(i);
          
          s.value = 0;
          s.valuex = s.w/2;
          
          if(s.Link!=null){
                  Field field = null;
                try{
                     field = s.Link.getClass().getField(s.control); 
                     field.set(s.Link, 0); 
                }catch (NullPointerException e) {
                }catch (NoSuchFieldException e) {
                }catch (IllegalAccessException e) {
                } 
          }}t2down = false; }

          if(tooltip.items.get(1).pos()&&mousePressed)save();
          
          //important
          //if(tooltip.items.get(2).pos())load.listen1();
          
          if(!mousePressed &&mdown) t2down = false;

          tooltip.toggle2(3,menu,"show");
          
          
          }
        if(mousePressed&&!tooltipPos())t2down = false;
        
        if(!mousePressed){
          m3down = false;
          if(!tooltipPos())m4down = false;
        }
  };

  void logic(PGraphics canvas){
    canvas.fill(0);
    if(tooltip!=null){
      if(mousePressed&&!m3down&&!pos(mouse)&&!tooltipPos(mouse)){
        m3down = true;
      }
      if(mousePressed&&m3down&&(pos(mouse)||tooltipPos(mouse))){
        m4down = true;
      }
      if(mousePressed&&m4down&&(!pos(mouse)&&!tooltipPos(mouse))){
        m4down = false;
      }
    }else{
      if(mousePressed&&!m3down&&!pos(mouse)){
        m3down = true;
      }
      if(mousePressed&&m3down&&(pos(mouse))){
        m4down = true;
      }
      if(mousePressed&&m4down&&(!pos(mouse))){
        m4down = false;
      }
    }
    if(menu.draggable&&menu.drag){
      if(tooltip!=null){
        tooltip.x = menu.x+menu.w;
        tooltip.y = menu.y - 50;
      }
        //menu.spacing = vspacing;
        for(int i=0;i<sliders.size();i++){
        
        Slider b = sliders.get(i);
        
        b.x = menu.x;
        b.y = menu.y + (b.h + vspacing) * i;
        if(tooltip!=null){
          b.tooltip.x = b.x+b.w+textWidth("0.0000");
          b.tooltip.y = b.y;
        }
        
      }}
    
    if(frameCount%BMS.autoSaveTimeout==0)saved = false;
    else saved = true;
    if(tooltip!=null&&mousePressed&&!tdown&&!mdown&&tooltipPos(mouse)&&!t2down&&!mdown&&tooltip.visible){
      tdown = true;
      mdown = true;
    }
    if(tooltip!=null&&mousePressed&&tdown&&!mdown&&!tooltipPos(mouse)&&!t2down&&tooltip.visible){
      tdown = false;
      mdown = true;
    }
    
    
    if(!mousePressed)mdown = false;
    if(tooltip!=null&&!tooltipPos(mouse)&&!tooltip.pos(mouse))tdown = false;
    if(tdown&&!mousePressed&&!m4down&&tooltipPos(mouse))t2down = true;
    //if(tdown&&mousePressed)t2down = true;
    
    //if(!mousePressed)mdown = false;
    //if(tdown&&!mousePressed&&!t2down)t2down = true;
    if(t2down){
      
      if(tooltip!=null&&tooltip.items.get(0).pos(mouse)&&mousePressed){
        mdown = true;
        for(int i=0;i<menu.sliders.size();i++){
          Slider s = menu.sliders.get(i);
          
          s.value = 0;
          s.valuex = s.w/2;
          
          if(s.Link!=null){
                  Field field = null;
                try{
                     field = s.Link.getClass().getField(s.control); 
                     field.set(s.Link, 0); 
                }catch (NullPointerException e) {
                }catch (NoSuchFieldException e) {
                }catch (IllegalAccessException e) {
                }}}
          t2down = false;
        }
        if(tooltip.items.get(1).pos(mouse)&&mousePressed){
            save();
            t2down = false;
          }
          if(tooltip.items.get(2).pos(mouse)){
            //important
            //load.listen1();
            if(mousePressed &&!mdown) t2down = false;
          }

          tooltip.toggle2(3,menu,"show");
          if(mousePressed&&!tooltipPos(mouse))t2down = false;
        }
        if(t2down&&tooltip!=null&&!tooltip.items.get(0).pos(mouse)&&mousePressed)t2down = false;
  };
  
  void drawToolTip(PGraphics canvas){
    
    if(tooltip!=null&&tooltipPos2(mouse)&&tooltip.visible&&!t2down){
      canvas.noStroke();
      
      canvas.fill(BMS.col);
      
      canvas.rect(menu.x+menu.w,menu.y-50,50,50);
    }
  };
  
  void drawToolTip(){
    if(!tdown&&tooltip!=null&&tooltipPos()&&!t2down&&tooltip.visible){
      noStroke();
      fill(col);
      if(localTheme)fill(fcol);
      rect(menu.x+menu.w,menu.y-50,50,50);
    }
  };
  
  void add(Slider s,float spacing){
    
    vspacing = spacing;
    menu.spacing = spacing;
    s.valuex = w/2;
    menu.add(s,spacing);
    h = (s.h+spacing)*menu.sliders.size();
    
    menu.h = h;
  };
  
  void add(Slider s){
    
    s.valuex = w/2;
    menu.add(s);
    h = (s.h+vspacing)*menu.sliders.size();
    
    menu.h = h;
  };

  void set(int i,float v){
    menu.sliders.get(i).parent = this.menu;
    menu.sliders.get(i).value = v;
  };
  
  void save(){
    //important
    if(save.location!=null){
      save.checkLocation(save.location);
      save.open();
      for(int i=0;i<sliders.size();i++){
            
          Slider s = sliders.get(i);
          save.write((s.value));
      }
      save.close();
    }
  };
  
  void setColor(){
    for(int i=0;i<menu.sliders.size();i++){
      Slider s = menu.sliders.get(i);
      
      s.setint(0,255);
      s.value = floor(s.value);
    }
  };
  
  void load(){
    //important
    //for(int i=0;i<read.text.length;i++){
    //  String s = read.text[i];
    //  Slider s1 = sliders.get(i);
    //  if(i<sliders.size()) sliders.get(i).value = float(s);

    //}
  };
  
  void display(String a){
    
    if(a=="vertical"|| a== "Vertical"){
      float k = 0;
      menu.vertical = true;
      k = menu.h;
      menu.h = menu.w ;
      h = w;
      menu.w = k;
      w = k;
      
      for(int i=0;i<sliders.size();i++){
        
        Slider b = sliders.get(i);
        
        //b.horizontal = false;
        k = b.w;
        b.w = b.h;
        b.h = k;
        k = b.btnw;
        b.btnw = b.btnh;
        b.btnh = k;
      }
    }
    
  };
  
  void set(int b, String a){
    
    if(b==menu.sindex)menu.sliders.get(b).label = a;
  };
  
  void set(int a,int b, int c){
    menu.sliders.get(a).parent = this.menu;
    if(a==menu.sindex)menu.sliders.get(a).set(b,c);
  };
  
  float get(int a){
    
    return menu.sliders.get(a).value;
  };
  
  int getint(int a){
    
    return floor(menu.sliders.get(a).value);
  };
  
  void set(int a, float b,float c,Object o, String variable){
    menu.sliders.get(a).parent = this.menu;
    menu.sliders.get(a).parentObject = o;
    menu.sliders.get(a).parentVar = variable;
    menu.sliders.get(a).functionId = 0;
    menu.sliders.get(a).startvalue = b;
    menu.sliders.get(a).endvalue = c;
    if(a==menu.sindex)menu.sliders.get(a).set(b,c,o,variable);
  };
  
  void set(int a, float b,float c,Object o, String variable,String n){
    if(a==menu.sindex){
      menu.sliders.get(a).parent = this.menu;
      menu.sliders.get(a).parentObject = o;
      menu.sliders.get(a).parentVar = variable;
      menu.sliders.get(a).functionId = 1;
      menu.sliders.get(a).startvalue = b;
      menu.sliders.get(a).endvalue = c;
      menu.sliders.get(a).set(b,c,o,variable,n);
    }
  };
  
  void setint(int a, int b,int c,Object o, String variable){
    if(a==menu.sindex){
      menu.sliders.get(a).parent = this.menu;
      menu.sliders.get(a).parentObject = o;
      menu.sliders.get(a).parentVar = variable;
      menu.sliders.get(a).functionId = 2;
      menu.sliders.get(a).startvalue = b;
      menu.sliders.get(a).endvalue = c;
      menu.sliders.get(a).setint(b,c,o,variable);
    }
  };
  
  void setint(int a, int b,int c){
    if(a==menu.sindex){
      menu.sliders.get(a).parent = this.menu;
      menu.sliders.get(a).functionId = 3;
      menu.sliders.get(a).startvalue = b;
      menu.sliders.get(a).endvalue = c;
      menu.sliders.get(a).setint(b,c);
    }
  };
  
  void setint(int a, int b,int c,Object o, String variable,String n){
    //if(visible)
    //menu.sliders.get(a).setint(b,c,o,variable,n);
  };
  
  void set(int a, String b, String c){
    
    if(b == "Classic" || b == "classic"){
      if(c == "Bar" || c =="bar"){
        menu.sliders.get(a).classic = true;
        menu.sliders.get(a).bar = true;
        menu.sliders.get(a).radio = false;
        menu.sliders.get(a).square = false;
      }
      
      if(c == "Radio" || c =="radio"){
        menu.sliders.get(a).classic = true;
        menu.sliders.get(a).bar = false;
        menu.sliders.get(a).radio = true;
        menu.sliders.get(a).square = false;
      }
      
      if(c == "Square" || c =="square"){
        menu.sliders.get(a).classic = true;
        menu.sliders.get(a).bar = false;
        menu.sliders.get(a).radio = false;
        menu.sliders.get(a).square = true;
      }}
      
      //menus.remove(menu.id);
      //menu.add(
  };
  
  //void draw2(){
    
  //  fill(255);
  //  text("hello",100,100);
    
  //};
  
  
  
  
  void set(Window a, String b){
    
  };
  
  void set(Menu a, String b){
    
  };
  
  void set(Boundary a, String b){
    
  };
  
  
  void setbg(){
    
  };
  
  void setBar(){
    for(int i=0;i<menu.sliders.size();i++){
      Slider s = menu.sliders.get(i);
      s.bar = true;
      s.radio = false;
      s.square = false;
      s.pie = false;
      s.matrix = false;
      s.classic = true;
    };
  };
  
  void setSquare(){
    for(int i=0;i<menu.sliders.size();i++){
      Slider s = menu.sliders.get(i);
      s.bar = false;
      s.radio = false;
      s.square = true;
      s.pie = false;
      s.matrix = false;
      s.classic = true;
      //println(s);
    };
  };
  
  void setRadio(){
    for(int i=0;i<menu.sliders.size();i++){
      Slider s = menu.sliders.get(i);
      s.bar = false;
      s.radio = true;
      s.square = false;
      s.pie = false;
      s.matrix = false;
      s.classic = true;
    };
  };
  
  void setMatrix(){
    for(int i=0;i<menu.sliders.size();i++){
      Slider s = menu.sliders.get(i);
      s.bar = false;
      s.radio = false;
      s.square = false;
      s.pie = false;
      s.matrix = true;
      s.classic = false;
    };
  };
  
  void setPie(){
    for(int i=0;i<menu.sliders.size();i++){
      Slider s = menu.sliders.get(i);
      s.bar = false;
      s.radio = false;
      s.square = false;
      s.pie = true;
      s.matrix = false;
      s.classic = false;
    };
  };
  
  void setDrag(Boolean a){
    menu.draggable = a;
  };
  
  boolean pos(){
    return mouseX>menu.x&&mouseX<menu.x+menu.w&&mouseY>menu.y&&mouseY<menu.y+menu.w;
  }
  
  boolean pos(PVector m){
    return m.x>menu.x&&m.x<menu.x+menu.w&&m.y>menu.y&&m.y<menu.y+menu.w;
  }
  
  boolean tooltipPos(){
    return mouseX>menu.x+menu.w&&mouseX<menu.x+menu.w+50&&mouseY>menu.y-50&&mouseY<menu.y;
  };
  
  boolean tooltipPos(PVector m){
    //return m.x>menu.x+menu.w&&m.x<menu.x+menu.w+50&&m.x>menu.y-50&&m.x<menu.y;
    return mouseX>menu.x+menu.w+parentTab.x&&mouseX<menu.x+menu.w+50+parentTab.x&&mouseY>menu.y-50+parentTab.y&&mouseY<menu.y+parentTab.y;
  };
  
  boolean tooltipPos(PVector m,PGraphics c){
    return mouseX>menu.x+menu.w+parentTab.x&&mouseX<menu.x+menu.w+50+parentTab.x&&mouseY>menu.y-50+parentTab.y&&mouseY<menu.y+parentTab.y;
  };
  
  boolean tooltipPos2(PVector m){
    return m.x>menu.x+menu.w&&m.x<menu.x+menu.w+50&&m.y>menu.y-50&&m.y<menu.y;
  };
  
  void setStart(float start){
    for(int i=0;i<menu.sliders.size();i++){
      Slider s = menu.sliders.get(i);
      
      s.startvalue = start;
    }
  };
  
  void setEnd(float end){
    for(int i=0;i<menu.sliders.size();i++){
      Slider s = menu.sliders.get(i);
      
      s.endvalue = end;
    }
  };
  
  void setFloat(int i,float a,float b){
    if(i<menu.sliders.size()){
      Slider s = menu.sliders.get(i);
      s.startvalue = a;
      s.endvalue = b;
    }
  };
  
  void setFloat(int i,int a,int b){
    if(i<menu.sliders.size()){
      Slider s = menu.sliders.get(i);
      s.startvalue = a;
      s.endvalue = b;
    }
  };
};
