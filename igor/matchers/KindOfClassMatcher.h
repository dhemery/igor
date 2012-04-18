#import "Matcher.h"

@interface KindOfClassMatcher : NSObject <Matcher>

@property(strong, readonly) id matchClass;

+ (KindOfClassMatcher *)matcherForBaseClass:(Class)baseClass;

@end
