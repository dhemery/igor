#import "SimpleMatcher.h"

@interface KindOfClassMatcher : NSObject<SimpleMatcher>

@property(strong, readonly) id matchClass;

+ (KindOfClassMatcher *)matcherForBaseClass:(Class)baseClass;

@end
