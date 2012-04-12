#import "IgorQueryScanner.h"

@interface IgorQueryStringScanner : NSObject <IgorQueryScanner>

+ (id<IgorQueryScanner>)withQuery:(NSString *)query;

@end
