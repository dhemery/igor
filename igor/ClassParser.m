#import "ClassParser.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "IgorQueryScanner.h"
#import "UniversalMatcher.h"

@implementation ClassParser

- (void)parseClassMatcherFromQuery:(id<IgorQueryScanner>)query intoArray:(NSMutableArray*)array {
    if ([query skipString:@"*"]) {
        [array addObject:[UniversalMatcher new]];
        return;
    }

    NSString *className;
    if (![query scanNameIntoString:&className]) {
        return;
    }

    Class targetClass = NSClassFromString(className);
    if ([query skipString:@"*"]) {
        [array addObject:[KindOfClassMatcher forBaseClass:targetClass]];
    } else {
        [array addObject:[MemberOfClassMatcher forExactClass:targetClass]];
    }
}

+ (ClassParser*)parser {
    return [self new];
}
@end
