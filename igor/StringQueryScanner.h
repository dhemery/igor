#import "QueryScanner.h"

@interface StringQueryScanner : NSObject <QueryScanner>

@property (strong) NSScanner *scanner;

+ (id <QueryScanner>)scannerWithString:(NSString *)queryString;

@end
