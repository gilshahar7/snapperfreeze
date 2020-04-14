#import "SFCCToggle.h"

@implementation SFCCToggle

//Return the icon of your module here
- (UIImage *)iconGlyph
{
	return [UIImage imageNamed:@"icon" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
}

//Return the color selection color of your module here
- (UIColor *)selectedColor
{
	return [UIColor blueColor];
}

- (BOOL)isSelected
{
	_selected = NO;
  return _selected;
}

- (void)setSelected:(BOOL)selected
{
	_selected = selected;

  [super refreshState];

	[NSNotificationCenter.defaultCenter postNotificationName:@"com.gilshahar7.snapperfreeze/toggle" object:nil];
}

@end
