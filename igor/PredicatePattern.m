#import "IgorParserException.h"
#import "PredicatePattern.h"
#import "PredicateMatcher.h"

@implementation PredicatePattern

+ (PredicatePattern *)forScanner:(NSScanner *)scanner {
    return (PredicatePattern *)[[self alloc] initWithScanner:scanner];
}

- (PredicateMatcher *)parse {
    if (![self.scanner scanString:@"[" intoString:nil]) {
        return [PredicateMatcher withPredicateExpression:@"TRUEPREDICATE"];
    }
    NSString *expression = [NSString string];
    if (![self.scanner scanUpToString:@"]" intoString:&expression]) {
        @throw [IgorParserException exceptionWithReason:@"Expected predicate" scanner:self.scanner];
    }
    if (![self.scanner scanString:@"]" intoString:nil]) {
        @throw [IgorParserException exceptionWithReason:@"Expected ]" scanner:self.scanner];
    }
    return [PredicateMatcher withPredicateExpression:expression];
}

@end
