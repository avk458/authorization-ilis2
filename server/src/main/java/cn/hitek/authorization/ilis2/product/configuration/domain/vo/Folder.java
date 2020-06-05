package cn.hitek.authorization.ilis2.product.configuration.domain.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @author chenlm
 */
@NoArgsConstructor
@Data
public class Folder {

    public Folder(File file) {
        this.file = file;
        this.value = file.getPath();
        this.label = file.getPath();
    }

    private File file;
    private String value;
    private String label = value;
    private boolean loading = false;
    private List<Folder> children = new ArrayList<>(0);
}
