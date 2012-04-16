#import "SubjectMatcher.h"

@protocol Combinator;

@interface CombinatorMatcher : NSObject <SubjectMatcher>

@property (strong) id <SubjectMatcher> subjectMatcher;
@property (strong) id <Combinator> combinator;
@property (strong) id <SubjectMatcher> relativeMatcher;

+ (id <SubjectMatcher>)matcherWithRelativeMatcher:(id <SubjectMatcher>)relativeMatcher
                                combinator:(id <Combinator>)combinator
                            subjectMatcher:(id <SubjectMatcher>)subjectMatcher;

@end
