#import "SubjectMatcher.h"

@protocol Combinator;

@interface BranchMatcher : NSObject <SubjectMatcher>

@property (strong) id <SubjectMatcher> subjectMatcher, relativeMatcher;
@property (strong) id <Combinator> combinator;

+ (BranchMatcher *)matcherWithSubjectMatcher:(id <SubjectMatcher>)subject
                                   combinator:(id <Combinator>)combinator
                              relativeMatcher:(id <SubjectMatcher>)relativeMatcher;

@end
