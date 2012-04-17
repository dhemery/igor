#import "CombinatorParser.h"
#import "DescendantCombinatorParser.h"
#import "QueryScanner.h"
#import "DescendantCombinator.h"

// TODO Test
@implementation DescendantCombinatorParser {
    id <QueryScanner> scanner;
}

- (id <CombinatorParser>)initWithScanner:(id <QueryScanner>)theScanner {
    self = [super init];
    if (self) {
        scanner = theScanner;
    }
    return self;
}


- (id <Combinator>)parseCombinator {
    if ([scanner skipWhiteSpace]) return [DescendantCombinator new];
    return nil;
}

+ (id <CombinatorParser>)parserWithScanner:(id <QueryScanner>)scanner {
    return [[self alloc] initWithScanner:scanner];
}

@end