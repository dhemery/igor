#import "KindOfClassMatcher.h"
#import "ViewFactory.h"
#import "MatchesView.h"

@interface KindOfClassMatcherTests : SenTestCase
@end

@implementation KindOfClassMatcherTests {
    CGRect frame;
}

- (void)setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

- (void)testMatchesAViewOfTheTargetClass {
    KindOfClassMatcher *kindOfUIButtonClassMatcher = [KindOfClassMatcher forClass:[UIButton class]];
    UIButton *button = [ViewFactory button];
    assertThat(kindOfUIButtonClassMatcher, [MatchesView view:button]);
}

- (void)testMismatchesAViewOfANonTargetClass {
    id kindOfUIButtonClassMatcher = [KindOfClassMatcher forClass:[UIButton class]];
    UIView *view = [ViewFactory view];
    assertThat(kindOfUIButtonClassMatcher, isNot([MatchesView view:view]));
}

- (void)testMatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id kindOfUIViewClassMatcher = [KindOfClassMatcher forClass:[UIView class]];
    UIButton *button = [ViewFactory button];
    assertThat(kindOfUIViewClassMatcher, [MatchesView view:button]);
}

@end
