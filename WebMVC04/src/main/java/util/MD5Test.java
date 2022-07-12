package util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class MD5Test {
    public static void main(String[] args) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        String pwd = "admin";
        md.update(pwd.getBytes());
        pwd = String.valueOf(new BigInteger(1, md.digest()).toString(16));
        System.out.println(pwd);
    }
}
