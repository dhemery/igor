#import "PredicateParser.h"
#import "PredicateMatcher.h"
#import "IgorQueryScanner.h"

@implementation PredicateParser

+ (PredicateMatcher *)parse:(IgorQueryScanner *)query {
    if (![query skipString:@"["]) {
        return [PredicateMatcher withPredicateExpression:@"TRUEPREDICATE"];
    }
    NSString *expression = [self parseExpressionFrom:query];
    if (![query skipString:@"]"]) {
        [query failBecause:@"Expected ]"];
    }
    return [PredicateMatcher withPredicateExpression:expression];
}

+ (NSString *)parseExpressionFrom:(IgorQueryScanner *)query {
    NSString *expression = @"";
    NSString *chunk;
    while([query scanUpToString:@"]" intoString:&chunk]) {
        expression = [expression stringByAppendingString:chunk];
        @try {
            [NSPredicate predicateWithFormat:expression];
            return expression;
        }
        @catch (NSException *e) {
        }
        while([query skipString:@"]"]) {
            expression = [expression stringByAppendingString:@"]"];
        }
    }
    [query failBecause:@"Expected predicate"];
    return nil;
}

@end
