
#import "PredicatePattern.h"
#import "PredicateMatcher.h"
#import "PatternScanner.h"

@implementation PredicatePattern

+ (PredicatePattern *)forScanner:(PatternScanner *)scanner {
    return (PredicatePattern *)[[self alloc] initWithScanner:scanner];
}

- (PredicateMatcher *)parse {
    if (![self.scanner skipString:@"["]) {
        return [PredicateMatcher withPredicateExpression:@"TRUEPREDICATE"];
    }
    NSString *expression = [NSString string];
    if (![self.scanner scanUpToString:@"]" intoString:&expression]) {
        [self.scanner failBecause:@"Expected predicate"];
    }
    if (![self.scanner skipString:@"]"]) {
        [self.scanner failBecause:@"Expected ]"];
    }
    return [PredicateMatcher withPredicateExpression:expression];
}

@end
