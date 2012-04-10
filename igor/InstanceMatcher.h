#import "SubjectMatcher.h"

@protocol ClassMatcher;
@protocol SubjectMatcher;
@protocol SimpleMatcher;

@interface InstanceMatcher : NSObject <SubjectMatcher>

@property(nonatomic, strong) NSMutableArray *simpleMatchers;

+ (InstanceMatcher *)withSimpleMatchers:(NSMutableArray *)simpleMatchers;
@end
