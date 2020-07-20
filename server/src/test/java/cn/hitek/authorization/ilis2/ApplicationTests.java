package cn.hitek.authorization.ilis2;

import cn.hitek.authorization.ilis2.product.unit.service.impl.UnitServiceImpl;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

@ActiveProfiles("test")
@SpringBootTest
class ApplicationTests {

	@Autowired
	private UnitServiceImpl unitService;

	@Test
	void contextLoads() {
		unitService.logUnitOnlineUsersEachDay();
	}
}
