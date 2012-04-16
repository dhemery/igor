#import "SubjectMatcher.h"
#import "SimpleMatcher.h"

@protocol Combinator;
@class IdentityMatcher;

@interface BranchMatcher : NSObject <SubjectMatcher, SimpleMatcher>

@property (strong, readonly) id <SubjectMatcher> subjectMatcher;
@property (strong, readonly) id <SubjectMatcher> relativeMatcher;
@property (strong, readonly) id <Combinator> subjectCombinator;
@property (strong, readonly) IdentityMatcher *subjectIdentityMatcher;

+ (BranchMatcher *)matcherWithSubjectMatcher:(id <SubjectMatcher>)subjectMatcher;

- (BranchMatcher *)appendCombinator:(id <Combinator>)combinator matcher:(id <SubjectMatcher>)relativeSubjectMatcher;

@end
