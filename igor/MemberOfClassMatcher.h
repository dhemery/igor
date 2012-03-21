
#import "ClassMatcher.h"

@interface MemberOfClassMatcher : NSObject<ClassMatcher>

+(MemberOfClassMatcher*) forClass:(Class)targetClass;

@end
