#import "DEMatcher.h"

@interface DEIdentityMatcher : NSObject <DEMatcher>

@property(strong) UIView *targetView;

+ (DEIdentityMatcher *)matcherWithView:(UIView *)view description:(NSString *)description;

+ (DEIdentityMatcher *)matcherWithView:(UIView *)view;

@end
