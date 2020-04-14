@interface Snap : UIView
@end

@interface SnapperWindow : UIWindow
@end

@interface CALayer (SF)
@property BOOL allowsHitTesting;
@end

//static SnapperWindow *mySnapperWindow;
static BOOL shouldIgnoreHitTest;

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
    self.alpha = 0.5;
  }else{
    [self setUserInteractionEnabled:YES];
    self.layer.allowsHitTesting = true;
    self.alpha = 1;
  }
}

%end

%ctor {

    dlopen("/Library/MobileSubstrate/DynamicLibraries/Snapper2.dylib", RTLD_LAZY);
      %init;

}
