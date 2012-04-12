#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@interface InstanceMatcher : NSObject <SubjectMatcher>

@property(strong, readonly) NSArray *simpleMatchers;

+ (InstanceMatcher *)matcherWithSimpleMatchers:(NSArray *)simpleMatchers;

@end
