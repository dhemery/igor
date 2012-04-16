#import "InstanceMatcher.h"

@interface IdentityMatcher : NSObject <SimpleMatcher, SubjectMatcher>

@property(strong) UIView *targetView;

+ (IdentityMatcher *)matcherWithView:(UIView *)view description:(NSString *)description;

+ (IdentityMatcher *)matcherWithView:(UIView *)view;

@end
