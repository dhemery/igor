#import "InstanceChainParser.h"

@protocol IgorQueryScanner;
@protocol InstanceParser;

@interface ScanningInstanceChainParser : NSObject <InstanceChainParser>

+ (id<InstanceChainParser>) parserWithScanner:(id<IgorQueryScanner>)scanner instanceParser:(id<InstanceParser>)instanceParser;

@end
