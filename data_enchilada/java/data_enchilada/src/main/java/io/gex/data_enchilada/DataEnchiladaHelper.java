package io.gex.data_enchilada;

public class DataEnchiladaHelper {

    public static String getMethodName() {
        return Thread.currentThread().getStackTrace()[2].getMethodName();
    }

    static void sleep() {
        sleep(3000);
    }

    //time in milliseconds
    static void sleep(long time) {
        try {
            Thread.sleep(time);
        } catch (Throwable e) {
            // do nothing
        }
    }

}
