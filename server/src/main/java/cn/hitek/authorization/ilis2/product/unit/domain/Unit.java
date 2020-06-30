package cn.hitek.authorization.ilis2.product.unit.domain;

import cn.hitek.authorization.ilis2.common.validation.group.OnCreate;
import cn.hitek.authorization.ilis2.common.validation.group.OnUpdate;
import cn.hitek.authorization.ilis2.framework.web.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.Future;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.time.LocalDate;

/**
 * @author chenlm
 *
 */
@Getter
@Setter
public class Unit extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    public static final boolean AUTHORIZED = true;
    /**
     * 是否删除
     */
    @TableField(fill = FieldFill.INSERT)
    @TableLogic
    private Boolean isDeleted;

    /**
     * 单位名称
     */
    @NotBlank(message = "单位名称不能为空", groups = {OnCreate.class, OnUpdate.class})
    private String name;

    /**
     * 单位编码，使用数据源识别
     */
    @NotBlank(message = "单位编码不能为空", groups = {OnCreate.class, OnUpdate.class})
    private String uniqCode;

    /**
     * 有效截止日期
     */
    @Future(message = "过期日期必须是一个未来的某一个日期", groups = {OnCreate.class, OnUpdate.class})
    private LocalDate expireDate;

    /**
     * 最大用户数
     */
    private Integer maxAccount;

    /**
     * 最大在线用户数
     */
    private Integer maxOnlineAccount;

    private Boolean isAuthorized;

    private Boolean singleLogin;

    private String authorizationCode;

    private String unitShortName;

    @NotBlank(message = "必须选择目标数据源", groups = {OnCreate.class, OnUpdate.class})
    private String targetSourceId;

    private String targetSource;

}
