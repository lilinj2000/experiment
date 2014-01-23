#ifndef LOG_HH
#define LOG_HH

class Log
{
public:
  Log(): value_(5) {}
  
  void setValue(int value)
  {
    value_ = value;
  }

  int getValue()
  {
    return value_;
  }

private:
  int value_;
};

#endif
