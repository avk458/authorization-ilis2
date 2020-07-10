package cn.hitek.authorization.ilis2.product.configuration.event;

import lombok.Getter;
import org.springframework.context.ApplicationEvent;

/**
 * @author chenlm
 */
@Getter
public class UpdateDatabaseEvent extends ApplicationEvent {

    private static final long serialVersionUID = -4557747739957372233L;

    private final String targetProfileId;

    public UpdateDatabaseEvent(Object source, String targetProfileId) {
        super(source);
        this.targetProfileId = targetProfileId;
    }
}
