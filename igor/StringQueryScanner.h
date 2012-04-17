#import "QueryScanner.h"

@interface StringQueryScanner : NSObject <QueryScanner>

+ (id <QueryScanner>)scannerWithString:(NSString *)queryString;

@end
