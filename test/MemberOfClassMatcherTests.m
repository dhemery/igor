#import "SimpleMatcher.h"
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
    assertThatBool([memberOfUIButtonClassMatcher matchesView:button], equalToBool(YES));
}

- (void)testMismatchesAViewOfANonTargetClass {
    id memberOfUIButtonClassMatcher = [MemberOfClassMatcher forClass:[UIButton class]];
    UIView *view = [ViewFactory view];
    assertThatBool([memberOfUIButtonClassMatcher matchesView:view], equalToBool(NO));
}

- (void)testMismatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id memberOfUIViewClassMatcher = [MemberOfClassMatcher forClass:[UIView class]];
    UIButton *button = [ViewFactory button];
    assertThatBool([memberOfUIViewClassMatcher matchesView:button], equalToBool(NO));
}

@end
