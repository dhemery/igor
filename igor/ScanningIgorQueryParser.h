@protocol IgorQueryScanner;
@protocol InstanceParser;

#import "InstanceChainParser.h"
#import "IgorQueryParser.h"


@interface ScanningIgorQueryParser : NSObject <IgorQueryParser>

+ (id<IgorQueryParser>)parserWithScanner:(id <IgorQueryScanner>)scanner instanceParser:(id<InstanceParser>)instanceParser instanceChainParser:(id <InstanceChainParser>)instanceChainParser;

@end
