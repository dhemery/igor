#import "Matcher.h"

@protocol Combinator;

@protocol ChainMatcher <Matcher>

- (void)appendCombinator:(id <Combinator>)combinator matcher:(id <Matcher>)matcher;

@end