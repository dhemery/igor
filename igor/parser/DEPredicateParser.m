#import "DEPredicateParser.h"
#import "DEPredicateMatcher.h"
#import "DEQueryScanner.h"

@implementation DEPredicateParser

- (NSString *)parseExpressionFromScanner:(id <DEQueryScanner>)scanner {
    NSString *expression = @"";
    NSString *chunk;
    while ([scanner scanUpToString:@"]" intoString:&chunk]) {
        expression = [expression stringByAppendingString:chunk];
        @try {
            [NSPredicate predicateWithFormat:expression];
            return expression;
        }
        @catch (NSException *e) {
        }
        while ([scanner skipString:@"]"]) {
            expression = [expression stringByAppendingString:@"]"];
        }
    }
    [scanner failBecause:@"Expected predicate"];
    return nil;
}

- (id <DEMatcher>)parseMatcherFromScanner:(id <DEQueryScanner>)scanner {
    if (![scanner skipString:@"["]) {
        return nil;
    }
    NSString *expression = [self parseExpressionFromScanner:scanner];
    if (![scanner skipString:@"]"]) {
        [scanner failBecause:@"Expected ]"];
    }
    return [DEPredicateMatcher matcherForPredicateExpression:expression];
}

@end
