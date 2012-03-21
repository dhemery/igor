
#import "Matcher.h"

@interface IdentityMatcher : NSObject<Matcher>

+(IdentityMatcher*) forView:(UIView*)view;

@end
