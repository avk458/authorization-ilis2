package cn.hitek.authorization.ilis2.framework.consolelog;

/**
 * 利用rewrite把日志推送到页面
 *
 * @author chenlm
 */
// @Plugin(name = "ConsoleLogPolicy", category = "Core", elementType = "rewritePolicy", printObject = true)
// public final class ConsoleLogPolicy implements RewritePolicy {
//
//     @PluginFactory
//     public static ConsoleLogPolicy factory() {
//         return new ConsoleLogPolicy();
//     }
//
//     @Override
//     public LogEvent rewrite(LogEvent source) {
//         ConsoleLog loggerMessage = new ConsoleLog(
//                 source.getMessage().getFormattedMessage(),
//                 DateFormat.getDateTimeInstance().format(new Date(source.getTimeMillis())),
//                 source.getSource().getFileName(),
//                 source.getSource().getLineNumber(),
//                 source.getThreadName(),
//                 source.getLevel().name());
//         ConsoleLogQueue.getInstance().push(loggerMessage);
//         return source;
//     }
// }
