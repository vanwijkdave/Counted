INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64 arm64e


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Counted

Counted_FILES = Tweak.xm
Counted_CFLAGS = -fobjc-arc
Counted_EXTRA_FRAMEWORKS = Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += countedprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
