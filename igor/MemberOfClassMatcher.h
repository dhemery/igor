#import "SimpleMatcher.h"

@interface MemberOfClassMatcher : NSObject<SimpleMatcher>

@property(strong, readonly) Class matchClass;

+ (MemberOfClassMatcher*)forExactClass:(Class)exactClass;

@end
