//
//  ViewController.m
//  内存对齐
//
//  Created by CYAX_BOY on 2021/3/1.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Test.h"
#import "Dog.h"
#import "Cat.h"
#import <malloc/malloc.h>

struct S {
    char a;
    long b;
    int c;
    float d;
}S1;


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //a _ _ _ _ _ _ _ b b b b b b b b c c c c d d
    //内存对齐 结构体或者union里第一个成员是冲offset为0的位置开始的，其后成员根据所占字节或者所占字节的倍数开始往后排。。。。。。最后结构的内存对齐是以结构体内最大成员所占字节的倍数，如上分析char占1自己从0开始，long在64位操作系统下占8自己，所以从8的倍数开始（0，8，16，24.。。。，这里前面有个char成员，所以b从8开始，前面1-7空着），b占8-15，c占4字节（从0，4，8，12，16.。。开始），同上从16开始（16-19），d占2字节（从0，2，4，6，8，10.。。开始），所以从20开始，20-21，最后相加8+8+4+2=22，但是结构体内存对齐以最大成员所占自己的倍数，其中最大是long 8位，所以是8的倍数24
    NSLog(@"-----%ld",sizeof(S1));//24
    
    
    //Test类没有任何成员（其实内部有个isa指针，指针占8字节），所以下面打印，可以给他加几个属性等测试内存对齐
    Test *te = [Test new];
    NSLog(@"test所占内存==%ld",class_getInstanceSize([te class]));//8
    NSLog(@"test实际分配的内存==%ld",malloc_size((__bridge const void *)(te)));//16

    //name 和 nickName是指针对象各站8个字节，name从0开始（0-7），nickName从8开始（8-15），age占4字节从16开始（16-19），这三个属性占的自己很整齐，所以最后加上dog的isa所占的8字节，分析 01234567 89101112131415 1617181929212223 2425262728203031共32
    Dog *dog = [Dog new];
    NSLog(@"dog所占内存==%ld",class_getInstanceSize([dog class]));//32
    NSLog(@"dog实际分配的内存==%ld",malloc_size((__bridge const void *)(dog)));//32

    //name8 nickName8 age4 score8字节 + isa
    //01234567 89101112131415 1617181920212223 24-31 32-39 共40
    Cat *cat = [[Cat alloc]init];
    NSLog(@"cat所占内存==%ld",class_getInstanceSize([cat class]));//40
    NSLog(@"cat实际分配的内存==%ld",malloc_size((__bridge const void *)(cat)));//48
    
    ///总结
    /*
     class_getInstanceSize 和 sizeof等价，理论上分配的最少内存，
     malloc_size实际系统真正分配的内存（iOS系统以16自己对齐，所以分配的额是16字节的倍数）
     底层实现原理
     void *
     calloc(size_t num_items, size_t size)
     {
         void *retval;
             // 内存对齐,40 => 48  16的倍数
         retval = malloc_zone_calloc(default_zone, num_items, size);
         if (retval == NULL) {
             errno = ENOMEM;
         }
         return retval;
     }
     */
    
}


@end
