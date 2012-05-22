#import "DEChainMatcher.h"

@protocol DECombinator;

@interface DECombinatorMatcher : NSObject <DEChainMatcher>

@property (strong) id <DEMatcher> subjectMatcher;
@property (strong) id <DECombinator> combinator;
@property (strong) id <DEMatcher> relativeMatcher;

+ (id <DEChainMatcher>)matcherWithSubjectMatcher:(id <DEMatcher>)matcher;

@end
