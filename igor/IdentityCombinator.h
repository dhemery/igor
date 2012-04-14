#import "Combinator.h"

@protocol SubjectMatcher;

@interface IdentityCombinator : NSObject <Combinator>
- (id <Combinator>)initWithSubjectMatcher:(id <SubjectMatcher>)aSubjectMatcher;


+ (id <Combinator>)combinatorThatAppliesMatcher:(id <SubjectMatcher>)subjectMatcher;
@end