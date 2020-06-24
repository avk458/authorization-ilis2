package cn.hitek.authorization.ilis2.product.base.mapper;

import cn.hitek.authorization.ilis2.product.base.domain.Role;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class RoleMapperTest {

    @Autowired
    private RoleMapper roleMapper;

    @Test
    void getRolePermissionsBatch() {
        List<Role> roles = roleMapper.getRolePermissionsBatch();
        roles.forEach(System.out::println);
    }
}
