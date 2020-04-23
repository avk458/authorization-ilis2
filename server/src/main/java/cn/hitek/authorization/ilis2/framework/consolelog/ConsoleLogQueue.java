package cn.hitek.authorization.ilis2.framework.consolelog;

/**
 * 创建一个阻塞队列，作为日志系统输出的日志的一个临时载体
 *
 * @author chenlm
 */
// @Slf4j
// public class ConsoleLogQueue {
//
//     /**
//      * 队列大小
//      */
//     public static final int QUEUE_MAX_SIZE = 10000;
//
//     private static final ConsoleLogQueue ALARM_MESSAGE_QUEUE = new ConsoleLogQueue();
//     /**
//      * 阻塞队列
//      */
//     private final BlockingQueue<ConsoleLog> blockingQueue = new LinkedBlockingQueue<>(QUEUE_MAX_SIZE);
//
//     private ConsoleLogQueue() {
//     }
//
//     public static ConsoleLogQueue getInstance() {
//         return ALARM_MESSAGE_QUEUE;
//     }
//
//     /**
//      * 消息入队
//      *
//      * @param log 日志
//      */
//     public void push(ConsoleLog log) {
//         this.blockingQueue.add(log);
//     }
//
//     /**
//      * 消息出队
//      *
//      * @return log result
//      */
//     public ConsoleLog poll() {
//         ConsoleLog result = null;
//         try {
//             result = (ConsoleLog) this.blockingQueue.take();
//         } catch (InterruptedException e) {
//             log.warn("消息出列异常:{}", e.getMessage());
//         }
//         return result;
//     }
// }
