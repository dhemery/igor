#import "DEChainMatcher.h"

@protocol DEMatcher;
@protocol DECombinator;
@class DEIdentityMatcher;

@interface DEBranchMatcher : NSObject <DEChainMatcher>

@property (strong, readonly) id <DEMatcher> subjectMatcher;
@property (strong, readonly) id <DEChainMatcher> relativeMatcher;
@property (strong, readwrite) NSMutableArray *combinators;
@property (strong, readonly) DEIdentityMatcher *subjectIdentityMatcher;

+ (DEBranchMatcher *)matcherWithSubjectMatcher:(id <DEMatcher>)subjectMatcher;

- (void)appendCombinator:(id <DECombinator>)combinator matcher:(id <DEMatcher>)matcher;

@end
