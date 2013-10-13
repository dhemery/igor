#import "DEChildCombinator.h"
#import "DEDescendantCombinator.h"
#import "DECombinatorParser.h"
#import "DEQueryScanner.h"
#import "DESiblingCombinator.h"

@interface CombinatorParserTests : XCTestCase
@end

@implementation CombinatorParserTests

- (void)testParsesWhitespaceAsDescendantCombinator {
    id <DECombinatorParser> parser = [DECombinatorParser new];
    id <DEQueryScanner> scanner = [DEQueryScanner scannerWithString:@"                 "];

    id <DECombinator> combinator = [parser parseCombinatorFromScanner:scanner];

    assertThat(combinator, instanceOf([DEDescendantCombinator class]));
}

- (void)testParsesGreaterThanSignAsChildCombinator {
    id <DECombinatorParser> parser = [DECombinatorParser new];
    id <DEQueryScanner> scanner = [DEQueryScanner scannerWithString:@">"];

    id <DECombinator> combinator = [parser parseCombinatorFromScanner:scanner];

    assertThat(combinator, instanceOf([DEChildCombinator class]));
}

- (void)testParsesTildeAsSiblingCombinator {
    id <DECombinatorParser> parser = [DECombinatorParser new];
    id <DEQueryScanner> scanner = [DEQueryScanner scannerWithString:@"~"];

    id <DECombinator> combinator = [parser parseCombinatorFromScanner:scanner];

    assertThat(combinator, instanceOf([DESiblingCombinator class]));
}

- (void)testAllowsWhitespaceBeforeCombinator{
    id <DECombinatorParser> parser = [DECombinatorParser new];
    id <DEQueryScanner> scanner = [DEQueryScanner scannerWithString:@"           >"];

    id <DECombinator> combinator = [parser parseCombinatorFromScanner:scanner];

    assertThat(combinator, instanceOf([DEChildCombinator class]));
}

- (void)testConsumesWhitespaceAfterCombinator {
    id <DECombinatorParser> parser = [DECombinatorParser new];
    id <DEQueryScanner> scanner = [DEQueryScanner scannerWithString:@">                   !"];

    [parser parseCombinatorFromScanner:scanner];

    BOOL consumedWhitespace = [scanner skipString:@"!"]; // Next character is !
    assertThatBool(consumedWhitespace, equalToBool(YES));
}

@end

