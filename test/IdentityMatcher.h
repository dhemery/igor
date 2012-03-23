#import "NodeMatcher.h"

@interface IdentityMatcher : NodeMatcher

+ (IdentityMatcher *)forView:(UIView *)view;

@end
