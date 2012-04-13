#import "InstanceMatcher.h"

@interface IdentityMatcher : NSObject <SimpleMatcher, SubjectMatcher>

+ (IdentityMatcher *)forView:(UIView *)view;

@end
