#import "ClassMatcher.h"
#import "ClassParser.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "IgorQueryScanner.h"

@implementation ClassParser

+ (id<ClassMatcher>)parse:(IgorQueryScanner *)pattern {
    Class targetClass = [UIView class];
    Class selectorClass = [KindOfClassMatcher class];

    NSString *className;
    if ([pattern scanNameIntoString:&className]) {
        targetClass = NSClassFromString(className);
        selectorClass = [MemberOfClassMatcher class];
    }
    if ([pattern skipString:@"*"]) {
        selectorClass = [KindOfClassMatcher class];
    }
    return [selectorClass forClass:targetClass];
}

@end
