#include <iostream>
#include "Log.hh"

Log bLog;
#define LOG std::cout <<bLog.getValue()<<std::endl
#include "Display.hh"

void fun2()
{
  bLog.setValue(20);
  
  std::cout <<"in fun2" <<std::endl;
  LOG;

  Display aDisplay;

  aDisplay.display();
}
