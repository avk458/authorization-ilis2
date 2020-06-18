package cn.hitek.authorization.ilis2.product.base.domain;


import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

/**
 * @author chenlm
 */
@Getter
@Setter
@TableName("t_s_role")
public class Role extends BaseEntity {

    private String roleName;
    private String desc;
}
