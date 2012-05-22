#import "DEMatcher.h"

@interface DEMemberOfClassMatcher : NSObject <DEMatcher>

@property(strong, readonly) Class matchClass;

+ (DEMemberOfClassMatcher *)matcherForExactClass:(Class)exactClass;

@end
