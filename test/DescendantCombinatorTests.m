#import "ViewFactory.h"
#import "Combinator.h"
#import "UniversalMatcher.h"
#import "DescendantCombinator.h"
#import "MatchesView.h"
#import "FalseMatcher.h"
#import "IdentityMatcher.h"

@interface DescendantCombinatorTests : SenTestCase
@end

@implementation DescendantCombinatorTests {
    UIView *subject;
    UIView *parent;
    UIView *grandParent;
    UIView *greatGrandParent;
    UIView *greatGreatGrandParent;
    UIView *greatGreatGreatGrandParent;
}

- (void)setUp {
    subject = [ViewFactory view];
    parent = [ViewFactory view];
    grandParent = [ViewFactory view];
    greatGrandParent = [ViewFactory view];
    greatGreatGrandParent = [ViewFactory view];
    greatGreatGreatGrandParent = [ViewFactory view];
    [parent addSubview:subject];
    [grandParent addSubview:parent];
    [greatGrandParent addSubview:grandParent];
    [greatGreatGrandParent addSubview:greatGrandParent];
    [greatGreatGreatGrandParent addSubview:greatGreatGrandParent];
}

- (void)testMatchesIfViewMatchesSubjectMatcherAndAncestorMatchesRelativeMatcher {
    id <SubjectMatcher> grandParentMatcher = [IdentityMatcher forView:grandParent];
    id <Combinator> combinator = [DescendantCombinator combinatorWithSubjectMatcher:[UniversalMatcher new]
                                                                    relativeMatcher:grandParentMatcher];

    assertThat(combinator, [MatchesView view:subject inTree:greatGreatGreatGrandParent]);
}

- (void)testSearchesToRootForMatchingAncestor {
    IdentityMatcher *greatGreatGreatGrandParentMatcher = [IdentityMatcher forView:greatGreatGreatGrandParent];
    id <Combinator> combinator = [DescendantCombinator combinatorWithSubjectMatcher:[UniversalMatcher new]
                                                                    relativeMatcher:greatGreatGreatGrandParentMatcher];

    assertThat(combinator, [MatchesView view:subject inTree:greatGreatGreatGrandParent]);
}

- (void)testMismatchesIfViewMismatchesSubjectMatcher {

    id <Combinator> combinator = [DescendantCombinator combinatorWithSubjectMatcher:[FalseMatcher new]
                                                                    relativeMatcher:[UniversalMatcher new]];

    assertThat(combinator, isNot([MatchesView view:subject inTree:greatGreatGreatGrandParent]));
}

- (void)testMismatchesIfViewMatchesSubjectMatcherAndNoAncestorMatchesRelativeMatcher {

    id <Combinator> combinator = [DescendantCombinator combinatorWithSubjectMatcher:[UniversalMatcher new]
                                                                    relativeMatcher:[FalseMatcher new]];

    assertThat(combinator, isNot([MatchesView view:subject inTree:greatGreatGreatGrandParent]));
}

- (void)testMismatchesIfMatchingAncestorIsAboveTree {

    id <Combinator> combinator = [DescendantCombinator combinatorWithSubjectMatcher:[UniversalMatcher new]
                                                                    relativeMatcher:[IdentityMatcher forView:greatGreatGreatGrandParent]];

    assertThat(combinator, isNot([MatchesView view:subject inTree:grandParent]));
}

@end


