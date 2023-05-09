hello_world: .hello_world.o .amboso.o
	gcc .hello_world.o .amboso.o -o hello_world

.hello_world.o: ./src/hello_world.c
	gcc -c ./src/hello_world.c -o .hello_world.o

.amboso.o: ./static/amboso.c
	gcc -c ./static/amboso.c -o .amboso.o

clean:
	rm \.*.o hello_world

cleanob:
	rm \.*.o
