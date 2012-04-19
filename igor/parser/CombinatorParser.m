#import "CombinatorParser.h"
#import "QueryScanner.h"
#import "DescendantCombinator.h"
#import "ChildCombinator.h"
#import "SiblingCombinator.h"

// TODO Test
@implementation CombinatorParser

- (id <Combinator>)parseCombinatorFromScanner:(id <QueryScanner>)scanner {
    Class combinatorClass;

    if ([scanner skipWhiteSpace]) {
        combinatorClass = [DescendantCombinator class];
    }
    if ([scanner skipString:@">"]) {
        combinatorClass = [ChildCombinator class];
    } else if ([scanner skipString:@"~"]) {
        combinatorClass = [SiblingCombinator class];
    }
    [scanner skipWhiteSpace];
    return [combinatorClass new];
}

@end
