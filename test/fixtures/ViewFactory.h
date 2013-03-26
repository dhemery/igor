@interface ViewFactory : NSObject

+ (Class)classForButton;

+ (Class)classForControl;

+ (Class)classForLabel;

+ (Class)classForView;

+ (NSString *)classNameForButton;

+ (NSString *)classNameForControl;

+ (NSString *)classNameForLabel;

+ (NSString *)classNameForView;

+ (id)button;

+ (id)control;

+ (id)view;

+ (id)viewWithName:(NSString *)name;

+ (id)window;

@end

