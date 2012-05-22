#import "DEClassParser.h"
#import "DEKindOfClassMatcher.h"
#import "DEMemberOfClassMatcher.h"
#import "DEQueryScanner.h"
#import "DEUniversalMatcher.h"

@implementation DEClassParser

- (id <DEMatcher>)parseMatcherFromScanner:(id <DEQueryScanner>)scanner {
    NSString *className;

    if ([scanner skipString:@"*"]) return [DEUniversalMatcher new];

    if (![scanner scanNameIntoString:&className]) return nil;

    Class targetClass = NSClassFromString(className);

    if ([scanner skipString:@"*"]) return [DEKindOfClassMatcher matcherForBaseClass:targetClass];

    return [DEMemberOfClassMatcher matcherForExactClass:targetClass];
}

@end
