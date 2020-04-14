ARCHS = armv7 arm64 arm64e
export TARGET = iphone:clang:11.2:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SnapperFreezePrefs

SnapperFreezePrefs_FILES = SFPRootListController.m
SnapperFreezePrefs_INSTALL_PATH = /Library/PreferenceBundles
SnapperFreezePrefs_FRAMEWORKS = UIKit
SnapperFreezePrefs_PRIVATE_FRAMEWORKS = Preferences
SnapperFreezePrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SnapperFreezePrefs.plist$(ECHO_END)
