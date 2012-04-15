#import "SubjectChain.h"
#import "UniversalMatcher.h"
#import "DescendantCombinator.h"

@interface SubjectChainTests : SenTestCase
@end

@implementation SubjectChainTests

- (void)testIsStartedIfHasMatcher {
    SubjectChain *chain = [SubjectChain stateWithMatcher:[UniversalMatcher new] combinator:nil];

    assertThatBool(chain.started, equalToBool(YES));
}

- (void)testIsDoneIfIsStartedAndHasNoCombinator {
    SubjectChain *chain = [SubjectChain stateWithMatcher:[UniversalMatcher new] combinator:nil];

    assertThatBool(chain.done, equalToBool(YES));
}

- (void)testIsNotDoneIfIsStartedAndHasCombinator {
    SubjectChain *chain = [SubjectChain stateWithMatcher:[UniversalMatcher new] combinator:[DescendantCombinator new]];

    assertThatBool(chain.done, equalToBool(NO));
}
@end
