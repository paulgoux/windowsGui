import java.io.BufferedWriter;
import java.io.FileWriter;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.awt.*;
import java.lang.reflect.*;

PApplet app = this;
BMScontrols BMS;

import java.io.*;
import java.net.*;

//----------reflections-----------------


boolean k1 = false;
int W = 1200,H = 600;
tab tab1;
Menu file;

//Camera cam;

float counter,mult;
boolean mdown;

void settings(){
  size(W,H,P2D);
};


void setup(){
  orientation(LANDSCAPE);
  BMS = new BMScontrols(this);
  BMS.begin();
  String [] flabels = {"Background","Camera","Window"};
  file = new Menu(20,0,50,70,"File",flabels,0);
  
  BMS.add(file);
  
  tab1 = new tab(720,200,200,400,"Background");
  tab1.toggle = true;
  tab1.visible = true;
  tab1.draggable = true;
  tab1.scrollable = true;
  tab1.vscroll = true;
  
  String [] s3 = {"red","green","blue"};
  float [] v1 = {52, 235, 225};
  sliderBox sl2 = new sliderBox(0,40,90,90,10,s3,v1,0);
  sl2.menu.draggable = false;
  sl2.tooltip = null;
  sl2.setStart(0);
  sl2.setEnd(255);
  tab1.add(sl2);
  tab1.setAlignment("center");
  tab1.setRadius(10);
  
  BMS.dock.add(tab1);
  BMS.dock.setRadius(10);
  BMS.menus.get(0).setRadius(10);
  BMS.menus.get(0).setAlignment("center");
  
};

void draw(){
  fill(255);
  background(BMS.bgcol);
  text(frameRate,50,100);
  logic();
  BMS.run();
  //tab1.displayTab();
  
};

void logic(){
  BMS.selfToggle(0,0);
  BMS.toggle(0,2,BMS.fmenu,"toggle");
  
  if(tab1.sliderBoxes.size()>0){
    Menu m1 = tab1.sliderBoxes.get(0).menu;
    Slider r = m1.sliders.get(0);
    Slider g = m1.sliders.get(1);
    Slider b = m1.sliders.get(2);
    BMS.bgcol = color(r.value,g.value,b.value);
  }
  tab1.sliderv.set(0,200);
  if(BMS.getToggle(0,0))tab1.displayTab();
};
