#import "FakeCombinatorParser.h"

@implementation FakeCombinatorParser

+ (FakeCombinatorParser *)parserThatYieldsNoCombinators {
    return [FakeCombinatorParser new];
}

- (id <Combinator>)parseCombinator {
    return nil;
}


@end