#import "InstanceMatcher.h"

@interface IdentityMatcher : NSObject <Matcher>

@property(strong) UIView *targetView;

+ (IdentityMatcher *)matcherWithView:(UIView *)view description:(NSString *)description;

+ (IdentityMatcher *)matcherWithView:(UIView *)view;

@end
