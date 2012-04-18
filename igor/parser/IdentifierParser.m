#import "IdentifierParser.h"
#import "IdentifierMatcher.h"
#import "QueryScanner.h"

@implementation IdentifierParser

- (NSString *)parseNameFrom:(id <QueryScanner>)scanner {
    NSString *name;
    if (![scanner scanNameIntoString:&name]) [scanner failBecause:@"Expected a name after the #"];
    return name;
}

- (id <Matcher>)parseMatcherFromScanner:(id <QueryScanner>)scanner {
    if (![scanner skipString:@"#"]) {
        return nil;
    }
    NSString *name = [self parseNameFrom:scanner];
    return [IdentifierMatcher matcherWithAccessibilityIdentifier:name];
}


@end