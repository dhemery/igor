#import "ClassMatcher.h"

@interface KindOfClassMatcher : NSObject<ClassMatcher>

+ (KindOfClassMatcher *)forClass:(Class)targetClass;

@end
