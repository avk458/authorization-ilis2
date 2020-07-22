package cn.hitek.authorization.ilis2.product.unit.event;

import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import lombok.Getter;
import org.springframework.context.ApplicationEvent;

/**
 * @author chenlm
 */
@Getter
public class AutoInsertMainProfileEvent extends ApplicationEvent {

    private static final long serialVersionUID = 5931820387485946845L;

    private final Unit unit;

    public AutoInsertMainProfileEvent(Object source, Unit unit) {
        super(source);
        this.unit = unit;
    }
}
