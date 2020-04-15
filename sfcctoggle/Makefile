
ARCHS = armv7 arm64
export TARGET = iphone:clang:11.2:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SFCCToggle
SFCCToggle_BUNDLE_EXTENSION = bundle
SFCCToggle_FILES = SFCCToggle.m
SFCCToggle_PRIVATE_FRAMEWORKS = ControlCenterUIKit
SFCCToggle_INSTALL_PATH = /Library/ControlCenter/Bundles/

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk
