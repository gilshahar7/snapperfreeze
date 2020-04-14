#define PLIST_PATH @"/User/Library/Preferences/com.gilshahar7.snapperfreezerprefs.plist"

@interface Snap : UIView
@end

@interface SnapperWindow : UIWindow
@end

@interface CALayer (SF)
@property BOOL allowsHitTesting;
@end

//static SnapperWindow *mySnapperWindow;
static BOOL shouldIgnoreHitTest;
static float alpha;

static void loadPrefs() {
  [NSNotificationCenter.defaultCenter postNotificationName:@"com.gilshahar7.snapperfreeze/toggle" object:nil];
  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
  alpha = [[prefs objectForKey:@"alphaSlider"] floatValue];
  if(alpha == 0.0){
    alpha = 50.0;
  }
  alpha = alpha/100.0;
  [NSNotificationCenter.defaultCenter postNotificationName:@"com.gilshahar7.snapperfreeze/toggle" object:nil];

}

%hook SnapperWindow
-(SnapperWindow *)initWithFrame:(CGRect)arg1{
  SnapperWindow *origself = %orig;
  shouldIgnoreHitTest = NO;

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sfToggle) name:@"com.gilshahar7.snapperfreeze/toggle" object:nil];

  return origself;
}

- (BOOL)_ignoresHitTest {
	return shouldIgnoreHitTest;
}


%new
-(void)sfToggle{
  shouldIgnoreHitTest = !shouldIgnoreHitTest;
  if(shouldIgnoreHitTest == true){
    [self setUserInteractionEnabled:NO];
    self.layer.allowsHitTesting = false;
    self.alpha = alpha;
  }else{
    [self setUserInteractionEnabled:YES];
    self.layer.allowsHitTesting = true;
    self.alpha = 1;
  }
}

%end

%ctor {
  dlopen("/Library/MobileSubstrate/DynamicLibraries/Snapper2.dylib", RTLD_LAZY);
  loadPrefs();
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.gilshahar7.snapperfreezerprefs.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
  %init;
}
