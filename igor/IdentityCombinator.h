#import "Combinator.h"

@protocol SimpleMatcher;

@interface IdentityCombinator : NSObject <Combinator>

+ (id <Combinator>)combinatorWithSubjectMatcher:(id <SimpleMatcher>)subjectMatcher;

@end
