#import "DECombinatorParser.h"
#import "DEQueryScanner.h"
#import "DEDescendantCombinator.h"
#import "DEChildCombinator.h"
#import "DESiblingCombinator.h"

// TODO Test
@implementation DECombinatorParser

- (id <DECombinator>)parseCombinatorFromScanner:(id <DEQueryScanner>)scanner {
    Class combinatorClass;

    if ([scanner skipWhiteSpace]) {
        combinatorClass = [DEDescendantCombinator class];
    }
    if ([scanner skipString:@">"]) {
        combinatorClass = [DEChildCombinator class];
    } else if ([scanner skipString:@"~"]) {
        combinatorClass = [DESiblingCombinator class];
    }
    [scanner skipWhiteSpace];
    return [combinatorClass new];
}

@end
