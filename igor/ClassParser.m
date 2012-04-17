#import "ClassParser.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "QueryScanner.h"
#import "UniversalMatcher.h"

@implementation ClassParser

- (id <Matcher>)parseMatcherFromScanner:(id <QueryScanner>)scanner {
    NSString *className;

    if ([scanner skipString:@"*"]) return [UniversalMatcher new];

    if (![scanner scanNameIntoString:&className]) return nil;

    Class targetClass = NSClassFromString(className);

    if ([scanner skipString:@"*"]) return [KindOfClassMatcher matcherForBaseClass:targetClass];

    return [MemberOfClassMatcher matcherForExactClass:targetClass];
}

@end
