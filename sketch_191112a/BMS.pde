class BMScontrols{
  
  int Mcount,maxFolderSize = 100,gw = 25,gh = 20;
  HashMap<Object,String> booleans = new HashMap<Object,String>();
  int bgcol = color(50, 235, 225);
  int col = color(0, 255, 73), bcol = color(255), tcol = color(255), fcol = color(0, 255, 73), hcol = color(0, 255, 73,100),toggleCol = color(55, 84, 63),
        tabcol = color(0, 150, 255),sliderbgcol = color(255);
  PApplet applet = null;
  boolean updated,autoSave,globalDown;
  public String clipBoard;
  String currentMouseObject;
  Object currentObject;
  Menu menuObject,file,reset,resetDialogue,shapes;
  Window fmenu;
  Slider sliderObject;
  //objectSelected;
  Dropdown dropDownObject;
  String[] Lines;
  Button yes,no;
  Dock dock;
  public float autoSaveTimeout = 30;
  ArrayList<Slider> sliders = new ArrayList<Slider>();
  ArrayList<sliderBox> sliderBoxes = new ArrayList<sliderBox>();
  
  ArrayList<Button> buttons = new ArrayList<Button>();
  ArrayList<Menu> menus = new ArrayList<Menu>();
  ArrayList<Dropdown> dmenus = new ArrayList<Dropdown>();
  ArrayList<radioMenu> radioMenus = new ArrayList<radioMenu>();
  ArrayList<toggleMenu> toggleMenus = new ArrayList<toggleMenu>();
  
  ArrayList<Grid> grids = new ArrayList<Grid>();
  ArrayList<Table_> tables = new ArrayList<Table_>();
  
  ArrayList<PImage> images = new ArrayList<PImage>();
  ArrayList<String> links = new ArrayList<String>();
  
  ArrayList<textBlock> textBlocks = new ArrayList<textBlock>();
  ArrayList<TextBox> textBoxes = new ArrayList<TextBox>();
  ArrayList<TextArea> textAreas = new ArrayList<TextArea>();
  
  ArrayList<Window> windows = new ArrayList<Window>();
  ArrayList<tab> tabs = new ArrayList<tab>();
  
  Boundary bb;
  Window main;
  //fileInput File,Folder;
  Menu menu;
  
  //String[] cameras = Capture.list();
  String[] files;
  
  //Capture Cam;
  Dropdown dd;
  
  BMScontrols(PApplet Applet){
    applet = Applet;
    //startCam();
    
  };
  
  void add(Object o,String globalVar,boolean localVar){
    Field field = null;
    
    booleans.put(o,globalVar);
  
};

void draw(){
  // fill(255);
  
  // text("hello",100,100);
};

void begin(){
  //File = new fileInput();
  //Folder = new fileInput(true);
  //String []ss = {"test1","test2","test3"};
  //sliderBox s = new sliderBox(100,100,90,10,ss);
  setupDock();
  setupWindows();
  setupMenus();
  setupReset();
  
};


void setupDock(){
  dock = new Dock(0,height -22,width,24);
  
};


void setupWindows(){
  main = new Window(23,20,W-46,H-90-20,this);
  main.fill = false;
  main.border = false;
  Boundary b = new Boundary(main.x+1,main.y+1,main.w-2,main.h-2,4);
  //b.cohesionBoundary = true;
  //b.avoidBoundary = true;
  b.state = 1;
  b.visible = false;
  main.Boundaries.add(b);
  fmenu = new Window(200,200,200,200,"C:\\Users\\paul goux\\");
  fmenu.setRadius(10);
  fmenu.quickAccess = true;
  windows.add(fmenu);
  dock.add(fmenu);
  
};

void setupMenus(){
  // file----------------------------------------------
  
  //println("iugoiugoiugoiug", sliders.size());
  //String [] flabels = {"Open","Save","Grid","Plot 2D","Plot 3D","Attractor","Reset"};

  
};


void setupReset(){
  resetDialogue = new Menu(W/2 - 136,H/2 - 22,275,45,"Are you sure you want to exit?");
  resetDialogue.visible = true;
  resetDialogue.highlightable = false;
  resetDialogue.free = true;
  yes = new Button(W/2 - 136 ,H/2 +2,resetDialogue.w/2,20,"Yes");
  yes.border = false;
  yes.togglebox = true;
  
  no = new Button(yes.x + yes.w,H/2 +2,resetDialogue.w/2,20,"No");
  no.border = false;
  no.togglebox = true;
  
  resetDialogue.items.add(yes);
  resetDialogue.items.add(no);
  yes.parent = resetDialogue;
  no.parent = resetDialogue;
};


void loadImg(){
    
};

void displayWindows(){
  for(int i=0;i<windows.size();i++){
    
    Window r = windows.get(i);
    r.displayGrid();
    
  }
};

void run(){
  globalLogic();
  
  displayButtons();
  //mainFunctions();
  
  radioMenus();
  sliderBoxFunctions();
  sliderFunctions();
  displayTabs();
  displayWindows();
  toggleMenus();
  
  for(Menu menu : BMS.menus)menu.click();
  
  dock.logic();
  dock.drawItems();
  menuFunctions();
};

void toggleMenus(){
  for(int i=0;i<toggleMenus.size();i++){
    
    toggleMenu r = toggleMenus.get(i);
    r.draw();
    
  }
};

void radioMenus(){
  for(int i=0;i<radioMenus.size();i++){
    
    radioMenu r = radioMenus.get(i);
    r.draw();
    
  }
};

void selfToggle(int i){
  if(i<=buttons.size())
  buttons.get(i).self_toggle();
};

void selfToggle(int i,PVector m){
  if(i<=buttons.size())
  buttons.get(i).self_toggle(m);
};

void selfToggle(int i,int j){
    
    if(i<menus.size()&&j<menus.get(i).items.size()){
      
      menus.get(i).self_toggle(j);
    }else {
      println("BMS: button or menu not found..");
    }
  };
  
  void selfToggle(int i,int j,PVector m){
    
    if(i<menus.size()&&j<menus.get(i).items.size()){
      
      menus.get(i).self_toggle(j,m);
    }else {
      println("BMS: button or menu not found..");
    }
  };
  
  void toggle(int i,Object o,String s){
    if(i<=buttons.size())
    buttons.get(i).toggle2(o,s);
  };

  void toggle(int i,int j,Object o,String s){
    if(i<=buttons.size())
    menus.get(i).toggle2(j,o,s);
  };

  

void displayButtons(){
  for(int i=0;i<buttons.size();i++){
    Button b = buttons.get(i);
    
    b.draw();
    b.highlight();
  };
};

void mainFunctions(){
  
  //fmenu.displayGrid();
};

void displayTabs(){
  for(int i=0;i<tabs.size();i++){
    tab t = tabs.get(i);
    
    t.displayTab();
    //b.highlight();
  };
};


void displayTextBoxes(){
  for(TextArea textb : textAreas){
    //textb.draw();
  }
  
  for(TextBox textb : textBoxes){
    //textb.draw();
  }
};

void manageClipBoard(){
  //if(getTextFromClipboard ()!=clipBoard)clipBoard = getTextFromClipboard ();
};

void click(){
  buttons();
};

void reload(){
  if(buttons.get(0).toggle==1&&!updated){
    frameCount = -1;
    updated = true;
  }
};

void buttons(){
  
  file.self_toggle(6);
  yes.self_toggle();
  no.self_toggle();
  String [] gridm = {"forward","backward","pause"};
  Menu grid = file.items.get(2).submenu;
  Menu attractor = file.items.get(5).submenu;
  
  

  //----------Shapes------------------------
  String [] shapes_bool = {"toggle","connectedlines","circle","square","tri","bezier","none"};
  
  // for(int i=0;i<shapes_bool.length;i++){
  //   shapes.sptoggle(i,main,shapes_bool[i],shapes_bool);
  // }
  //shapes.sptoggle(main,shapes_bool);
  shapes.sptoggle(0,main,"toggle",shapes_bool);
  shapes.sptoggle(1,main,"connectedlines",shapes_bool);
  shapes.sptoggle(2,main,"circle",shapes_bool);
  shapes.sptoggle(3,main,"square",shapes_bool);
  shapes.sptoggle(4,main,"tri",shapes_bool);
  shapes.sptoggle(5,main,"poligon",shapes_bool);
  shapes.sptoggle(6,main,"complex",shapes_bool);
  shapes.sptoggle(7,main,"bezier",shapes_bool);
  shapes.sptoggle(8,main,"spline",shapes_bool);
  shapes.sptoggle(9,main,"none",shapes_bool);
  shapes.sptoggle(11,main,"path",shapes_bool);
  
  String [] ld = {"draw","edit"};
  
  main.pallete.toggle(0,main,"fill");
  main.pallete.toggle(1,main,"gravity");
  main.pallete.toggle(2,main,"friction");
  main.pallete.toggle(3,main,"velocity");
  main.pallete.toggle(4,main,"connect");
  main.pallete.toggle(5,main,"amendBoundary");
  main.pallete.toggle(6,main,"amendInnerBoundary");
  main.pallete.toggle(7,main,"amendAvoidance");
  main.pallete.toggle(8,main,"amendCohesion");
  main.pallete.toggle(9,main,"followBoundary");
  main.pallete.toggle(10,main,"follow");
  main.pallete.toggle(11,main,"dashed");
  main.pallete.toggle(12,main,"border");
  main.pallete.toggle(13,main,"amendAvoidance");
  main.pallete.toggle(14,main,"showgrid");
  main.pallete.toggle(15,main,"hidemenu");
  main.pallete.sptoggle(16,main,"edit",ld);
  main.pallete.toggle(17,main,"reset");
  //main.complexsub.toggle(0,main,"cfinish");
  
};

void sliderBoxFunctions(){
  //println("slidersize",sliderBoxes.size());
  for(int i=0;i<sliderBoxes.size();i++){
    
    sliderBox s = sliderBoxes.get(i);
    if(s.visible)s.draw();
    
    //s.tooltip.draw();
    //for(int i=0
    
    //s.menu.sliderFunctions();
    //if(mousePressed)println("sliders",sliderBoxes.size());
    
  }
};

void sliderFunctions(){
  //if(mousePressed)println("sliders",sliders.size());
  for(int i=0;i<sliders.size();i++){
    
    Slider s = sliders.get(i);
    s.draw();
    s.mouseFunctions();
    if(i==0)s.set(0,20);
    if(i==1)s.setint(0,6);
    //s.tooltip.draw();
    //for(int i=0
    
    //s.menu.sliderFunctions();
    //if(mousePressed)println("sliders",sliderBoxes.size());
    
  }
};


void menuFunctions(){
  
  Mcount = 0;
  //if(mousePressed)println("m size",BMS.menus.size());
  for(int i=0;i<BMS.menus.size();i++){
    
    Menu m = BMS.menus.get(i);
    m.draw();
    
  //   if(m.parent==null&&(m.pos()||m.toggle==1)){Mcount++;}
  //   else if(m.parent!=null&&m.items.size()>0&&m.parent.toggle==1){
  //     for(int j=0;j<m.items.size();j++){
  //       Button b = m.items.get(j);
  //       if(b.pos())Mcount++;
  //     }}
  //     else if(m.sliders.size()>0&&m.parent.toggle==1){
  //     for(int j=0;j<m.sliders.size();j++){
  //       Slider b = m.sliders.get(j);
  //       if(b.pos())Mcount++;
  //     }
  // }
  
    
  }
};

void boundariesNscenes(){
  
  //------------------------------------------------------
  //Boundaries--------------------------------------------
};


void autoSave(){
  
  if(autoSave){
    saveText();
  }
  
};

void load(){
  
};

void saveText(){
  
  for(int i=0;i<textBoxes.size();i++){
    TextBox t = textBoxes.get(i);
    
    t.save();
  }
  
  for(int i=0;i<textAreas.size();i++){
    TextArea t = textAreas.get(i);
    
    t.save();
  }
};

void saveSliderBox(){
  
  for(int i=0;i<sliderBoxes.size();i++){
    sliderBox s = sliderBoxes.get(i);
    
    s.save();
  }
};

void saveButtons(){
  
  for(int i=0;i<buttons.size();i++){
    Button b = buttons.get(i);
    
    b.save();
  }
};

void saveMenu(){
  
  for(int i=0;i<menus.size();i++){
    Menu m = menus.get(i);
    
    m.save();
  }
  
  for(int i=0;i<textAreas.size();i++){
    TextArea t = textAreas.get(i);
    
    t.save();
  }
};


void saveTabs(){
  
  for(int i=0;i<tabs.size();i++){
    tab t = tabs.get(i);
    
    t.save();
  }
  
  for(int i=0;i<tabs.size();i++){
    tab t = tabs.get(i);
    
    t.save();
  }
};

void saveImgp(){
  
  for(int i=0;i<textBoxes.size();i++){
    TextBox t = textBoxes.get(i);
    
    t.save();
  }
};

void save(){
  
};

void start(Object o,boolean localVar){
    Field field = null;
    
    String s = "hello";
    
    try{
      //field = o.getClass().getfield(s);
      field = applet.getClass().getField(s); 
      }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }}
    
    void eventListener(){
  
};

void toggle(Object o,String globalVar,boolean localVar){
    Field field = null;
    
    try{
      
      field = applet.getClass().getField(globalVar);
      
      
    }catch (NullPointerException e) {
    }catch (NoSuchFieldException e) {
    }
  
};

void globalLogic(){
  //if(dropDownObject!=null)println(dropDownObject.label);
  if(dropDownObject!=null&&!dropDownObject.dclick){
    dropDownObject = null;
  }
  if(mousePressed) globalDown = true;
  else {
    currentMouseObject = null;
    currentObject = null;
    globalDown = false;
  }

};

  boolean getToggle(int i){
    
    if(i<menus.size()){
      Button b = buttons.get(i);
      
      if(b.toggle==1)return true;
      else return false;
    }else {
      println("BMS: menu not found");
      return false;
    }
  };

  boolean getToggle(int i,int j){
    
      if(i<menus.size()&&j<menus.get(i).items.size()){
      
      Button b = menus.get(i).items.get(j);
      
      if(b.toggle==1)return true;
      else return false;
      
    }else {
      
      println("BMS: button or menu not found.");
      return false;
      
    }
  };

  Button add(int i,Button b){
    //clear();
    b.Bms = this;
    b.applet = applet;
    buttons.add(b);
    return b;
  };
  
  Menu add(int i,Menu m){
    //clear();
    m.Bms = this;
    m.applet = applet;
    menus.add(m);
    return m;
  };
  
  Dropdown add(int i,Dropdown d){
    //clear();
    d.Bms = this;
    d.applet = applet;
    dmenus.add(d);
    return d;
  };
  
  TextBox add(int i,TextBox t){
    //clear();
    t.Bms = this;
    t.applet = applet;
    textBoxes.add(t);
    return t;
  };
  
  TextArea add(int i,TextArea t){
    //clear();
    t.Bms = this;
    t.applet = applet;
    textAreas.add(t);
    return t;
  };

  textBlock add(int i,textBlock t){
    //clear();
    t.Bms = this;
    t.applet = applet;
    textBlocks.add(t);
    return t;
  };
  
  String add(int i,String s){
    //clear();
    // tab k = states.get(i);
    // textblock.add(s);
    return s;
  };
  
  Table_ add(int i,Table_ t){
    //clear();
    t.Bms = this;
    t.applet = applet;
    tables.add(t);
    return t;
  };
  
  Button add(Button b){
    //clear();
    b.Bms = this;
    b.applet = applet;
    buttons.add(b);
    return b;
  };
  
  Menu add(Menu m){
    //clear();
    m.Bms = this;
    m.applet = applet;
    menus.add(m);
    return m;
  };
  
  Dropdown add(Dropdown d){
    //clear();
    d.Bms = this;
    d.applet = applet;
    dmenus.add(d);
    return d;
  };
  
  TextBox add(TextBox t){
    //clear();
    t.Bms = this;
    t.applet = applet;
    textBoxes.add(t);
    return t;
  };
  
  TextArea add(TextArea t){
    //clear();
    t.Bms = this;
    t.applet = applet;
    textAreas.add(t);
    return t;
  };
  
  String add(String s){
    //clear();
    //textBlocks.add(s);
    return s;
  };
  
  Table_ add(Table_ t){
    //clear();
    t.Bms = this;
    t.applet = applet;
    tables.add(t);
    return t;
  };
  
  sliderBox add(sliderBox s){
    //clear();
    s.Bms = this;
    s.applet = applet;
    sliderBoxes.add(s);
      return s;
  };
  
  Window add(Window s){
    //clear();
    s.Bms = this;
    s.applet = applet;
    windows.add(s);
    return s;
  };
  
};
