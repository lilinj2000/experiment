#include <iostream>
#include "Log.hh"

extern Log aLog;
#define LOG std::cout <<aLog.getValue()<<std::endl
#include "Display.hh"

void fun3()
{
  std::cout <<"in fun3" <<std::endl;
  LOG;

  Display aDisplay;
  aDisplay.display();
}
