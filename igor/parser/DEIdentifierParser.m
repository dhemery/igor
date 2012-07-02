#import "DEIdentifierParser.h"
#import "DEAccessibilityIdentifierMatcher.h"
#import "DEQueryScanner.h"

@implementation DEIdentifierParser

- (NSString *)parseNameFrom:(id <DEQueryScanner>)scanner {
    NSString *name;
    if (![scanner scanNameIntoString:&name]) [scanner failBecause:@"Expected a name after the #"];
    return name;
}

- (id <DEMatcher>)parseMatcherFromScanner:(id <DEQueryScanner>)scanner {
    if (![scanner skipString:@"#"]) {
        return nil;
    }
    NSString *name = [self parseNameFrom:scanner];
    return [DEAccessibilityIdentifierMatcher matcherWithAccessibilityIdentifier:name];
}

@end
