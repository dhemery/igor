#import "Combinator.h"

@protocol SimpleMatcher;

@interface DescendantCombinator : NSObject <Combinator>

+ (id <Combinator>)combinatorWithSubjectMatcher:(id <SimpleMatcher>)theSubjectMatcher relativeMatcher:(id <SubjectMatcher>)theRelativeMatcher;

@end
