#import "DEMemberOfClassMatcher.h"
#import "ViewFactory.h"
#import "MatchesView.h"

@interface MemberOfClassMatcherTests : SenTestCase
@end

@implementation MemberOfClassMatcherTests

- (void)testMatchesAViewOfTheTargetClass {
    id <DEMatcher> memberOfButtonMatcher = [DEMemberOfClassMatcher matcherForExactClass:[UIButton class]];
    UIButton *classIsExactlyButton = [ViewFactory button];

    assertThat(memberOfButtonMatcher, [MatchesView view:classIsExactlyButton]);
}

- (void)testMismatchesAViewOfANonTargetClass {
    id <DEMatcher> memberOfButtonMatcher = [DEMemberOfClassMatcher matcherForExactClass:[UIButton class]];
    UIView *classIsNotButtonOrSubclass = [ViewFactory view];

    assertThat(memberOfButtonMatcher, isNot([MatchesView view:classIsNotButtonOrSubclass]));
}

- (void)testMismatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id <DEMatcher> memberOfViewMatcher = [DEMemberOfClassMatcher matcherForExactClass:[UIView class]];
    UIButton *classIsSubclassOfView = [ViewFactory button];

    assertThat(memberOfViewMatcher, isNot([MatchesView view:classIsSubclassOfView]));
}

@end
