#import "SimpleMatcher.h"
#import "MemberOfClassMatcher.h"
#import "ViewFactory.h"
#import "MatchesView.h"

@interface MemberOfClassMatcherTests : SenTestCase
@end

@implementation MemberOfClassMatcherTests {
    CGRect frame;
}

- (void)setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

- (void)testMatchesAViewOfTheTargetClass {
    id memberOfUIButtonClassMatcher = [MemberOfClassMatcher forClass:[UIButton class]];
    UIButton *button = [ViewFactory button];

    assertThat(memberOfUIButtonClassMatcher, [MatchesView view:button]);
}

- (void)testMismatchesAViewOfANonTargetClass {
    id memberOfUIButtonClassMatcher = [MemberOfClassMatcher forClass:[UIButton class]];
    UIView *notAButton = [ViewFactory view];
    assertThat(memberOfUIButtonClassMatcher, isNot([MatchesView view:notAButton]));
}

- (void)testMismatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id memberOfUIViewClassMatcher = [MemberOfClassMatcher forClass:[UIView class]];
    UIButton *button = [ViewFactory button];
    assertThat(memberOfUIViewClassMatcher, isNot([MatchesView view:button]));
}

@end
