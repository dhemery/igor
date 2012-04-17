#import "PredicateParser.h"
#import "PredicateMatcher.h"
#import "QueryScanner.h"

@implementation PredicateParser

- (NSString *)parseExpressionFromScanner:(id <QueryScanner>)scanner {
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

- (id <Matcher>)parseMatcherFromScanner:(id <QueryScanner>)scanner {
    if (![scanner skipString:@"["]) {
        return nil;
    }
    NSString *expression = [self parseExpressionFromScanner:scanner];
    if (![scanner skipString:@"]"]) {
        [scanner failBecause:@"Expected ]"];
    }
    return [PredicateMatcher matcherForPredicateExpression:expression];
}

@end
