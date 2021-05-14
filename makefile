
CROSS_COMPILE =

CC = @echo "GCC $@"; $(CROSS_COMPILE)gcc
CXX = @echo "G++ $@"; $(CROSS_COMPILE)g++
RM = rm -rf
AR = ar -rcs
CP = cp -r
MKDIR = mkdir -p

TOPDIR = .

SRC_DIRS := $(shell find src -maxdepth 3 -type d)
LIBFACEDETECTION = libfacedetection
LIBOPENCV = libopencv

CFLAGS += $(addprefix -I , $(SRC_DIRS))
CFLAGS += -I$(LIBFACEDETECTION)/include/facedetection
CFLAGS += -I$(LIBOPENCV)/include/opencv4
CFLAGS += -Wall

LDFLAGS += -L$(LIBFACEDETECTION)/lib
LDFLAGS += -L$(LIBOPENCV)/lib
LDFLAGS += -L$(TOPDIR)

#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:libopencv/lib
LIBS += -Wl,--start-group	\
		-Wl,-Bstatic -lfacedetection \
		-Wl,-Bdynamic -ldl -lm -lpthread -lrt -lopencv_core -lopencv_imgproc -lopencv_imgcodecs -lopencv_highgui -lopencv_video -lopencv_features2d -lopencv_gapi -lopencv_ml -lopencv_photo \
		-Wl,--end-group

SRC += $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.cpp))

OBJ += $(SRC:%.cpp=%.o)

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $<
%.o : %.cpp
	$(CXX) $(CFLAGS) -c -o $@ $<

TARGET := faceapp
.PHONY : all clean

all: $(TARGET)

$(TARGET) : $(OBJ)
	$(CXX) $^  $(CFLAGS) $(LDFLAGS) $(LIBS) -o $@

clean :
	$(RM) $(TARGET)
	$(RM) $(OBJ)
