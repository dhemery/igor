#import "PredicateParser.h"
#import "PredicateMatcher.h"
#import "IgorQueryScanner.h"

@implementation PredicateParser {
    id <IgorQueryScanner> scanner;
}

- (id<SimplePatternParser>)initWithScanner:(id <IgorQueryScanner>)theScanner {
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

- (void)parseSimpleMatcherIntoArray:(NSMutableArray *)matchers {
    if (![scanner skipString:@"["]) {
        return;
    }
    NSString *expression = [self parseExpression];
    if (![scanner skipString:@"]"]) {
        [scanner failBecause:@"Expected ]"];
    }
    [matchers addObject:[PredicateMatcher matcherForPredicateExpression:expression]];
}

+ (id<SimplePatternParser>)parserWithScanner:(id<IgorQueryScanner>)scanner {
    return [[self alloc] initWithScanner:scanner];
}

@end
