#import "SimpleMatcher.h"

@interface KindOfClassMatcher : NSObject<SimpleMatcher>

@property(strong, readonly) id matchClass;

+ (KindOfClassMatcher *)forBaseClass:(Class)baseClass;

@end
