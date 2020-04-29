include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = countedPrefs
ARCHS = arm64 arm64e
export SYSROOT = $(THEOS)/sdks/iPhoneOS11.2.sdk
TARGET = iphone:11.2


countedPrefs_FILES = ctprefsRootListController.m countedCells.m
countedPrefs_INSTALL_PATH = /Library/PreferenceBundles
countedPrefs_FRAMEWORKS = UIKit
countedPrefs_PRIVATE_FRAMEWORKS = Preferences
countedPrefs_CFLAGS = -fobjc-arc
countedPrefs_EXTRA_FRAMEWORKS = CepheiPrefs, Cephei



include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/countedPrefs.plist$(ECHO_END)
