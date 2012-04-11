#import "ClassParser.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "IgorQueryScanner.h"
#import "UniversalMatcher.h"

@implementation ClassParser

+ (void)addClassMatcherFromQuery:(IgorQueryScanner *)query toArray:(NSMutableArray*)array {
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

@end
