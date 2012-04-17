#import "StringQueryScanner.h"
#import "IgorParserException.h"

// todo  Test
@implementation StringQueryScanner {
    NSScanner *scanner;
}

- (id <QueryScanner>)initWithString:(NSString *)queryString {
    self = [super init];
    if (self) {
        NSString *stripped = [queryString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        scanner = [NSScanner scannerWithString:stripped];
        [scanner setCharactersToBeSkipped:nil];
    }
    return self;
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
    return [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet] intoString:destination];
}

+ (id <QueryScanner>)scannerWithString:(NSString *)queryString {
    return [[self alloc] initWithString:queryString];
}

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination {
    return [scanner scanUpToString:string intoString:destination];
}

- (BOOL)skipString:(NSString *)string {
    return [scanner scanString:string intoString:nil];
}

- (BOOL)skipWhiteSpace {
    return [scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil];
}

@end