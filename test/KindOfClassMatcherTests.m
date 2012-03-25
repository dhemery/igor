#import "KindOfClassMatcher.h"
#import "ViewFactory.h"

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
    assertThatBool([kindOfUIButtonClassMatcher matchesView:button], equalToBool(YES));
}

- (void)testMismatchesAViewOfANonTargetClass {
    id kindOfUIButtonClassMatcher = [KindOfClassMatcher forClass:[UIButton class]];
    UIView *view = [ViewFactory view];
    assertThatBool([kindOfUIButtonClassMatcher matchesView:view], equalToBool(NO));
}

- (void)testMatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id kindOfUIViewClassMatcher = [KindOfClassMatcher forClass:[UIView class]];
    UIButton *button = [ViewFactory button];
    assertThatBool([kindOfUIViewClassMatcher matchesView:button], equalToBool(YES));
}

@end
