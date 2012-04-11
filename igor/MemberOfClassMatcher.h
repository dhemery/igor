#import "SimpleMatcher.h"

@interface MemberOfClassMatcher : NSObject<SimpleMatcher>

@property(nonatomic, assign) id matchClass;

+ (MemberOfClassMatcher*)forClass:(Class)targetClass;

@end
