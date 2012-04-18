#import "ChildCombinator.h"
#import "DescendantCombinator.h"
#import "CombinatorParser.h"
#import "QueryScanner.h"
@interface CombinatorParserTests : SenTestCase
@end

@implementation CombinatorParserTests {

}

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

- (void)testAllowsWhitespaceBeforeChildCombinator{
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

