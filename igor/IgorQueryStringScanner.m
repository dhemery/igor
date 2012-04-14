#import "IgorQueryStringScanner.h"
#import "IgorParserException.h"

// todo  Test
@implementation IgorQueryStringScanner {
    NSScanner *scanner;
}

- (NSString *)description {
    return [scanner string];
}

- (void)failBecause:(NSString *)reason {
    @throw [IgorParserException exceptionWithReason:reason scanner:scanner];
}

- (void)failIfNotAtEnd {
    if (![scanner isAtEnd]) {
        [self failBecause:@"Unexpected characters"];
    }
}

- (BOOL)nextStringIs:(NSString *)string {
    NSUInteger originalLocation = [scanner scanLocation];
    if ([scanner scanString:string intoString:nil]) {
        [scanner setScanLocation:originalLocation];
        return YES;
    }
    return NO;
}

- (BOOL)scanNameIntoString:(NSString **)destination {
    return [scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:destination];
}

+ (id <IgorQueryScanner>)scanner {
    return [self alloc];
}

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination {
    return [scanner scanUpToString:string intoString:destination];
}

- (void)setQuery:(NSString *)query {
    NSString *stripped = [query stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    scanner = [NSScanner scannerWithString:stripped];
    [scanner setCharactersToBeSkipped:nil];
}

- (BOOL)skipString:(NSString *)string {
    return [scanner scanString:string intoString:nil];
}

- (BOOL)skipWhiteSpace {
    return [scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil];
}

@end