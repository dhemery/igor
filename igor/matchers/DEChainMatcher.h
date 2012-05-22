#import "DEMatcher.h"

@protocol DECombinator;

@protocol DEChainMatcher <DEMatcher>

- (void)appendCombinator:(id <DECombinator>)combinator matcher:(id <DEMatcher>)matcher;

@end