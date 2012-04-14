#import "SubjectMatcher.h"

@protocol Combinator;

@interface CombinatorMatcher : NSObject <SubjectMatcher>

@property id <SubjectMatcher> subjectMatcher;
@property id <Combinator> combinator;
@property id <SubjectMatcher> relativeMatcher;

- (id)initWithSubjectMatcher:(id <SubjectMatcher>)theSubjectMatcher combinator:(id <Combinator>)theCombinator relativeMatcher:(id <SubjectMatcher>)theRelativeMatcher;


+ (id <SubjectMatcher>)matcherWithSubjectMatcher:(id <SubjectMatcher>)subjectMatcher
                                      combinator:(id <Combinator>)combinator
                                 relativeMatcher:(id <SubjectMatcher>)relativeMatcher;
@end
