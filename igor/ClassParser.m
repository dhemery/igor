#import "ClassMatcher.h"
#import "ClassParser.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "IgorQueryScanner.h"
#import "UniversalMatcher.h"

@implementation ClassParser

+ (void)parse:(IgorQueryScanner *)pattern intoArray:(NSMutableArray*) matchers {
    if ([pattern skipString:@"*"]) {
        [matchers addObject:[UniversalMatcher new]];
        return;
    }

    NSString *className;
    if (![pattern scanNameIntoString:&className]) {
        return;
    }

    Class targetClass = NSClassFromString(className);
    if ([pattern skipString:@"*"]) {
        [matchers addObject:[KindOfClassMatcher forClass:targetClass]];
    } else {
        [matchers addObject:[MemberOfClassMatcher forClass:targetClass]];
    }
}

@end
