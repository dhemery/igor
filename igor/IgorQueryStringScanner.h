#import "IgorQueryScanner.h"

@interface IgorQueryStringScanner : NSObject <IgorQueryScanner>

+ (id<IgorQueryScanner>)withQueryString:(NSString *)queryString;

@end
