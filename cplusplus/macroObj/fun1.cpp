#include <iostream>
#include "Log.hh"

Log aLog;
#define LOG std::cout <<aLog.getValue()<<std::endl
#include "Display.hh"

void fun1()
{
  aLog.setValue(10);

  std::cout <<"in fun1" <<std::endl;
  LOG;

  Display aDisplay;
  aDisplay.display();
}
