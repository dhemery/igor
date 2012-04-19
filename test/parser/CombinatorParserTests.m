#import "ChildCombinator.h"
#import "DescendantCombinator.h"
#import "CombinatorParser.h"
#import "QueryScanner.h"
#import "SiblingCombinator.h"

@interface CombinatorParserTests : SenTestCase
@end

@implementation CombinatorParserTests

- (void)testParsesWhitespaceAsDescendantCombinator {
    id <CombinatorParser> parser = [CombinatorParser new];
    id <QueryScanner> scanner = [QueryScanner scannerWithString:@"                 "];

    id <Combinator> combinator = [parser parseCombinatorFromScanner:scanner];

    assertThat(combinator, instanceOf([DescendantCombinator class]));
}

- (void)testParsesGreaterThanSignAsChildCombinator {
    id <CombinatorParser> parser = [CombinatorParser new];
    id <QueryScanner> scanner = [QueryScanner scannerWithString:@">"];

    id <Combinator> combinator = [parser parseCombinatorFromScanner:scanner];

    assertThat(combinator, instanceOf([ChildCombinator class]));
}

- (void)testParsesTildeAsSiblingCombinator {
    id <CombinatorParser> parser = [CombinatorParser new];
    id <QueryScanner> scanner = [QueryScanner scannerWithString:@"~"];

    id <Combinator> combinator = [parser parseCombinatorFromScanner:scanner];

    assertThat(combinator, instanceOf([SiblingCombinator class]));
}

- (void)testAllowsWhitespaceBeforeCombinator{
    id <CombinatorParser> parser = [CombinatorParser new];
    id <QueryScanner> scanner = [QueryScanner scannerWithString:@"           >"];

    id <Combinator> combinator = [parser parseCombinatorFromScanner:scanner];

    assertThat(combinator, instanceOf([ChildCombinator class]));
}

- (void)testConsumesWhitespaceAfterCombinator {
    id <CombinatorParser> parser = [CombinatorParser new];
    id <QueryScanner> scanner = [QueryScanner scannerWithString:@">                   !"];

    [parser parseCombinatorFromScanner:scanner];

    BOOL consumedWhitespace = [scanner skipString:@"!"]; // Next character is !
    assertThatBool(consumedWhitespace, equalToBool(YES));
}

@end

