#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@protocol SubjectMatcher;

@interface InstanceMatcher : NSObject <SubjectMatcher>

@property(nonatomic, strong) NSArray *simpleMatchers;

+ (InstanceMatcher *)withSimpleMatchers:(NSArray *)simpleMatchers;
@end
