#import "SimpleMatcher.h"

@interface MemberOfClassMatcher : NSObject <SimpleMatcher>

@property(strong, readonly) Class matchClass;

+ (MemberOfClassMatcher *)matcherForExactClass:(Class)exactClass;

@end
