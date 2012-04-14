#import "ViewFactory.h"
#import "SubjectMatcher.h"
#import "IdentityMatcher.h"
#import "IdentityCombinator.h"
#import "FalseMatcher.h"
#import "UniversalMatcher.h"
#import "MatchesView.h"

@interface IdentityCombinatorTests : SenTestCase
@end

@implementation IdentityCombinatorTests

- (void)testMatchesViewIfSubjectMatcherMatches {
    id <Combinator> combinator = [IdentityCombinator combinatorWithSubjectMatcher:[UniversalMatcher new]];

    assertThat(combinator, [MatchesView view:[ViewFactory view] inTree:nil]);
}

- (void)testMismatchesViewIfSubjectMatcherMismatches {
    id <Combinator> combinator = [IdentityCombinator combinatorWithSubjectMatcher:[FalseMatcher new]];

    assertThat(combinator, isNot([MatchesView view:[ViewFactory view] inTree:nil]));
}

@end