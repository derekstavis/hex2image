# Comment/uncomment the following line to disable/enable debugging prints
# DEBUG = y

# -----------------------------------------------------------------------------

INSTALL_DIR := /usr/local/bin
TARGET = hex2image

CFLAGS += -Wall -D_GNU_SOURCE -I../
ifeq ($(DEBUG),y)
   CFLAGS += -O -ggdb -DDEBUG # "-O" is needed to expand inlines
else
   CFLAGS += -O -ggdb
   LDFLAGS += -s
endif

# --- Actions section

.PHONY : all
.PHONY : depend dep

all : .depend $(TARGET)

.depend depend dep :
	$(CC) $(CFLAGS) -M $(TARGET:=.c) > .depend

-include .depend

# --- Clean section

.PHONY : clean

clean :
	rm -f *~ core .depend
	rm -f $(TARGET) *.o

install:
	cp $(TARGET) $(INSTALL_DIR)
