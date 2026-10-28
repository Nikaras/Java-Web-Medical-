package general;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.lang.reflect.Type;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.HashMap;

public class General {
    public static String generateSalt() {
        SecureRandom random = new SecureRandom();

        int salt = random.nextInt(10000000,100000000);

        return (String.valueOf(salt));
    }


    public static String generateHash(String unhashed, String salt) {
        // Hash the password.
        final String toHash = salt + unhashed + salt;
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("SHA-256");
        } catch (NoSuchAlgorithmException ex) {
            return "00000000000000000000000000000000";
        }
        messageDigest.update(toHash.getBytes(), 0, toHash.length());
        String hashed = new BigInteger(1, messageDigest.digest()).toString(16);
        if (hashed.length() < 32) {
            hashed = "0" + hashed;
        }
        return hashed.toUpperCase();
    }

    public static String mapToJson(HashMap<String, ArrayList<String>> map) {
        Gson gson = new Gson();
        return gson.toJson(map);
    }

    public static HashMap<String, ArrayList<String>> jsonToMap(String json) {
        Gson gson = new Gson();
        Type type = new TypeToken<HashMap<String, ArrayList<String>>>(){}.getType();

        return gson.fromJson(json, type);
    }
}

