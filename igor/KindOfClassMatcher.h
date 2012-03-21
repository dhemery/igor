
#import "ClassMatcher.h"

@interface KindOfClassMatcher : NSObject<ClassMatcher>

+(id) forClass:(Class)targetClass;

@end
