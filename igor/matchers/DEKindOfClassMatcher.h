#import "DEMatcher.h"

@interface DEKindOfClassMatcher : NSObject <DEMatcher>

@property(strong, readonly) id matchClass;

+ (DEKindOfClassMatcher *)matcherForBaseClass:(Class)baseClass;

@end
