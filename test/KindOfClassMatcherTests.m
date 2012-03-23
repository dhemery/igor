
#import "KindOfClassMatcher.h"
#import "ViewFactory.h"

@interface KindOfClassMatcherTests : SenTestCase
@end

@implementation KindOfClassMatcherTests {
    CGRect frame;
}

-(void) setUp {
    frame = CGRectMake(0, 0, 100, 100);
}

-(void) testMatchesAViewOfTheTargetClass {
    KindOfClassMatcher* kindOfUIButtonClassMatcher = [KindOfClassMatcher forClass:[UIButton class]];
    UIButton* button = [ViewFactory button];
    expect([kindOfUIButtonClassMatcher matchesView:button]).toBeTruthy();
}

- (void)testMismatchesAViewOfANonTargetClass {
    id kindOfUIButtonClassMatcher = [KindOfClassMatcher forClass:[UIButton class]];
    UIView* view = [ViewFactory view];
    expect([kindOfUIButtonClassMatcher matchesView:view]).toBeFalsy();
}

- (void)testMatchesAViewOfAClassThatInheritsFromTheTargetClass {
    id kindOfUIViewClassMatcher = [KindOfClassMatcher forClass:[UIView class]];
    UIButton* button = [ViewFactory button];
    expect([kindOfUIViewClassMatcher matchesView:button]).toBeTruthy();
}

@end
