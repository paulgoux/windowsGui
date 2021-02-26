class Img {
  float Mean = 0,Variance,VarianceR,VarianceG,VarianceB,VarianceBR,s_mult,currentSliderPos = 30,ix,iy;
  public PImage img,img2, mean,mean_,meanGx,meanGy,blurX,blurY, threshold, variance,varianceR,varianceG,varianceB,varianceBR,Gaussian,
         kMeans, kNearest,sobel, sobelx, sobely,sobel2, sobel2x, sobel2y, sobelMax,sobelMin,sobelG,gradientB, blur,combined,current,canny,cannyT,temp;
  int cutoff = 250,gridRes = 1,Type = 3,pointMax = 30,min = 40,max = 10,
    contourType = 1,linesCompleted,Mode = 4,thresh = 10,pixelThresh = 40,pixelThresh1 = 20;
  public String currentParameter,currentS;
  public boolean state;
  public int processes;
  ArrayList<String>workFlowLabels=new ArrayList<String>();
  String []ddLabels = {"Blur","BlurS","Canny","Canny2","Canny3","Canny4","CannyTrim","CannyTrim1",
                       "GaussianS","Gaussian 3","Gaussian 5","Mean","Variance","Sobel","Sobel2a",
                       "Sobel2b","Sobel Max","Sobel Max2", "Sobel Max3","Sobel Max4","SobelG","SobelG1",};
  
  String []menuLabels = {"Load","Save Workflow","Save Image","Restore Menus","State"};
  String []sobelSliderLabels = {"Mult","Range"};
  String []sobel2aliderLabels = {"Mult","Range"};
  String []sobel2bliderLabels = {"Mult","Range","Type"};
  String []sobelSliderLabels1 = {"Mult","Range","Threshold"};
  String []sobelGSSliderLabels = {"Mult","Range"};
  String []sobelSSliderLabels = {"Mult","Range"};
  String []sobelASliderLabels = {"Mult","Range"};
  String []sobel2SliderLabels = {"Mult","Range"};
  String []sobelMaxSliderLabels = {"Mult","Range"};
  String []sobelMax2SliderLabels = {"Mult","Range"};
  String []sobelMax3SliderLabels = {"Mult","Range"};
  String []sobelMax4SliderLabels = {"Mult","Range"};
  String []meanSliderLabels = {"Range"};
  String []meanASliderLabels = {"Mult","Range"};
  String []meanSSliderLabels = {"Mult","Range"};
  String []varianceSliderLabels = {"Mult","Range"};
  String []blurSliderLabels = {"Mult","Range"};
  String []blurSSliderLabels ;
  String []sharpenSliderLabels = {"Mult","Range"};
  String []substractSliderLabels ;
  String []gaussian3SliderLabels ;
  String []gaussian5SliderLabels ;
  String []gaussianSSliderLabels = {"Mult","Range"};
  String []combineSliderLabels ;
  String []cannySliderLabels = {"Mode","Thresh"};
  String []canny2SliderLabels = {"Mode","Thresh","Thresh1"};
  String []canny3SliderLabels = {"Mode","Thresh"};
  String []cannyTSliderLabels = {"Type","Thresh"};
  String []cannyT1SliderLabels = {"Type","Thresh"};
  String []cannyT2SliderLabels = {"Type","Thresh","Thresh2"};
  String []blendSliderLabels ;
  String []variance2SliderLabels  = {"Range"};
  String []variance3SliderLabels  = {"Range"};
  String []menuLabels1 = {"Load","Save","Pick Camera","Load workflow","Save workflow","Restore Menus"};
  String []menuLabels2 = {"Run"};
  String []menuLabels3 = {"Clear"};
  String []menuLabels4 = {"Run All"};
  String [][]kernelLabels = {{"Range"},
                             {"Mult","Output"},
                             {"Mult","Range"},
                             {"Mult","Range","Output"},
                             {"Mult","Thresh1","Thresh2"},
                             {"Mult","Range"},
                             
                             };
  String [] functions = {"Blur","BlurS","Gaussian 3","Gaussian 5","GausianS","Mean","MeanS",
                         "Variance", "VarianceS","Sobel", "SobelS","Sobel 2","Sobel Max","Canny","CannyS"};
  HashMap<String,String[]> workFlowSliders = new HashMap<String,String[]>();
  String []sliderLabels ,currentFolder,currentWorkFlow;
  String file,folder,location;
  PImage currentImage;
  PGraphics canvas2;
  Menu menu,run,runAll,clear;
  Dropdown workFlowDD;
  sliderBox sobelSlider, meanSlider, varianceSlider, blurSlider, sobelMaxSlider, sharpenSlider, gaussianSlider ;
  public float currentF;
  int currentImageIndex,counter;
  public int firstImageIndex;
  boolean update = true,imageF = true,videoF,audioF,camF,mdown,m2down,updateSliders,sDown,docked;
  public final int IMAGES = 0,VIDEOS = 1,AUDIO = 2,MOVIE = 3,SOUND = 4;
  public boolean load = true,toggle,iUpdate,iUpdate2,iUpdate3,iUpdate4,wUpdate;
  ArrayList<PImage> images = new ArrayList<PImage>();
  ArrayList<PImage> imagesWF = new ArrayList<PImage>();
  ArrayList<ArrayList<PImage>> imagesWF2 = new ArrayList<ArrayList<PImage>>();
  ArrayList<ArrayList<PImage>> processedImages = new ArrayList<ArrayList<PImage>>();
  ArrayList<PImage> thumbnails = new ArrayList<PImage>();
  ArrayList<PImage> currentThumbnails = new ArrayList<PImage>();
  ArrayList<PImage> nextThumbnails = new ArrayList<PImage>();
  ArrayList<PImage> previousThumbnails = new ArrayList<PImage>();
  ArrayList<sliderBox> sliderBoxes = new ArrayList<sliderBox>();
  ArrayList<String> names = new ArrayList<String>();
  fileInput input;
  fileOutput output,outputWF;
  tab info,sliders,workFlow,workFlow1,workFlow3;
  PGraphics canvas,camera,c1,c2,pass1,pass2,pass3,pass4;
  PShader Sobel,Blur,GaussianS,Sobel1,Sobel2,SobelG,SobelG1,SobelMax,SobelMax2,Canny,CannyTrim,CannyTrim1;
  String []shaders = {"sobel.glsl","blur.glsl","gBlur.glsl"};
  String imPath = dataPath("images");
  String shaderPath = dataPath("shaders");
  //currentField;
  String [] instructions;
  cell cell;
  Dock myDock;
  
  int [][]SobelH = {{-1, -2, -1}, 
                    {0, 0, 0}, 
                    {1, 2, 1}};

  int [][]SobelV = {{-1, 0, 1}, 
                    {-2, 0, 2}, 
                    {-1, 0, 1}};
                    
  int [][]SobelH_ = {{-2, -1, 0}, 
                    {-1, 0, 1}, 
                    {0, 1, 2}};

  int [][]SobelV_ = {{0, 1, 2}, 
                    {-1, 0, 1}, 
                    {-2, -1, 0}};
                    
  int [][]edgev = {{-1, -2, -1}, 
                   {0, 0, 0}, 
                   {1, 2, 1}};

  int [][]edgeh = {{-1, 0, 1}, 
                   {-2, 0, 2}, 
                   {-1, 0, 1}};

  int [][]LapLacian = {{0, 1, 0}, 
                      {-1, 4, -1}, 
                      {0, 1, 0}};

  int [][]LapLacianD = {{-1, -1, -1}, 
                        {-1, 8, -1}, 
                        {-1, -1, -1}};
                        
  int [][]edge = {{-1, 1, -1}, 
                  {-1, 0, -1}, 
                  {-1, -1, -1}};
                  
  int [][]meanX = {{1,1,1}, 
                   {0,0,0}, 
                   {1,1,1}};

  int [][]meanY = {{1,1,1}, 
                   {2,0,2}, 
                   {1,0,1}};
                   
  float [][]gaussian3 = {{1,2,1}, 
                         {2,4,2}, 
                         {1,2,1}};
                     
  float [][]gaussian5 = {{1,4,7,4,1}, 
                         {4,16,126,16,4}, 
                         {7,26,41,26,7},
                         {4,16,26,16,4},
                         {1,4,7,4,1}};
                   
  color [][]neighbours;
  float [][]gradient;
  
  Img(String s) {
    img = loadImage(s);
    img2 = loadImage(s);
    neighbours = new color[img.width][img.height];
    gradient = new float[img.width][img.height];
    c1 = createGraphics(img.width,img.height,P2D);
    c2 = createGraphics(img.width,img.height,P2D);
    pass1 = createGraphics(img.width,img.height,P2D);
    pass2 = createGraphics(img.width,img.height,P2D);
    pass3 = createGraphics(img.width,img.height,P2D);
    pass4 = createGraphics(img.width,img.height,P2D);
    Sobel = loadShader(shaderPath+"sobel.glsl");
    Sobel1 = loadShader(shaderPath+"sobel1.glsl");
    Sobel2 = loadShader(shaderPath+"sobel2.glsl");
    SobelG = loadShader(shaderPath+"sobelG.glsl");
    SobelG1 = loadShader(shaderPath+"sobelG1.glsl");
    SobelMax = loadShader(shaderPath+"sobelMax.glsl");
    Canny = loadShader(shaderPath+"canny.glsl");
    CannyTrim = loadShader(shaderPath+"cannyTrim.glsl");
    CannyTrim1 = loadShader(shaderPath+"cannyTrim1.glsl");
    GaussianS = loadShader(shaderPath+"gaussian.glsl");
    c1.beginDraw();
    c1.image(img, 0, 0);
    c1.endDraw();
    pass1.beginDraw();
    pass1.image(img, 0, 0);
    pass1.endDraw();
    pass2.beginDraw();
    pass2.image(img, 0, 0);
    pass2.endDraw();
    pass3.beginDraw();
    pass3.image(img, 0, 0);
    pass3.endDraw();
    pass4.beginDraw();
    pass4.image(img, 0, 0);
    pass4.endDraw();
    cell = new cell();
    cell.pImage = this.img;
    initHashMap();
  };

  Img(PImage p) {
    img = new PImage(p.width,p.height,ARGB);
    img.pixels = p.pixels;
    cell = new cell();
    initHashMap();
  };

  Img(int w,int h){
      img = new PImage(w, h, ARGB);
      cell = new cell();
      initHashMap();
  };
  
  Img(int a){
    float mx = width-200;
    if(a==0){
      imageF=true;
      menu = new Menu(twitter.x+twitter.w,0,50,20,"IMG",menuLabels,0);
      //menu.toggle=1;
      //menus.add(menu);
      //menu = new Menu(0,0,30,20,"File",flabels,0);
    }
    if(a==1||a==3)videoF=true;
    if(a==2||a==4){
      audioF=true;
      menu = new Menu(mx,23,100,menuLabels1);
    }
    if(a==6){
      imageF = false;
      camF = true;
      menu = new Menu(mx,23,100,menuLabels1);
    }

    myDock = new Dock(0,height - 22,width,24,this);
    info = new tab(0,height - 170,width,150,"Images");
    sliders = new tab(width-100,68,100,height - 240,"Sliders");
    sliders.parentDock = myDock;
    sliders.title.w -=20;
    Button b = new Button(80,0,20,20,"<");
    sliders.add(b);
    workFlow = new tab(0,68,100,height - 240,"Workflow");
    workFlow.parentDock = myDock;
    //workFlow.addState(1);
    workFlow1 = new tab(0,68,100,height - 240,"Workflow");
    workFlow1.parentDock = myDock;
    workFlowDD = new Dropdown(0,20,100,"Function",ddLabels,0);
    //workFlow.add(1,workFlowDD);
    workFlow1.add(workFlowDD);
    workFlow1.toggle = true;
    b = new Button(workFlow1.w-20,40,20,20);
    workFlow1.add(b);
    b = new Button(workFlow1.w-40,40,20,20);
    workFlow1.add(b);
    TextArea m1 = new TextArea(0,20,100,workFlow.h - 60,10,100);
    run = new Menu(0,workFlow.h-40,100,menuLabels2);
    clear = new Menu(50,workFlow.h-40,workFlow.w-run.w,menuLabels3);
    runAll = new Menu(0,workFlow.h-20,workFlow.w,menuLabels4);
    run.w = 50;
    run.items.get(0).w = 50;
    clear.w = 50;
    clear.items.get(0).w = 50;
    runAll.w = 100;
    runAll.items.get(0).w = 100;
    workFlow.add(m1);
    workFlow.add(run);
    workFlow.add(clear);
    workFlow.add(runAll);
    workFlow1.add(run);
    workFlow1.add(clear);
    workFlow1.add(runAll);
    
    input = new fileInput(menu.items.get(0),true);
    output = new fileOutput();
    info.toggle = true;
    sliders.toggle = true;
    workFlow.toggle = true;
    info.draggable = true;
    info.scrollable = true;
    workFlow.draggable = true;
    sliders.draggable = true;
    sliders.scrollable = true;
    //workFlow.scrollable = true;
    canvas = createGraphics(width-200,height - 190);
    //menu.toggle=1;
    cell = new cell();
    initHashMap();
    initDock1();
  };

  Img(){
    menu = new Menu(width-100,23,100,menuLabels);
    
    info = new tab(0,height - 170,width,150,"Images");
    sliders = new tab(width-100,68,100,height - 240,"Sliders");
    sliders.title.w -=20;
    Button b = new Button(80,0,20,20,"<");
    sliders.add(b);
    workFlow = new tab(0,68,100,height - 240,"Workflow");
    TextArea m1 = new TextArea(0,20,100,height - 240,10,100);
    workFlow.add(m1);
    
    input = new fileInput(menu.items.get(0),true);
    output = new fileOutput();
    info.toggle = true;
    sliders.toggle = true;
    workFlow.toggle = true;
    info.draggable = true;
    info.scrollable = true;
    workFlow.draggable = true;
    sliders.draggable = true;
    sliders.scrollable = true;
    canvas = createGraphics(width-200,height - 190);
    menu.toggle=1;
    cell = new cell();
    initHashMap();
    initDock1();
    
  };

  void initDock1(){
    myDock.add(info);
    myDock.add(sliders);
    myDock.add(workFlow);
    myDock.add(workFlow1);
  };

  void initDock(){
    // float currentWidth = 0;
    // // -------------------workflow 0----------------
    
    // String loc = "Workflow";
    // PGraphics canvas = createGraphics((int)textWidth(loc)+20,20);
    // myDock.canvases.add(canvas);
    // Button b = new Button(currentWidth,y,textWidth(loc)+20,20,loc);

    // b.togglebox = true;
    // myDock.buttons.add(b);
    // myDock.objects.add(workflow);
    // myDock.currentWidth += textWidth(loc)+20;
    // myDock.names.add(loc);

    // // -------------------workflow 1----------------
    // String loc = "Workflow1";
    // PGraphics canvas = createGraphics((int)textWidth(loc)+20,20);
    // myDock.canvases.add(canvas);
    // b = new Button(currentWidth,y,textWidth(loc)+20,20,loc);

    // b.togglebox = true;
    // myDock.buttons.add(b);
    // myDock.objects.add(workflow1);
    // myDock.currentWidth += textWidth(loc)+20;
    // myDock.names.add(loc);

    // // -------------------sliders----------------
    // String loc = "Sliders";
    // PGraphics canvas = createGraphics((int)textWidth(loc)+20,20);
    // myDock.canvases.add(canvas);
    // b = new Button(currentWidth,y,textWidth(loc)+20,20,loc);

    // b.togglebox = true;
    // myDock.buttons.add(b);
    // myDock.objects.add(sliders);
    // myDock.currentWidth += textWidth(loc)+20;
    // myDock.names.add(loc);

    // // -------------------info----------------
    // String loc = "Info";
    // PGraphics canvas = createGraphics((int)textWidth(loc)+20,20);
    // myDock.canvases.add(canvas);
    // b = new Button(currentWidth,y,textWidth(loc)+20,20,loc);

    // b.togglebox = true;
    // myDock.buttons.add(b);
    // myDock.objects.add(info);
    // myDock.currentWidth += textWidth(loc)+20;
    // myDock.names.add(loc);
  };

  void initHashMap(){
    workFlowSliders.put("Blur",blurSliderLabels);
    workFlowSliders.put("BlurS",blurSSliderLabels);
    workFlowSliders.put("Gaussian 3",gaussian3SliderLabels);
    workFlowSliders.put("Gaussian 5",gaussian5SliderLabels);
    workFlowSliders.put("GaussianS",gaussianSSliderLabels);
    workFlowSliders.put("Mean",meanSliderLabels);
    workFlowSliders.put("MeanS",meanSSliderLabels);
    workFlowSliders.put("Sobel",sobelSliderLabels);
    workFlowSliders.put("SobelGS",sobelGSSliderLabels);
    workFlowSliders.put("SobelS",sobelSSliderLabels);
    workFlowSliders.put("SobelS2",sobelSSliderLabels);
    workFlowSliders.put("SobelS3",sobelSSliderLabels);
    workFlowSliders.put("Sobel 2",sobel2SliderLabels);
    workFlowSliders.put("Sobel Max",sobelMaxSliderLabels);
    workFlowSliders.put("Sobel Max2",sobelMaxSliderLabels);
    workFlowSliders.put("Sobel Max3",sobelMaxSliderLabels);
    workFlowSliders.put("Sobel Max4",sobelMaxSliderLabels);
    workFlowSliders.put("Canny",cannySliderLabels);
    workFlowSliders.put("CannyTrim",cannyTSliderLabels);
    workFlowSliders.put("CannyTrim1",cannyT1SliderLabels);
    workFlowSliders.put("Combine",combineSliderLabels);
    workFlowSliders.put("Substract",substractSliderLabels);
    workFlowSliders.put("Blend",blendSliderLabels);
    workFlowSliders.put("Variance",varianceSliderLabels);
    workFlowSliders.put("Variance2",variance2SliderLabels);
    workFlowSliders.put("Variance3",variance3SliderLabels);
  };

  Object parseParameter(String parameter) {
    try {
        return Integer.parseInt(parameter);
      } catch(NumberFormatException e) {
          try {
              return Float.parseFloat(parameter);
          } catch(NumberFormatException e1) {
              try {
                  Field field = this.getClass().getField(parameter);
                  return field.get(this);
              } catch (NoSuchFieldException e2){return null;}
                catch(IllegalAccessException e2) {
                  throw new RuntimeException(e2);
              }
          }
      }
  };

  Class<?> getParameterClass(String parameter) {
      try {
          Integer.parseInt(parameter);
          return int.class;
      } catch(NumberFormatException e) {
          try {
              Float.parseFloat(parameter);
              return float.class;
          } catch(NumberFormatException e1) {
              
              if(parameter!=null)return PImage.class;
              else return null;
          }
      }
  };

  void loadInput(){
    if(location!=null){
      String loc = "";
      if(file!=null||folder!=null){
        if(file!=null)loc = file;
        else loc = folder;

      }
      load = false;
      location = null;
    }
  };

  void display(){

  };

  void menus(){
    
    if(toggle){
      if(sliders.buttons.size()>0&&sliders.buttons.get(0).pos(sliders.getMouse())&&mousePressed&&!mdown){
        updateSliders = true;
      }
      if(!docked){
        // sliders
        // BMS.dock
        docked = true;
      }
      if(!info.sliderh.mdown)myDock.logic();
      myDock.drawItems();
      if(imageF)loadImages();
      if(videoF)loadVideo();
      if(audioF)loadSound();

      save();
      workFlowLogic();
      infoTabLogic();
      
      info.displayTab();
      info.drawDynamicImages(info.images,currentImageIndex);
      
      slidersTabLogic();
      if(!state)workFlow.displayTab();
      else workFlow1.displayTab();

      displayCam();
      
      menu.click(true);

      if(menu.click(4))menu.toggle(4,BMS.imageProcessing,"state");

      if(!state)runWorkFlow();
      else runWorkFlow1();

      displayCanvas();
      menu.draw();
      sliders.displayTab();
    }
  };

  void displayCanvas(){
    if(!mousePressed)mdown = false;

    if(currentImage!=null&&canvas!=null){
        if(iUpdate){
          canvas.beginDraw();
          canvas.background(50);
          canvas.image(currentImage,0,0);
          canvas.endDraw();

          iUpdate = false;
        }
        if(iUpdate2&&names.size()>0){
          if((firstImageIndex + currentImageIndex-3)<names.size()&&(firstImageIndex + currentImageIndex-3)>0)
          currentImage = loadImage(names.get(firstImageIndex + currentImageIndex-3));
          canvas.beginDraw();
          canvas.background(50);
          canvas.image(currentImage,0,0);
          canvas.endDraw();
          iUpdate2 = false;
        }
        
      }

      if(iUpdate4&&imagesWF.size()>0){
          currentImage = imagesWF.get(imagesWF.size()-1);
          canvas.beginDraw();
          canvas.background(50);
          canvas.image(currentImage,0,0);
          canvas.endDraw();
          iUpdate4 = false;
        }else if(iUpdate4&&imagesWF.size()==0){
          println("Workflow error...");
          iUpdate4 = false;
        }
      image(canvas,workFlow.w,21);
  };

  void slidersTabLogic(){
    int a = 200;
    int b = 100;
    int c = 40;
    
    if(sliders.buttons.size()>0&&sliders.buttons.get(0).toggle==1&&updateSliders){
      sliders.canvas = createGraphics(a,(int)sliders.h);
      sliders.buttons.get(0).x = a-20;
      sliders.title.w = a-20;
      sliders.x = width -a;
      sliders.w = a;
      sliders.sliderh.w = a;
      sliders.sliderv.x = sliders.w-10;
      updateSliders = false;
      for(int i=0;i<sliders.sliderBoxes.size();i++){
        sliderBox s = sliders.sliderBoxes.get(i);
        if(s!=null)s.menu.x = c;
      }

      for(int i=1;i<sliders.buttons.size();i++){
        if(sliders.buttons.size()>1){
        Button b1 = sliders.buttons.get(i);
        b1.x = c;
      }}
    }
    if(sliders.buttons.size()>0&&sliders.buttons.get(0).toggle==0&&updateSliders){
      sliders.canvas = createGraphics(b,(int)sliders.h);
      sliders.x = width -b;
      sliders.buttons.get(0).x = b-20;
      sliders.title.w = b-20;
      sliders.w = b;
      sliders.sliderh.w = b;
      sliders.sliderv.x = sliders.w-10;
      updateSliders = false;

      for(int i=0;i<sliders.sliderBoxes.size();i++){
        sliderBox s = sliders.sliderBoxes.get(i);
        if(s!=null){
          s.menu.x = 0;
          
        }
      }
      for(int i=1;i<sliders.buttons.size();i++){
        Button b1 = sliders.buttons.get(i);
        b1.x = 0;
      }
    }

    for(int i=0;i<sliders.sliderBoxes.size();i++){
        sliderBox s = sliders.sliderBoxes.get(i);
        if(s!=null){
          for(int j=0;j<s.menu.sliders.size();j++){
            Slider s1 = s.menu.sliders.get(j);
            if(s1.label=="Mult")s1.set(1,50);
            if(s1.label=="Range")s1.setint(1,10);
            if(s1.label=="Thresh")s1.set(1,255);
            if(s1.label=="Type")s1.setint(1,10);
          }
        }
      }
  };

  void infoTabLogic(){
    if(thumbnails.size()>0)info.sliderh.setint(0,thumbnails.size(),this,"firstImageIndex");
      if(!mousePressed&&info.posTab()){
        currentImageIndex = floor(map(mouseX,0,info.w,0,7));
      }else if(info.posTab()&&!info.sliderh.mdown)iUpdate2 = true;

      if(info.sliderh.mdown&&mousePressed&&info.posTab()&&!iUpdate&&mouseX!=pmouseX){
        iUpdate = true;
        mdown = true;
      }

    if(names!=null&&names.size()>0&&iUpdate){
      
      for(int i=firstImageIndex-4;i<firstImageIndex+5;i++){
          if(i>0&&i<thumbnails.size()){
            PImage p1 = thumbnails.get(i);
            
            if(!info.images.contains(p1)){
              info.images.add(p1);
            }
            if(info.images.size()>9)info.images.remove(0);
        }}
    }

  };

  void workFlowLogic(){
    Dropdown d1 = null;
    if(state)d1 = workFlow1.dmenus.get(workFlow1.dmenus.size()-1);

    if(d1!=null&&d1.toggle!=1){
      
      if(state&&workFlow1.buttons.get(0).click(workFlow1.getMouse())&&d1.index>-1){
        
        img = currentImage;

        workFlow1.add(new Dropdown(0,workFlow1.dmenus.size()*20+20,100,"Function " + workFlow1.dmenus.size(),ddLabels,0));
        workFlow1.buttons.get(0).y+=20;
        workFlow1.buttons.get(1).y+=20;
        //println(workFlow1.Dropdowns.get(0).)
        if(workFlowSliders.get(d1.label)!=null){
          sliderBox s = null;
          Button b1 = null; 
          if(sliders.buttons.size()>0&&sliders.buttons.get(0).toggle==0){
            s = new sliderBox(0,30+ currentSliderPos,90,5,workFlowSliders.get(d1.label),sliders);
            b1 = new Button(0,30+ currentSliderPos-20,90,20,d1.label);
          }else{
            s = new sliderBox(30,30+ currentSliderPos,90,5,workFlowSliders.get(d1.label),sliders);
            b1 = new Button(30,30+ currentSliderPos-20,90,20,d1.label);
          } 
          
          s.visible = true;
          s.tooltip = null;
          sliders.add(s);
          b1.border = false;
          sliders.add(b1);
          
        }else{
          Button b1;
          if(sliders.buttons.size()>0&&sliders.buttons.get(0).toggle==0){
            
            b1 = new Button(0,30+ currentSliderPos-20,90,20,d1.label);
          }else{
            b1 = new Button(30,30+ currentSliderPos-20,90,20,d1.label);
          } 
          sliders.buttons.add(b1);
          sliders.sliderBoxes.add(null);
        }

        sliderBox s1 = null;
        if(sliders.sliderBoxes.get(sliders.sliderBoxes.size()-1)!=null){
        s1 = sliders.sliderBoxes.get(sliders.sliderBoxes.size()-1);

        currentSliderPos = s1.y+s1.h ;
        }else{
          currentSliderPos += 40;
        }
      }

      if(workFlow1.buttons.get(1).click(workFlow1.getMouse())&&workFlow1.dmenus.size()>1){
        if(workFlow1.dmenus.size()>=1)workFlow1.dmenus.remove(workFlow1.dmenus.size()-1);
        if(sliders.sliderBoxes.size()>=1){
          sliderBox s1 ;
          if(sliders.sliderBoxes.get(sliders.sliderBoxes.size()-1)!=null){
            s1 = sliders.sliderBoxes.get(sliders.sliderBoxes.size()-1);
            currentSliderPos = s1.y-s1.h-20;
            if(currentSliderPos<sliders.y+20)currentSliderPos = currentSliderPos+20;
            sliders.sliderBoxes.remove(sliders.sliderBoxes.size()-1);
            sliders.buttons.remove(sliders.buttons.size()-1);
          }
          else {
            sliders.sliderBoxes.remove(sliders.sliderBoxes.size()-1);
            sliders.buttons.remove(sliders.buttons.size()-1);
            currentSliderPos -= 20;
          }

          workFlow1.buttons.get(0).y-=20;
          workFlow1.buttons.get(1).y-=20;
        }
      }
    }
      if(info.sliderh.mdown)iUpdate2 = true;

    // if(workFlow1.menus.items.get(0).click(workflow.getMouse())){

    // }
  };

  void workFlowLogic1(){
    //if()
  };

  void displayCam(){

    if(BMS.Cam!=null){
        set(BMS.Cam);
        canvas.beginDraw();
        //if(img!=null)
        canvas.image(BMS.Cam,0,0);
        if(mousePressed)println("cam connected");
        
        canvas.background(50);
        if(firstImageIndex<images.size()&&firstImageIndex>0)canvas.image(images.get(firstImageIndex),0,0);
        canvas.endDraw();
      }

  };

  void runWorkFlow(){
    if(run.selfClick(0)&&!state){
      println("workflow 0");
        imagesWF = new ArrayList<PImage>();
        img = currentImage;
        
        if(workFlow.textareas.get(0).getValue()!=null){

          println("Run",workFlow.textareas.get(0).getValue());
          String[] s = splitTokens(workFlow.textareas.get(0).getValue(),",");
          String[] s1 = new String[1];
          currentWorkFlow = s1;
          s1[0] = workFlow.textareas.get(0).getValue();
          iUpdate3 = true;
          workflow(s1);
          //println(s1);
          
        }else println(false);
      }

      if(clear.selfClick(0)){
        currentWorkFlow = null;
        workFlow.textareas.get(0).textBox ="";
        workFlow.textareas.get(0).textbox = new ArrayList<Letter>();
      }
      // if(runAll.selfClick(0)){

      //   for(int i=0;i<names.size();i++){

      //   }
      // }
  };

  void runWorkFlow1(){
    if(run.selfClick(0)&&state){
        imagesWF = new ArrayList<PImage>();
        img = currentImage;
        
        if(sliders.sliderBoxes.size()>0){
          String log = "Run state1";

          String []wf = new String[sliders.sliderBoxes.size()] ;
          println("Run state1",workFlow.textareas.get(0).getValue());
          for(int i=0;i<sliders.sliderBoxes.size();i++){
            String s = workFlow1.dmenus.get(i).label + "(";
            sliderBox sl = null;
            if(sliders.sliderBoxes.get(i)!=null)
              sl = sliders.sliderBoxes.get(i);
              for(int j=0;j<sl.menu.sliders.size();j++){
                Slider slider = sl.menu.sliders.get(j);

                float v1 = -1;
                int v2 = -1;

                if(slider.label=="Mult"||slider.label=="Thresh"){
                  if(j<sl.menu.sliders.size()-1)s += slider.value + ",";
                  else s += slider.value ;
                }else{
                  if(j<sl.menu.sliders.size()-1)s += (int)slider.value + ",";
                  else s += (int)slider.value ;
                }
              }
            s += ")";
            if(s!=null)wf[i] = s;
          }
          println(wf);
          // String[] s1 = splitTokens(workFlow.textareas.get(0).getValue(),",");
          // String[] s2 = new String[1];
          // currentWorkFlow = s2;
          // s2[0] = workFlow.textareas.get(0).getValue();
          // iUpdate3 = true;
          // workflow(s2);
          // println(s2);
          
        }else println("No workflow available");
      }

      if(clear.selfClick(0)&&state){
        currentWorkFlow = null;

        while(sliders.buttons.size()>1)sliders.buttons.remove(sliders.buttons.size()-1);
        while(sliders.sliderBoxes.size()>0)sliders.buttons.remove(sliders.sliderBoxes.size()-1);

      }
      // if(runAll.selfClick(0)){

      //   for(int i=0;i<names.size();i++){

      //   }
      // }
  };

  void loadImages(){
    input.listen();
    if(input.values!=null){
      println("input",input.values.length);
      currentFolder = input.values;
          //names = new String[input.values.length];
          if(images.size()<input.values.length)
          for(int i=0;i<input.values.length;i++){
            String s1 = input.files[i].getAbsolutePath();
            String[] m1 = match(s1, ".jpg");
            String[] m2 = match(s1, ".jpeg");
            String[] m3 = match(s1, ".gif");
            String[] m4 = match(s1, ".png");
            String[] m5 = match(s1, ".bmp");
            String[] m6 = match(s1, ".JPG");
            String[] m7 = match(s1, ".JPEG");
            String[] m8 = match(s1, ".GIF");
            String[] m9 = match(s1, ".PNG");
            String[] m10 = match(s1, ".BMP");

            if (m1 != null||m2 != null||m3 != null||m4 != null||m5 != null||
                m6 != null||m7 != null||m8 != null||m9 != null||m10 != null) { 
              
                PImage thumbnail = loadImage(s1);
                
                thumbnail.resize(150,90);
                thumbnails.add(thumbnail);
                names.add(s1);
            }
          }
          if(names.size()>0){
            println("step 1","first index:",firstImageIndex);
            info.sliderh.valuex = 0;
            info.sliderh.value = 0;
            if(firstImageIndex<0)firstImageIndex=0;
            currentImage = loadImage(names.get(firstImageIndex));
            iUpdate = true;
          }else{
            println("No images found...");
            names = new ArrayList<String>();
          }
          input.values = null;
    } 
    
  };

  void loadVideo(){


  };

  void loadSound(){


  };

  void save(){

  };
  
  void workflow(String a){
    String[] s = splitTokens(a, "-");
    println("workflow 0");
    for(int i=0;i<s.length;i++){
      String s1 = s[i];
      
      //ArrayList<Integer> [] pIndex = strIndex(s1,"(",")");
      int [] pIndex = strIndex1(s1,"(",")");
      String function = s1.substring(0,pIndex[0]);
      
      //String[]parameters = new String [pIndex[0].size()];
      String[]parameters = splitTokens(s[i].substring(pIndex[0]+1,pIndex[1]),",");
      parameters[parameters.length-1] =  parameters[parameters.length-1].substring(0,parameters.length-1);
      
      boolean image = false;
      Method method = null;
      try {
        method = this.getClass().getMethod(function,float.class,float.class);
        //Img instance = new Img();
        float result = (float) method.invoke(this, 1, 3);
        println("result",result);
      } catch (SecurityException e) {
        println(function , "se");
      }catch (NoSuchMethodException e) {  
        println(function , "nsm");
      }
      catch (IllegalAccessException e) {  
        println(function , "nsm");
      }
      catch (InvocationTargetException e) {  
        println(function , "nsm");
      }
      for(int j=0;j<parameters.length;j++){
        
        float currentF = float(parameters[j]);
        
        if(currentF>-10000000&&currentF<10000000){
          println(function,"f " + currentF);
        }else println(function,"s " + parameters[j]);
        
      }
    }
  };
  
  void workflow(String[] a){
    if(!iUpdate3){
      println("something wrong..");

    }
    if(iUpdate3&&a!=null){
      println("workflow 0");
      String[] s = a;
      
      for(int i=0;i<s.length;i++){
        String s1 = s[i];
        if(s[i].length()>0){
        int [] pIndex = strIndex1(s1,"(",")");
        String function = s1.substring(0,pIndex[0]);
        
        String[]parameters = splitTokens(s[i].substring(pIndex[0]+1,pIndex[1]),",");
        print("Parameters",function +"(");
        String s2 = "";
        Class<?>[] parameterClasses = new Class<?>[parameters.length];
        Object[] parsedParameters = new Object[parameters.length];
        for(int j=0;j<parameters.length;j++){
          //print(parameters[j]);
          
          parameterClasses[j] = getParameterClass(parameters[j]);
          parsedParameters[j] = parseParameter(parameters[j]);
          // s2+=parameterClasses[j]+" "+parameters[j];
          s2 += parameters[j];
          if(j<parameters.length-1)s2+=",";
        }
        println(s2+")");
        
        update = true;
        try {
            Method method = this.getClass().getMethod(function, parameterClasses);
            method.invoke(this, parsedParameters);
            img = imagesWF.get(imagesWF.size()-1);
            workFlowLabels.add(function);
          } catch (NoSuchMethodException e){println("nsm",function,parameterClasses[0]);e.printStackTrace();}
            catch(IllegalAccessException e){println("ia");e.printStackTrace();}
            catch( InvocationTargetException e){println("it...Check images");e.printStackTrace();}
    }}
    update = false;
  }else if(a==null){
    iUpdate3 = false;
    println("Please correct function...");
  }

};
  
void workflow2(String[] a){
    if(update&&a!=null){
      String[] s = a;
      
      for(int i=0;i<s.length;i++){
        String s1 = s[i];
        if(s[i].length()>0){
        int [] pIndex = strIndex1(s1,"(",")");
        String function = s1.substring(0,pIndex[0]);
        
        String[]parameters = splitTokens(s[i].substring(pIndex[0]+1,pIndex[1]),",");
        print("p",function +"(");
        String s2 = "";
        Class<?>[] parameterClasses = new Class<?>[parameters.length];
        Object[] parsedParameters = new Object[parameters.length];
        for(int j=0;j<parameters.length;j++){
          //print(parameters[j]);
          
          parameterClasses[j] = getParameterClass(parameters[j]);
          parsedParameters[j] = parseParameter(parameters[j]);
          // s2+=parameterClasses[j]+" "+parameters[j];
          s2 += parameters[j];
          if(j<parameters.length-1)s2+=",";
        }
        println(s2+")");
        
        update = true;
        try {
            Method method = this.getClass().getMethod(function, parameterClasses);
            method.invoke(this, parsedParameters);
          } catch (NoSuchMethodException e){println("nsm",function,"...Check Params?");}
            catch(IllegalAccessException e){println("ia") ;}
            catch( InvocationTargetException e){println("it","This function is missing an image...");e.printStackTrace();}
    }}
    update = false;
  }else if(a==null)update = false;
  
  if(keyPressed&&key =='r')update = true;
      
  };
  
  
void catch1(){
    
  };
  
  void reflection(){
    
  };
  
  float mult(float a,float b){
    return a * b;
  };
  
  //String[] split(String s,String s1){
  //  String[]S = splitTokens(s.substring(pIndex[0]+1,pIndex[1]),",");
  //  parameters[parameters.length-1] =  parameters[parameters.length-1].replaceAll(")s+","");
  //  return 
  //};
  
  int [] strIndex1(String s,String a,String b){
    int[]index = new int [2];
    for(int i=0;i<s.length();i++){
      char c = s.charAt(i);
      if(c=='(')index[0] = i;
      if(c==')')index[1] = i;
    }
    return index;
  };
  
  ArrayList [] strIndex(String s,String a,String b){
    ArrayList[]index = new ArrayList [2];
    index[0] = new ArrayList<Integer>();
    index[1] = new ArrayList<Integer>();
    for(int i=0;i<s.length();i++){
      char c = s.charAt(i);
      if(c=='(')index[0].add(i);
      if(c==')')index[1].add(i);
    }
    return index;
  };
  
  int findNext(String s){
    int a = -1;
    
    return a;
  };
  
  void set(PImage p){
    img = p;
    c1 = createGraphics(img.width,img.height,P2D);
  };

  void threshold(float a) {
    threshold = new PImage(img.width, img.height, RGB);
    img.loadPixels();
    threshold.loadPixels();
    if (mean==null) {
      for (int i=0; i<img.width; i++) {
        for (int j=0; j<img.height; j++) {
          int p = i + j * img.width;
          float b = brightness(img.pixels[p]);
          if (b>a)b = 0;
          threshold.pixels[p] = color(255-b);
        }
      }
    } else {
      //for (int i=0; i<mean.width; i++) {
      //  for (int j=0; j<mean.height; j++) {
      //    int p = i + j * mean.width;
      //    float b = brightness(mean.pixels[p]);
      //    //if (b>a)b = 0;
      //    threshold.pixels[p] = color(b);
      //  }
      //}
    }

    threshold.updatePixels();

    threshold.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(mean.pixels[i]);
      //println(b);
      //if (b<a)b=0;
      b = 255;

      threshold.pixels[i] = color(random(b));
      //threshold.pixels[i] = color(b);
    }
    threshold.updatePixels();
    imagesWF.add(threshold);
  };

  void threshold(PImage im,float a) {
    threshold = new PImage(im.width, im.height, RGB);
    threshold.loadPixels();
    im.loadPixels();

    for (int i=0; i<im.width; i++) {
      for (int j=0; j<im.height; j++) {
        
        int p = i + j * im.width;
        float b = brightness(im.pixels[p]);
        boolean k = getTMin(i,j,im,a);
        //b = 255;
        if (k)b = 0;
        else b = 255;
  
        threshold.pixels[p] = color((b));
    }}
    threshold.updatePixels();
    imagesWF.add(threshold);
  };
  
  boolean getTMin(int x, int y,PImage im,float t) {
    
    float []min = new float[2];
    min[0] = 255;
    
    boolean k = false;
    int p = x + y * im.width;
    
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
        
        int p1 = i+j*im.width;
        
        if(p1>0&&p1<im.pixels.length&&p1!=p){
          
          float c = brightness(im.pixels[p1]);
          
          if(min[0]>c){
            min[0] = c;
            min[1] = p1;
          }}}
    }
    
    int p1 = (int)min[1];
    
    float c = brightness(im.pixels[p]);
    float c2 = brightness(im.pixels[p1]);
    float t2 = 30;
    //println(min[0]);
    float d = abs((c)-c2);
    
    //if(c<=c2&&c<t||c2<t&&d<t2)k = true;
    //if(c<t&&(c<=c2)||c2<t&&(d<t2)||c2<t&&d<t2)k = true;
    //if(c<t&&(c>=c2)^c>t&&(d>t2)||c2<t&&d<t2)k = true;
    if(c2<c){
      if(c2<t+t2)k = true;
    }
    else{
      //if(c<t)k = true;
    }
    //println(c,k,t,t+t2);
    //println(c,c2,c<t,d<t2,t,k,d);
    //println(d<t2&&c2>c,c2<c,c,c2,k);
    return k;
    
  };

  void mean() {

    mean = new PImage(img.width, img.height, RGB);
    float mean_ = 0;
    img.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(img.pixels[i]);
      mean_ += b;
    }

    mean_ /= img.pixels.length;

    mean.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(img.pixels[i]);
      float a = mean_ - b;
      mean.pixels[i] = color(255-a);
    }

    mean.updatePixels();
    imagesWF.add(mean);
    c1.beginDraw();
    c1.image(mean, 0, 0);
    c1.endDraw();
  };

  void mean(float k) {

    mean = new PImage(img.width, img.height, RGB);
    Mean = 0;
    img.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(img.pixels[i]);
      Mean += b;
    }

    Mean /= img.pixels.length;
    //Mean = k + Mean;

    mean.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(img.pixels[i]);
      float a = Mean - b;
      mean.pixels[i] = color(255-a);
    }

    mean.updatePixels();
    imagesWF.add(mean);
    c1.beginDraw();
    c1.image(mean, 0, 0);
    c1.endDraw();
  };

  void mean(int a) {
    mean = new PImage(img.width, img.height, RGB);
    mean.loadPixels();
    mean_ = new PImage(img.width, img.height, RGB);
    mean_.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        //float b = brightness(img.pixels[p]);

        float []mn = getNeighboursMean(i, j, a);
        float m = mn[0];
        //println(mean_);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);

        float a5 = brightness(img.pixels[p]);
        //println(mean_ - b);

        //img.pixels[p] = color(b);
        //float k = mean_*mean_*mean_*mean_*mean_ -(-mean_ -a1)*(-mean_ +a1)*(-mean_ -a2)*(-mean_ +a2)*(-mean_ -a3)*(-mean_ +a3)*(-mean_ -a4)*(-mean_ +a4)*(-mean_ -a5)*(-mean_ +a5);
        //mean.pixels[p] = color((255)-k);
        //if ((mean_ -b)<20)
        //mean.pixels[p] = color(255-(mean_ -(-mean_ -a1)));
        //mean.pixels[p] = color(255-(mean_*mean_ -(-mean_ -a1)));
        mean_.pixels[p] = color(255-(m - a5));
        mean.pixels[p] = color(255-(m - a5));
        //mean.pixels[p] = color(0);
        //mean.pixels[p] = color(random(255));
        //else mean.pixels[p] = color(255);
      }
    }
    mean.updatePixels();
    imagesWF.add(mean);
    c1.beginDraw();
    c1.image(mean, 0, 0);
    c1.endDraw();
  };
  
  void mean(PImage img,int a) {
    mean = new PImage(img.width, img.height, RGB);
    mean.loadPixels();
    mean_ = new PImage(img.width, img.height, RGB);
    mean_.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        //float b = brightness(img.pixels[p]);

        float []mn = getNeighboursMean(i, j, a,img);
        float m = mn[0];
        //println(mean_);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);

        float a5 = brightness(img.pixels[p]);
        //println(mean_ - b);

        //img.pixels[p] = color(b);
        //float k = mean_*mean_*mean_*mean_*mean_ -(-mean_ -a1)*(-mean_ +a1)*(-mean_ -a2)*(-mean_ +a2)*(-mean_ -a3)*(-mean_ +a3)*(-mean_ -a4)*(-mean_ +a4)*(-mean_ -a5)*(-mean_ +a5);
        //mean.pixels[p] = color((255)-k);
        //if ((mean_ -b)<20)
        //mean.pixels[p] = color(255-(mean_ -(-mean_ -a1)));
        //mean.pixels[p] = color(255-(mean_*mean_ -(-mean_ -a1)));
        mean_.pixels[p] = color(255-(m - a5));
        mean.pixels[p] = color(255-(m - a5)*25);
        //mean.pixels[p] = color(0);
        //mean.pixels[p] = color(random(255));
        //else mean.pixels[p] = color(255);
      }
    }
    mean.updatePixels();
    imagesWF.add(mean);
    c1.beginDraw();
    c1.image(mean, 0, 0);
    c1.endDraw();
  };
  
  void mean(float mult,int a) {
    mean = new PImage(img.width, img.height, RGB);
    mean.loadPixels();
    mean_ = new PImage(img.width, img.height, RGB);
    mean_.loadPixels();
    meanGx = new PImage(img.width, img.height, RGB);
    meanGx.loadPixels();
    meanGy = new PImage(img.width, img.height, RGB);
    meanGy.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        //float b = brightness(img.pixels[p]);

        float []mn = getNeighboursMean(i, j, a);
        float m = mn[0];
        float mx = mn[1];
        float my = mn[2];
        //println(mean_);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);

        float a5 = brightness(img.pixels[p]);
        //println(mean_ - b);

        //img.pixels[p] = color(b);
        //float k = m*m*m*m*m*m -(-m -a1)*(-m +a1)*(-m -a2)*(-m +a2)*(-m -a3)*(-m +a3)*(-m -a4)*(-m +a4)*(-m -a5)*(-m +a5);
        //float k = m*m*m*m*m -(-m -a2)*(-m +a2)*(-m -a3)*(-m +a3)*(-m -a4)*(-m +a4)*(-m -a5)*(-m +a5);
        //float k = m*m*m*m -(-m -a2)*(-m +a2)*(-m -a3)*(-m +a3)*(-m -a4)*(-m +a4);
        //float k = m*m*m -(-m -a2)*(-m +a2)*(-m -a3)*(-m +a3);
        //float k = m*m -(-m -a2)*(-m +a2);
        //float k = m*m -(-m -a1)*(-m +a1);
        //float k = m*m -(-m -a5)*(-m +a5);
        
        //mean.pixels[p] = color((255)-k);
        //if ((m -b)<20)
        //mean.pixels[p] = color(255-(m -(-m -a1)));
        //mean.pixels[p] = color(255-(m*m -(-m -a1)));
        //mean.pixels[p] = color(255-(m*mult - a5));
        mean.pixels[p] = color(255-(m - a5)*mult);
        //mean.pixels[p] = color(255-(k));
      }
    }
    mean.updatePixels();
    imagesWF.add(mean);
    c1.beginDraw();
    c1.image(mean, 0, 0);
    c1.endDraw();
  };
  
  void mean(PImage img,float mult,int a) {
    mean = new PImage(img.width, img.height, RGB);
    mean.loadPixels();
    mean_ = new PImage(img.width, img.height, RGB);
    mean_.loadPixels();
    meanGx = new PImage(img.width, img.height, RGB);
    meanGx.loadPixels();
    meanGy = new PImage(img.width, img.height, RGB);
    meanGy.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        //float b = brightness(img.pixels[p]);

        float []mn = getNeighboursMean(i, j, a,img);
        float m = mn[0];
        float mx = mn[1];
        float my = mn[2];
        //println(mean_);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);

        float a5 = brightness(img.pixels[p]);
        //println(mean_ - b);

        //img.pixels[p] = color(b);
        //float k = mean_*mean_*mean_*mean_*mean_ -(-mean_ -a1)*(-mean_ +a1)*(-mean_ -a2)*(-mean_ +a2)*(-mean_ -a3)*(-mean_ +a3)*(-mean_ -a4)*(-mean_ +a4)*(-mean_ -a5)*(-mean_ +a5);
        //mean.pixels[p] = color((255)-k);
        //if ((mean_ -b)<20)
        //mean.pixels[p] = color(255-(mean_ -(-mean_ -a1)));
        //mean.pixels[p] = color(255-(mean_*mean_ -(-mean_ -a1)));
        mean_.pixels[p] = color(255-(m - a5));
        mean.pixels[p] = color(255-(m - a5)*mult);
        meanGx.pixels[p] = color(mx);
        meanGy.pixels[p] = color(my);
        //mean.pixels[p] = color(0);
        //mean.pixels[p] = color(random(255));
        //else mean.pixels[p] = color(255);
      }
    }
    meanGx.updatePixels();
    meanGy.updatePixels();
    imagesWF.add(mean);
    c1.beginDraw();
    c1.image(mean, 0, 0);
    c1.endDraw();
  };

  void mean_(int a) {
    mean = new PImage(img.width, img.height, RGB);

    mean.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;

        float []mean_ = getNeighboursMean(i, j, a);
        float m = mean_[0];
        //println(mean_);
        //float b = brightness(img.pixels[p]);
        //println(mean_ - b);

        //img.pixels[p] = color(b);
        //if ((mean_ -b)<20)
        float k = m-((m)/(b)*(m)/(b)) *((m)*(b)/(m));
        //k = m*m - (m-b)*(m-b);
        //println(k);
        //k = m - b;
        float t1 = (k);
        //k = (m*m -t1*t1);
        float t = 2.0;
        //k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        k = t/ (1.0 + exp(-t * (k))) - 1.0;

        mean.pixels[p] = color(k*255);
        //mean

        //mean.pixels[p] = color(b);
        //else mean.pixels[p] = color(255);
      }
    }
    mean.updatePixels();
    c1.beginDraw();
    c1.image(mean, 0, 0);
    c1.endDraw();
  };


  void meanR(int a) {
    mean = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        img.pixels[p] = color(b);
      }
    }
  };

  void meanG(int a) {
    mean = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        img.pixels[p] = color(b);
      }
    }
  };

  void meanB(int a) {
    mean = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        img.pixels[p] = color(b);
      }
    }
  };

  void meanRGB() {
    mean = new PImage(img.width, img.height, RGB);
    float mean_ = 0;
    img.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float b = brightness(img.pixels[i]);
      mean_ += b;
    }

    mean_ /= img.pixels.length;
    mean_ = 150 +mean_;

    mean.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      float r = red(img.pixels[i]);
      float g = green(img.pixels[i]);
      float b = blue(img.pixels[i]);
      float br = brightness(img.pixels[i]);
      float a = mean_ - (r+g+b+br)/4;
      mean.pixels[i] = color(255-a);
    }

    mean.updatePixels();
    imagesWF.add(mean);
  };

  void localMean() {
    mean = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
      }
    }
  };

  void kMeans() {
    kMeans = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        //float b = map(brightness(img.pixels[p]),0,255,0,100);
        float b = brightness(img.pixels[p]);
        img.pixels[p] = color(b);
      }
    }
  };

  void kNearest(float a) {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);

        img.pixels[p] = color(b);
      }
    }
  };

  void variance() {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();
    variance.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float var = getNeighboursVar(i,j,1);
        float a1 = red(img.pixels[p]);
        float a2 = green(img.pixels[p]);
        float a3 = blue(img.pixels[p]);
        float a4 = brightness(img.pixels[p]);
        //println(var);
        variance.pixels[p] = color(255-var);
      }
    }
    variance.updatePixels();
    imagesWF.add(variance);
    c1.beginDraw();
    c1.image(variance, 0, 0);
    c1.endDraw();
  };

  void variance(int a) {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();
    variance.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float var = getNeighboursVar(i, j, a);
        //float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
        float a2 = red(mean.pixels[p]);
        float a3 = green(mean.pixels[p]);
        float a4 = blue(mean.pixels[p]);
        float a5 = brightness(mean.pixels[p]);


        float k = var*4;
        //float r = sqrt((var + ( var - a1)) * a1 + (var + ( var - a2)) * a2 + (var + ( var - a3)) * a3 + (var + ( var - a4)) * a4);
        //float r = var*var*var - (var + a1)*(var - a1)*(var + a2)*(var - a2)*(var + a3)*(var - a3)*(var + a4)*(var - a4)*(var + a5)*(var - a5);
        float r = var*var*var*var*var*var*var*var*var - (var + a1)*(var - a1)*(var + a2)*(var - a2)*(var + a3)*(var - a3)*(var + a4)*(var - a4)*(var + a5)*(var - a5);
        //float r = var*var*var*var*var*var*var*var*var - (-var + a1)*(-var - a1)*(-var + a2)*(-var - a2)*(-var + a3)*(-var - a3)*(-var + a4)*(-var - a4)*(-var + a5)*(-var - a5);
        //println(k);
        //float r = ((var-brightness(mean.pixels[p]))*20);
        //float r = var;
        //r = (var*var-(var - a5)*(var + a5));
        //r = var+a1;
        //println(r);
        //println(var,r);
        variance.pixels[p] = color(var);
      }
    }
    variance.updatePixels();
    imagesWF.add(variance);
    c1.beginDraw();
    c1.image(variance, 0, 0);
    c1.endDraw();
  };
  
  void variance3(int a) {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();
    variance.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float var = getNeighboursVar3(i, j, a);
        //float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        float a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
        float a2 = red(mean.pixels[p]);
        float a3 = green(mean.pixels[p]);
        float a4 = blue(mean.pixels[p]);
        float a5 = brightness(mean.pixels[p]);
        
        float r = var;
        //println(var);
        //r = (var*var-(var - a5)*(var + a5));
        variance.pixels[p] = color(r);
      }
    }
    variance.updatePixels();
    imagesWF.add(variance);
    c1.beginDraw();
    c1.image(variance, 0, 0);
    c1.endDraw();
  };
  
  void variance(PImage imgg,int a) {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();
    variance.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float var = getNeighboursVar(i, j, a,imgg);
        float a7 = (red(imgg.pixels[p]) + green(imgg.pixels[p]) + blue(imgg.pixels[p]) + brightness(imgg.pixels[p]))/4;
        float r = sqrt(var + (a7));
        variance.pixels[p] = color((r));
      }
    }
    variance.updatePixels();
    imagesWF.add(variance);
    c1.beginDraw();
    c1.image(variance, 0, 0);
    c1.endDraw();
  };

  void variance(int a, int n) {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();
    //variance.loadPixels();
    Variance = 0;
    for (int i=0; i<img.pixels.length; i++) {
      float a1 = (red(img2.pixels[i]) + green(img2.pixels[i]) + blue(img2.pixels[i]) + brightness(img2.pixels[i]))/4;
      float a2 = (red(mean.pixels[i]) + green(mean.pixels[i]) + blue(mean.pixels[i]) + brightness(mean.pixels[i]))/4;
      //float a2 = (red(threshold.pixels[i]) + green(threshold.pixels[i]) + blue(threshold.pixels[i]) + brightness(threshold.pixels[i]))/4;
      //a2 = brightness(mean.pixels[i]);
      //println("mean " + i + " " + a2);
      Variance += (a2 - a1)*(a2 - a1);
      //float a1 = red(img.pixels[p]);
      //float a2 = green(img.pixels[p]);
      //float a3 = blue(img.pixels[p]);
      //float a4 = brightness(img.pixels[p]);

      //float k = var*4;
      //float r = (var + ( var - a1)) * a1 + (var + ( var - a2)) * a2 + (var + ( var - a3)) * a3 + (var + ( var - a4)) * a4;
      ////println(k);
      ////println(var,r);
      //variance.pixels[p] = color(255-(k-r));
    }
    //variance.updatePixels();
    Variance /= img.pixels.length;
    Variance = sqrt(Variance);
    //var = abs(var);
    println("Variance " + Variance);
    variance.loadPixels();
    img.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float m = brightness(mean.pixels[p]);
        //float a1 = red(img.pixels[p]);
        float a1 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
        //float a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
        float a2 = red(img.pixels[p]);
        float a3 = green(img.pixels[p]);
        float a4 = blue(img.pixels[p]);
        float a5 = brightness(img.pixels[p]);

        float k = Variance*4;
        float r = Variance;
        //float r = Variance*Variance - (Variance - a1)*(Variance + a2);
        //float b = Variance*Variance*Variance*Variance -((((Variance+a1)) + (Variance - a2))*(((Variance)) + (Variance + a3))*(((Variance)) + (Variance + a4))*((Variance) + (Variance + a1)))-255;
        //println(r);
        ////println(Variance,r);
        variance.pixels[p] = color(r);
      }
    }
    variance.updatePixels();
    imagesWF.add(variance);
    c1.beginDraw();
    c1.image(variance, 0, 0);
    c1.endDraw();
  };

  void variance2(int a) {
    variance = new PImage(img.width, img.height, RGB);
    variance.loadPixels();
    varianceR = new PImage(img.width, img.height, RGB);
    varianceR.loadPixels();
    varianceG = new PImage(img.width, img.height, RGB);
    varianceG.loadPixels();
    varianceB = new PImage(img.width, img.height, RGB);
    varianceB.loadPixels();
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float []v = getNeighboursVar2(i, j, a);
        float a1 = (red(img2.pixels[p]) + green(img2.pixels[p]) + blue(img2.pixels[p]) + brightness(img2.pixels[p]))/4;
        //float a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
        float a2 = red(img2.pixels[p]);
        float a3 = green(img2.pixels[p]);
        float a4 = blue(img2.pixels[p]);
        float a5 = brightness(img2.pixels[p]);
        
        float var = v[0];

        float k = var*4;
        float r = (var + ( var - a1)) * a1 + (var + ( var - a2)) * a2 + (var + ( var - a3)) * a3 + (var + ( var - a4)) * a4;
        //float r = var*var*var*var*var*var*var*var - (var + a2)*(var - a2)*(var + a3)*(var - a3)*(var + a4)*(var - a4)*(var + a5)*(var - a5);
        //float r = var*var*var*var*var*var*var*var*var - (var + a1)*(var - a1)*(var + a2)*(var - a2)*(var + a3)*(var - a3)*(var + a4)*(var - a4)*(var + a5)*(var - a5);
        //float r = var*var*var*var*var*var*var*var*var - (-var + a1)*(-var - a1)*(-var + a2)*(-var - a2)*(-var + a3)*(-var - a3)*(-var + a4)*(-var - a4)*(-var + a5)*(-var - a5);
        //println(k);
        //println(var,r);
        variance.pixels[p] = color((r));
      }
    }
    variance.updatePixels();
    imagesWF.add(variance);
    c1.beginDraw();
    c1.image(variance, 0, 0);
    c1.endDraw();
  };

  void kNearest() {
    variance = new PImage(img.width, img.height, RGB);
    img.loadPixels();

    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);

        img.pixels[p] = color(b);
      }
    }
  };
  
  void combine(PImage a,PImage b){
    combined = new PImage(img.width, img.height, RGB);
    combined.loadPixels();
    for (int i=0; i<img.pixels.length; i++) {
      
      float b1 = brightness(a.pixels[i]);
      float b2 = brightness(b.pixels[i]);
      
      if(b1<b2)combined.pixels[i] = color(b1);
      else combined.pixels[i] = color(b2);
      
    }
    combined.updatePixels();
    imagesWF.add(combined);
  };

  void blur(int a) {
    blur = new PImage(img.width, img.height, RGB);
    //sobelG = new PImage(img.width, img.height, RGB);
    blur.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float mean = getNeighboursBlur(i, j, a);
        float b = brightness(img.pixels[p]);
        blur.pixels[p] = color(mean);
        
      }
    }
    blur.updatePixels();
    imagesWF.add(blur);
    c1.beginDraw();
    c1.image(blur, 0, 0);
    c1.endDraw();
  };
  
  void blur(PImage img,int a) {
    blur = new PImage(img.width, img.height, RGB);
    //sobelG = new PImage(img.width, img.height, RGB);
    blur.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float mean = getNeighboursBlur(i, j, a,img);
        float b = brightness(img.pixels[p]);
        //blur.pixels[p] = color(255-(mean*(mult2)-b)+offset);
        blur.pixels[p] = color(mean);
        //sobelG.pixels[p] = color((gradient[i][j]*100));
        //println(gradient[i][j],green(sobelG.pixels[p]));
      }
    }
    blur.updatePixels();
    imagesWF.add(blur);
    c1.beginDraw();
    c1.image(blur, 0, 0);
    c1.endDraw();
  };
  
  void blurS(int a) {
    blur = new PImage(img.width, img.height, RGB);
    blurX = new PImage(img.width, img.height, RGB);
    blurY = new PImage(img.width, img.height, RGB);
    blur.loadPixels();
    blurX.loadPixels();
    blurY.loadPixels();
    //gradientB = new PImage(img.width, img.height, RGB);
    //gradientB.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float bx = getNeighboursBlurX(i, j, a);
        float by = getNeighboursBlurY(i, j, a);
        blur.pixels[p] = color(((bx+by)/2));
      }
    }
    blur.updatePixels();
    blurX.updatePixels();
    blurY.updatePixels();
    imagesWF.add(blur);
    c1.beginDraw();
    c1.image(blur, 0, 0);
    c1.endDraw();
  };
  
  void blurS(PImage img,int a) {
    blur = new PImage(img.width, img.height, RGB);
    blurX = new PImage(img.width, img.height, RGB);
    blurY = new PImage(img.width, img.height, RGB);
    blur.loadPixels();
    blurX.loadPixels();
    blurY.loadPixels();
    //gradientB = new PImage(img.width, img.height, RGB);
    //gradientB.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float bx = getNeighboursBlurX(i, j, a,img);
        float by = getNeighboursBlurY(i, j, a,img);
        blur.pixels[p] = color(((bx+by)/2));
      }
    }
    blur.updatePixels();
    blurX.updatePixels();
    blurY.updatePixels();
    imagesWF.add(blur);
    c1.beginDraw();
    c1.image(blur, 0, 0);
    c1.endDraw();
  };
  
  void gaussianS(){
    Gaussian = new PImage(img.width,img.height,ARGB);
    //Gaussian.loadPixels();
    GaussianS.set("blurSize", 9);
    GaussianS.set("sigma", 5.0f); 
    
    GaussianS.set("horizontalPass", 0);
    pass1.beginDraw();            
    pass1.shader(GaussianS);  
    pass1.image(img, 0, 0);
    pass1.endDraw();
    
    //// Applying the blur shader along the horizontal direction      
    GaussianS.set("horizontalPass", 1);
    pass2.beginDraw();            
    pass2.shader(GaussianS);  
    pass2.image(pass1, 0, 0);
    pass2.endDraw(); 
    c1.beginDraw();
    c1.image(pass2, 0, 0);
    c1.endDraw();
    //c1.updatePixels();
    Gaussian = c1.get();
    //Gaussian.updatePixels();
    imagesWF.add(Gaussian);
  };
  
  void gaussianS2(float a,int b){
    Gaussian = new PImage(img.width,img.height,ARGB);
    //Gaussian.loadPixels();
    println("gaussian 2");
    GaussianS.set("blurSize", 9);
    GaussianS.set("sigma", 5.0f); 
    
    GaussianS.set("horizontalPass", 0);
    pass1.beginDraw();            
    pass1.shader(GaussianS);  
    pass1.image(img, 0, 0);
    pass1.endDraw();
    
    //// Applying the blur shader along the horizontal direction      
    GaussianS.set("horizontalPass", 1);
    pass2.beginDraw();            
    pass2.shader(GaussianS);  
    pass2.image(pass1, 0, 0);
    pass2.endDraw(); 
    c1.beginDraw();
    c1.image(pass2, 0, 0);
    c1.endDraw();
    Gaussian = c1.get();
    
    imagesWF.add(Gaussian);
  };
  
  void gaussianS(float a,int b){
    println("gaussian");
    Gaussian = new PImage(img.width,img.height,ARGB);
    Gaussian.loadPixels();
    GaussianS.set("blurSize", b);
    GaussianS.set("sigma", a); 
    
    GaussianS.set("horizontalPass", 0);
    pass1.beginDraw();            
    pass1.shader(GaussianS);  
    pass1.image(img, 0, 0);
    pass1.endDraw();
    
    //// Applying the blur shader along the horizontal direction      
    GaussianS.set("horizontalPass", 1);
    pass2.beginDraw();            
    pass2.shader(GaussianS);  
    pass2.image(pass1, 0, 0);
    pass2.endDraw(); 
    c1.beginDraw();
    c1.image(pass2, 0, 0);
    c1.endDraw();
    Gaussian = c1.get();
    Gaussian.updatePixels();
    imagesWF.add(Gaussian);
  };
  
  void gaussian3(){
    Gaussian = new PImage(img.width,img.height,ARGB);
    Gaussian.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float v = getGaussian3(i, j);
        //println(v);
        Gaussian.pixels[p] = color(v);
      }
    }
    Gaussian.updatePixels();
    imagesWF.add(Gaussian);
    c1.beginDraw();
    c1.image(Gaussian, 0, 0);
    c1.endDraw();
  };
  
  float getGaussian3(int x,int y){
    float val = 0;
    float v = 0;
    int z = 1;
    img.loadPixels();
    
    int count = 0;
    
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    
    for (int i=x-z; i<=x+z; i++) {
      for (int j=y-z; j<=y+z; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          
          int x1 = 0 + i - x + 1;
          int y1 = 0 + j - y + 1;
          
          float col = brightness(img.pixels[p]);
          col = b;
          
          v += gaussian3[x1][y1] * col;
          //println(gaussian3[x1][y1]);
          }
          count ++;
        }
      }
    
    v/= 2;
    v/= count;
    
    return v;
  };
  
  void gaussian3(PImage img){
    Gaussian = new PImage(img.width,img.height,ARGB);
    Gaussian.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float v = getGaussian3(i, j,img);
        Gaussian.pixels[p] = color(v);
      }
    }
    Gaussian.updatePixels();
    imagesWF.add(Gaussian);
    c1.beginDraw();
    c1.image(Gaussian, 0, 0);
    c1.endDraw();
  };
  
  float getGaussian3(int x,int y, PImage img){
    float val = 0;
    float v = 0;
    int z = 1;
    img.loadPixels();
    
    int count = 0;
    
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    
    for (int i=x-z; i<=x+z; i++) {
      for (int j=y-z; j<=y+z; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          
          int x1 = 0 + i - x + 1;
          int y1 = 0 + j - y + 1;
          
          float col = brightness(img.pixels[p]);
          col = b;
          
          v += gaussian3[x1][y1] * col;
          }
          count ++;
        }
      }
    v/= 16;
    v/= count;
    return v;
  };
  
  void gaussian5(){
    Gaussian = new PImage(img.width,img.height,ARGB);
    Gaussian.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float v = getGaussian5(i, j);
        Gaussian.pixels[p] = color(v);
      }
    }
    Gaussian.updatePixels();
    imagesWF.add(Gaussian);
    c1.beginDraw();
    c1.image(Gaussian, 0, 0);
    c1.endDraw();
  };
  
  float getGaussian5(int x,int y){
    float val = 0;
    float v = 0;
    int z = 2;
    img.loadPixels();
    
    int count = 0;
    
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    
    for (int i=x-z; i<=x+z; i++) {
      for (int j=y-z; j<=y+z; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          
          int x1 = 0 + (i - x) + z;
          int y1 = 0 + j - y + z;
          //println(x1);
          //if(x1 == -1)x1 = 4;
          //if(y1 == -1)y1 = 4;
          float col = brightness(img.pixels[p]);
          col = b;
          
          v += gaussian5[x1][y1] * col;
          }
          count ++;
        }
      }
    v/= 273;
    v/= count;
    return v;
  };
  
  void gaussian5(PImage img){
    Gaussian = new PImage(img.width,img.height,ARGB);
    Gaussian.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float b = brightness(img.pixels[p]);
        float v = getGaussian5(i, j,img);
        Gaussian.pixels[p] = color(v);
      }
    }
    Gaussian.updatePixels();
    imagesWF.add(Gaussian);
    c1.beginDraw();
    c1.image(Gaussian, 0, 0);
    c1.endDraw();
  };
  
  float getGaussian5(int x,int y, PImage img){
    float val = 0;
    float v = 0;
    int z = 2;
    img.loadPixels();
    
    int count = 0;
    
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    
    for (int i=x-z; i<=x+z; i++) {
      for (int j=y-z; j<=y+z; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          
          int x1 = 0 + i - x + z;
          int y1 = 0 + j - y + z;
          
          float col = brightness(img.pixels[p]);
          col = b;
          
          v += gaussian5[x1][y1] * col;
          }
          count ++;
        }
      }
    v/= 273;
    v/= count;
    return v;
  };
  
  float getNeighboursBlur(int x, int y,int a){
    float mean = 0;
    int count = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          mean += brightness(img.pixels[p]);
          count++;
      }}
    }
    mean /= count;
    return mean;
  };
  
  float getNeighboursBlur(int x, int y,int a,PImage img){
    float mean = 0;
    int count = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          mean += brightness(img.pixels[p]);
          count++;
      }}
    }
    mean /= count;
    return mean;
  };

  float getNeighboursBlurX(int x, int y,int a){
    float mean = 0;
    int count = 0;
    int count2 = 0;
    for (int i=x-a; i<=x+a; i++) {
        int p = (i) + y * img.width;
        count2++;
        int n = (y-a+count);
        float k = (a-abs(n-y));
        k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        //println(k);
        //k = 1;
        int p1 = (i) + (n) * img.width;
        if (p<img.pixels.length&&p>0&&p1>0&&p1<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
           mean += (brightness(img.pixels[p])+brightness(img.pixels[p1])*k)/2;
           count++;
      }
    }
    int p = x + y * img.width;
    blurX.pixels[p] = color(mean);
    return mean/count;
  };
  
  float getNeighboursBlurX(int x, int y,int a,PImage img){
    float mean = 0;
    int count = 0;
    int count2 = 0;
    for (int i=x-a; i<=x+a; i++) {
        int p = (i) + y * img.width;
        count2++;
        int n = (y-a+count);
        float k = (a-abs(n-y));
        k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        //println(k);
        //k = 1;
        int p1 = (i) + (n) * img.width;
        if (p<img.pixels.length&&p>0&&p1>0&&p1<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
           mean += (brightness(img.pixels[p])+brightness(img.pixels[p1])*k)/(2);
           count++;
      }
    }
    int p = x + y * img.width;
    blurX.pixels[p] = color(mean);
    return mean/count;
  };
  
  float getNeighboursBlurY(int x, int y,int a){
    float mean = 0;
    int count = 0;
    int count2 = 0;
    //print("h");
      for (int j=y-a; j<=y+a; j++) {
        int p = x + (j) * img.width;
        int n = (x-a+count);
        float k = (a-abs(n-x));
        k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        //k = 1;
        int p1 = (n) + (j) * img.width;
        
        if (p<img.pixels.length&&p>0&&p1>0&&p1<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
           mean += (brightness(img.pixels[p])+ brightness(img.pixels[p1])*k)/2;
           count++;
      }
    }
    int p = x + y * img.width;
    blurX.pixels[p] = color(mean);
    return mean/count;
    //return sqrt(mean*mean);
  };
  
  float getNeighboursBlurY(int x, int y,int a,PImage img){
    float mean = 0;
    int count = 0;
    int count2 = 0;
    //print("h");
      for (int j=y-a; j<=y+a; j++) {
        int p = x + (j) * img.width;
        int n = (x-a+count);
        float k = (a-abs(n-x));
        k = 2.0 / (1.0 + exp(-2.0 * k)) - 1.0;
        //k = 1;
        int p1 = (n) + (j) * img.width;
        
        if (p<img.pixels.length&&p>0&&p1>0&&p1<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
           mean += (brightness(img.pixels[p])+brightness(img.pixels[p1])*k)/2;
           count++;
      }
    }
    int p = x + y * img.width;
    blurX.pixels[p] = color(mean);
    return mean/count;
    //return sqrt(mean*mean);
  };

  void getNeighboursAv(int x, int y) {
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
      }
    }
  };

  float[] getNeighboursMean(int x, int y, int a) {
    float mean = 0;
    int count = 0;
    int count2 = 0;
    float mx = 0;
    float my = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          mean += brightness(img.pixels[p]);
          count++;
          if (brightness(img.pixels[p])>10)count2++;
          
          int x1 = 0 + i - x + 1;
          int y1 = 0 + j - y + 1;
          if(x1>=0&&x1<3&&y1>=0&&y1<3){
            mx += meanX[x1][y1];
            my += meanY[x1][y1];
          }
        }
      }
    }
    mean /= count;
    mx /= count;
    my /= count;
    float []val = {mean,mx,my};
    return val;
  };
  
  float []getNeighboursMean(int x, int y, int a,PImage img) {
    float mean = 0;
    int count = 0;
    int count2 = 0;
    float mx = 0;
    float my = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          mean += brightness(img.pixels[p]);
          count++;
          int x1 = 0 + i - x + 1;
          int y1 = 0 + j - y + 1;
          //println(x1);
          
          if(x1>=0&&x1<3&&y1>=0&&y1<3){
            mx += meanX[x1][y1] * brightness(img.pixels[p]);
            my += meanY[x1][y1] * brightness(img.pixels[p]);
            //println(
            //count++;
          }
        }
      }
    }
    
    mean /= count;
    mx /= count;
    my /= count;
    //println(mx,my,count2);
    float []val = {mean,mx,my};
    return val;
  };

  float getNeighboursMean_(int x, int y, int a) {
    float mean = 0;
    int count = 0;
    int count2 = 0;
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    float k = 40;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          if (abs(b1-b)<k
            //if(abs(red(img.pixels[p1])-red(img.pixels[p]))<k
            //  ||abs(green(img.pixels[p1])-red(img.pixels[p]))>k
            //  ||abs(blue(img.pixels[p1])-red(img.pixels[p]))<k
            ) {
            //if(true){
            mean += brightness(img.pixels[p]);
            //mean += b;
            count2++;
          } else mean += 15;
          //else mean -=20;
          count++;
        }
      }
    }
    //if (count2<(a*2*a*2)/(a*4)) mean = 1;
    if (mean<k*(a*2*a*2)) mean = 0;
    //if(count2>8) mean = 0;
    return mean/count;
  };

  float getNeighboursVar(int x, int y, int a) {
    float variance = 0;
    int count = 0;
    int count2 = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          
          float a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
          float a2 = (red(img2.pixels[p]) + green(img2.pixels[p]) + blue(img2.pixels[p]) + brightness(img2.pixels[p]))/4;
          variance += (a2-a1)*(a2-a1);
          //println(a2);
          //variance += (a2-a1);

          count++;
        }
      }
    }
    //variance/=count;
    //println(sqrt(variance*variance));
    
    return sqrt((variance)/count);
    //return sqrt((variance*variance)/count);
  };
  
  float getNeighboursVar3(int x, int y, int a) {
    float variance = 0;
    int count = 0;
    int count2 = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float a1 = 0;
          if(threshold==null){
            a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
            a1 = brightness(mean.pixels[p]);
          }else a1 = (red(threshold.pixels[p]) + green(threshold.pixels[p]) + blue(threshold.pixels[p]) + brightness(threshold.pixels[p]))/4;
          float a2 = (red(img2.pixels[p]) + green(img2.pixels[p]) + blue(img2.pixels[p]) + brightness(img2.pixels[p]))/4;
          //variance += brightness(threshold.pixels[p]) - brightness(img.pixels[p]);
          variance += (a2-a1)*(a2-a1);
          //variance += (a2-a1);

          count++;
        }
      }
    }
    //variance/=count;
    return sqrt((variance)/count);
    //return (random(255));
  };

  float getNeighboursVar(int x, int y, int a,PImage mean) {
    float variance = 0;
    int count = 0;
    int count2 = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float a1 = 0;
            a1 = (red(mean.pixels[p]) + green(mean.pixels[p]) + blue(mean.pixels[p]) + brightness(mean.pixels[p]))/4;
            a1 = brightness(mean.pixels[p]);
          float a2 = (red(img.pixels[p]) + green(img.pixels[p]) + blue(img.pixels[p]) + brightness(img.pixels[p]))/4;
          //variance += brightness(threshold.pixels[p]) - brightness(img.pixels[p]);
          variance += a2-a1;

          count++;
        }
      }
    }
    return sqrt((variance*variance)/count);
  };
  
  float []getNeighboursVar2(int x, int y, int a) {
    float variance = 0;
    float varianceR = 0;
    float varianceG = 0;
    float varianceB = 0;
    int count = 0;
    int count2 = 0;
    float a1r = 0,a1g = 0,a1b = 0,a1br = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          
          
          float a2r = red(img2.pixels[p]);
          float a2g = green(img2.pixels[p]);
          float a2b = blue(img2.pixels[p]);
          float a2br = red(img2.pixels[p]);
          
          varianceR += a1r-a2r;
          varianceG += a1g-a2g;
          varianceB += a1b-a2b;
          
          variance += a1br-a2br;

          count++;
        }
      }
    }
    variance /= count;
    varianceR /= count;
    varianceG /= count;
    varianceB /= count;
    
    //float []val = {sqrt(variance*variance),varianceR,varianceG,varianceB};
    float []val = {abs(variance),varianceR,varianceG,varianceB};
    return val;
  };

  void getNeighbours2Min(int x, int y, int a, int b) {
    for (int i=x-a; i<=x+b; i++) {
      for (int j=y-a; j<=y+b; j++) {
      }
    }
  };

  void getNeighbours2Min(int x, int y, int a) {
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
      }
    }
  };
  
  void sobelGS(float a,int b,float c){
    
    if(sobel==null)sobel = new PImage(img.width, img.height, RGB);
    
    if(update){
      Gaussian = new PImage(img.width,img.height,ARGB);
      //Gaussian.loadPixels();
      GaussianS.set("blurSize", b);
      GaussianS.set("sigma", a); 
      
      GaussianS.set("horizontalPass", 0);
      pass1.beginDraw();            
      pass1.shader(GaussianS);  
      pass1.image(img, 0, 0);
      pass1.endDraw();
      
      //// Applying the blur shader along the horizontal direction      
      GaussianS.set("horizontalPass", 1);
      pass2.beginDraw();            
      pass2.shader(GaussianS);  
      pass2.image(pass1, 0, 0);
      pass2.endDraw(); 
      c1.beginDraw();
      c1.image(pass2, 0, 0);
      c1.endDraw();
      
      c1.beginDraw();
      Sobel.set("mult",c);
      //c1.shader(GaussianS);
      c1.shader(Sobel);
      c1.image(pass2, 0, 0);
      sobel.pixels = c1.pixels;
      c1.endDraw();
      update=false;
      //println(red(img.pixels[1000]),red(sobel.pixels[1000]));
      sobel = c1.get();
      imagesWF.add(sobel);
    }
    
    
  };
  
  void sobelS2(float mult){
    
    if(sobel==null)sobel = new PImage(img.width, img.height, RGB);
    
    if(update){
      
      c1.beginDraw();
      println("mult",mult);
      SobelG.set("mult",mult);
      c1.shader(SobelG);
      c1.image(img, 0, 0);
      c1.endDraw();
      update=false;
      sobel = c1.get();
      imagesWF.add(sobel);
      
    }
  };
  
  void sobelS3(float mult){
    
    if(sobel==null)sobel = new PImage(img.width, img.height, RGB);
    
    if(update){
      
      c1.beginDraw();
      println("mult",mult);
      println("Shader sobelG1");
      SobelG1.set("mult",mult);
      c1.shader(SobelG1);
      c1.image(img, 0, 0);
      c1.endDraw();
      update=false;
      sobel = c1.get();
      imagesWF.add(sobel);
      
    }
  };
  
  void sobelS(int a){
    
    if(sobel==null)sobel = new PImage(img.width, img.height, RGB);
    ////sobel.loadPixels();
    //sobelx = new PImage(img.width, img.height, RGB);
    //sobelx.loadPixels();
    //sobely = new PImage(img.width, img.height, RGB);
    //sobely.loadPixels();
    
    if(update){
      
      c1.beginDraw();
      //println(s_mult);
      //Sobel.set("mult",mult);
      c1.shader(Sobel);
      c1.image(img, 0, 0);
      //sobel.pixels = c1.pixels;
      c1.endDraw();
      update=false;
      imagesWF.add(sobel);
      //println(red(img.pixels[1000]),red(sobel.pixels[1000]));
      //sobel = c1.get();
    }
    
    ////sobel.updatePixels();
    //sobelx.updatePixels();
    //sobely.updatePixels();
  };
  
  void sobelS(float mult){
    sobel = new PImage(img.width, img.height, RGB);
    
    if(update){
      
      c1.beginDraw();
      Sobel.set("mult",mult);
      c1.shader(Sobel);
      c1.image(img, 0, 0);
      sobel.pixels = c1.pixels;
      c1.endDraw();
      update=false;
    }
    sobel = c1.get();
    imagesWF.add(sobel);
    
  };
  
  void sobelS(float mult,int a){
    sobel = new PImage(img.width, img.height, RGB);
    
    if(update){
      
      c1.beginDraw();
      Sobel1.set("mult",mult);
      Sobel1.set("type",(float)a);
      //println((float)a);
      c1.shader(Sobel1);
      c1.image(img, 0, 0);
      sobel.pixels = c1.pixels;
      c1.endDraw();
      update=false;
      //println(red(img.pixels[1000]),red(sobel.pixels[1000]));
      
    }
    sobel = c1.get();
    imagesWF.add(sobel);
    
  };
  
  void sobelS(float mult,int a,float max){
    sobel = new PImage(img.width, img.height, RGB);
    
    if(update){
      
      c1.beginDraw();
      Sobel2.set("mult",mult);
      Sobel2.set("type",(float)a);
      Sobel2.set("max",max);
      //println((float)a);
      c1.shader(Sobel1);
      c1.image(img, 0, 0);
      sobel.pixels = c1.pixels;
      c1.endDraw();
      update=false;
      //println(red(img.pixels[1000]),red(sobel.pixels[1000]));
      
    }
    sobel = c1.get();
    imagesWF.add(sobel);
    
  };
  
  void sobelS(PImage img, float mult,int a){
    Sobel = loadShader("shaders\\sobel.glsl");
    sobel = new PImage(img.width, img.height, RGB);
    sobel.loadPixels();
    sobelx = new PImage(img.width, img.height, RGB);
    sobelx.loadPixels();
    sobely = new PImage(img.width, img.height, RGB);
    sobely.loadPixels();
    
    if(update){
      c1.beginDraw();
      c1.shader(Sobel);
      c1.image(img, 0, 0);
      update=false;
      c1.endDraw();
      sobel = c1.get(0,0,c1.width,c1.height);
    }
    
    sobel.updatePixels();
    sobelx.updatePixels();
    sobely.updatePixels();
    imagesWF.add(sobel);
  };
  
  void sobel(float mult) {
    sobel = new PImage(img.width, img.height, RGB);
    sobel.loadPixels();
    sobelx = new PImage(img.width, img.height, RGB);
    sobelx.loadPixels();
    sobely = new PImage(img.width, img.height, RGB);
    sobely.loadPixels();
    sobelG = new PImage(img.width, img.height, RGB);
    sobelG.loadPixels();
    //gx = new float[img.pixels.length];
    //gy = new float[img.pixels.length];
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        
        int p = i + j * img.width;
        float[] val = getSobel(i, j);
        
        float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
        float r = red(img.pixels[p]);
        float g = green(img.pixels[p]);
        float b1 = blue(img.pixels[p]);
        float b2 = brightness(img.pixels[p]);
        //println(val.length);
        float v = val[0];
        float k = v * mult;
        sobel.pixels[p] = color(255-(k));
        //sobel.pixels[p] = color(255-(k-b2));
        float v1 = map(val[1],-255,255,0,500);
        float v2 = map(val[2],-255,255,0,500);
        sobelx.pixels[p] = color(v1,0,0);
        sobely.pixels[p] = color(v2,0,0);
        sobelG.pixels[p] = color(val[3]);
        //gradient[i][j] = val[3];
        gradient[i][j] = map(val[3],-PI,PI,0,360);
        //gx[p] = val[1];
        //gy[p] = val[2];
      }
    }
    //println("h");
    sobel.updatePixels();
    sobelx.updatePixels();
    sobely.updatePixels();
    sobelG.updatePixels();
    //sobelG.updatePixels();
    imagesWF.add(sobel);
    c1.beginDraw();
    c1.image(sobel, 0, 0);
    c1.endDraw();
    
  };
  
  void sobel(float mult,int a) {
    sobel = new PImage(img.width, img.height, RGB);
    sobel.loadPixels();
    sobelx = new PImage(img.width, img.height, RGB);
    sobelx.loadPixels();
    sobely = new PImage(img.width, img.height, RGB);
    sobely.loadPixels();
    sobelG = new PImage(img.width, img.height, RGB);
    sobelG.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        
        int p = i + j * img.width;
        float[] val = getSobel(i, j);
        
        float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
        float r = red(img.pixels[p]);
        float g = green(img.pixels[p]);
        float b1 = blue(img.pixels[p]);
        float b2 = brightness(img.pixels[p]);
        float v = val[0];
        float k = v * mult;
        float t = 2.0;
        if(a==0)sobel.pixels[p] = color(255-(k-(b2)));
        if(a==1)sobel.pixels[p] = color(255-k);
        if(a==2)sobel.pixels[p] = color(b2-k);
        if(a==3)sobel.pixels[p] = color(k);
        if(a==4)sobel.pixels[p] = color(r - k,g - k,b1 - k,b2);
        if(a==5)sobel.pixels[p] = color(r - (k-(r)),g - (k-(g)),b1 - (k-(b1)),b2 -(k-(b2)));
        if(a==6)sobel.pixels[p] = color(255 - (k-(r)),255 - (k-(g)),255 - (k-(b1)),255 -(k-(b2)));
        if(a==7){
          float rng = random(200);
          float rng1 = random(100);
          if(255-(k-(b2))<100)sobel.pixels[p] = color(0);
          else sobel.pixels[p] = color(255-(k-b2),0);
        }
        if(a==8){
          float rng = random(200);
          float rng1 = random(100);
          if(255-(k-(b2))<100)sobel.pixels[p] = color(0,rng);
          else sobel.pixels[p] = color(255-(k-b2),0);
        }
        if(a==9){
          float rng = random(200);
          float rng1 = random(100);
          if(255-(k-(b2))<100)sobel.pixels[p] = color(r-rng1,g-rng1,b1-rng1,rng);
          else sobel.pixels[p] = color(255-(k-b2),0);
        }
      }
    }
    sobel.updatePixels();
    sobelx.updatePixels();
    sobely.updatePixels();
    //sobelG.updatePixels();
    imagesWF.add(sobel);
    c1.beginDraw();
    c1.image(sobel, 0, 0);
    c1.endDraw();
    
  };
  
  void sobel(float mult,int a,float c) {
    sobel = new PImage(img.width, img.height, RGB);
    sobel.loadPixels();
    sobelx = new PImage(img.width, img.height, RGB);
    sobelx.loadPixels();
    sobely = new PImage(img.width, img.height, RGB);
    sobely.loadPixels();
    sobelG = new PImage(img.width, img.height, RGB);
    sobelG.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        
        int p = i + j * img.width;
        float[] val = getSobel(i, j);
        
        float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
        float r = red(img.pixels[p]);
        float g = green(img.pixels[p]);
        float b1 = blue(img.pixels[p]);
        float b2 = brightness(img.pixels[p]);
        //println(val.length);
        float v = val[0];
        float k = v * mult;
        float t = 2.0;
        if(a==0)sobel.pixels[p] = color(255-(k-(b2)));
        //sobel.pixels[p] = color(0);
        if(a==1)sobel.pixels[p] = color(255-k);
        if(a==2)sobel.pixels[p] = color(b2-k);
        if(a==3)sobel.pixels[p] = color(k);
        if(a==4)sobel.pixels[p] = color(r - k,g - k,b1 - k,b2);
        //if(a==5)sobel.pixels[p] = color(r - (k-(r)),g - (k-(g)),b1 - (k-(b1)),b2 -(k-(b2)));
        if(a==5)sobel.pixels[p] = color(r - (k),g - (k),b1 - (k),b2 -(k));
        if(a==6)sobel.pixels[p] = color(255 - (k-(r)),255 - (k-(g)),255 - (k-(b1)),b2);
        if(a==7){
          float rng = random(200);
          float rng1 = random(100);
          if(255-(k-(b2))<c)sobel.pixels[p] = color(0);
          else sobel.pixels[p] = color(255-(k-b2),0);
        }
        if(a==8){
          float rng = random(200);
          float rng1 = random(100);
          if(255-(k-(b2))<c)sobel.pixels[p] = color(0,rng);
          else sobel.pixels[p] = color(255-(k-b2),0);
        }
        if(a==9){
          //println(9);
          float rng = random(200);
          float rng1 = random(100);
          if(255-(k-(b2))<c)sobel.pixels[p] = color(r-rng1,g-rng1,b1-rng1,rng);
          else sobel.pixels[p] = color(255-(k-b2),0);
        }
      }
    }
    sobel.updatePixels();
    sobelx.updatePixels();
    sobely.updatePixels();
    //sobelG.updatePixels();
    imagesWF.add(sobel);
    c1.beginDraw();
    c1.image(sobel, 0, 0);
    c1.endDraw();
  };
  
  void sobelSP(float mult,float thresh) {
    sobel = new PImage(img.width, img.height, RGB);
    sobel.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        
        int p = i + j * img.width;
        float[] val = getSobel(i, j);
        
        float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
        float r = red(img.pixels[p]);
        float g = green(img.pixels[p]);
        float b1 = blue(img.pixels[p]);
        float b2 = brightness(img.pixels[p]);
        float v = val[0];
        float k = v * mult;
        float rng = random(200);
          
        if(255-(k-(b2))<thresh){
          sobel.pixels[p] = img.pixels[p];
        }
        else sobel.pixels[p] = color(255);
        sobel.pixels[p] = color(255-(k-(b2)));
        //sobel.pixels[p] = color(255-k);
        //if(red(sobel.pixels[p])<60)sobel.pixels[p] = color(0);
      }
    }
    sobel.updatePixels();
    //cell = new cell();
    cell.Mode = 3;
    cell.pixelThresh = 2000;
    cell.pixelThresh1 = 80;
    cell.cutoff = 15;
    //cell.maxT = 100;
    //cell.minT = 50;
    //cell.pixelThresh1 = 20;
    imagesWF.add(img);
    cell.imgUpdate(sobel);
    imagesWF.add(sobel);
    cell.getContour();
    imagesWF.add(cell.canny);
    imagesWF.add(cell.backup);
    //imagesWF.add(cell.img);
  };
  
  void sobelSP(PImage img,float mult,float thresh) {
    sobel = new PImage(img.width, img.height, RGB);
    sobel.loadPixels();
    sobelx = new PImage(img.width, img.height, RGB);
    sobelx.loadPixels();
    sobely = new PImage(img.width, img.height, RGB);
    sobely.loadPixels();
    sobelG = new PImage(img.width, img.height, RGB);
    sobelG.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        
        int p = i + j * img.width;
        float[] val = getSobel(i, j);
        
        float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
        float r = red(img.pixels[p]);
        float g = green(img.pixels[p]);
        float b1 = blue(img.pixels[p]);
        float b2 = brightness(img.pixels[p]);
        float v = val[0];
        float k = v * mult;
        float rng = random(200);
          
        if(255-(k-(b2))<thresh)sobel.pixels[p] = img.pixels[p];
        else sobel.pixels[p] = color(255);
      }
    }
    sobel.updatePixels();
    sobelx.updatePixels();
    sobely.updatePixels();
    //sobelG.updatePixels();
    imagesWF.add(sobel);
  };

  float []getSobel(int x, int y) {
    float val = 0;
    float vy = 0;
    float vx = 0;
    float vd = 0;
    float hd = 0;
    float eh = 0;
    float ev =0;
    img.loadPixels();
    int count = 0;
    int count2 = 0;
    int p1 = x + y * img.width;
    float b1 = (red(img.pixels[p1])+green(img.pixels[p1])+blue(img.pixels[p1])+brightness(img.pixels[p1]))/4;
    float k = 40;
    int z = 1;
    for (int i=x-z; i<=x+z; i++) {
      for (int j=y-z; j<=y+z; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          //if (abs(red(img.pixels[p1])-red(img.pixels[p]))<k
          //  ||abs(green(img.pixels[p1])-green(img.pixels[p]))<k
          //  ||abs(blue(img.pixels[p1])-blue(img.pixels[p]))<k
          //  ||brightness(img.pixels[p1])-brightness(img.pixels[p])<k
          //  ) {
            count2 ++;
            
            int x1 = 0 + i - x + 1;
            int y1 = 0 + j - y + 1;
            
            float col = brightness(img.pixels[p]);
            col = b;
            float v = SobelH[x1][y1] * col;
            float h = SobelV[x1][y1] * col;
            float vd_ = SobelH_[x1][y1] * col;
            float hd_ = SobelV_[x1][y1] * col;
            float eh_ = SobelV[x1][y1] * col;
            float ev_ = SobelH[x1][y1] * col;
            
            vx += v;
            vy += h;
            vd += vd_;
            hd += hd_;
            ev += ev_;
            eh += eh_;
          count ++;
          //}
        }
      }
    }
    //println(vx,count);
    vx/= count;
    vy/= count;
    
    //if(vx<0)vx = 0;
    //if(vy<0)vy = 0;
    //println(vx,vy);
    val = sqrt(vx*vx + vy*vy);
    //val = sqrt(vx*vx + vy*vy + vd*vd + hd*hd + ev*ev + eh*eh);
    //val = sqrt(vx*vx + vy*vy + vd*vd + hd*hd);
    //println(atan2(vy,vx));
    float [] sob = {val, vx, vy,atan2(vy,vx)};
    //float [] sob = {val, vx, vy, count2,atan2((vy + hd + eh)/3,(vx + vd + ev)/3)};
    //float [] sob = {val, vx, vy, count2,atan2((vy + hd)/2,(vx + vd)/2)};
    //gradient[x][y] = atan2(vy,vx);
    return sob;
  };
  
  void sobel(PImage img,float mult,int a) {
    println("h");
    sobel = new PImage(img.width, img.height, RGB);
    sobel.loadPixels();
    sobelx = new PImage(img.width, img.height, RGB);
    sobelx.loadPixels();
    sobely = new PImage(img.width, img.height, RGB);
    sobely.loadPixels();
    sobelG = new PImage(img.width, img.height, RGB);
    sobelG.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        float[] val = getSobel(i, j,img);
        float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
        float r = red(img.pixels[p]);
        float g = green(img.pixels[p]);
        float b1 = blue(img.pixels[p]);
        float b2 = brightness(img.pixels[p]);
        //println(val.length);
        float v = val[0];
        //println(val[0]);
        float k = v*mult;
        //k = random(255);
        
        if(a==0)sobel.pixels[p] = color(255-(k-(b2)));
        //sobel.pixels[p] = color(0);
        if(a==1)sobel.pixels[p] = color(255-k);
        if(a==2)sobel.pixels[p] = color(b2-k);
        if(a==3)sobel.pixels[p] = color(k);
        //sobel.pixels[p] = color(((b2)-k));
        //sobel.pixels[p] = color(0);
        //sobel.pixels[p] = color(k);
        //sobel.pixels[p] = color(k-r,k-g,k-b1);
        //sobel.pixels[p] = color((k-r),(k-g),(k-b1));
        //sobel.pixels[p] = color(r-k,g-k,b1-k);
        //float s = brightness(sobel.pixels[p]);
        //if(s>250)sobel.pixels[p] = color(0);
        //println(sobel.pixels[p]);
        //if(k<200)sobel.pixels[p] = color(img.pixels[p]);
        //sobel.pixels[p] = color(val[0]);
        //else sobel.pixels[p] = color(255);
        sobelx.pixels[p] = color(val[1]);
        sobely.pixels[p] = color(val[2]);
      }
    }
    sobel.updatePixels();
    sobelx.updatePixels();
    sobely.updatePixels();
    sobelG.updatePixels();
    imagesWF.add(sobel);
    c1.beginDraw();
    c1.image(sobel, 0, 0);
    c1.endDraw();
  };
  
  float []getSobel(int x, int y, PImage img) {
    float val = 0;
    float vy = 0;
    float vx = 0;
    img.loadPixels();
    int count = 0;
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {

        int p = i + j * img.width;
        if (p>0&&p<img.pixels.length) {
          int x1 = 0 + i - x + 1;
          int y1 = 0 + j - y + 1;

          float col = brightness(img.pixels[p]);
          //println(col);
          //col = (red(img.pixels[p])+blue(img.pixels[p])+green(img.pixels[p])+brightness(img.pixels[p]))/4;
          float v = SobelH[x1][y1] * col;
          float h = SobelV[x1][y1] * col;

          //println(col);
          vx += v;
          vy += h;

          count ++;
        }
      }
    }

    vx/= count;
    vy/= count;

    val = sqrt(vx*vx + vy*vy);
    //val = random(255);
    //println(count);
    float [] sob = {val, vx, vy, count};
    return sob;
  };
  
  void sobel2(float mult,int a) {
    sobel2 = new PImage(img.width, img.height, RGB);
    sobel2.loadPixels();
    sobel2x = new PImage(img.width, img.height, RGB);
    sobel2x.loadPixels();
    sobel2y = new PImage(img.width, img.height, RGB);
    sobel2y.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float []mean = getSobel2(i, j, a);
        float b = brightness(img.pixels[p]);
        //println(mean[0]);
        sobel2.pixels[p] = color(255-(mean[0]*mult-b));
        sobel2x.pixels[p] = color(mean[1]);
        sobel2y.pixels[p] = color(mean[2]);
        //sobel2.pixels[p] = color(mean);
        //sobelG.pixels[p] = color((gradient[i][j]*100));
        //println(gradient[i][j],green(sobelG.pixels[p]));
      }
    }
    sobel2.updatePixels();
    c1.beginDraw();
    c1.image(sobel, 0, 0);
    c1.endDraw();
    imagesWF.add(sobel2);
  };
  
  float []getSobel2(int x, int y,int a){
    float mean = 0;
    float meany = 0;
    float meana = 0;
    float meanb = 0;
    int count = 0;
    float a1 = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          float c = (i-x);
          float d = (j-y);
          float e = x - i;
          float f = y - j;
          //if(c==0)c=1;
          //meany += brightness(img.pixels[p])*(c+d);
          //mean += brightness(img.pixels[p])*(e+f);
          //meana += brightness(img.pixels[p])*(c+f);
          //meanb += brightness(img.pixels[p])*(e+d);
          meany += b*(c+d);
          mean += b*(e+f);
          meana += b*(c+f);
          meanb += b*(e+d);
          a1 += (c + d);
          //println(c+d);
          //mean += (brightness(img.pixels[p])*(c+d) + brightness(img.pixels[p])*(e+f))/2;
          //mean += brightness(img.pixels[p])*(c+d);
          count++;
      }}
    }
    //println(mean,brightness(img.pixels[x+y*img.width]));
    //println(mean,brightness(img.pixels[x+y*img.width]));
    //println(mean,brightness(img.pixels[x+y*img.width]));
    //println(mean,brightness(img.pixels[x+y*img.width]));
    //println(a1);
    mean /= count;
    meana /= count;
    meanb /= count;
    meany /= count;
    float k = 00;
    //return sqrt(mean*mean+meany*meany);
    //gradient[x][y] = atan2((meany+meana)/2,(mean+meanb)/2);
    float val = sqrt(mean*mean+meany*meany+(meana*meana+meanb*meanb))+random(-k);
    //float val = sqrt((mean*mean+meany*meany)/(meana*meana+meanb*meanb));
    //float val = sqrt((mean*mean+meany*meany)/(meana*meana+meanb*meanb))-sqrt((meana*meana+meanb*meanb)/(mean*mean+meany*meany));;
    //float val = sqrt((mean*mean+meany*meany)*(meana*meana+meanb*meanb))*sqrt((x^x&y^y));
    //float val = sqrt((mean*mean+meany*meany)*(meana*meana+meanb*meanb))/sqrt(((x^x)-(width/2))&((y^y)-(height/2)));
    //float val = sqrt(mean*mean+meany*meany);
    //float val = sqrt(meana*meana+meanb*meanb);
    //println(val);
    float valx = (mean);
    float valy = (meany);
    float [] sob = {val,valx,valy};
    return sob;
    //return sqrt((meana*meana+meanb*meanb));
    //return sqrt((meany/count)*meany/count+meanb/count*meanb/count);
  };
  
  void sobel2(int a, float mult2,int c) {
    sobel2 = new PImage(img.width, img.height, ARGB);
    sobel2.loadPixels();
    sobel2x = new PImage(img.width, img.height, RGB);
    sobel2x.loadPixels();
    sobel2y = new PImage(img.width, img.height, RGB);
    sobel2y.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float []mean = getSobel2(i, j, a);
        float b = brightness(img.pixels[p]);
        float k = mean[0]*(mult2);
        //if(k>0)k=255;
        //println(mean[1]);
        if(c==0)sobel2.pixels[p] = color(255-(k-b));
        if(c==1)sobel2.pixels[p] = color(255-(k));
        if(c==2)sobel2.pixels[p] = color(255-(k)-b);
        if(c==3)sobel2.pixels[p] = color(b-k);
        if(c==4)sobel2.pixels[p] = color(k);
        if(c==7){
          
          if(255-(k)<10)sobel2.pixels[p] = color(255-(k),255);
          else sobel2.pixels[p] = color(255-(k),0);
        }
        //
        //sobel2x.pixels[p] = color(255-(mean[1]*(mult2)-b));
        //sobel2y.pixels[p] = color(255-(mean[2]*(mult2)-b));
        sobel2x.pixels[p] = color((mean[1]));
        sobel2y.pixels[p] = color((mean[2]));
        
        
        //sobel2.pixels[p] = color(mean);
        //sobelG.pixels[p] = color((gradient[i][j]*100));
        //println(gradient[i][j],green(sobelG.pixels[p]));
      }
    }
    sobel2.updatePixels();
    imagesWF.add(sobel2);
  };
  
  void sobel2(PImage img,float mult,int a) {
    sobel2 = new PImage(img.width, img.height, RGB);
    sobel2.loadPixels();
    sobel2x = new PImage(img.width, img.height, RGB);
    sobel2x.loadPixels();
    sobel2y = new PImage(img.width, img.height, RGB);
    sobel2y.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {
        int p = i + j * img.width;
        float []mean = getSobel2(img,i, j, a);
        float b = brightness(img.pixels[p]);
        float k = mean[0]*mult;
        sobel2.pixels[p] = color(255-(k-b));
        
        sobel2x.pixels[p] = color(mean[1]);
        sobel2y.pixels[p] = color(mean[2]);
        //sobel2.pixels[p] = color(mean);
        //sobelG.pixels[p] = color((gradient[i][j]*100));
        //println(gradient[i][j],green(sobelG.pixels[p]));
      }
    }
    sobel2.updatePixels();
    imagesWF.add(sobel2);
  };
  
  float []getSobel2(PImage img,int x, int y,int a){
    float mean = 0;
    float meany = 0;
    float meana = 0;
    float meanb = 0;
    int count = 0;
    for (int i=x-a; i<=x+a; i++) {
      for (int j=y-a; j<=y+a; j++) {
        int p = i + j * img.width;
        if (p<img.pixels.length&&p>0) {
          float b = (red(img.pixels[p])+green(img.pixels[p])+blue(img.pixels[p])+brightness(img.pixels[p]))/4;
          //b = brightness(img.pixels[p]);
          //println(b);
          float c = (i-x);
          float d = (j-y);
          float e = x - i;
          float f = y - j;
          //if(c==0)c=1;
          //meany += brightness(img.pixels[p])*(c+d);
          //mean += brightness(img.pixels[p])*(e+f);
          //meana += brightness(img.pixels[p])*(c+f);
          //meanb += brightness(img.pixels[p])*(e+d);
          meany += b*(c+d);
          mean += b*(e+f);
          meana += b*(c+f);
          meanb += b*(e+d);
          //mean += (brightness(img.pixels[p])*(c+d) + brightness(img.pixels[p])*(e+f))/2;
          //mean += brightness(img.pixels[p])*(c+d);
          count++;
      }}
    }
    
    mean /= count;
    meana /= count;
    meany /= count;
    meanb /= count;
    float k = 90;
    //return sqrt(mean*mean+meany*meany);
    //gradient[x][y] = atan2((meany+meana)/2,(mean+meanb)/2);
    float val = sqrt(mean*mean+meany*meany+(meana*meana+meanb*meanb))+random(-k);;
    //float val = sqrt((mean*mean+meany*meany)/(meana*meana+meanb*meanb));
    //float val = sqrt((mean*mean+meany*meany)/(meana*meana+meanb*meanb))-sqrt((meana*meana+meanb*meanb)/(mean*mean+meany*meany));;
    //float val = sqrt((mean*mean+meany*meany)*(meana*meana+meanb*meanb))*sqrt((x^x&y^y));
    //float val = sqrt((mean*mean+meany*meany)*(meana*meana+meanb*meanb))/sqrt(((x^x)-(width/2))&((y^y)-(height/2)));
    //float val = sqrt(mean*mean+meany*meany);
    //float val = sqrt(meana*meana+meanb*meanb);
    //println(val);
    float valx = (mean);
    float valy = (meany);
    float [] sob = {val,valx,valy};
    return sob;
    //return sqrt(((meana/count)*meana/count+meanb/count*meanb/count));
    //return sqrt((meany/count)*meany/count+meanb/count*meanb/count);
  };
 
  
  void sobelMax(float t){
    sobelMax = new PImage(img.width, img.height, RGB);
    sobelMax.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        
        boolean max = getNeighboursMax(i,j,t);
        if(max)sobelMax.pixels[p] = color(255);
        else sobelMax.pixels[p] = sobel.pixels[p];
      }}
      sobelMax.updatePixels();
      imagesWF.add(sobelMax);
  };
  
  
  boolean getNeighboursMax(int x, int y,float t) {
    
    float []max = new float[7];
    max[0] = 255;
    
    boolean k = false;
    int p = x + y * img.width;
    float c = brightness(sobel.pixels[p]);
    float g 
    //= gradient[x][y];
    //= red(sobelG.pixels[p]);
    = atan2(red(sobely.pixels[p]),red(sobelx.pixels[p]));
    int count=0;
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
        
        int p1 = i+j*sobel.width;
        
        if(p1>0&&p1<sobel.pixels.length){
          
          float c1 = brightness(sobel.pixels[p1]);
          float g1 = atan2(y-j,x-i);
          
          float g2 = brightness(sobelG.pixels[p1]);
          //= atan2((sobely.pixels[p1]),(sobelx.pixels[p1]));
          float d1 = abs(g-g1);
          float d2 = abs((g-PI)-g1);
          float d3 = abs(g-g2);
          float d4 = abs((g-PI)-g2);
          float t1 = radians(45);
          float t2 = radians(90);
          float t3 = radians(180);
          float t4 = radians(270);
          //if(max[0]>c){
          //println(g,g1);
          if(((d1<=t1||d2<=t1)&&(c1<=c)&&c1<=max[0])||((d1>=t1||d2>=t1)&&(c1>=c)&&c1>=max[0])){
            //println(g,g1,d1,t1,t2);
          //if((d1<t1||d2<t1)){
              max[0] = c1;
              max[3] = p1;
              k = true;
              count++;
          }}}
    }
    int p1 = (int)max[3];
    boolean k2 = false;
    //float c = brightness(sobel.pixels[p]);
    float c2 = brightness(sobel.pixels[p1]);
    //float t = 30;
    float t2 = radians(45);
    float t3 = radians(10);
    float d1 = abs(max[0]-(255-(c)));
    float d2 = abs(atan2(sobely.pixels[p] - sobely.pixels[p1],sobelx.pixels[p] - sobelx.pixels[p1]));
    //println(d2);
    float d3 = abs(max[0]-c);
    if(max[0]<255&&c>=max[0])k = false;
    return k;
  };
  
  void sobelMax2(float t){
    sobelMax = new PImage(img.width, img.height, RGB);
    sobelMax.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        
        if(brightness(sobel.pixels[p])<255)getNeighboursMax2(i,j,t);
        else sobelMax.pixels[p] = color(255);
      }}
      sobelMax.updatePixels();
      imagesWF.add(sobelMax);
  };
  
  void getNeighboursMax2(int x, int y,float t) {
    
    boolean k = false;
    int p = x + y * img.width;
    float c = brightness(sobel.pixels[p]);
    float g 
    = gradient[x][y];
    //= red(sobelG.pixels[p]);
    //= atan2(red(sobely.pixels[p]),red(sobelx.pixels[p]));
        
        float q = 255;
        float r = 255;
        int p1 = 0;
        
       //angle 0
       if ((0 <= g && g < (22.5))){
            if((x+1)+(y)*img.width<img.pixels.length&&(x+1)+(y)*img.width>=0)q = brightness(sobel.pixels[(x+1)+(y)*img.width]);
            if((x-1)+(y)*img.width<img.pixels.length&&(x-1)+(y)*img.width>=0)r = brightness(sobel.pixels[(x-1)+(y)*img.width]);
        //angle 45
        }else if ((22.5) <= g && g < (67.5)){
            if((x+1)+ (y+1)*img.width<img.pixels.length&&(x+1)+ (y+1)*img.width>=0)q = brightness(sobel.pixels[(x+1)+ (y+1)*img.width]);
            if((x-1)+ (y-1)*img.width<img.pixels.length&&(x-1)+ (y-1)*img.width>=0)r = brightness(sobel.pixels[(x-1)+ (y-1)*img.width]);
        //angle 90
        }else if ((67.5) <= g && g< (112.5)){
            if((x)+ (y+1)*img.width<img.pixels.length&&(x)+ (y+1)*img.width>=0)q = brightness(sobel.pixels[(x)+ (y+1)*img.width]);
            if((x)+ (y-1)*img.width<img.pixels.length&&(x)+ (y-1)*img.width>=0)r = brightness(sobel.pixels[(x)+ (y-1)*img.width]);
        //angle 135
        }else if ((112.5) <= g && g < (157.5)){
            if((x-1)+(y+1)*img.width<img.pixels.length&&(x-1)+(y+1)*img.width>=0)q = brightness(sobel.pixels[(x-1)+(y+1)*img.width]);
            if((x+1)+(y-1)*img.width<img.pixels.length&&(x+1)+(y-1)*img.width>=0)r = brightness(sobel.pixels[(x+1)+(y-1)*img.width]);
        //angle 180
        }else if ((157.5) <= g && g < (202.5)){
            if((x-1)+(y)*img.width<img.pixels.length&&(x-1)+(y)*img.width>=0)q = brightness(sobel.pixels[(x-1)+(y)*img.width]);
            if((x+1)+(y)*img.width<img.pixels.length&&(x+1)+(y)*img.width>=0)r = brightness(sobel.pixels[(x+1)+(y)*img.width]);
        //angle 225
        }else if ((202.5) <= g && g < (247.5)){
            if((x-1)+(y-1)*img.width<img.pixels.length&&(x-1)+(y-1)*img.width>=0)q = brightness(sobel.pixels[(x-1)+(y-1)*img.width]);
            if((x+1)+(y+1)*img.width<img.pixels.length&&(x+1)+(y+1)*img.width>=0)r = brightness(sobel.pixels[(x+1)+(y+1)*img.width]);
        //angle 270
        }else if ((247.5) <= g && g < (292.5)){
            if((x-1)+(y+1)*img.width<img.pixels.length&&(x-1)+(y+1)*img.width>=0)q = brightness(sobel.pixels[(x-1)+(y+1)*img.width]);
            if((x+1)+(y-1)*img.width<img.pixels.length&&(x+1)+(y-1)*img.width>=0)r = brightness(sobel.pixels[(x+1)+(y-1)*img.width]);
        //angle 315
        }else if ((292.5) <= g && g < (337.5)){
            if((x)+(y-1)*img.width<img.pixels.length&&(x)+(y-1)*img.width>=0)q = brightness(sobel.pixels[(x)+(y-1)*img.width]);
            if((x)+(y+1)*img.width<img.pixels.length&&(x)+(y+1)*img.width>=0)r = brightness(sobel.pixels[(x)+(y+1)*img.width]);
        //angle 360
        }else if ((337.5) <= g && g <= (360)){
            if((x+1)+(y)*img.width<img.pixels.length&&(x+1)+(y)*img.width>=0)q = brightness(sobel.pixels[(x+1)+(y)*img.width]);
            if((x-1)+(y)*img.width<img.pixels.length&&(x-1)+(y)*img.width>=0)r = brightness(sobel.pixels[(x-1)+(y)*img.width]);
        }
        //println(q,r);
        if (q<t&&(brightness(sobel.pixels[x+y*img.width]) <= q) && (r<t&&brightness(sobel.pixels[x+y*img.width]) <= r)) sobelMax.pixels[x+y*img.width] = 0;
        else sobelMax.pixels[x+y*img.width] = color(255);
        
  };
  
  void sobelMax3(float t){
    sobelMax = new PImage(img.width, img.height, RGB);
    sobelMax.loadPixels();
    c1.loadPixels();
    float max = 0;
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        
        //if(blue(sobel.pixels[p])<t)getNeighboursMax3(i,j,t);
        //else sobelMax.pixels[p] = color(255);
        //println(blue(c1.pixels[p]));
        if(red(sobel.pixels[p])>max)max = red(sobel.pixels[p]);
        if(green(sobel.pixels[p])>max)max = green(sobel.pixels[p]);
        if(blue(c1.pixels[p])<t)getNeighboursMax3(i,j,t);
        else sobelMax.pixels[p] = color(255);
      }}
      sobelMax.updatePixels();
      imagesWF.add(sobelMax);
      println("max",max);
  };
  
  void getNeighboursMax3(int x, int y,float t) {
    
    boolean k = false;
    int p = x + y * img.width;
    float red = red(sobel.pixels[p]);
    float green = green(sobel.pixels[p]);
    float m = 1;
    //red = map(red,0,255*m,-255,255);
    //green = map(green,0,255*m,-255,255);
    float g = atan2(green,red);
    float g1 = g;
    g = map(g,-PI,PI,0,360);
    //g = gradient[x][y];
    //println(red,green,g6,g7,g,gradient[x][y],g8);
    //if(red!=green)println(red,green,g);
    //println(g);
    int w1 = img.width;
    //= red(sobelG.pixels[p]);
    //= atan2(red(sobely.pixels[p]),red(sobelx.pixels[p]));
        
        float q = 255;
        float r = 255;
        int p1 = 0;
        
       //angle 0
       //if ((0 <= g && g < (22.5))){
       //     if((x+1)+(y)*w1<img.pixels.length&&(x+1)+(y)*w1>=0)q = blue(sobel.pixels[(x+1)+(y)*w1]);
       //     if((x-1)+(y)*w1<img.pixels.length&&(x-1)+(y)*w1>=0)r = blue(sobel.pixels[(x-1)+(y)*w1]);
       // //angle 45
       // }else if ((22.5) <= g && g < (67.5)){
       //     if((x+1)+ (y+1)*w1<img.pixels.length&&(x+1)+ (y+1)*w1>=0)q = blue(sobel.pixels[(x+1)+ (y+1)*w1]);
       //     if((x-1)+ (y-1)*w1<img.pixels.length&&(x-1)+ (y-1)*w1>=0)r = blue(sobel.pixels[(x-1)+ (y-1)*w1]);
       // //angle 90
       // }else if ((67.5) <= g && g< (112.5)){
       //     if((x)+ (y+1)*w1<img.pixels.length&&(x)+ (y+1)*w1>=0)q = blue(sobel.pixels[(x)+ (y+1)*w1]);
       //     if((x)+ (y-1)*w1<img.pixels.length&&(x)+ (y-1)*w1>=0)r = blue(sobel.pixels[(x)+ (y-1)*w1]);
       // //angle 135
       // }else if ((112.5) <= g && g < (157.5)){
       //     if((x-1)+(y+1)*w1<img.pixels.length&&(x-1)+(y+1)*w1>=0)q = blue(sobel.pixels[(x-1)+(y+1)*w1]);
       //     if((x+1)+(y-1)*w1<img.pixels.length&&(x+1)+(y-1)*w1>=0)r = blue(sobel.pixels[(x+1)+(y-1)*w1]);
       // //angle 180
       // }else if ((157.5) <= g && g < (202.5)){
       //     if((x-1)+(y)*w1<img.pixels.length&&(x-1)+(y)*w1>=0)q = blue(sobel.pixels[(x-1)+(y)*w1]);
       //     if((x+1)+(y)*w1<img.pixels.length&&(x+1)+(y)*w1>=0)r = blue(sobel.pixels[(x+1)+(y)*w1]);
       // //angle 225
       // }
         if ((202.5) <= g && g < (247.5)){
            if((x-1)+(y-1)*w1<img.pixels.length&&(x-1)+(y-1)*w1>=0)q = blue(sobel.pixels[(x-1)+(y-1)*w1]);
            if((x+1)+(y+1)*w1<img.pixels.length&&(x+1)+(y+1)*w1>=0)r = blue(sobel.pixels[(x+1)+(y+1)*w1]);
        //angle 270
        }
         if ((247.5) <= g && g < (292.5)){
            if((x-1)+(y+1)*w1<img.pixels.length&&(x-1)+(y+1)*w1>=0)q = blue(sobel.pixels[(x-1)+(y+1)*w1]);
            if((x+1)+(y-1)*w1<img.pixels.length&&(x+1)+(y-1)*w1>=0)r = blue(sobel.pixels[(x+1)+(y-1)*w1]);
        //angle 315
        }
        else if ((292.5) <= g && g < (337.5)){
            if((x)+(y-1)*w1<img.pixels.length&&(x)+(y-1)*w1>=0)q = blue(sobel.pixels[(x)+(y-1)*w1]);
            if((x)+(y+1)*w1<img.pixels.length&&(x)+(y+1)*w1>=0)r = blue(sobel.pixels[(x)+(y+1)*w1]);
        //angle 360
        }
        else if ((337.5) <= g && g <= (360)){
            if((x+1)+(y)*w1<img.pixels.length&&(x+1)+(y)*w1>=0)q = blue(sobel.pixels[(x+1)+(y)*w1]);
            if((x-1)+(y)*w1<img.pixels.length&&(x-1)+(y)*w1>=0)r = blue(sobel.pixels[(x-1)+(y)*w1]);
        }
        //println(q,r);
        //if (q<t&&(blue(sobel.pixels[p]) <= q) && (r<t&&blue(sobel.pixels[p]) <= r)) sobelMax.pixels[p] = color(0);
        //else sobelMax.pixels[p] = color(255);
        if (q<t&&(blue(sobel.pixels[p]) <= q) && (r<t&&blue(sobel.pixels[p]) <= r)) sobelMax.pixels[p] = color(0);
        else sobelMax.pixels[p] = color(255);
        
  };
  
  void sobelMax4(float thresh){
    sobelMax = new PImage(img.width, img.height, RGB);
    
    if(update){
      thresh = map(thresh,0,255,0,1);
      println("ThreshHold",thresh);
      SobelMax.set("thresh", thresh);
      c1.beginDraw();
      c1.shader(SobelMax);
      c1.image(sobel, 0, 0);
      c1.endDraw();
      canny = c1.get();
      imagesWF.add(canny);
      update = true;
    }

  };
  
  void sobelMax4(int t1){
    sobelMax = new PImage(img.width, img.height, RGB);
    
    if(update){
      float thresh = map(t1,0,255,0,1);
      println("ThreshHold",thresh);
      SobelMax.set("thresh", thresh);
      c1.beginDraw();
      c1.shader(SobelMax);
      c1.image(sobel, 0, 0);
      c1.endDraw();
      canny = c1.get();
      imagesWF.add(canny);
      update = true;
    }

  };
  
  void sobelMax(PImage sobel,float t){
    sobelMax = new PImage(img.width, img.height, RGB);
    sobelMax.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        
        boolean max = getNeighboursMax(i,j,sobel,t);
        sobelMax.pixels[p] = color(255);
        if( max)sobelMax.pixels[p] = color(0);
        //else if(max&&brightness(sobel.pixels[p])<255-t)sobelMax.pixels[p] = color(0);
      }}
      sobelMax.updatePixels();
      imagesWF.add(sobelMax);
  };
  
  void canny3(float mult,float thresh){
    canny = new PImage(img.width,img.height,ARGB);
    thresh = map(thresh,0,255,0,1);
    SobelG.set("mult", mult);
    println("mult", mult);
    pass3.beginDraw();            
    pass3.shader(SobelG);  
    pass3.image(imagesWF.get(imagesWF.size()-1), 0, 0);
    
    pass3.endDraw();
    //pass3.loadPixels();
    //for(int i=0;i<pass3.pixels.length;i++){
    //  pass3.pixels[i] = color(random(255));
    //}
    //pass3.updatePixels();
    if(temp==null)temp = new PImage(img.width,img.height,ARGB);
    temp = pass3.get();
    imagesWF.add(temp);
    println("ThreshHold",thresh);
    SobelMax.set("thresh", thresh);
    pass4.beginDraw();            
    pass4.shader(SobelMax);  
    pass4.image(pass3, 0, 0);
    pass4.endDraw(); 
    c2.beginDraw();
    c2.image(pass4, 0, 0);
    c2.endDraw();
    canny = c2.get();
    imagesWF.add(canny);
  };
  
  void canny4(float mult,float thresh){
    canny = new PImage(img.width,img.height,ARGB);
    thresh = map(thresh,0,255,0,1);
    SobelG.set("mult", mult);
    pass1.beginDraw();            
    pass1.shader(SobelG);  
    pass1.image(img, 0, 0);
    pass1.endDraw();
    PImage t = new PImage(img.width,img.height,ARGB);
    t = pass1.get();
    imagesWF.add(t);
    println("ThreshHold",thresh);
    SobelMax.set("thresh", thresh);
    pass2.beginDraw();            
    pass2.shader(SobelMax);  
    pass2.image(pass1, 0, 0);
    pass2.endDraw(); 
    c1.beginDraw();
    c1.image(pass2, 0, 0);
    c1.endDraw();
    canny = c1.get();
    imagesWF.add(canny);
  };
  
  //boolean getNeighboursMax(int x, int y,PImage sobel,float t) {
    
  //  float []min = new float[2];
  //  min[0] = 255;
    
  //  boolean k = false;
  //  int p = x + y * img.width;
  //  float myGradient = gradient[x][y];
    
  //  for (int i=x-1; i<=x+1; i++) {
  //    for (int j=y-1; j<=y+1; j++) {
        
  //      int p1 = i+j*sobel.width;
        
  //      if(p1>0&&p1<sobel.pixels.length){
  //        float c = 0;
  //        c = brightness(sobel.pixels[p1]);
  //        if(min[0]>c){
  //          min[0] = c;
  //          min[1] = p1;
  //        }}}
  //  }
  //  int p1 = (int)min[1];
  //  boolean k2 = false;
  //  float c = brightness(sobel.pixels[p]);
  //  float c1 = brightness(sobel.pixels[p1]);
  //  float t1 = radians(45);
  //  float t2 = 30;
  //  float d = abs(c1-(255-(c)));
  //  //println(d2);
  //  float d1 = abs(c1-c);
  //  float g = atan2(green(sobelG.pixels[p]), blue(sobelG.pixels[p]));
  //  float g1 = atan2(green(sobelG.pixels[p1]), blue(sobelG.pixels[p1]));
  //  float d2 = abs(g-g1);
  //  //println(d3,d1,c,c2,min[0]);
  //  //if(d3<t)k = true;
  //  //println(g,g1,g-g1,t1);
  //  //if(c<t&&c<=c1||d2<t&&d<t2)k = true;
  //  if(c>c1&&c1<t&&d2<t1&&d1<t2||c<t&&c<=c1)k = true;

  //  // for(int i=0;i<8;i++){
  //  //   float theta = radians(45)*i;
  //  //   float theta2 = radians(45)*(i+1);

  //  //   if(g>theta&&g<theta2){
  //  //     if(g2>theta-PI&&g2<theta2-PI||g2>theta+PI&&g2<theta2+PI)
  //  //   }
  //  // }
  //  //println(min[0],brightness(combined.pixels[p]),x,y);
  //  //if(min[0]<=brightness(combined.pixels[p])||k2)k=true;
    
  //  // keep this one for cartoons
  //  //if((min[0]<=brightness(combined.pixels[p]))||d1>t&&min[0]<=brightness(combined.pixels[p]))k = true;
  //  return k;
  //};
  
  boolean getNeighboursMax(int x, int y,PImage sobel,float t) {
    
    float []min = new float[2];
    min[0] = 255;
    
    boolean k = false;
    int p = x + y * img.width;
    float g = atan2((sobelx.pixels[p]),(sobely.pixels[p]));
    
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
        
        int p1 = i+j*sobel.width;
        
        if(p1>0&&p1<sobel.pixels.length){
          float c = 0;
          c = brightness(sobel.pixels[p1]);
          if(min[0]>c){
            min[0] = c;
            min[1] = p1;
          }}}
    }
    int p1 = (int)min[1];
    boolean k2 = false;
    float c = brightness(sobel.pixels[p]);
    float c1 = brightness(sobel.pixels[p1]);
    float t1 = radians(45);
    float t2 = 30;
    float d = abs(c1-(255-(c)));
    //println(d2);
    float d1 = abs(c1-c);
    //float g = atan2(green(sobelG.pixels[p]), blue(sobelG.pixels[p]));
    float g1 = atan2(green(sobelG.pixels[p1]), blue(sobelG.pixels[p1]));
    float d2 = abs(g-g1);
    //println("h");
    return k;
  };
  
  // used with mean--------------------------------
  void sobelMax(PImage sobel,float t,float t1){
    sobelMax = new PImage(img.width, img.height, RGB);
    sobelMax.loadPixels();
    println(t);
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        
        boolean max = getNeighboursMax(i,j,sobel,t,t1);
        sobelMax.pixels[p] = color(255);
        if(max)sobelMax.pixels[p] = color(brightness(sobel.pixels[p]));
        //else if(!max&&brightness(sobel.pixels[p])<t+t1)sobelMax.pixels[p] = color(200);
        //else if(max&&brightness(sobel.pixels[p])<255-t)sobelMax.pixels[p] = color(0);
      }}
      sobelMax.updatePixels();
      imagesWF.add(sobelMax);
  };
  
  boolean getNeighboursMax(int x, int y,PImage sobela,float t,float t2) {
    
    float []min = new float[2];
    min[0] = 255;
    
    boolean k = false;
    int p = x + y * img.width;
    float g = 0;
    if(sobel!=null)g = atan2((sobelx.pixels[p]),(sobely.pixels[p]));
    else g = atan2((sobel2x.pixels[p]),(sobel2y.pixels[p]));
    
    float c = brightness(sobela.pixels[p]);
    //float t2 = 30;
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
        
        int p1 = i+j*sobela.width;
        
        if(p1>0&&p1<sobela.pixels.length){
          float c1 = 0;
          float g1 = atan2(y-j,x-i);
          float d1 = abs(g-g1);
          float d2 = abs((g-PI)-g1);
          float t1 = radians(45);
          float t5 = radians(45);
          float t3 = radians(270);
          float t4 = radians(90);
          if(combined==null)c1= brightness(sobela.pixels[p1]);
          else c1= brightness(combined.pixels[p1]);
          //if((((d1<t1||d2<t1)&&((c1<c&&c1<t))))){
          //if((((d1<t1||d2<t1)&&((c1<c&&c1<t))))){
          if((((d1>t1&&d1<t4+t1)||(d2>t3-t1&&d2<t3+t1))&&(c1<c&&c1<t))){
            
            min[0] = c1;
            min[1] = p1;
            k = true;
            
          }}}
    }
    int p1 = (int)min[1];
    boolean k2 = false;
    //float c = brightness(sobel.pixels[p]);
    float c1 = brightness(sobela.pixels[p1]);
    float t1 = radians(180);
    //println(k);
    float d = abs(c1-(255-(c)));
    
    float d1 = abs(c1-c);
    float g1 = 0;
    if(sobel!=null)g1 = atan2((sobelx.pixels[p1]),(sobely.pixels[p1]));
    else g1 = atan2((sobel2x.pixels[p1]),(sobel2y.pixels[p1]));
    //float g1 = atan2((meanGy.pixels[p1]), (meanGy.pixels[p1]));
    //float g1 = atan2((blurX.pixels[p1]),(blurY.pixels[p1]));
    float d2 = abs(g-g1);
    float d3 = abs((g-PI)-g1);
    float d4 = abs(c-t);
    return k;
  };
  
  void sobelMaxS(float t){
    if(sobel!=null){
      if(sobelMax==null)sobelMax = new PImage(img.width, img.height, RGB);
      
      if(update){
        float t1 = map(t,0,255,0,1);
        println("thresh",t1);
        c1.beginDraw();
        SobelMax.set("thresh",t1);
        c1.shader(SobelMax);
        c1.image(sobel, 0, 0);
        c1.endDraw();
        update=false;
        sobelMax = c1.get();
        imagesWF.add(sobelMax);
        
      }
    }else{
      println("No Sobel Image");
    }
  };
  
  //boolean getNeighboursMax(int x, int y,PImage sobela,float t,float t2) {
    
  //  boolean k = true;
  //  int p = x + y * img.width;
    
  //  float c = brightness(sobela.pixels[p]);
    
  //  for (int i=x-1; i<=x+1; i++) {
  //    for (int j=y-1; j<=y+1; j++) {
        
  //      int p1 = i+j*sobela.width;
        
  //      if(p1>0&&p1<sobela.pixels.length){
  //        float c1 = brightness(sobela.pixels[p1]);
  //        if(c>c1)k = false;
  //    }}
  //  }
  //  return k;
  //};
  
  
  void sobelMin(){
    sobelMin = new PImage(img.width, img.height, RGB);
    sobelMin.loadPixels();
    for (int i=0; i<img.width; i++) {
      for (int j=0; j<img.height; j++) {

        int p = i + j * img.width;
        
        boolean min = getNeighboursMin(i,j);
        if(!min)sobelMin.pixels[p] = color(255);
        else sobelMin.pixels[p] = sobel.pixels[p];
      }}
      sobelMin.updatePixels();
      imagesWF.add(sobelMin);
  };
  
  boolean getNeighboursMin(int x, int y) {
    
    float []max = new float[3];
    max[0] = 0;
    boolean k = false;
    int p = x + y * img.width;
    float myGradient = brightness(sobelG.pixels[p]);
    for (int i=x-1; i<=x+1; i++) {
      for (int j=y-1; j<=y+1; j++) {
        
        int p1 = i+j*sobel.width;
        
        if(p1>0&&p1<sobel.pixels.length&&p1!=p){
        float cGradient = brightness(sobelG.pixels[p1]);
        
        //if(cGradient==-1/myGradient||cGradient==PI-(-1/myGradient)){
        //if(cGradient==myGradient){
          float c = brightness(sobel.pixels[p1]);
          if(max[0]>c){
            max[0] = c;
            max[1] = i;
            max[2] = j;
          }
        //}
      }}
    }
    //println(max[0],brightness(blur.pixels[x+y*sobel.width]));
    int p2 = (int)max[1] + (int)max[2] * sobelG.width;
    //if(p2
    //println((int)max[0],(int)max[1],x,y);
    float cGradient = brightness(sobelG.pixels[p]);
    //if(max[0]>=brightness(blur.pixels[x+y*sobel.width])||(cGradient==-1/myGradient||cGradient==PI-(-1/myGradient)))k=true;
    boolean k2 = false;
    float r = red(blur.pixels[p]);
    float g = green(blur.pixels[p]);
    float b = blue(blur.pixels[p]);
    float b1 = brightness(blur.pixels[p]);
    float r1 = red(blur.pixels[p2]);
    float g1 = green(blur.pixels[p2]);
    float b2 = blue(blur.pixels[p2]);
    float b3 = brightness(blur.pixels[p2]);
    float t = 0;
    if(abs(r-r1)<t||abs(g-g1)<t||abs(b-b2)<t||abs(b1-b3)<t)k2 = true;
    
    //if(max[0]<=brightness(blur.pixels[x+y*sobel.width])||(cGradient==-1/myGradient||cGradient==PI-(-1/myGradient))||k2)k=true;
    if(max[0]<=brightness(blur.pixels[x+y*sobel.width])&&(cGradient!=-1/myGradient&&cGradient!=PI-(-1/myGradient)))k=true;
    //if(max[0]<=brightness(blur.pixels[x+y*sobel.width])||(cGradient==myGradient))k=true;
    //if(max[0]<=brightness(blur.pixels[x+y*sobel.width]))k=true;
    return k;
  };
  
  void displayWF(String []s){
    logic();
    workflow(s);
    if(imagesWF.size()>0)
    image(imagesWF.get(counter),ix,iy);
    text(workFlowLabels.get(counter),10,10);
  };
  
  void displayWF2(String []s){
    logic2();
    workflow(s);
    
    //if(imagesWF.size()>0)
    image(imagesWF.get(counter),0,0);
    //if(pmouseX!=mouseX){
    //  cell.canny.loadPixels();
    //  for(int i=0;i<cell.edges.size();i++){
    //    //cell c0 = cell.edges.get(i).get(0);
    //    //fill(0);
    //    //text(i,c0.x+10,c0.y);
    //    if(cell.edges.get(i).size()>edgeLength){
    //      for(int j=0;j<cell.edges.get(i).size();j++){
    //      cell c = cell.edges.get(i).get(j);
    //      cell.canny.pixels[(int)c.x+(int)c.y*img.width] = color(0);
    //      }
    //    }else{
    //      for(int j=0;j<cell.edges.get(i).size();j++){
    //      cell c = cell.edges.get(i).get(j);
    //      cell.canny.pixels[(int)c.x+(int)c.y*img.width] = color(255);
    //      }
    //    }
    //  }
    //  cell.canny.updatePixels();
    //}
    //if(cell.update&&cell.edges.size()>0)
    //for(int j=0;j<cell.edges.get(counter).size();j++){
    //  cell c = cell.edges.get(counter).get(j);
    //  //pixels[(int)c.x+(int)c.y*img.width] = color(0);
    //  stroke(0);
    //  point(c.x,c.y);
    //}
    
    for(int j=0;j<cell.cells.size();j++){
      
    }
    
    cell c = cell.unsortedEdges.get(counter);
    stroke(0);
    //point(c.x,c.y);
    //c.debug();
    //for(int j=0;j<cell.neighbours.size();j++){
    //  cell c1 = cell.neighbours.get(i);
      
    //}
    //updatePixels();
  };
  
  void displayWF(){
    logic2();
      //for(int i=0;i<cell.edges.size();i++){
      //  if(cell.edges.get(i).size()>edgeLength){
      //    for(int j=0;j<cell.edges.get(i).size();j++){
      //      cell c = cell.edges.get(i).get(j);
      //      stroke(0);
      //      point(c.x,c.y);
      //    }
      //  }
      //}
    
    
    for(int j=0;j<cell.edges.get(counter).size();j++){
      cell c = cell.edges.get(counter).get(j);
      stroke(0);
      point(c.x,c.y);
    }
  };
  
  void displayWFCanvas(String []s){
    logic();
    workflow2(s);
    //if(imagesWF.size()>0)image(imagesWF.get(imagesWF.size()-1),x,y);
    
    //if(imagesWF.size()>0)
    //image(imagesWF.get(counter),x,y);
    
  };
  
  void logic(){
    int count = 0;
    if(mousePressed&&!mdown){
      mdown = true;
      counter++;
      
    }
    
    if(counter<imagesWF.size()){
      if(imagesWF.get(counter).width>width){
        if(mouseX>0&&mouseX<width)ix = -(int)map(mouseX,0,width,0,imagesWF.get(counter).width-width);
      }
      if(imagesWF.get(counter).height>height){
        if(mouseY>0&&mouseY<height)iy = -(int)map(mouseY,0,height,0,imagesWF.get(counter).height-height);
      }
    }
    
    if(!mousePressed){
      mdown = false;
      m2down = false; 
    }
    if(counter>imagesWF.size()-1)counter = 0;
    if(imagesWF.size()>0&&mdown&&!m2down){
      m2down = true;
      println(workFlowLabels.get(counter),imagesWF.size());
      
    }
    
  };
  
  void logic2(){
    //if(mousePressed&&!mdown){
    //  mdown = true;
    //  counter++;
    //  println(counter);
    //}
    
    if(mouseX>0)counter = (int)map(mouseX,0,width,0,imagesWF.size());
    //if(mouseX>0)counter = (int)map(mouseX,0,width,0,cell.edges.size());
    
    if(!mousePressed)mdown = false;
    //if(counter>cell.edges.size()-1)counter = 0;
    fill(0);
    text("c "+counter,10,20);
  };
  
  void canny2(int mode,float t1,int t2) {
    canny = new PImage(img.width, img.height, RGB);
    
    //cell = new cell();
    cell.Mode = mode;
    cell.pixelThresh = 20000;
    cell.pixelThresh1 = t2;
    cell.cutoff = t1;
    //cell.maxT = 100;
    //cell.minT = 50;
    //cell.pixelThresh1 = 20;
    cell.imgUpdate(img);
    cell.getContour3();
    imagesWF.add(cell.canny);
    imagesWF.add(cell.backup);
    //imagesWF.add(cell.img);
  };
  
  void canny(int mode,float t1) {
    canny = new PImage(img.width, img.height, RGB);
    
    //cell = new cell();
    cell.Mode = mode;
    cell.pixelThresh = 20000;
    cell.pixelThresh1 = 0;
    cell.cutoff = t1;
    //cell.maxT = 100;
    //cell.minT = 50;
    //cell.pixelThresh1 = 20;
    cell.imgUpdate(img);
    cell.getContour();
    imagesWF.add(cell.canny);
    //imagesWF.add(cell.backup);
    //imagesWF.add(cell.img);
  };
  
  void canny(int mode,float t1,int t2) {
    canny = new PImage(img.width, img.height, RGB);
    
    //cell = new cell();
    cell.Mode = mode;
    cell.pixelThresh = 20000;
    cell.pixelThresh1 = t2;
    cell.cutoff = t1;
    //cell.maxT = 100;
    //cell.minT = 50;
    //cell.pixelThresh1 = 20;
    cell.imgUpdate(img);
    cell.getContour4();
    imagesWF.add(cell.canny);
    //imagesWF.add(cell.backup);
    //imagesWF.add(cell.img);
  };
  
  void canny(int mode,float t1,int t2,int t3) {
    canny = new PImage(img.width, img.height, RGB);
    
    //cell = new cell();
    cell.Mode = mode;
    cell.pixelThresh = t3;
    cell.pixelThresh1 = t2;
    cell.cutoff = t1;
    //cell.maxT = 100;
    //cell.minT = 50;
    //cell.pixelThresh1 = 20;
    //imagesWF.add(img);
    cell.imgUpdate(sobel);
    imagesWF.add(sobel);
    cell.getContour();
    imagesWF.add(cell.canny);
    //imagesWF.add(cell.backup);
    //imagesWF.add(cell.img);
  };
  
  void cannySP(){
    if(update){
      canny = new PImage(img.width,img.height);
      c1.beginDraw();
      //println(s_mult);
      //Canny.set("u_mult",s_mult);
      c1.shader(Canny);
      c1.image(img, 0, 0);
      c1.endDraw();
      update=false;
      imagesWF.add(canny);
      //println(red(img.pixels[1000]),red(sobel.pixels[1000]));
      //sobel = c1.get();
    }
  };
  
  void cannyTrim(int type,float t){
    if(cannyT== null) cannyT = new PImage(img.width,img.height,ARGB);
    CannyTrim.set("type",(float)type);
    t = map(t,0,255,0,1);
    CannyTrim.set("thresh",t);
    if(update){
      c1.beginDraw();
      c1.shader(CannyTrim);
      c1.image(img,0,0);
      c1.endDraw();
      update = false;
    }
    cannyT = c1.get();
    imagesWF.add(cannyT);
      
  };
  
  void cannyTrim(int type,int t){
    if(cannyT== null) cannyT = new PImage(img.width,img.height,ARGB);
    CannyTrim.set("type",(float)type);
    float t1 = map(t,0,255,0,1);
    CannyTrim.set("thresh",t1);
    if(update){
      c1.beginDraw();
      c1.shader(CannyTrim);
      c1.image(img,0,0);
      c1.endDraw();
      update = false;
    }
    cannyT = c1.get();
    imagesWF.add(cannyT);
      
  };
  
  void cannyTrim(int type,int t,int t1){
    if(cannyT== null) cannyT = new PImage(img.width,img.height,ARGB);
    CannyTrim.set("type",(float)type);
    float t2 = map(t,0,255,0,1);
    CannyTrim.set("thresh",t2);
    println(t1);
    t2 = map(t1,0,255,0,1);
    CannyTrim.set("thresh2",t2);
    if(update){
      c1.beginDraw();
      c1.shader(CannyTrim);
      c1.image(img,0,0);
      c1.endDraw();
      update = false;
    }
    cannyT = c1.get();
    imagesWF.add(cannyT);
      
  };
  
  void cannyTrim2(int mode){
    if(cannyT== null) cannyT = new PImage(img.width,img.height,ARGB);
    CannyTrim1.set("Mode",mode);
    if(update){
      c1.beginDraw();
      c1.shader(CannyTrim1);
      c1.image(img,0,0);
      c1.endDraw();
      update = false;
    }
    cannyT = c1.get();
    imagesWF.add(cannyT);
      
  };
  
  void superPixel(){
    img.loadPixels();
    for(int j=0;j<img.pixels.length;j++){
      
      //if(red(img.pixels[j])<200)img.pixels[j] = color(255,0,0);
      if(color(img.pixels[j])==color(0))img.pixels[j] = color(255,0,0);
    }
    img.updatePixels();
  };
};
