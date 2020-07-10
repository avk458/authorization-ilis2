package cn.hitek.authorization.ilis2;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;

import java.util.Set;

@SpringBootTest
class ApplicationTests {

	@Autowired
	private RedisTemplate<String, Object> redisTemplate;

	@Test
	void contextLoads() {
		Set<String> keys = this.redisTemplate.keys(Constant.ILIS_LOGIN_OFFLINE_PREFIX + "test.*");
		System.out.println(keys.size());
	}
}
