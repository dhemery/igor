#import "IgorParserException.h"
#import "PredicatePattern.h"
#import "PredicateMatcher.h"

@implementation PredicatePattern

- (PredicateMatcher *)parse:(NSScanner *)scanner {
    if (![scanner scanString:@"[" intoString:nil]) {
        return [PredicateMatcher withPredicateExpression:@"TRUEPREDICATE"];
    }
    NSString *expression = [NSString string];
    if (![scanner scanUpToString:@"]" intoString:&expression]) {
        @throw [IgorParserException exceptionWithReason:@"Expected predicate" scanner:scanner];
    }
    if (![scanner scanString:@"]" intoString:nil]) {
        @throw [IgorParserException exceptionWithReason:@"Expected ]" scanner:scanner];
    }
    return [PredicateMatcher withPredicateExpression:expression];
}

@end
