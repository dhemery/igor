#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@interface InstanceMatcher : NSObject <SubjectMatcher>

@property(strong) NSArray *simpleMatchers;

+ (InstanceMatcher *)matcherWithSimpleMatchers:(NSArray *)simpleMatchers;

@end
