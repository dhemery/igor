
#import "ClassMatcher.h"

@interface MemberOfClassMatcher : ClassMatcher

+(MemberOfClassMatcher*) forClass:(Class)targetClass;

@end
