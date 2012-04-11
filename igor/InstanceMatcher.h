#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@interface InstanceMatcher : NSObject <SubjectMatcher>

@property(nonatomic, strong) NSArray *simpleMatchers;

+ (InstanceMatcher *)withSimpleMatchers:(NSArray *)simpleMatchers;
@end
