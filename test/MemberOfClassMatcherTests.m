#import "Matcher.h"
#import "MemberOfClassMatcher.h"
#import "ViewFactory.h"

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
    expect([memberOfUIButtonClassMatcher matchesView:button]).toBeTruthy();
}

- (void)testMismatchesAViewOfANonTargetClass {
    id memberOfUIButtonClassMatcher = [MemberOfClassMatcher forClass:[UIButton class]];
    UIView *view = [ViewFactory view];
    expect([memberOfUIButtonClassMatcher matchesView:view]).toBeFalsy();
}

- (void)testMismatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id memberOfUIViewClassMatcher = [MemberOfClassMatcher forClass:[UIView class]];
    UIButton *button = [ViewFactory button];
    expect([memberOfUIViewClassMatcher matchesView:button]).toBeFalsy();
}

@end
