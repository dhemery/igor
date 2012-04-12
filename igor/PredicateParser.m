#import "PredicateParser.h"
#import "PredicateMatcher.h"
#import "IgorQueryScanner.h"

@implementation PredicateParser

+ (void)addPredicateMatcherFromQuery:(id<IgorQueryScanner>)query toArray:(NSMutableArray *)matchers {
    if (![query skipString:@"["]) {
        return;
    }
    NSString *expression = [self parseExpressionFrom:query];
    if (![query skipString:@"]"]) {
        [query failBecause:@"Expected ]"];
    }
    [matchers addObject:[PredicateMatcher withPredicateExpression:expression]];
}

+ (NSString *)parseExpressionFrom:(id<IgorQueryScanner>)query {
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
