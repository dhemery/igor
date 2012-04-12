#import "ScanningPredicateParser.h"
#import "PredicateMatcher.h"
#import "IgorQueryScanner.h"

@implementation ScanningPredicateParser {
    id <IgorQueryScanner> scanner;
}

- (id<PredicateParser>)initWithScanner:(id <IgorQueryScanner>)theScanner {
    if (self = [super init]) {
        scanner = theScanner;
    }
    return self;
}

- (NSString *)parseExpression {
    NSString *expression = @"";
    NSString *chunk;
    while([scanner scanUpToString:@"]" intoString:&chunk]) {
        expression = [expression stringByAppendingString:chunk];
        @try {
            [NSPredicate predicateWithFormat:expression];
            return expression;
        }
        @catch (NSException *e) {
        }
        while([scanner skipString:@"]"]) {
            expression = [expression stringByAppendingString:@"]"];
        }
    }
    [scanner failBecause:@"Expected predicate"];
    return nil;
}

- (void)parsePredicateMatcherIntoArray:(NSMutableArray *)matchers {
    if (![scanner skipString:@"["]) {
        return;
    }
    NSString *expression = [self parseExpression];
    if (![scanner skipString:@"]"]) {
        [scanner failBecause:@"Expected ]"];
    }
    [matchers addObject:[PredicateMatcher matcherForPredicateExpression:expression]];
}

+ (id<PredicateParser>)parserWithScanner:(id<IgorQueryScanner>)scanner {
    return [[self alloc] initWithScanner:scanner];
}

@end
