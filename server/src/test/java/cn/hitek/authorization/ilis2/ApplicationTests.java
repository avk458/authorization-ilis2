package cn.hitek.authorization.ilis2;

import cn.hitek.authorization.ilis2.common.utils.FileUtil;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.service.UnitService;
import org.apache.ibatis.jdbc.ScriptRunner;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Set;

@SpringBootTest
class ApplicationTests {

	@Test
	void contextLoads() {
		String driver = "com.mysql.jdbc.Driver";
		final String jdbcPathPrefix = "jdbc:mysql://";
		final String host = "127.0.0.1";
		final String colon = ":";
		final String port = "3306";
		final String slash = "/";
		String database = "";
		final String pathParams = "?characterEncoding=utf8&serverTimezone=Asia/Shanghai&useSSL=false";
		final String username = "root";
		final String pwd = "123456";
		final String initDatabase = "mysql";
		final String initSqlFilePath = "C:\\Users\\chenlm\\Desktop\\dump.sql";
		Connection connection;
		try {
			String connectionPath = jdbcPathPrefix + host + colon + port + slash + initDatabase + pathParams;
			connection = DriverManager.getConnection(connectionPath, username, pwd);
			Statement statement = connection.createStatement();
			ResultSet show_databases = statement.executeQuery("SHOW DATABASES");
			ArrayList<String> databases = new ArrayList<>(0);
			while (show_databases.next()) {
				databases.add(show_databases.getString("database"));
			}
			databases.forEach(System.out::println);
			database = "hitek_dev";
			int execute = statement.executeUpdate("CREATE DATABASE " + database + " CHARACTER SET utf8 COLLATE utf8_general_ci");
			if (execute == 1) {
				statement.close();
				connection.close();
			} else {
				System.out.println("数据库创建失败");
				return;
			}
			System.out.println("使用数据库【" + database + "】");
			connectionPath = jdbcPathPrefix + host + colon + port + slash + database + pathParams;
			connection = DriverManager.getConnection(connectionPath, username, pwd);
			System.out.println("开始执行数据库初始化脚本");
			ScriptRunner runner = new ScriptRunner(connection);
			InputStreamReader fileReader = new InputStreamReader(new FileInputStream(initSqlFilePath), StandardCharsets.UTF_8);
			runner.runScript(fileReader);
			runner.setStopOnError(true);
			System.out.println("数据库【" + database + "】初始化完毕！");
			runner.closeConnection();
		} catch (SQLException | FileNotFoundException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void do1() {

		Set<String> mySqlDatabaseNameKeyWords = FileUtil.getMySqlDatabaseNameKeyWords();
		mySqlDatabaseNameKeyWords.forEach(System.out::println);
	}

	@Test
	public void do2() {
		String dump = "mysqldump --host=127.0.0.1 --port=3306 --user=root --password=123456 auth01 ";
		String dump1 = "mysqldump -h127.0.0.1 -P3306 -uroot -p123456 auth01 ";
		String[] command = new String[]{"mysqldump ", "-h192.168.2.2", "-P3306", "-uroot", "-p123456", "-d", "auth01"};
		File backupFile = new File("C:\\Users\\chenlm\\Desktop\\javadump.sql");
		File errorFile = new File("C:\\Users\\chenlm\\Desktop\\error.log");
		InputStream inStream;
		OutputStreamWriter writer;
		try {
			ProcessBuilder processBuilder = new ProcessBuilder(Arrays.asList(command));
			processBuilder.redirectError(errorFile);
			processBuilder.redirectOutput(ProcessBuilder.Redirect.to(backupFile));

			Process process = processBuilder.start();
			process.waitFor();
			// String data = getData("127.0.0.1", "3306", "root", "123456", "auth01", "t_unit");
			// Process process = Runtime.getRuntime().exec(dump1);
			// InputStreamReader isr = new InputStreamReader(process.getInputStream());
			// BufferedReader br = new BufferedReader(isr,1024);
			// String line=null;
			// while ( (line = br.readLine()) != null)
			// 	System.out.println("> " + line);
			// if (process.waitFor() == 0) {
			// 	System.out.println("--");
			// }
			// ProcessBuilder
			// writer = new OutputStreamWriter(new FileOutputStream("C:\\Users\\chenlm\\Desktop\\javadump.sql"), StandardCharsets.UTF_8);
			// BufferedReader reader = new BufferedReader(new InputStreamReader(inStream));
			// System.out.println(reader.readLine());
			// String line;
			// while ((line = reader.readLine()) != null) {
			// 	System.out.println(line);
			// 	writer.write(line + System.lineSeparator());
			// }
			// String infoLine;
			// StringBuffer infoMsg = new StringBuffer();
			// BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
			// while((infoLine = bufferedReader.readLine()) != null) {
			// 	infoMsg.append(infoLine).append("\n");
			// }
			// String str = infoMsg.toString();
			// if(process.waitFor() == 0){
			// 	System.out.println(infoMsg);
			// } else {
			// 	throw new RuntimeException(str);
			// }
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String getData(String host, String port, String user, String password, String db,String table) throws Exception {


		Process run = Runtime.getRuntime().exec(
				"C:\\Program Files\\MySQL\\MySQL Server 5.7\\bin\\mysqldump.exe --host="  + host + " --port=" + port +
						" --user=" + user + " --password=" + password +
						" --compact --databases --add-drop-table --complete-insert --extended-insert " +
						"--skip-comments --skip-triggers "+ db+" --tables "+table);

		InputStream in = run.getInputStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(in));
		StringBuffer temp = new StringBuffer();
		int count;
		char[] cbuf = new char[1024];

		while ((count = br.read(cbuf, 0, 1024)) != -1)
			temp.append(cbuf, 0, count);

		br.close();
		in.close();

		return temp.toString();
	}

	@Autowired
	private UnitService unitService;

	@Test
	public void do3() {
		Unit unit = new Unit();
		unit.setName("testset");
		unit.setUniqCode("ttttt");
		unit.setExpireDate(LocalDate.parse("2020-05-30"));
		unit.setId("1252423990724759554");
		boolean update = this.unitService.updateById(unit);
		// this.unitService.save(unit);
	}

	@Test
	public void do4() {
		File[] files = File.listRoots();
		for (File file : files) {
			System.out.println(file);
		}
	}
}
