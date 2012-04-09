#import "InstanceMatcher.h"

@interface IdentityMatcher : InstanceMatcher

+ (IdentityMatcher *)forView:(UIView *)view;

@end
