#import "DEIdentifierParser.h"
#import "DEAccessibilityIdentifierMatcher.h"
#import "DEQueryScanner.h"
#import "DETagMatcher.h"

@implementation DEIdentifierParser

- (NSString *)parseNameFrom:(id <DEQueryScanner>)scanner {
    NSString *name;
    if ([scanner scanNameIntoString:&name]) return name;
    return nil;
}

- (NSString *)parseDigitsFrom:(id <DEQueryScanner>)scanner {
    NSString *digits;
    if ([scanner scanDigitsIntoString:&digits]) return digits;
    return nil;
}

- (id <DEMatcher>)parseMatcherFromScanner:(id <DEQueryScanner>)scanner {
    if (![scanner skipString:@"#"]) {
        return nil;
    }
    NSString *digits = [self parseDigitsFrom:scanner];
    if (digits != nil) return [DETagMatcher matcherWithTag:[digits integerValue]];

    NSString *name = [self parseNameFrom:scanner];
    if (name != nil) return [DEAccessibilityIdentifierMatcher matcherWithAccessibilityIdentifier:name];

    [scanner failBecause:@"Expected a name or integer after the #"];
    return nil;
}

@end
