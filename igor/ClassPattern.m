#import "ClassMatcher.h"
#import "ClassPattern.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "PatternScanner.h"

@implementation ClassPattern

+ (ClassPattern *)forScanner:(PatternScanner *)scanner {
    return (ClassPattern *) [[self alloc] initWithScanner:scanner];
}

- (ClassMatcher *)parse {
    Class targetClass = [UIView class];
    Class selectorClass = [KindOfClassMatcher class];

    NSString *className;
    if ([self.scanner scanNameIntoString:&className]) {
        targetClass = NSClassFromString(className);
        selectorClass = [MemberOfClassMatcher class];
    }
    if ([self.scanner skipString:@"*"]) {
        selectorClass = [KindOfClassMatcher class];
    }
    return [selectorClass forClass:targetClass];
}

@end
