#import "StringQueryScanner.h"
#import "IgorParserException.h"

// todo  Test
@implementation StringQueryScanner

@synthesize scanner;

- (id <QueryScanner>)initWithString:(NSString *)queryString {
    self = [super init];
    if (self) {
        scanner = [NSScanner scannerWithString:queryString];
        [scanner setCharactersToBeSkipped:nil];
    }
    return self;
}
- (NSString *)description {
    return [self.scanner string];
}

- (void)failBecause:(NSString *)reason {
    @throw [IgorParserException exceptionWithReason:reason scanner:self.scanner];
}

- (void)failIfNotAtEnd {
    if (![self.scanner isAtEnd]) {
        [self failBecause:@"Unexpected characters"];
    }
}

- (BOOL)scanNameIntoString:(NSString **)destination {
    return [self.scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet] intoString:destination];
}

+ (id <QueryScanner>)scannerWithString:(NSString *)queryString {
    return [[self alloc] initWithString:queryString];
}

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination {
    return [self.scanner scanUpToString:string intoString:destination];
}

- (BOOL)skipString:(NSString *)string {
    return [self.scanner scanString:string intoString:nil];
}

- (BOOL)skipWhiteSpace {
    return [self.scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:nil];
}

@end