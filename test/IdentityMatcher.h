#import "InstanceMatcher.h"

@interface IdentityMatcher : NSObject<SubjectMatcher>

+ (IdentityMatcher *)forView:(UIView *)view;

@end
