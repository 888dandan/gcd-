//
//  ViewController.m
//  gcd的详细总结
//
//  Created by 曹轩 on 2018/5/12.
//  Copyright © 2018年 曹轩. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"test");
    /*
    Grand Central Dispatch(GCD) 是 Apple 开发的一个多核编程的较新的解决方法。它主要用于优化应用程序以支持多核处理器以及其他对称多处理系统。它是一个在线程池模式的基础上执行的并发任务。

    GCD 可用于多核的并行运算
    GCD 会自动利用更多的 CPU 内核（比如双核、四核）
    GCD 会自动管理线程的生命周期（创建线程、调度任务、销毁线程）
    程序员只需要告诉 GCD 想要执行什么任务，不需要编写任何线程管理代码
    
     */
    
    // gcd 的两大核心 任务 与队列
    
    //任务：是否是同步执行还是异步执行
    
    // 区别：是否等待队列的任务完成，是否具有开启新线程的能力
    
    // 队列：存储任务 有串型队列和并发队列
    
    // gcd 的使用步骤
    
    /*
     GCD 的使用步骤其实很简单，只有两步。
     
     创建一个队列（串行队列或并发队列）
     将任务追加到任务的等待队列中，然后系统就会根据任务类型执行任务（同步执行或异步执行）

     */
    [self test12];
}

/**
 * 同步执行 + 并发队列
 * 特点：在当前线程中执行任务，不会开启新线程，执行完一个任务，再执行下一个任务。
 */
-(void)test1{
    
    // 创建队列
    dispatch_queue_t queue=dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"111111----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"222222----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"33333----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
}



/**
 * 异步执行 + 并发队列
 * 特点：可以开启多个线程，任务交替（同时）执行。
 */
-(void)test2{
    
    // 创建队列
    dispatch_queue_t queue=dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    
    // 将任务添加到队列中
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"111111----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"222222----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"33333----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
}




/**
 * 同步执行 + 串行队列
 * 特点：不会开启新线程，在当前线程执行任务。任务是串行的，执行完一个任务，再执行下一个任务。
 */

-(void)test3{
    // 创建队列
    dispatch_queue_t queue=dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    
    // 将任务添加到队列中
    dispatch_sync(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"111111----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"222222----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"33333----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    
}

/**
 * 异步执行 + 串行队列
 * 特点：会开启新线程，但是因为任务是串行的，执行完一个任务，再执行下一个任务。
 */

// 新开启了一个线程 是不是我们一般封装的网络请求就是异步串型
-(void)test4{
    // 创建队列
    dispatch_queue_t queue=dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
    
    // 将任务添加到队列中
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"111111----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"222222----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"33333----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    
}

// 主队列：GCD自带的一种特殊的串行队列
//所有放在主队列中的任务，都会放到主线程中执行
//可使用dispatch_get_main_queue()获得主队列

-(void)test5{
    
    // 创建队列
    dispatch_queue_t queue=dispatch_get_main_queue();
    
    // 将任务添加到队列中
    dispatch_sync(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"111111----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"222222----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"33333----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
}



/**
 * 异步执行 + 主队列
 * 特点：只在主线程中执行任务，执行完一个任务，再执行下一个任务
 */
// 不回开启新的线程
-(void)test6{
    // 创建队列
    dispatch_queue_t queue=dispatch_get_main_queue();
    
    // 将任务添加到队列中
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"111111----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"222222----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"33333----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
}
//  GCD 线程间的通信
/*
 在iOS开发过程中，我们一般在主线程里边进行UI刷新，例如：点击、滚动、拖拽等事件。我们通常把一些耗时的操作放在其他线程，比如说图片下载、文件上传等耗时操作。而当我们有时候在其他线程完成了耗时操作时，需要回到主线程，那么就用到了线程之间的通讯
 */
// 注意 这里是异步串型 会开启新的线程  在这里我尝试添加在主线程添加button的点击事件。 发现是可以点击的 这样也是符合一般开发的实际需要的操作 当我们在一个界面发送网络请求的时候，用户由于网络太慢不想等待 可以在主线程有推出此界面的操作 所以可以在之前的项目 添加在主线程刷新 ui的做法

-(void)test7{
    
    // add button
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(50, 50, 50, 50);
    btn.center=self.view.center;
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    dispatch_queue_t qutut=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_queue_t mainqueue=dispatch_get_main_queue();
    
    dispatch_async(qutut, ^{
        
        
        for (NSInteger i=0; i<100000; i++) {
            NSLog(@"111111----%@%ld",[NSThread currentThread],(long)i);
            
        }
    
        dispatch_async(mainqueue, ^{
            
            NSLog(@"222222-----%@",[NSThread currentThread]);
        });

    });
}
-(void)onClick:(UIButton*)btn{
    NSLog(@"我将要被打印");
}


/*
 我们有时需要异步执行两组操作，而且第一组操作执行完之后，才能开始执行第二组操作。这样我们就需要一个相当于栅栏一样的一个方法将两组异步执行的操作组给分割起来，当然这里的操作组里可以包含一个或多个任务。这就需要用到dispatch_barrier_async方法在两个操作组间形成栅栏。

 */
-(void)test8{
    dispatch_queue_t queue=dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"111111----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"222222----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"我是栅栏");
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"33333----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (NSInteger i=0; i<10; i++) {
            NSLog(@"44444----&=%ld-----%@",(long)i,[NSThread currentThread]);
        }
    });

}

// GCD 延时执行方法：dispatch_after
/*
 需要注意的是：dispatch_after函数并不是在指定时间之后才开始执行处理，而是在指定时间之后将任务追加到主队列中。严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务，dispatch_after函数是很有效
 */
-(void)test9{
    
    NSLog(@"开始");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"我是2.0秒后将任务添加到此队列");
    });
    

    
}


/*
 我们在创建单例、或者有整个程序运行过程中只执行一次的代码时，我们就用到了 GCD 的 dispatch_once 函数。使用
 dispatch_once 函数能保证某段代码在程序运行过程中只被执行1次，并且即使在多线程的环境下，dispatch_once也可以保证线程安全。

 */
/*一次性代码（只执行一次）dispatch_once*/


-(void)test10{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
    
    // 具体在代码中的体现 为一个类 写一个单利
    /*
     #import "Tools.h"
     
     @implementation Tools
     // 创建静态对象 防止外部访问
     static Tools *_instance;
     +(instancetype)allocWithZone:(struct _NSZone *)zone
     {
     //    @synchronized (self) {
     //        // 为了防止多线程同时访问对象，造成多次分配内存空间，所以要加上线程锁
     //        if (_instance == nil) {
     //            _instance = [super allocWithZone:zone];
     //        }
     //        return _instance;
     //    }
     // 也可以使用一次性代码
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
     if (_instance == nil) {
     _instance = [super allocWithZone:zone];
     }
     });
     return _instance;
     }
     // 为了使实例易于外界访问 我们一般提供一个类方法
     // 类方法命名规范 share类名|default类名|类名
     +(instancetype)shareTools
     {
     //return _instance;
     // 最好用self 用Tools他的子类调用时会出现错误
     return [[self alloc]init];
     }
     // 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
     -(id)copyWithZone:(NSZone *)zone
     {
     return _instance;
     }
     -(id)mutableCopyWithZone:(NSZone *)zone
     {
     return _instance;
     }
     
     */
    
}

// 快速迭代方法：dispatch_apply
// 开启了很多线程 通过打印发现里面还有主线程 开启的线程《=6
// 这个在实际开发会用上
-(void)test11{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"apply---begin");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
    });
    NSLog(@"apply---end");
    }

// GCD 队列组：dispatch_group
-(void)test12{
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"group---begin");
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务1
        for (int i = 0; i < 10; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 追加任务2
        for (int i = 0; i < 10; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    
    // 回到主线程
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步任务1、任务2都执行完毕后，回到主线程执行下边任务
        for (int i = 0; i < 10; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
        NSLog(@"group---end");
    });
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
