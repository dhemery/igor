#import "InstanceChainParser.h"

@protocol IgorQueryScanner;

@interface ScanningInstanceChainParser : NSObject <InstanceChainParser>

+ (id<InstanceChainParser>) parser;

@end
