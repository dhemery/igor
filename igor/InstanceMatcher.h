#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@protocol SubjectMatcher;

@interface InstanceMatcher : NSObject <SubjectMatcher>

@property(nonatomic, strong) NSMutableArray *simpleMatchers;

+ (InstanceMatcher *)withSimpleMatchers:(NSMutableArray *)simpleMatchers;
@end
