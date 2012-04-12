#import "InstanceChainParser.h"

@protocol IgorQueryScanner;

@interface ScanningInstanceChainParser : NSObject <InstanceChainParser>

+ (id<InstanceChainParser>)withQueryScanner:(id<IgorQueryScanner>)scanner;

@end
