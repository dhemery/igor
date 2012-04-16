#import "ChainMatcher.h"
#import "Matcher.h"

@protocol Combinator;
@class IdentityMatcher;

@interface BranchMatcher : NSObject <ChainMatcher>

@property (strong, readonly) id <Matcher> subjectMatcher;
@property (strong, readonly) id <ChainMatcher> relativeMatcher;
@property (strong, readwrite) id <Combinator> subjectCombinator;
@property (strong, readonly) IdentityMatcher *subjectIdentityMatcher;

+ (BranchMatcher *)matcherWithSubjectMatcher:(id <Matcher>)subjectMatcher;

- (void)appendCombinator:(id <Combinator>)combinator matcher:(id <Matcher>)matcher;

@end
