//
//  Cat.h
//  内存对齐
//
//  Created by CYAX_BOY on 2021/3/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cat : NSObject
@property(nonatomic,copy)NSString *name;//0-7
@property(nonatomic,copy)NSString *nickName;//8-15
@property(nonatomic,assign)int age;//16-19
@property(nonatomic,assign)int age1;//20-23

@property(nonatomic)short a;//25 26 27 28 29 30 31
//32-39

@end

NS_ASSUME_NONNULL_END
