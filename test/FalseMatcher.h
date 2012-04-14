#import "SubjectMatcher.h"
#import "SimpleMatcher.h"

@interface FalseMatcher : NSObject <SubjectMatcher, SimpleMatcher>
@end