#import "ClassMatcher.h"
#import "ClassPattern.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"

@implementation ClassPattern

+ (ClassPattern *)forScanner:(NSScanner *)scanner {
    return (ClassPattern *) [[self alloc] initWithScanner:scanner];
}

- (ClassMatcher *)parse {
    Class targetClass = [UIView class];
    Class selectorClass = [KindOfClassMatcher class];

    NSString *className;
    if ([self.scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:&className]) {
        targetClass = NSClassFromString(className);
        selectorClass = [MemberOfClassMatcher class];
    }
    if ([self.scanner scanString:@"*" intoString:nil]) {
        selectorClass = [KindOfClassMatcher class];
    }
    return [selectorClass forClass:targetClass];
}

@end
