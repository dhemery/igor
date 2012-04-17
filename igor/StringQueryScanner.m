#import "StringQueryScanner.h"
#import "IgorParserException.h"

// todo  Test
@implementation StringQueryScanner {
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

- (BOOL)scanNameIntoString:(NSString **)destination {
    return [scanner scanCharactersFromSet:[NSCharacterSet letterCharacterSet] intoString:destination];
}

+ (id <QueryScanner>)scanner {
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