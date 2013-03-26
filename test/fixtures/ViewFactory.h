@interface ViewFactory : NSObject

+ (Class)classForButton;

+ (Class)classForControl;

+ (Class)classForLabel;

+ (Class)classForView;

+ (Class)classForWindow;

+ (NSString *)classNameForButton;

+ (NSString *)classNameForControl;

+ (NSString *)classNameForLabel;

+ (NSString *)classNameForView;

+ (NSString *)classNameForWindow;

+ (id)button;

+ (id)control;

+ (id)view;

+ (id)viewWithName:(NSString *)name;

+ (id)window;

@end

