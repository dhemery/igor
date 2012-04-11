#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@interface InstanceMatcher : NSObject <SubjectMatcher>

@property(strong, readonly) NSArray *simpleMatchers;

+ (InstanceMatcher *)withSimpleMatchers:(NSArray *)simpleMatchers;

@end
