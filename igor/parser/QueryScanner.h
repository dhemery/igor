@protocol QueryScanner <NSObject>

- (void)failBecause:(NSString *)string;

- (void)failIfNotAtEnd;

- (BOOL)scanNameIntoString:(NSString **)destination;

- (BOOL)scanUpToString:(NSString *)string intoString:(NSString **)destination;

- (BOOL)skipString:(NSString *)string;

- (BOOL)skipWhiteSpace;

@end

@interface QueryScanner : NSObject <QueryScanner>

@property (strong) NSScanner *scanner;

+ (id <QueryScanner>)scannerWithString:(NSString *)queryString;

@end
