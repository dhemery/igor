#import "PredicatePattern.h"
#import "PredicateMatcher.h"
#import "PatternScanner.h"

@implementation PredicatePattern

+ (PredicatePattern *)forScanner:(PatternScanner *)scanner {
    return (PredicatePattern *) [[self alloc] initWithScanner:scanner];
}

- (PredicateMatcher *)parse {
    if (![self.scanner skipString:@"["]) {
        return [PredicateMatcher withPredicateExpression:@"TRUEPREDICATE"];
    }
    NSString *expression = [self parseExpression];
    if (![self.scanner skipString:@"]"]) {
        [self.scanner failBecause:@"Expected ]"];
    }
    return [PredicateMatcher withPredicateExpression:expression];
}

- (NSString *)parseExpression {
    NSString *expression = @"";
    NSString *chunk;
    while([self.scanner scanUpToString:@"]" intoString:&chunk]) {
        expression = [expression stringByAppendingString:chunk];
        @try {
            [NSPredicate predicateWithFormat:expression];
            return expression;
        }
        @catch (NSException *e) {
        }
        while([self.scanner skipString:@"]"]) {
            expression = [expression stringByAppendingString:@"]"];
        }
    }
    [self.scanner failBecause:@"Expected predicate"];
    return nil;
}

@end
