#import "ChainStep.h"
#import "ChainMatcher.h"
@implementation ChainStep

@synthesize combinator = _combinator;
@synthesize matcher = _matcher;

- (NSString *)description {
    return [NSString stringWithFormat:@"{%@} {%@}", self.matcher, self.combinator];
}

- (ChainStep *)initWithCombinator:(id <Combinator>)combinator matcher:(id <Matcher>)matcher {
    self = [super init];
    if (self) {
        _combinator = combinator;
        _matcher = matcher;
    }
    return self;
}

+ (ChainStep *)stepWithCombinator:(id <Combinator>)combinator matcher:(id <Matcher>)matcher {
    return [[self alloc] initWithCombinator:combinator matcher:matcher];
}
@end