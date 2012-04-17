#import "CombinatorParser.h"
#import "DescendantCombinatorParser.h"
#import "QueryScanner.h"
#import "DescendantCombinator.h"

// TODO Test
@implementation DescendantCombinatorParser

- (id <Combinator>)parseCombinatorFromScanner:(id <QueryScanner>)scanner {
    if ([scanner skipWhiteSpace]) return [DescendantCombinator new];
    return nil;
}

@end