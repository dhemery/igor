#import "DEKindOfClassMatcher.h"
#import "ViewFactory.h"
#import "MatchesView.h"

@interface KindOfClassMatcherTests : SenTestCase
@end

@implementation KindOfClassMatcherTests

- (void)testMatchesAViewOfTheTargetClass {
    id <DEMatcher> kindOfButtonMatcher = [DEKindOfClassMatcher matcherForBaseClass:[ViewFactory classForButton]];
    id classIsExactlyButton = [ViewFactory button];

    assertThat(kindOfButtonMatcher, [MatchesView view:classIsExactlyButton]);
}

- (void)testMismatchesAViewOfANonTargetClass {
    id <DEMatcher> kindOfButtonMatcher = [DEKindOfClassMatcher matcherForBaseClass:[ViewFactory classForButton]];
    id classIsNotButtonOrSubclass = [ViewFactory view];

    assertThat(kindOfButtonMatcher, isNot([MatchesView view:classIsNotButtonOrSubclass]));
}

- (void)testMatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id <DEMatcher> kindOfViewMatcher = [DEKindOfClassMatcher matcherForBaseClass:[ViewFactory classForView]];
    id classIsSubclassOfView = [ViewFactory button];

    assertThat(kindOfViewMatcher, [MatchesView view:classIsSubclassOfView]);
}

@end
