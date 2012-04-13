#import "SimpleMatcher.h"
#import "SubjectMatcher.h"

@interface UniversalMatcher : NSObject <SimpleMatcher, SubjectMatcher>
@end