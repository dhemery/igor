#import "CombinatorParser.h"
#import "DescendantCombinatorParser.h"
#import "IgorQueryScanner.h"
#import "DescendantCombinator.h"

@implementation DescendantCombinatorParser {
    id <IgorQueryScanner> scanner;
}


- (id <CombinatorParser>)initWithScanner:(id <IgorQueryScanner>)theScanner {
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

+ (id <CombinatorParser>)parserWithScanner:(id <IgorQueryScanner>)scanner {
    return [[self alloc] initWithScanner:scanner];
}

@end