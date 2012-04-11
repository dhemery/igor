#import "SimpleMatcher.h"

@interface KindOfClassMatcher : NSObject<SimpleMatcher>

@property(nonatomic, assign) id matchClass;

+ (KindOfClassMatcher *)forClass:(Class)targetClass;

@end
