package cn.hitek.authorization.ilis2.common.mybatisplus;

import cn.hitek.authorization.ilis2.product.base.domain.UserDetail;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.security.core.context.SecurityContextHolder;

import java.time.LocalDateTime;

/**
 * @author chenlm
 */
public class CommonMetaDataHandler implements MetaObjectHandler {

    /**
     * 创建时间
     */
    private static final String CREATE_TIME = "createTime";
    /**
     * 修改时间
     */
    private static final String UPDATE_TIME = "updateTime";
    /**
     * 创建者
     */
    private static final String CREATE_BY = "createBy";
    private static final String CREATE_NAME = "createName";
    /**
     * 修改者
     */
    private static final String UPDATE_BY = "updateBy";
    private static final String UPDATE_NAME = "updateName";
    /**
     * 删除标志（0代表存在 1代表删除）
     */
    private static final String DELETED = "isDeleted";

    @Override
    public void insertFill(MetaObject metaObject) {
        strictInsertFill(metaObject, CREATE_TIME, LocalDateTime.class, LocalDateTime.now());
        strictInsertFill(metaObject, UPDATE_TIME, LocalDateTime.class, LocalDateTime.now());
        strictInsertFill(metaObject, CREATE_BY, String.class, CurrentUserProvider.getCurrentUser().getUsername());
        strictInsertFill(metaObject, CREATE_NAME, String.class, CurrentUserProvider.getCurrentUser().getRealName());
        strictInsertFill(metaObject, UPDATE_BY, String.class, CurrentUserProvider.getCurrentUser().getUsername());
        strictInsertFill(metaObject, UPDATE_NAME, String.class, CurrentUserProvider.getCurrentUser().getRealName());
        strictInsertFill(metaObject, DELETED, Boolean.class, Boolean.FALSE);
    }

    @Override
    public void updateFill(MetaObject metaObject) {
        strictUpdateFill(metaObject, UPDATE_BY, String.class, CurrentUserProvider.getCurrentUser().getUsername());
        strictUpdateFill(metaObject, UPDATE_NAME, String.class, CurrentUserProvider.getCurrentUser().getRealName());
        strictUpdateFill(metaObject, UPDATE_TIME, LocalDateTime.class, LocalDateTime.now());
    }

    public static class CurrentUserProvider {

        public static UserDetail getCurrentUser() {
            return  (UserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        }
    }
}
