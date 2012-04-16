#import "MemberOfClassMatcher.h"
#import "ViewFactory.h"
#import "MatchesView.h"

@interface MemberOfClassMatcherTests : SenTestCase
@end

@implementation MemberOfClassMatcherTests

- (void)testMatchesAViewOfTheTargetClass {
    id <Matcher> memberOfButtonMatcher = [MemberOfClassMatcher matcherForExactClass:[UIButton class]];
    UIButton *classIsExactlyButton = [ViewFactory button];

    assertThat(memberOfButtonMatcher, [MatchesView view:classIsExactlyButton]);
}

- (void)testMismatchesAViewOfANonTargetClass {
    id <Matcher> memberOfButtonMatcher = [MemberOfClassMatcher matcherForExactClass:[UIButton class]];
    UIView *classIsNotButtonOrSubclass = [ViewFactory view];

    assertThat(memberOfButtonMatcher, isNot([MatchesView view:classIsNotButtonOrSubclass]));
}

- (void)testMismatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id <Matcher> memberOfViewMatcher = [MemberOfClassMatcher matcherForExactClass:[UIView class]];
    UIButton *classIsSubclassOfView = [ViewFactory button];

    assertThat(memberOfViewMatcher, isNot([MatchesView view:classIsSubclassOfView]));
}

@end
