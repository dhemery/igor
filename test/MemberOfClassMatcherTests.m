#import "SimpleMatcher.h"
#import "MemberOfClassMatcher.h"
#import "ViewFactory.h"
#import "MatchesView.h"

@interface MemberOfClassMatcherTests : SenTestCase
@end

@implementation MemberOfClassMatcherTests

- (void)testMatchesAViewOfTheTargetClass {
    id<SimpleMatcher> memberOfButtonMatcher = [MemberOfClassMatcher forClass:[UIButton class]];
    UIButton *classIsExactlyButton = [ViewFactory button];

    assertThat(memberOfButtonMatcher, [MatchesView view:classIsExactlyButton]);
}

- (void)testMismatchesAViewOfANonTargetClass {
    id<SimpleMatcher> memberOfButtonMatcher = [MemberOfClassMatcher forClass:[UIButton class]];
    UIView *classIsNotButtonOrSubclass = [ViewFactory view];

    assertThat(memberOfButtonMatcher, isNot([MatchesView view:classIsNotButtonOrSubclass]));
}

- (void)testMismatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id<SimpleMatcher> memberOfViewMatcher = [MemberOfClassMatcher forClass:[UIView class]];
    UIButton *classIsSubclassOfView = [ViewFactory button];

    assertThat(memberOfViewMatcher, isNot([MatchesView view:classIsSubclassOfView]));
}

@end
