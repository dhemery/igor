#import "ClassParser.h"
#import "KindOfClassMatcher.h"
#import "MemberOfClassMatcher.h"
#import "IgorQueryScanner.h"
#import "UniversalMatcher.h"


@implementation ClassParser {
    id <IgorQueryScanner> scanner;
}

- (id<SimplePatternParser>)initWithScanner:(id <IgorQueryScanner>)theScanner {
    if (self = [super init]) {
        scanner = theScanner;
    }
    return self;
}

- (void)parseSimpleMatcherIntoArray:(NSMutableArray*)array {
    if ([scanner skipString:@"*"]) {
        [array addObject:[UniversalMatcher new]];
        return;
    }

    NSString *className;
    if (![scanner scanNameIntoString:&className]) {
        return;
    }

    Class targetClass = NSClassFromString(className);
    if ([scanner skipString:@"*"]) {
        [array addObject:[KindOfClassMatcher matcherForBaseClass:targetClass]];
    } else {
        [array addObject:[MemberOfClassMatcher matcherForExactClass:targetClass]];
    }
}

+ (id<SimplePatternParser>)parserWithScanner:(id<IgorQueryScanner>)scanner {
    return [[self alloc] initWithScanner:scanner];
}
@end
