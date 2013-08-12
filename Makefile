CC = gcc

main: main.o app.o func.o
	$(CC) -o $@ $+

clean:
	@rm *.o *.d
	@find -type f -exec test -x {} \; -a -exec rm {} \;

.PHONY: clean


## 使用Makefile自动添加源文件的依赖头文件
sources = main.c app.c func.c

include $(sources:.c=.d)

%.d: %.c
	set -e; rm -f $@; \
	$(CC) -MM $(CPPFLAGS) $< > $@.$$$$; \
	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
	rm -f $@.$$$$
