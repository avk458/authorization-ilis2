package cn.hitek.authorization.ilis2;

import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.service.UnitService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.io.*;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

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
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void do1() {

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
		File file = new File("C:\\");
		File[] files = file.listFiles();
		for (File f : files) {
			System.out.println(f.getPath());
		}
	}

	@Test
	public void do5() {
		ArrayList<String> list = new ArrayList<>(Arrays.asList("1", "2", "2", "3", "4", "3"));
		HashMap<String, Integer> map = new HashMap<>(0);
		map.put("2", 8);
		list.forEach(s -> map.computeIfAbsent(s, Integer::new));
		System.out.println(map);
	}

	@Test
	public void do6() {
		List<String> command = Arrays.asList("mysqldump", "-h127.0.0.1", "-P3306", "-uroot", "-p123456", "-d", "auth01", "--ignore-table=auth01.t_init_file", "--ignore-table=auth01.t_initial_config");
		List<String> command2 = Arrays.asList("mysqldump", "-h192.168.2.3", "-P3306", "-uroot", "-p123456", "ilis_test");
		ProcessBuilder processBuilder = new ProcessBuilder(command2);
		processBuilder.redirectOutput(ProcessBuilder.Redirect.appendTo(new File("E:\\fileShare\\s.sql")));
		processBuilder.redirectError(new File("E:\\fileShare\\l.log"));
		Process process = null;
		try {
			process = processBuilder.start();
			process.waitFor();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void do7() throws SQLException, IOException, InterruptedException {
		String url = "jdbc:mysql://127.0.0.1:3306/auth01?characterEncoding=utf8&serverTimezone=Asia/Shanghai&useSSL=false";
		// final List<String> commands = Arrays.asList("mysql", "-h127.0.0.1", "-P3306", "-uroot", "-p123456", "ilis_dev");
		// final ProcessBuilder builder = new ProcessBuilder(commands);
		// builder.redirectInput(new File("G:\\ilis\\1589505804078\\init.sql"));
		// builder.redirectError(new File("G:\\ilis\\1589505804078\\process.log"));
		// final Process process = builder.start();
		// process.waitFor();
		// Connection con = DriverManager.getConnection(url, "root", "123456");
		// Statement statement = con.createStatement();
		// String user = "'ilis_dev'@'%'";
		// String decryptPwd = "ilis_dev";
		// String schema = "ilis_dev";
		// boolean createUser = statement.execute("CREATE USER " + user + " IDENTIFIED BY '" + decryptPwd + "'");
		// if (createUser) {
		// 	statement.execute("GRANT ALL PRIVILEGES ON " + schema +".* " + "TO " + user);
		// }
		FileWriter fileWriter = new FileWriter(new File("G:\\ilis\\\\1589509014511\\process.log"), true);
		fileWriter.write("INSERT INTO t_s_depart_version (id, sys_org_code, sys_company_code, departname, extendname, description, address, postcode, fax, email, phone, query_phone, explain_phone, contacts, mobile, bank_account, bank_account_name, bank_name, bank_address, version, start_time, end_time, status, complaint_phone, org_type, org_code, depart_id, parentdepartid, bpm_status, update_date, update_by, update_name, create_date, create_by, create_name, company_short_name) VALUES ('402882105ec60bc0015ec6262d3d0003', null, 'A03', '贵州宏信创达工程检测咨询有限公司', '', '', '贵州省贵阳市贵阳国家高新技术开发产业园区高海路949号', '550014', '0851—85861098', 'hr_hxcd@163.com', '0851—85861098', '', '0851—84285207', '', '0851—85861098', '', '', '', '', 0, '2020-05-14 17:15:27', '2040-05-14 17:15:27', '1', null, null, null, null, null, null, '2020-05-14 17:15:27', 'liuyi', '刘燚', null, null, null, '贵州宏信创达工程检测咨询有限公司');");
		fileWriter.flush();
	}

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Test
	public void do8() throws SQLException {
		String url = "jdbc:mysql://127.0.0.1:3306/ilis_local?characterEncoding=utf8&serverTimezone=Asia/Shanghai&useSSL=false";
		Connection con = DriverManager.getConnection(url, "root", "123456");
		Statement statement = con.createStatement();
		String batchSql = "INSERT INTO `t_s_base_user` VALUES ('297ed4995dd45eb7015dd46f56f90003', null, null, 'd92d5c5c1c6c2b33070537cc1e35d031', 'employee', null, '1', 'demo,普通用户', 'employee', null, '0');\n" +
				"INSERT INTO `t_s_base_user` VALUES ('297ed4995dd475cd015dd478fa220007', null, null, 'ef50c4f58dab753f', 'zhuguan', null, '1', 'demo,主管', 'zhuguan', null, '0');\n" +
				"INSERT INTO `t_s_base_user` VALUES ('297ed4995dd475cd015dd478fa220007', null, null, '71d8e4ace4bf7d4f', 'manager', null, '1', 'demo,经理角色', 'manager', null, '0');\n" +
				"INSERT INTO `t_s_base_user` VALUES ('402880e74d75c4dd014d75d44af30005', null, null, 'deec3ebf23191eee', 'demo', null, '1', 'demo', 'demo', null, '0');\n" +
				"INSERT INTO `t_s_base_user` VALUES ('402881875988e889015988ec36770001', null, null, 'f68bb6f881b0ebe0', '7777', null, '1', 'demo', '777', null, '1');";
		DriverManagerDataSource driverManagerDataSource = new DriverManagerDataSource(url, "root", "123456");
		JdbcTemplate template = new JdbcTemplate(driverManagerDataSource);
		DataSourceTransactionManager dataSourceTransactionManager = new DataSourceTransactionManager(driverManagerDataSource);
		// TransactionStatus status = dataSourceTransactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			template.batchUpdate(batchSql.split(";"));
			// dataSourceTransactionManager.commit(status);
		} catch (DataAccessException e) {
			e.printStackTrace();
			// dataSourceTransactionManager.rollback(status);
		}

	}

	@Test
	public void do9() {
		System.out.println(LocalDateTime.now());
	}

}
