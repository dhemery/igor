#import "ClassParser.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "IgorQueryScanner.h"
#import "UniversalMatcher.h"


@implementation ClassParser {
    id <IgorQueryScanner> scanner;
}

- (id <SimplePatternParser>)initWithScanner:(id <IgorQueryScanner>)theScanner {
    self = [super init];
    if (self) {
        scanner = theScanner;
    }
    return self;
}

- (id <Matcher>)parseMatcher {
    NSString *className;

    if ([scanner skipString:@"*"]) return [UniversalMatcher new];

    if (![scanner scanNameIntoString:&className]) return nil;

    Class targetClass = NSClassFromString(className);

    if ([scanner skipString:@"*"]) return [KindOfClassMatcher matcherForBaseClass:targetClass];

    return [MemberOfClassMatcher matcherForExactClass:targetClass];
}

+ (id <SimplePatternParser>)parserWithScanner:(id <IgorQueryScanner>)scanner {
    return [[self alloc] initWithScanner:scanner];
}
@end
