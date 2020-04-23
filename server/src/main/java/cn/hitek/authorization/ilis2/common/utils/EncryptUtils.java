package cn.hitek.authorization.ilis2.common.utils;

import lombok.SneakyThrows;
import org.apache.tomcat.util.codec.binary.Base64;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;

/**
 * @author chenlm
 */
public class EncryptUtils {

    private static final String KEY = "ilisdatabasesalt";
    private static final String ALGORITHM_STR = "AES/ECB/PKCS5Padding";

    @SneakyThrows
    public static String encrypt(String content, String encryptKey) {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);
        Cipher cipher = Cipher.getInstance(ALGORITHM_STR);
        cipher.init(Cipher.ENCRYPT_MODE, new SecretKeySpec(encryptKey.getBytes(), "AES"));
        byte[] b = cipher.doFinal(content.getBytes(StandardCharsets.UTF_8));
        return Base64.encodeBase64String(b);

    }

    @SneakyThrows
    public static String decrypt(String encryptStr, String decryptKey) {
        KeyGenerator kgen = KeyGenerator.getInstance("AES");
        kgen.init(128);
        Cipher cipher = Cipher.getInstance(ALGORITHM_STR);
        cipher.init(Cipher.DECRYPT_MODE, new SecretKeySpec(decryptKey.getBytes(), "AES"));
        // 采用base64算法进行转码,避免出现中文乱码
        byte[] encryptBytes = Base64.decodeBase64(encryptStr);
        byte[] decryptBytes = cipher.doFinal(encryptBytes);
        return new String(decryptBytes);
    }

    @SneakyThrows
    public static String encrypt(String content) {
        return encrypt(content, KEY);
    }

    @SneakyThrows
    public static String decrypt(String encryptStr) {
        return decrypt(encryptStr, KEY);
    }
}
