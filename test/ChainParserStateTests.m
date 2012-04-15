#import "ChainParserState.h"
#import "UniversalMatcher.h"
#import "DescendantCombinator.h"

@interface ChainParserStateTests : SenTestCase
@end

@implementation ChainParserStateTests

- (void)testIsStartedIfHasMatcher {
    ChainParserState *state = [ChainParserState stateWithMatcher:[UniversalMatcher new] combinator:nil];

    assertThatBool(state.started, equalToBool(YES));
}

- (void)testIsDoneIfIsStartedAndHasNoCombinator {
    ChainParserState *state = [ChainParserState stateWithMatcher:[UniversalMatcher new] combinator:nil];

    assertThatBool(state.done, equalToBool(YES));
}

- (void)testIsNotDoneIfIsStartedAndHasCombinator {
    ChainParserState *state = [ChainParserState stateWithMatcher:[UniversalMatcher new] combinator:[DescendantCombinator new]];

    assertThatBool(state.done, equalToBool(NO));
}
@end
