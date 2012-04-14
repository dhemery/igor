#import "FakeCombinatorParser.h"

@implementation FakeCombinatorParser {
    NSArray *combinators;
    NSUInteger index;
}

- (FakeCombinatorParser *)initWithCombinators:(NSArray *)theCombinators {
    self = [super init];
    if (self) {
        combinators = [NSArray arrayWithArray:theCombinators];
        index = 0;
    }
    return self;
}

+ (FakeCombinatorParser *)parserThatYieldsNoCombinators {
    return [FakeCombinatorParser new];
}

+ (id)parserThatYieldsCombinator:(id <Combinator>)combinator {
    return [[self alloc] initWithCombinators:[NSArray arrayWithObject:combinator]];
}

- (id <Combinator>)parseCombinator {
    if (index < [combinators count]) {
        return [combinators objectAtIndex:index++];
    }
    return nil;
}

@end