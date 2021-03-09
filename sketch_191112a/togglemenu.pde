class toggleMenu{
  
  float x,w,h,y;
  Menu menu;
  
  toggleMenu(float x,float y,float w,String []s){
    
    menu = new Menu(x,y,w,s,false);
  };
  
  void draw(){
    menu.draw();
    for(int i=0;i<menu.items.size();i++){
      Button b = menu.items.get(i);
      b.self_toggle();
    };
  };
};
