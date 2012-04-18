#import "Matcher.h"

@interface MemberOfClassMatcher : NSObject <Matcher>

@property(strong, readonly) Class matchClass;

+ (MemberOfClassMatcher *)matcherForExactClass:(Class)exactClass;

@end
