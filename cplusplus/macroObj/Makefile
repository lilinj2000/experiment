all: test1 test2 test3 test4

test1:
	g++ Main.cpp fun1.cpp fun2.cpp fun3.cpp -o test1

test2:
	g++ Main.cpp fun2.cpp fun1.cpp fun3.cpp -o test2

test3:
	g++ fun1.cpp fun2.cpp Main.cpp fun3.cpp -o test3

test4:
	g++ fun2.cpp fun1.cpp Main.cpp fun3.cpp -o test4

clean:
	rm -rf test1 test2 test3 test4
