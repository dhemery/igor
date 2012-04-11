#import "KindOfClassMatcher.h"
#import "ViewFactory.h"
#import "MatchesView.h"

@interface KindOfClassMatcherTests : SenTestCase
@end

@implementation KindOfClassMatcherTests

- (void)testMatchesAViewOfTheTargetClass {
    id<SimpleMatcher> kindOfButtonMatcher = [KindOfClassMatcher forBaseClass:[UIButton class]];
    UIButton *classIsExactlyButton = [ViewFactory button];

    assertThat(kindOfButtonMatcher, [MatchesView view:classIsExactlyButton]);
}

- (void)testMismatchesAViewOfANonTargetClass {
    id<SimpleMatcher> kindOfButtonMatcher = [KindOfClassMatcher forBaseClass:[UIButton class]];
    UIView *classIsNotButtonOrSubclass = [ViewFactory view];

    assertThat(kindOfButtonMatcher, isNot([MatchesView view:classIsNotButtonOrSubclass]));
}

- (void)testMatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id<SimpleMatcher> kindOfViewMatcher = [KindOfClassMatcher forBaseClass:[UIView class]];
    UIButton *classIsSubclassOfView = [ViewFactory button];

    assertThat(kindOfViewMatcher, [MatchesView view:classIsSubclassOfView]);
}

@end
