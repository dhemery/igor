#import "SelectorEngineRegistry.h"

@protocol InstanceChainParser;
@protocol IgorQueryScanner;

@interface Igor : NSObject <SelectorEngine>

- (NSArray *)findViewsThatMatchQuery:(NSString *)query inTree:(UIView *)tree;

+ (Igor *)igor;
+ (Igor *)igorWithQueryScanner:(id<IgorQueryScanner>)scanner instanceChainParser:(id <InstanceChainParser>)instanceChainParser;

@end
